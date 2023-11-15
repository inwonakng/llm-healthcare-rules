from typing import Literal
import yaml
import json
import click

from .config.path import OUTPUT_DIR, TEMPLATES_DIR, DOCS_DIR
from .config.models import OPENAI_MODELS, TEXTGEN_MODELS, ModelNamesType
from .prompt import Prompt
from .utils import parse_mode, progress_bar

@click.command()
@click.argument('doc_name', default='scenario1')
@click.option('--model', default='gpt-3.5-turbo')
@click.option('--mode', default='all')
def run(
    doc_name: Literal['scenario1','scenario2', 'scenario3'],
    model: ModelNamesType,
    mode: str = 'all',
):
    document = open(DOCS_DIR/f'{doc_name}.txt').read()
    prompt = Prompt.load_from_file(TEMPLATES_DIR/'tasks.yaml')
    
    modes_to_run = parse_mode(mode)
    with progress_bar() as progress:    
        run_task = progress.add_task(f'{model} -- {doc_name}', total=len(modes_to_run))
        for mode in modes_to_run:
            save_dir = OUTPUT_DIR/model/doc_name/mode
            save_dir.mkdir(parents=True, exist_ok=True)
            continue_conversation = 'continue' in mode
            configs = yaml.safe_load(open(TEMPLATES_DIR/f'{mode}.yaml'))

            if all(
                (save_dir / f"{i}_{raw_conf['task']}.txt").is_file()
                for i, raw_conf in enumerate(configs)
            ):
                progress.advance(run_task)
                continue

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
