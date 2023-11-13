import os
import subprocess
from llm_doc_parse.config.path import HARDHAT_DIR

def run_hardhat_compile() -> tuple[str,str]:
    original_directory = os.getcwd()
    hardhat_project_directory = HARDHAT_DIR
    os.chdir(hardhat_project_directory)
    result = subprocess.run(
        ["npx", "hardhat", "compile"],
        capture_output=True,
        text=True
    )
    os.chdir(original_directory)
    return result.stdout, result.stderr

def run_hardhat_tests() -> tuple[str,str]:
    original_directory = os.getcwd()
    hardhat_project_directory = HARDHAT_DIR
    os.chdir(hardhat_project_directory)
    result = subprocess.run(
        ["npx", "hardhat", "test"], 
        capture_output=True,
        text=True
    )
    os.chdir(original_directory)
    return result.stdout, result.stderr