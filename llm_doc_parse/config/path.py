from pathlib import Path

BASE_PATH = Path(__file__).parent.parent
OUTPUT_PATH = BASE_PATH.parent / 'outputs'
TEMPLATE_PATH = BASE_PATH.parent / 'templates'
DOC_PATH = BASE_PATH.parent / 'documents'
DOTENV_PATH = BASE_PATH.parent / '.env'