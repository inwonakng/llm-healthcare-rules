# Prompts for generating smart contracts from natural language documents

## Prompts

[prompts](prompts)

Contains the prompts for each task.

**Task 1**

Summarize natural language into a numbered list. May be used for Task 2.

**Task 2**

Use input to extract logical rules.

**Task 3**

Use input logical rules to generate a smart contract.

### Output formats

**N3**

**CQL**

### Task setup

**Use Model Output**

The tasks use the model's output from the previous tasks.

**Use Natural Language**

Each task is done using the original document

## Tests

[tests](tests)

Contins the input text sampled from [Medicare benefits document](https://www.medicare.gov/Pubs/pdf/10116-your-medicare-benefits.pdf).

## Outputs

[outputs](outputs)

Contains the ouputs from chatGPT. 

## Running the tests programmatically

Python version: 3.10

You can run each test through [run_tests.ipynb](run_tests.ipynb). 

The easiest way to run this file is through vscode or a jupyter server.

The environment can be set up through conda using [environment.yml](environment.yml).

The only requirements necessary are `openai` and `jupyter`, so you can also install on a venv or your base environment by running

```
pip install openai jupyter notebook ipykernel
```

