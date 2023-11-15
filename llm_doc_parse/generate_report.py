import pandas as pd
from collections import Counter
import json

from .config.path import REPORT_DIR
from .config.models import OPENAI_MODELS, TEXTGEN_MODELS, MODEL_PRETTY_NAMES

models = [*OPENAI_MODELS, *TEXTGEN_MODELS]
scenarios = ['scenario1', 'scenario2', 'scenario3']

sc_report = pd.concat([
    pd.read_csv(
        REPORT_DIR/m/f'{s}_sc_aggregated.csv'
    ).assign(**{
        "Scenario": s,
        "Model": m
    })
    for m in models
    for s in scenarios
])

ut_report = pd.concat([
    pd.read_csv(
        REPORT_DIR/m/f'{s}_ut_aggregated.csv'
    ).assign(**{
        "Scenario": s,
        "Model": m
    })
    for m in models
    for s in scenarios
])

# Collect all errors for pretty printing
all_errors = sorted(set(
    [
        k 
        for v in sc_report["Compile Error Types"].values 
        for k in json.loads(v).keys()
    ] + [
        k 
        for v in ut_report["Compile Error Types"].values 
        for k in json.loads(v).keys()
    ]
)) 

sc_stats = []
for m, by_model in sc_report.groupby("Model"):
    for s, by_scenario in by_model.groupby("Scenario"):
        for mo, by_mode in by_scenario.groupby("Mode"):
            compile_errors = Counter()
            for v in by_mode["Compile Error Types"].values:
                compile_errors += Counter(json.loads(v)) 
            sc_stats += [{
                "Model": m,
                "Scenario": s, 
                "Mode": mo, 
                "Compile Success": by_mode["Compile Success"].values[0],
                "Warnings": int(by_mode["Compile Warning Count"].values.sum()),
                **{
                    k: int(compile_errors[k])
                    for k in all_errors
                },
                "Total": sum([
                    int(compile_errors[k])
                    for k in all_errors
                ]),
            }]
            

sc_stats = pd.DataFrame(sc_stats)
sc_stats.to_csv(REPORT_DIR/'sc_report.csv', index=False)

sc_table = pd.DataFrame([
    {
        'Model': m,
        'Scenario': s,
        'Compile Success': str(by_scenario['Compile Success'].values.sum()) + '/' + str(len(by_scenario)),
        **{
            cc: by_scenario[cc].sum()
            for cc in ["Warnings"] + all_errors + ["Total"]
        }
    }
    for m, by_model in sc_stats.groupby('Model')
    for s, by_scenario in by_model.groupby('Scenario')
])

sc_table.to_csv(REPORT_DIR/'sc_table.csv', index=False)


ut_stats = []
for m, by_model in ut_report.groupby("Model"):
    for s, by_scenario in by_model.groupby("Scenario"):
        for mo, by_mode in by_scenario.groupby("Mode"):
            compile_errors = Counter()
            for v in by_mode["Compile Error Types"].values:
                compile_errors += Counter(json.loads(v)) 
            ut_stats += [{
                "Model": m,
                "Scenario": s, 
                "Mode": mo, 
                "Compile Success": by_mode["Compile Success"].values[0],
                "Warnings": int(by_mode["Compile Warning Count"].values.sum()),
                **{
                    k: int(compile_errors[k])
                    for k in all_errors
                },
                "Total": sum([
                    int(compile_errors[k])
                    for k in all_errors
                ]),
            }]

ut_stats = pd.DataFrame(ut_stats)
ut_stats.to_csv(REPORT_DIR/'ut_report.csv', index=False)

ut_table = pd.DataFrame([
    {
        'Model': m,
        'Scenario': s,
        'Compile Success': str(by_scenario['Compile Success'].values.sum()) + '/' + str(len(by_scenario)),
        **{
            cc: by_scenario[cc].sum()
            for cc in ["Warnings"] + all_errors + ["Total"]
        }
    }
    for m, by_model in ut_stats.groupby('Model')
    for s, by_scenario in by_model.groupby('Scenario')
])

ut_table.to_csv(REPORT_DIR/'ut_table.csv', index=False)
