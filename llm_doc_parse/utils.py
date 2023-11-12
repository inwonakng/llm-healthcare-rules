import re
import rich.progress

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

def progress_bar():
    return rich.progress.Progress(
        '[progress.description]{task.description}',
        rich.progress.BarColumn(),
        '[progress.percentage]{task.percentage:>3.0f}%',
        rich.progress.TimeRemainingColumn(),
        rich.progress.TimeElapsedColumn(),
    )
