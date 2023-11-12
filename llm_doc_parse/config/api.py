import os
from dotenv import load_dotenv
from .path import DOTENV_PATH
load_dotenv(DOTENV_PATH)

def load_api_config(model_name):
    if model_name in ['gpt-4', 'gpt-3.5-turbo']:
        url = "https://api.openai.com/v1/chat/completions"
        api_key = os.environ['OPENAI_API_KEY']
    else:
        url = "http://127.0.0.1:5000/v1/chat/completions"
        api_key = 'sk-111111111111111111111111111111111111111111111111'
    return {
        'url': url,
        'api_key': api_key
    }