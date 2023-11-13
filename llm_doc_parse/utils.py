import re
import rich.progress

def extract_codeblock(string):
    match = re.findall(
        r'```(?:\w+)?\s*([\s\S]+?)\s*```',
        string,
    )
    if match:
        return match[0].strip()
    else:
        raise Exception('No codeblock found!')

def remove_imports(code):
    return re.sub(r'^\s*import.*?;', '', code, flags=re.MULTILINE)

def progress_bar(transient: bool = False):
    return rich.progress.Progress(
        '[progress.description]{task.description}',
        rich.progress.BarColumn(),
        '[progress.percentage]{task.percentage:>3.0f}%',
        '({task.completed}/{task.total})',
        rich.progress.TimeRemainingColumn(),
        rich.progress.TimeElapsedColumn(),
        transient = transient,
    )

all_modes = [
    'use_original_n3',
    'use_original_cql',
    'use_original_unit_test',
    'use_previous_n3',
    'use_previous_cql',
    'use_previous_unit_test',
    'use_previous_n3_unit_test',
    'use_previous_cql_unit_test',
    'continue_n3',
    'continue_cql',
    'continue_unit_test',
    'continue_n3_unit_test', 
    'continue_cql_unit_test', 
]

def parse_mode(mode: str) -> list[str]:
    modes_to_run = []
    for mo in mode.split('|'):
        if mo == 'all':
            modes_to_run += all_modes
        elif mo == 'n3': 
            modes_to_run += [m for m in all_modes if 'n3' in m]
        elif mo == 'cql': 
            modes_to_run += [m for m in all_modes if 'cql' in m]
        elif mo == 'unit_test': 
            modes_to_run += [m for m in all_modes if 'unit_test' in m]
        elif mo == 'n3_unit_test': 
            modes_to_run += [m for m in all_modes if 'n3_unit_test' in m]
        elif mo == 'cql_unit_test': 
            modes_to_run += [m for m in all_modes if 'cql_unit_test' in m]
        elif mo == 'use_original': 
            modes_to_run += [m for m in all_modes if 'use_original' in m]
        elif mo == 'use_previous': 
            modes_to_run += [m for m in all_modes if 'use_previous' in m]
        elif mo == 'continue': 
            modes_to_run += [m for m in all_modes if 'continue' in m]
        else:
            if not mode in all_modes:
                raise Exception(f'Unknown mode {mode}')
            modes_to_run = [ mode ]
    return list(set(modes_to_run))
