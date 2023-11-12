from typing import Self
import yaml
from dataclasses import dataclass, field

from .custom_types import OpenAIMessage
from .api import generate

VOWELS = 'aeiou'

@dataclass
class Task:
    name: str
    output_name: str
    messages: dict[str,str]

@dataclass
class ExecutableInput:
    name: str
    components: list[str] = field(default_factory=list) 

@dataclass
class Executable:
    task: str
    messages: list[str]
    input: ExecutableInput
    prefix: str | None = None
    
    def __post_init__(self):
        self.input = ExecutableInput(**self.input)

def replace_input_name(text, input_name):
    an_input_name = f'an {input_name}' if input_name[0].lower() in VOWELS else f'a {input_name}'
    text = text.replace(
        '<<AN_INPUT_NAME>>', an_input_name
    ).replace(
        '<<THE_INPUT_NAME>>', f'the {input_name}'
    )
    return text
    
class Prompt:
    tasks: dict[str,Task]
    continue_message: str
    responses: dict[str,str]

    def __init__(self, tasks: list[Task], continue_message: str) -> None:
        self.tasks = {
            task.name: task
            for task in tasks
        }
        self.continue_message = continue_message

    def execute(
        self, 
        model: str,
        configs: list[dict[str,str|list[str]]], 
        document: str
    ) -> None:
        valid_input_components = dict(document=document)
        for raw_conf in configs:
            executable = Executable(**raw_conf)
            task = self.tasks[executable.task]
            system_msg = '\n'.join(
                replace_input_name(
                    task.messages[message],
                    executable.input.name,
                )
                for message in executable.messages
            )
            user_msg = '\n'.join(
                f'### {input_component.capitalize()}\n' + 
                valid_input_components[input_component]
                for input_component in executable.input.components
            )
            messages = [
                {'role': 'system', 'content': system_msg,},
                {'role': 'user', 'content': user_msg,}
            ]
            
            output = generate(
                model, 
                messages
            )
            valid_input_components[executable.task] = output
            
            print('-'*20+'system'+'-'*20)
            print(system_msg)
            print()
            print('-'*20+'user'+'-'*20)
            print(user_msg)
            print('-'*20+'assistant'+'-'*20)
            print(output)
            print('='*80)


    @staticmethod
    def load_from_files(tasks_file, cont_file) -> 'Prompt':
        continue_message = open(cont_file).read()
        tasks = [Task(**task) for task in yaml.safe_load(open(tasks_file))]
        return Prompt(tasks, continue_message)
