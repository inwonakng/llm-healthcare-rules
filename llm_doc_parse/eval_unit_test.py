from typing import Literal
import re
import shutil
import yaml
import click
from collections import Counter
import json
import pandas as pd

from .config.path import OUTPUT_DIR, TEMPLATES_DIR, HARDHAT_DIR, REPORT_DIR
from .utils import (
    progress_bar,
    parse_mode,
    parse_solidity,
    run_hardhat_compile,
    count_warnings,
    find_errors,
)

@click.command()
@click.argument('doc_name', default='scenario1')
@click.option('--model', default='gpt-3.5-turbo')
@click.option('--mode', default='all')
def run(
    doc_name: Literal['scenario1','scenario2', 'scenario3'],
    model: Literal['gpt-3.5-turbo', 'gpt-3.5-turbo-1106', 'gpt-4', 'gpt-4-1106-preview', 'codellama'],
    mode: str = 'all',
):
    # filter out ones that don't have unit_test in it
    modes_to_run = [m for m in parse_mode(mode) if 'unit_test' in m]

    agg_report_file = REPORT_DIR/model/f'{doc_name}_aggregated.csv'
    results = []

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

            # prepare directories for saving 
            report_dir = REPORT_DIR/model/doc_name/mode
            report_dir.mkdir(parents=True, exist_ok=True)
            shutil.rmtree(save_dir / 'code')
            code_save_dir = report_dir / 'code'
            code_save_dir.mkdir(parents=True, exist_ok=True)
            
            unit_test_file = code_save_dir / 'UnitTest.sol'
            smart_contract_file = code_save_dir / 'SmartContract.sol'
            hardhat_unit_test_file = HARDHAT_DIR / 'contracts/UnitTest.sol'
            hardhat_smart_contract_file = HARDHAT_DIR / 'contracts/SmartContract.sol'
            hardhat_remix_test_file = HARDHAT_DIR / 'contracts/remix_tests.sol'
            hardhat_remix_test_template_file = HARDHAT_DIR / 'remix/remix_tests.sol'

            # load the unit_test and solidity file
            unit_test_output, smart_contract_output = '', ''
            unit_test_output_file, smart_contract_output_file = '',''
            for f in output_files:
                if 'unit_test' in f.name:
                    unit_test_output = open(f).read()
                    unit_test_output_file = f
                if 'smart_contract' in f.name:
                    smart_contract_output = open(f).read()
                    smart_contract_output_file = f

            sc_stdout_msg, sc_stderr_msg, ut_stdout_msg, ut_stderr_msg, parser_error_msg = '', '', '', '', ''

            if smart_contract_output:
                try:
                    smart_contract_code = parse_solidity(
                        smart_contract_output,
                        solidity_version = '0.8.0',
                    )
                    open(smart_contract_file, 'w').write(smart_contract_code)
                    # Compile just the smart contract
                    shutil.copy(smart_contract_file, hardhat_smart_contract_file)
                    sc_stdout_msg, sc_stderr_msg = run_hardhat_compile()
                    if unit_test_output:
                        try:
                            unit_test_code = parse_solidity(
                                unit_test_output,
                                solidity_version = '0.8.0',
                                new_imports = [
                                    './SmartContract.sol',
                                    './remix_tests.sol'
                                ]
                            )
                            open(unit_test_file, 'w').write(unit_test_code)
                            # Compile the unit test with the smart contract
                            shutil.copy(hardhat_remix_test_template_file, hardhat_remix_test_file)
                            shutil.copy(unit_test_file, hardhat_unit_test_file)
                            ut_stdout_msg, ut_stderr_msg = run_hardhat_compile()
                        except Exception as e:
                            parser_error_msg += f'{mode}: error parsing unit_test output.\ncheck {unit_test_output_file} for the original file.\n'
                            parser_error_msg += f'Exception detai:\n{e}\n'
                    else:
                        parser_error_msg += f'{mode}: unit_test output is empty.\ncheck {unit_test_output_file} for the original file.\n'
                except Exception:
                    parser_error_msg += f'{mode}: error parsing smart_contract output.\ncheck {smart_contract_output_file} for the original file.\n'
                    parser_error_msg += 'Exception message:\n{e}\n'
            else:
                parser_error_msg += f'{mode}: smart_contract output is empty.\ncheck {smart_contract_output_file} for the original file.\n'

            open(report_dir / 'contract_compile_stdout.txt', 'w').write(sc_stdout_msg)
            open(report_dir / 'contract_compile_stderr.txt', 'w').write(sc_stderr_msg)
            open(report_dir / 'test_compile_stdout.txt', 'w').write(ut_stdout_msg)
            open(report_dir / 'test_compile_stderr.txt', 'w').write(ut_stderr_msg)
            open(report_dir / 'parser_error.txt', 'w').write(parser_error_msg)

            # Clean up
            if hardhat_remix_test_file.is_file():
                hardhat_remix_test_file.unlink()
            if hardhat_smart_contract_file.is_file():
                hardhat_smart_contract_file.unlink()
            if hardhat_unit_test_file.is_file():
                hardhat_unit_test_file.unlink()

            sc_warning_count = count_warnings(sc_stderr_msg)
            sc_errors = find_errors(sc_stderr_msg)
            ut_warning_count = count_warnings(ut_stderr_msg)
            ut_errors = find_errors(ut_stderr_msg)
            sc_compile_success = len(re.findall('Compiled.*success.*', sc_stdout_msg)) > 0
            ut_compile_success = len(re.findall( 'Compiled.*success.*', ut_stdout_msg)) > 0

            results += [{
                "Mode": mode,
                "Smart Contract Compile Success": sc_compile_success,
                "Smart Contract Compile Warning Count": sc_warning_count,
                "Smart Contract Compile Error Count": len(sc_errors),
                "Smart Contract Compile Error Types": json.dumps(dict(Counter(sc_errors).most_common())),
                "Unit Test Compile Success": ut_compile_success,
                "Unit Test Compile Warning Count": ut_warning_count,
                "Unit Test Compile Error Count": len(ut_errors),
                "Unit Test Compile Error Types": json.dumps(dict(Counter(ut_errors).most_common())),
            }]
            
            progress.advance(run_task)

        results = pd.DataFrame(results)
        results.to_csv(agg_report_file, index=False)
        print(f'Saved results to {agg_report_file}')

if __name__ == "__main__":
    run()
