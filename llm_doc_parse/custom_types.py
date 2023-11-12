from typing import Literal

OpenAIMessage = list[dict[str, str]]
TextGenMessage = dict[
    Literal['user_input','history','context_instruct'], 
    str | dict[str, list[list[str]]]
]