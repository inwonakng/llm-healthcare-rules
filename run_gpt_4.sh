python -m llm_doc_parse.run scenario1 --model gpt-4 --mode use_original --logic n3
python -m llm_doc_parse.run scenario2 --model gpt-4 --mode use_original --logic n3
python -m llm_doc_parse.run scenario3 --model gpt-4 --mode use_original --logic n3

python -m llm_doc_parse.run scenario1 --model gpt-4 --mode use_previous --logic n3
python -m llm_doc_parse.run scenario2 --model gpt-4 --mode use_previous --logic n3
python -m llm_doc_parse.run scenario3 --model gpt-4 --mode use_previous --logic n3

python -m llm_doc_parse.run scenario1 --model gpt-4 --mode continue --logic n3
python -m llm_doc_parse.run scenario2 --model gpt-4 --mode continue --logic n3
python -m llm_doc_parse.run scenario3 --model gpt-4 --mode continue --logic n3

python -m llm_doc_parse.run scenario1 --model gpt-4 --mode use_original --logic cql
python -m llm_doc_parse.run scenario2 --model gpt-4 --mode use_original --logic cql
python -m llm_doc_parse.run scenario3 --model gpt-4 --mode use_original --logic cql

python -m llm_doc_parse.run scenario1 --model gpt-4 --mode use_previous --logic cql
python -m llm_doc_parse.run scenario2 --model gpt-4 --mode use_previous --logic cql
python -m llm_doc_parse.run scenario3 --model gpt-4 --mode use_previous --logic cql

python -m llm_doc_parse.run scenario1 --model gpt-4 --mode continue --logic cql
python -m llm_doc_parse.run scenario2 --model gpt-4 --mode continue --logic cql
python -m llm_doc_parse.run scenario3 --model gpt-4 --mode continue --logic cql