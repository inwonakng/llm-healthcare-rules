import yaml
from dataclasses import dataclass, field
from pathlib import Path
import rich.progress

from .api import generate
from .config.models import ModelNamesType

VOWELS = 'aeiou'

@dataclass
class Task:
    name: str
    messages: dict[str,str]

@dataclass
class ExecutableInput:
    name: str
    messages: list[str] = field(default_factory=list) 
    components: list[str] = field(default_factory=list) 

@dataclass
class ExecutableMessage:
    messages: list[str] = field(default_factory=list) 
    include_input: bool = False

@dataclass
class Executable:
    task: str
    input: ExecutableInput
    system_message: ExecutableMessage
    user_message: ExecutableMessage
    
    def __post_init__(self):
        self.input = ExecutableInput(**self.input)
        self.system_message = ExecutableMessage(**self.system_message)
        self.user_message = ExecutableMessage(**self.user_message)

def replace_input_name(text, input_name):
    an_input_name = f'an {input_name}' if input_name[0].lower() in VOWELS else f'a {input_name}'
    text = text.replace(
        '<<AN_INPUT_NAME>>', an_input_name
    ).replace(
        '<<INPUT_NAME>>', input_name
    )
    return text.strip()
    
class Prompt:
    tasks: dict[str,Task]
    responses: dict[str,str]

    def __init__(self, tasks: list[Task]) -> None:
        self.tasks = {
            task.name: task
            for task in tasks
        }

    def execute(
        self, 
        model: ModelNamesType,
        configs: list[dict[str,str|list[str]]], 
        document: str,
        continue_conversation: bool = False,
        save_dir: Path|str|None = None,
        progress: rich.progress.Progress = None,
        mode: str = '',
        skip_if_exist: bool = True,
    ) -> None:
        valid_input_components = dict(document=document)
        chat_history = []

        if save_dir is not None:
            save_dir = Path(save_dir)
            save_dir.mkdir(parents=True, exist_ok=True)
        
        if progress is not None:
            progress_msg = 'Executing..'
            if mode:
                progress_msg = f'Executing {mode}..'
            p_task = progress.add_task(progress_msg, total=len(configs))
        for i, raw_conf in enumerate(configs):
            executable = Executable(**raw_conf)
            task = self.tasks[executable.task]

            # build messages
            system_msg = '\n'.join(
                replace_input_name(
                    task.messages[message],
                    executable.input.name,
                )
                for message in executable.system_message.messages
            )
            if executable.system_message.include_input:
                system_msg += '\n\n'.join(
                    f'### {input_component.capitalize()}\n' + 
                    valid_input_components[input_component].strip()
                    for input_component in executable.input.components
                )
            user_msg = '\n'.join(
                replace_input_name(
                    task.messages[message],
                    executable.input.name,
                )
                for message in executable.user_message.messages
            )
            if executable.user_message.include_input:
                user_msg += '\n\n'.join(
                    f'### {input_component.capitalize()}\n' + 
                    valid_input_components[input_component].strip()
                    for input_component in executable.input.components
                )
            messages = [
                {'role': 'system', 'content': system_msg,},
            ]
            if user_msg:
                messages += [
                    {'role': 'user', 'content': user_msg,},
                ]            
            chat_history += messages 

            try:
                output = generate(
                    model, 
                    messages if not continue_conversation else chat_history,
                )
            except Exception as e:
                output = str(e)

            valid_input_components[executable.task] = output
            chat_history += [{'role': 'assistant', 'content': output,}]
            
            if save_dir is not None:
                open(save_dir / f"{i}_{executable.task}.txt",'w').write(output)
            
            if progress is not None:
                progress.advance(p_task)
        if progress is not None:
            progress.remove_task(p_task)

    @staticmethod
    def load_from_file(tasks_file) -> 'Prompt':
        tasks = [Task(**task) for task in yaml.safe_load(open(tasks_file))]
        return Prompt(tasks)
