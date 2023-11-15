pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Patient {
        bool hasPrimaryImmuneDeficiencyDisease;
        bool receivesIVIGAtHome;
        bool doctorDecidesMedicallyAppropriate;
        bool hasInsuranceCoveragePartB;
        bool hasInsuranceCoverageIVIG;
        bool doesNotHaveInsuranceCoverageOtherItemsAndServices;
    }

    mapping(address => Patient) public patients;

    function setPatient(address _patient, bool _hasPrimaryImmuneDeficiencyDisease, bool _receivesIVIGAtHome, bool _doctorDecidesMedicallyAppropriate) public {
        Patient storage patient = patients[_patient];
        patient.hasPrimaryImmuneDeficiencyDisease = _hasPrimaryImmuneDeficiencyDisease;
        patient.receivesIVIGAtHome = _receivesIVIGAtHome;
        patient.doctorDecidesMedicallyAppropriate = _doctorDecidesMedicallyAppropriate;

        if(_hasPrimaryImmuneDeficiencyDisease && _receivesIVIGAtHome && _doctorDecidesMedicallyAppropriate) {
            patient.hasInsuranceCoveragePartB = true;
        }

        if(_receivesIVIGAtHome && _doctorDecidesMedicallyAppropriate) {
            patient.hasInsuranceCoverageIVIG = true;
        }

        if(_receivesIVIGAtHome && patient.hasInsuranceCoverageIVIG) {
            patient.doesNotHaveInsuranceCoverageOtherItemsAndServices = true;
        }
    }

    function checkCoverage(address _patient) public view returns (bool, bool, bool) {
        Patient storage patient = patients[_patient];
        return (patient.hasInsuranceCoveragePartB, patient.hasInsuranceCoverageIVIG, patient.doesNotHaveInsuranceCoverageOtherItemsAndServices);
    }
}