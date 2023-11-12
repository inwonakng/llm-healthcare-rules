from typing import Literal
import json
import click

from .config.path import OUTPUT_PATH
from .api import generate
from .prompt import load_template, fill_template
from .utils import extract_codeblock
from .document import load_document

@click.command()
@click.argument('doc_name', default='scenario1')
@click.option('--model', default='gpt-3.5-turbo')
@click.option('--mode', default='use_original')
@click.option('--logic', default='n3')
def run(
    doc_name: Literal['scenario1','scenario2', 'scenario3'],
    model: Literal['gpt-3.5-turbo', 'gpt-4', 'codellama'],
    mode: Literal['use_original', 'use_previous', 'continue'],
    logic: Literal['n3', 'cql'],
):
    save_dir = OUTPUT_PATH/f'{model}/{doc_name}/{mode}_{logic}'
    save_dir.mkdir(parents=True, exist_ok=True)
    original_doc = load_document(doc_name)
    messages_per_task = load_template(mode, logic)
    responses = {}

    if mode in ['use_original', 'use_previous']:
        
        for task in messages_per_task:
            while True:
                messages = [
                    fill_template(m, original_doc, responses)
                    for m in task['messages']
                ]
                model_output = generate(model, messages)
                clean_output = extract_codeblock(model_output)
                if clean_output: break
            responses[task['task_name']] = model_output
            open(save_dir / f"{task['task_name']}.txt",'w').write(model_output)
    elif mode == 'continue':
        message_stack = [
            messages_per_task[0]['messages'][0],
        ]
        for task in messages_per_task:
            while True:
                message_stack += [
                    fill_template(task['messages'][1], original_doc)
                ]
                model_output = generate(model, message_stack)
                clean_output = extract_codeblock(model_output)
                if clean_output: break
            message_stack += [
                {
                    'role': 'assistant',
                    'content': model_output
                }
            ]
            open(save_dir / f"{task['task_name']}.txt",'w').write(model_output)
    else:
        raise Exception(f'Unknown mode [{mode}]')


if __name__ == "__main__":
    run()
