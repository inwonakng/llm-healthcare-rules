import requests
from requests.packages import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

from .config.api import load_api_config

OpenAIMessageType = list[dict[str,str]]

CODELLAMA_ARGS = {
    "chat_instruct_command": '<|prompt|>',
    "instruction_template": "Llama-v2",
}

DEFAULT_ARGS = {
    'temperature': 1e-20,
    'top_p': 0.1,
}

def generate(
    model: str,
    messages: OpenAIMessageType,
):
    conf = load_api_config(model)
    headers = {
        "Content-Type": "application/json;charset=UTF-8",
        "Authorization": f"Bearer {conf['api_key']}"
    }

    data = DEFAULT_ARGS
    data['messages'] = messages

    if model in ['gpt-4', 'gpt-4-1106-preview', 'gpt-3.5-turbo-1106', 'gpt-3.5-turbo']:
        data['model'] = model
    else:
        data.update(CODELLAMA_ARGS)

    response = requests.post(
        url = conf['url'],
        headers=headers,
        json=data,
        verify=False
    )
    if response.status_code == 200:
        model_output = response.json()['choices'][0]['message']['content']
    else:
        raise Exception(f"Response returned with code {response.status_code}, message: {response.content.decode()}")
    
    return model_output
