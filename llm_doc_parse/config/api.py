import os
from dotenv import load_dotenv
from .path import DOTENV_DIR
load_dotenv(DOTENV_DIR)

def load_api_config(model_name):
    if model_name in ['gpt-4', 'gpt-4-1106-preview', 'gpt-3.5-turbo', 'gpt-3.5-turbo-1106']:
        url = "https://api.openai.com/v1/chat/completions"
        api_key = os.environ['OPENAI_API_KEY']
    else:
        url = "http://127.0.0.1:5000/v1/chat/completions"
        api_key = 'sk-111111111111111111111111111111111111111111111111'
    return {
        'url': url,
        'api_key': api_key
    }
