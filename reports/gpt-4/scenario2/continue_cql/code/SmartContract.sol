pragma solidity ^0.8.0;

contract IVIGCoverage {
    struct Patient {
        bool primaryImmuneDeficiencyDiagnosis;
        bool doctorsDecision;
        bool ivigProvidedAtHome;
    }

    mapping(address => Patient) public patients;

    function setPatient(address _patient, bool _primaryImmuneDeficiencyDiagnosis, bool _doctorsDecision, bool _ivigProvidedAtHome) public {
        Patient storage patient = patients[_patient];
        patient.primaryImmuneDeficiencyDiagnosis = _primaryImmuneDeficiencyDiagnosis;
        patient.doctorsDecision = _doctorsDecision;
        patient.ivigProvidedAtHome = _ivigProvidedAtHome;
    }

    function checkCoverageEligibility(address _patient) public view returns (bool) {
        Patient storage patient = patients[_patient];
        return (patient.primaryImmuneDeficiencyDiagnosis && patient.doctorsDecision && patient.ivigProvidedAtHome);
    }
}