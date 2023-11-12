from .config.path import DOC_PATH

def load_document(doc_name: str) -> str:
    document = open(DOC_PATH / f'{doc_name}.txt').read()
    return document