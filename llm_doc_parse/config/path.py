from pathlib import Path

BASE_DIR = Path(__file__).parent.parent
OUTPUT_DIR = BASE_DIR.parent / 'outputs'
REPORT_DIR = BASE_DIR.parent / 'reports'
TEMPLATES_DIR = BASE_DIR.parent / 'templates'
DOCS_DIR = BASE_DIR.parent / 'documents'
DOTENV_DIR = BASE_DIR.parent / '.env'
HARDHAT_DIR = BASE_DIR.parent / 'sandbox'