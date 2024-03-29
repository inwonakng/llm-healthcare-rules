import re

def extract_codeblock(text):
    prev_is_delim = False
    codeblock_found = False
    codeblock = []
    for line in text.split('\n'):
        if not codeblock_found:
            # Logic for fiding the beginning of the codeblock
            if '```' in line:
                prev_is_delim = True
            elif prev_is_delim:
                # if previous line was a delimitor and this line is not, then we found the beginning of the codeblock
                codeblock_found = True
                codeblock += [line]
        else:
            if '```' in line:
                # if we found the end of the codeblock, then we are done
                break
            else:
                codeblock += [line]
    return '\n'.join(codeblock)

def remove_imports_solidity(code: str) -> str:
    return re.sub(
        r'^import.*$\n',
        '',
        code,
        flags=re.MULTILINE
    )

def inject_import_solidity(code: str, new_imports: list[str]) -> str:
    parsed_imports = '\n'.join(f'import "{n}";' for n in new_imports)
    return re.sub(
        r'pragma solidity[^;]+;$', 
        f'\\g<0>\n\n{parsed_imports}',
        code,
        flags = re.MULTILINE,
    )

def ensure_solidity_version(code: str, version: str) -> str:
    return re.sub(
        r'pragma solidity[^;]+;', 
        f'pragma solidity ^{version};',
        code,
        flags=re.MULTILINE
    )

def parse_solidity(
    text: str,
    solidity_version: str = '',
    new_imports: list[str ]= [],
):
    code = extract_codeblock(text)
    if solidity_version:
        code = ensure_solidity_version(code, solidity_version)
    if new_imports:
        code = remove_imports_solidity(code)
        code = inject_import_solidity(code, new_imports)
    return code
    
    
