from typing import Literal
from dotenv import load_dotenv
load_dotenv()

from openai import OpenAI
from pathlib import Path
import click
import yaml
import json

client = OpenAI()

def load_template(
    mode: Literal['use_original', 'use_previous', 'continue'],
    logic: Literal['n3', 'cql'],
) -> list[dict[str,str|list[dict[str,str]]]]:
    if mode == 'use_original':
        if logic == 'n3':
            filename = './prompts/use_original_n3.yaml'
        elif logic == 'cql':
            filename = './prompts/use_original_cql.yaml'
        else:
            raise Exception(f'Unknown logic [{logic}]')
    elif mode == 'use_previous':
        if logic == 'n3':
            filename = './prompts/use_previous_n3.yaml'
        elif logic == 'cql':
            filename = './prompts/use_previous_cql.yaml'
        else:
            raise Exception(f'Unknown logic [{logic}]')
    elif mode == 'continue':
        if logic == 'n3':
            filename = './prompts/continue_n3.yaml'
        elif logic == 'cql':
            filename = './prompts/continue_cql.yaml'
        else:
            raise Exception(f'Unknown logic [{logic}]')
    else:
        raise Exception(f'Unknown mode [{mode}]')
    template = yaml.safe_load(open(filename))
    messages_per_task = [
        {
            'task_name': task,
            'messages': [
                {'role': 'system', 'content': task_prompt['system']},
                {'role': 'user', 'content': task_prompt['user']},
            ]
        }
        for task, task_prompt in template.items()
    ]
    return messages_per_task

def fill_template(
    template: str,
    original_doc: str,
    responses: dict[str,str] | None = None,
):
    if '{ORIGINAL_DOC}' in template:
        template = template.replace(
            '{ORIGINAL_DOC}', original_doc
        )
    if '{TASK_1_RESPONSE}' in template and responses:
        template = template.replace(
            '{TASK_1_RESPONSE}', responses['task_1']
        )
    if '{TASK_2_RESPONSE}' in template and responses:
        template = template.replace(
            '{TASK_2_RESPONSE}', responses['task_2']
        )

    return template
 
@click.command()
@click.argument('scenario', default='scenario1')
@click.option('--model', default='gpt-3.5-turbo')
@click.option('--mode', default='use_original')
@click.option('--logic', default='n3')
def run(
    scenario: Literal['scenario1','scenario2', 'scenario3'],
    model: Literal['gpt-3.5-turbo', 'gpt-4'],
    mode: Literal['use_original', 'use_previous', 'continue'],
    logic: Literal['n3', 'cql'],
):
    save_dir = Path(f'./outputs/{model}/{scenario}/{mode}_{logic}')
    save_dir.mkdir(parents=True, exist_ok=True)
    original_doc = open(f'scenarios/{scenario}.txt').read()
    messages_per_task = load_template(mode, logic)
    responses = {}

    if mode in ['use_original', 'use_previous']:
        for task in messages_per_task:
            resp = client.chat.completions.create(
                model = model,
                messages = [
                    {**m, 'content': fill_template(m['content'], original_doc, responses)}
                    for m in task['messages']
                ]
            )
            model_output = resp.choices[0].message.content
            responses[task['task_name']] = model_output
            open(save_dir / f"{task['task_name']}.txt",'w').write(model_output)
    elif mode == 'continue':
        message_stack = [
            messages_per_task[0]['messages'][0],
        ]
        for task in messages_per_task:
            message_stack += [
                {
                    'role': 'user', 
                    'content': fill_template(
                        task['messages'][1]['content'], 
                        original_doc
                    )
                },
            ]
            resp = client.chat.completions.create(
                model = model,
                messages = message_stack
            )
            model_output = resp.choices[0].message.content
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
