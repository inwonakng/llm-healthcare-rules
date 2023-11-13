from typing import Literal
import shutil
import yaml
import click

from .config.path import OUTPUT_DIR, TEMPLATES_DIR, HARDHAT_DIR, REPORT_DIR
from .prompt import Prompt
from .utils import (
    progress_bar,
    parse_mode,
    parse_solidity,
    run_hardhat_compile,
)

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
            save_dir = OUTPUT_DIR/model/doc_name/mode
            configs = yaml.safe_load(open(TEMPLATES_DIR/f'{mode}.yaml'))
            output_files = [
                (save_dir / f"{i}_{raw_conf['task']}.txt")
                for i, raw_conf in enumerate(configs)
            ]
            if not all(f.is_file() for f in output_files):
                print(f'{mode} is not complete, skipping..')
                continue

            # load the unit_test and solidity file
            unit_test_output, smart_contract_output = '', ''
            for f in output_files:
                if 'unit_test' in f.name:
                    unit_test_output = open(f).read()
                if 'smart_contract' in f.name:
                    smart_contract_output = open(f).read()
            if not unit_test_output:
                print(f'{mode}: unit_test output is empty, skipping..')
            if not smart_contract_output:
                print(f'{mode}: solidity output is empty, skipping..')

            unit_test_code = parse_solidity(
                unit_test_output,
                solidity_version = '0.8.0',
                new_imports = [
                    './SmartContract.sol',
                    './remix_tests.sol'
                ]
            )
            smart_contract_code = parse_solidity(
                smart_contract_output,
                solidity_version = '0.8.0',
            )
            
            code_save_dir = save_dir / 'code'
            code_save_dir.mkdir(parents=True, exist_ok=True)
            
            unit_test_file = code_save_dir / 'UnitTest.sol'
            smart_contract_file = code_save_dir / 'SmartContract.sol'
            hardhat_unit_test_file = HARDHAT_DIR / 'contracts/UnitTest.sol'
            hardhat_smart_contract_file = HARDHAT_DIR / 'contracts/SmartContract.sol'
            hardhat_remix_test_file = HARDHAT_DIR / 'contracts/remix_tests.sol'
            hardhat_remix_test_template_file = HARDHAT_DIR / 'remix/remix_tests.sol'

            open(unit_test_file, 'w').write(unit_test_code)
            open(smart_contract_file, 'w').write(smart_contract_code)

            report_dir = REPORT_DIR/model/doc_name/mode
            report_dir.mkdir(parents=True, exist_ok=True)

            # Compile just the smart contract
            shutil.copy(smart_contract_file, hardhat_smart_contract_file)
            stdout_msg, stderr_msg = run_hardhat_compile()
            open(report_dir / 'contract_compile_stdout.txt', 'w').write(stdout_msg)
            open(report_dir / 'contract_compile_stderr.txt', 'w').write(stderr_msg)

            # Compile the unit test with the smart contract
            shutil.copy(hardhat_remix_test_template_file, hardhat_remix_test_file)
            shutil.copy(unit_test_file, hardhat_unit_test_file)
            stdout_msg, stderr_msg = run_hardhat_compile()
            open(report_dir / 'test_compile_stdout.txt', 'w').write(stdout_msg)
            open(report_dir / 'test_compile_stderr.txt', 'w').write(stderr_msg)

            # Clean up
            if hardhat_remix_test_file.is_file():
                hardhat_remix_test_file.unlink()
            if hardhat_smart_contract_file.is_file():
                hardhat_smart_contract_file.unlink()
            if hardhat_unit_test_file.is_file():
                hardhat_unit_test_file.unlink()
            
            progress.advance(run_task)
            # break

if __name__ == "__main__":
    run()
