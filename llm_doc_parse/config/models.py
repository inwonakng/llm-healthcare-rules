from typing import Literal

OPENAI_MODELS = [
    'gpt-3.5-turbo',
    'gpt-3.5-turbo-1106',
    'gpt-4',
    'gpt-4-1106-preview', 
]

TEXTGEN_MODELS = [
    'codellama',
]

PRETTY_MODEL_NAMES = {
    "codellama": "CodeLLaMA",
    "gpt-3.5-turbo": "GPT-3.5 Turbo",
    "gpt-3.5-turbo-1106": "GPT-3.5 Turbo-16K",
    "gpt-4": "GPT-4",
    "gpt-4-1106-preview": "GPT-4 Turbo",
}

ModelNamesType = Literal[*OPENAI_MODELS, *TEXTGEN_MODELS]
