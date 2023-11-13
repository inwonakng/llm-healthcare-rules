1. hasDiagnosisOfPrimaryImmuneDeficiency: patient.diagnosis = "primary immune deficiency disease"
2. isMedicallyAppropriateForHomeIVIG: hasDiagnosisOfPrimaryImmuneDeficiency and patient.location = "home"
3. isCoveredByMedicarePartB: hasDiagnosisOfPrimaryImmuneDeficiency
4. isNotCoveredByMedicarePartB: not isCoveredByMedicarePartB