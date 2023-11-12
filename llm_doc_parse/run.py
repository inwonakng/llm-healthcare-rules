from typing import Literal
import yaml
import json
import click

from .config.path import OUTPUT_PATH, TEMPLATE_PATH, DOC_PATH
from .prompt import Prompt
from .utils import progress_bar

all_modes = [
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
@click.option('--mode', default='all')
def run(
    doc_name: Literal['scenario1','scenario2', 'scenario3'],
    model: Literal['gpt-3.5-turbo', 'gpt-4', 'gpt-4-1106-preview', 'codellama'],
    mode: str = 'all',
):
    document = open(DOC_PATH/f'{doc_name}.txt').read()
    prompt = Prompt.load_from_file(TEMPLATE_PATH/'tasks.yaml')
    
    modes_to_run = all_modes
    if mode != 'all':
        if not mode in all_modes:
            raise Exception(f'Unknown mode {mode}')
        modes_to_run = [ mode ]
    
    with progress_bar() as progress:    
        run_task = progress.add_task(f'{model} -- {doc_name}', total=len(modes_to_run))
        for mode in modes_to_run:
            save_dir = OUTPUT_PATH/model/doc_name/mode
            save_dir.mkdir(parents=True, exist_ok=True)
            continue_conversation = 'continue' in mode
            configs = yaml.safe_load(open(TEMPLATE_PATH/f'{mode}.yaml'))
            prompt.execute(
                model = model,
                configs = configs,
                document = document,
                continue_conversation = continue_conversation,
                save_dir = save_dir,
                progress = progress,
                mode = mode,
            )
            progress.advance(run_task)

if __name__ == "__main__":
    run()
