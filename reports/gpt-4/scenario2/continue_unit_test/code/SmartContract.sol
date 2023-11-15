pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Patient {
        bool hasPrimaryImmuneDeficiency;
        bool isIVIGProvided;
        bool isDoctorApproved;
    }

    mapping(address => Patient) public patients;

    function setPatient(address _patient, bool _hasPrimaryImmuneDeficiency, bool _isIVIGProvided, bool _isDoctorApproved) public {
        patients[_patient] = Patient(_hasPrimaryImmuneDeficiency, _isIVIGProvided, _isDoctorApproved);
    }

    function checkCoverage(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        if(patient.hasPrimaryImmuneDeficiency && patient.isIVIGProvided && patient.isDoctorApproved) {
            return true;
        } else {
            return false;
        }
    }

    function checkNonIVIGCoverage() public pure returns (bool) {
        return false;
    }
}