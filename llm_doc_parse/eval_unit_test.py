from typing import Literal
import yaml
import json
import click

from .config.path import OUTPUT_PATH, TEMPLATE_PATH, DOC_PATH
from .prompt import Prompt
from .utils import progress_bar, parse_mode, extract_codeblock, remove_imports

@click.command()
@click.argument('doc_name', default='scenario1')
@click.option('--model', default='gpt-3.5-turbo')
@click.option('--mode', default='all')
def run(
    doc_name: Literal['scenario1','scenario2', 'scenario3'],
    model: Literal['gpt-3.5-turbo', 'gpt-4', 'gpt-4-1106-preview', 'codellama'],
    mode: str = 'all',
):
    # filter out ones that don't have unit_test in it
    modes_to_run = [m for m in parse_mode(mode) if 'unit_test' in m]

    with progress_bar() as progress:    
        run_task = progress.add_task(f'{model} -- {doc_name}', total=len(modes_to_run))
        for mode in modes_to_run:
            save_dir = OUTPUT_PATH/model/doc_name/mode
            configs = yaml.safe_load(open(TEMPLATE_PATH/f'{mode}.yaml'))
            output_files = [
                (save_dir / f"{i}_{raw_conf['task']}.txt")
                for i, raw_conf in enumerate(configs)
            ]
            if not all(f.is_file() for f in output_files):
                print(f'{mode} is not complete, skipping..')
                continue

            # load the unit_test and solidity file
            unit_test_output, solidity_output = '', ''
            for f in output_files:
                if 'unit_test' in f.name:
                    unit_test_output = open(f).read()
                if 'solidity' in f.name:
                    solidity_output = open(f).read()
            if not unit_test_output:
                print(f'{mode}: unit_test output is empty, skipping..')
            if not solidity_output:
                print(f'{mode}: solidity output is empty, skipping..')

            unit_test_code = remove_imports(extract_codeblock(unit_test_output))
            solidity_code = extract_codeblock(solidity_output)
            
            code_save_dir = save_dir / 'code'
            code_save_dir.mkdir(exist_ok=True, parents=True)
            open(code_save_dir / 'unit_test.sol', 'w').write(unit_test_code)
            open(code_save_dir / 'smart_contract.sol', 'w').write(solidity_code)

            print('-'*20 + 'unit_test' + '-'*20)
            print(unit_test_code)
            print('-'*20 + 'smart contract' + '-'*20)
            print(solidity_code)
            print('='*50)

            progress.advance(run_task)
            break

if __name__ == "__main__":
    run()
