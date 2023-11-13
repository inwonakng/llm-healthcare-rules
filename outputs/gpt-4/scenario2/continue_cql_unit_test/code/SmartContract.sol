```
pragma solidity ^0.8.0;

contract IVIGCoverage {
    struct Patient {
        bool primaryImmuneDeficiencyDiseaseDiagnosis;
        bool ivigMedicallyAppropriate;
        bool ivigProvidedAtHome;
    }

    mapping(address => Patient) public patients;

    function setPatient(address _address, bool _primaryImmuneDeficiencyDiseaseDiagnosis, bool _ivigMedicallyAppropriate, bool _ivigProvidedAtHome) public {
        Patient storage patient = patients[_address];
        patient.primaryImmuneDeficiencyDiseaseDiagnosis = _primaryImmuneDeficiencyDiseaseDiagnosis;
        patient.ivigMedicallyAppropriate = _ivigMedicallyAppropriate;
        patient.ivigProvidedAtHome = _ivigProvidedAtHome;
    }

    function primaryImmuneDeficiencyDiseaseDiagnosis(address _address) public view returns(bool) {
        return patients[_address].primaryImmuneDeficiencyDiseaseDiagnosis;
    }

    function ivigMedicallyAppropriate(address _address) public view returns(bool) {
        return patients[_address].ivigMedicallyAppropriate;
    }

    function ivigProvidedAtHome(address _address) public view returns(bool) {
        return patients[_address].ivigProvidedAtHome;
    }

    function partBCoverage(address _address) public view returns(bool) {
        return patients[_address].primaryImmuneDeficiencyDiseaseDiagnosis && patients[_address].ivigMedicallyAppropriate && patients[_address].ivigProvidedAtHome;
    }

    function finalCoverageDecision(address _address) public view returns(string memory) {
        if(partBCoverage(_address)) {
            return "Covered";
        } else {
            return "Not Covered";
        }
    }
}