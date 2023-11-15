pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Patient {
        string name;
        bool hasPrimaryImmuneDeficiency;
        bool isMedicallyAppropriateForIVIG;
        bool isIVIGProvidedAtHome;
    }

    mapping(address => Patient) public patients;

    function registerPatient(
        address _patientAddress,
        string memory _name,
        bool _hasPrimaryImmuneDeficiency,
        bool _isMedicallyAppropriateForIVIG,
        bool _isIVIGProvidedAtHome
    ) public {
        patients[_patientAddress] = Patient({
            name: _name,
            hasPrimaryImmuneDeficiency: _hasPrimaryImmuneDeficiency,
            isMedicallyAppropriateForIVIG: _isMedicallyAppropriateForIVIG,
            isIVIGProvidedAtHome: _isIVIGProvidedAtHome
        });
    }

    function isIVIGCovered(address _patientAddress) public view returns (string memory) {
        Patient memory patient = patients[_patientAddress];

        if (!patient.hasPrimaryImmuneDeficiency) {
            return "Patient does not have primary immune deficiency, IVIG is not covered.";
        }

        if (!patient.isMedicallyAppropriateForIVIG) {
            return "It is not medically appropriate for the patient to get IVIG, hence it is not covered.";
        }

        if (!patient.isIVIGProvidedAtHome) {
            return "IVIG is not provided at home, hence it is not covered.";
        }

        return "IVIG is covered, but other items and services related to getting the IVIG at home are not covered.";
    }
}