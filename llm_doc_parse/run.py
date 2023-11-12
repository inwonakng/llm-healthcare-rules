from typing import Literal
import yaml
import json
import click

from .config.path import OUTPUT_PATH, TEMPLATE_PATH, DOC_PATH
from .prompt import Prompt

generation_modes = Literal[
    'use_original_n3',
    'use_original_cql',
    'use_original_unittest',
    'use_previous_n3',
    'use_previous_cql',
    'use_previous_unittest',
    'use_previous_n3_unittest',
    'use_previous_cql_unittest',
    'continue_n3',
    'continue_cql',
    'continue_unittest',
    'continue_n3_unittest', 
    'continue_cql_unittest', 
]

@click.command()
@click.argument('doc_name', default='scenario1')
@click.option('--model', default='gpt-3.5-turbo')
def run(
    doc_name: Literal['scenario1','scenario2', 'scenario3'],
    model: Literal['gpt-3.5-turbo', 'gpt-4', 'codellama'],
    mode: generation_modes,
):
    save_dir = OUTPUT_PATH/model/doc_name/mode
    save_dir.mkdir(parents=True, exist_ok=True)
    # original_doc = load_document(doc_name)
    continue_conversation = 'continue' in mode

    document = open(DOC_PATH/f'{doc_name}.txt').read()
    prompt = Prompt.load_from_file(TEMPLATE_PATH/'tasks.yaml')
    configs = yaml.safe_load(open(TEMPLATE_PATH/f'{mode}.yaml'))
    
    prompt.execute(
        model = model,
        configs = configs,
        document = document,
        continue_conversation=continue_conversation,
        save_dir = save_dir
    )


    # messages_per_task = load_template(mode, logic)
    # responses = {}

    # if mode in ['use_original', 'use_previous']:
    #     for task in messages_per_task:
    #         while True:
    #             messages = [
    #                 fill_template(m, original_doc, responses)
    #                 for m in task['messages']
    #             ]
    #             model_output = generate(model, messages)
    #             clean_output = extract_codeblock(model_output)
    #             if clean_output: break
    #         responses[task['task_name']] = model_output
    #         open(save_dir / f"{task['task_name']}.txt",'w').write(model_output)
    # elif mode == 'continue':
    #     message_stack = [
    #         messages_per_task[0]['messages'][0],
    #     ]
    #     for task in messages_per_task:
    #         while True:
    #             message_stack += [
    #                 fill_template(task['messages'][1], original_doc)
    #             ]
    #             model_output = generate(model, message_stack)
    #             clean_output = extract_codeblock(model_output)
    #             if clean_output: break
    #         message_stack += [
    #             {
    #                 'role': 'assistant',
    #                 'content': model_output
    #             }
    #         ]
    #         open(save_dir / f"{task['task_name']}.txt",'w').write(model_output)
    else:
        raise Exception(f'Unknown mode [{mode}]')


if __name__ == "__main__":
    run()
