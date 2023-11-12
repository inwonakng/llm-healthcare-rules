import re

def extract_codeblock(string):
    match = re.match(
        '```(.*?)```',
        string,
        re.DOTALL
    )
    if match:
        return match.group(1).strip()
    else:
        return string.strip()
