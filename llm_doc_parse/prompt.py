from typing import Literal
import yaml

from .config.path import TEMPLATE_PATH

def load_template(
    mode: Literal['use_original', 'use_previous', 'continue'],
    logic: Literal['n3', 'cql'],
) -> list[dict[str,str|list[dict[str,str]]]]:
    if mode == 'use_original':
        if logic == 'n3':
            filename = TEMPLATE_PATH / 'use_original_n3.yaml'
        elif logic == 'cql':
            filename = TEMPLATE_PATH / 'use_original_cql.yaml'
        else:
            raise Exception(f'Unknown logic [{logic}]')
    elif mode == 'use_previous':
        if logic == 'n3':
            filename = TEMPLATE_PATH / 'use_previous_n3.yaml'
        elif logic == 'cql':
            filename = TEMPLATE_PATH / 'use_previous_cql.yaml'
        else:
            raise Exception(f'Unknown logic [{logic}]')
    elif mode == 'continue':
        if logic == 'n3':
            filename = TEMPLATE_PATH / 'continue_n3.yaml'
        elif logic == 'cql':
            filename = TEMPLATE_PATH / 'continue_cql.yaml'
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
    filled_content = template['content']
    if '{ORIGINAL_DOC}' in filled_content:
        filled_content = filled_content.replace(
            '{ORIGINAL_DOC}', original_doc
        )
    if '{TASK_1_RESPONSE}' in filled_content and responses:
        filled_content = filled_content.replace(
            '{TASK_1_RESPONSE}', responses['task_1']
        )
    if '{TASK_2_RESPONSE}' in filled_content and responses:
        filled_content = filled_content.replace(
            '{TASK_2_RESPONSE}', responses['task_2']
        )

    return {
        **template,
        'content': filled_content
    }