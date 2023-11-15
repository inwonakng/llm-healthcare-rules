import re

def remove_ansi(output: str) -> str:
    ansi_escape = re.compile(r'(?:\x1B[@-_]|[\x80-\x9F])[0-?]*[ -/]*[@-~]')
    return ansi_escape.sub('', output)
    
def count_warnings(output: str) -> int:
    return sum([
        'warning' in line.lower() and not 'spdx' in line.lower()
        for line in remove_ansi(output).split('\n')
    ])

def find_errors(output: str) -> list[str]:
    # ignore compile fail error
    errors = '\n'.join(
        line 
        for line in remove_ansi(output).split('\n') 
        if(
            'error' in line.lower() 
            and not 'compilation failed' in line.lower()
            and not 'using npm' in line.lower()
        )
    )
    error_types = re.findall(r'\b\w*Error\w*\b', errors)
    return error_types
