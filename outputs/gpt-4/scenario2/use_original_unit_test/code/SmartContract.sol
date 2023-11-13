// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Patient {
        bool hasPrimaryImmuneDeficiency;
        bool isMedicallyAppropriateForIVIG;
        bool isIVIGProvidedAtHome;
    }

    mapping(address => Patient) public patients;

    function setPatientDetails(address _patientAddress, bool _hasPrimaryImmuneDeficiency, bool _isMedicallyAppropriateForIVIG, bool _isIVIGProvidedAtHome) public {
        Patient memory patient = Patient(_hasPrimaryImmuneDeficiency, _isMedicallyAppropriateForIVIG, _isIVIGProvidedAtHome);
        patients[_patientAddress] = patient;
    }

    function isIVIGCovered(address _patientAddress) public view returns (bool) {
        Patient memory patient = patients[_patientAddress];
        if(patient.hasPrimaryImmuneDeficiency && patient.isMedicallyAppropriateForIVIG && patient.isIVIGProvidedAtHome) {
            return true;
        } else {
            return false;
        }
    }

    function isOtherItemsAndServicesCovered(address _patientAddress) public pure returns (bool) {
        return false;
    }
}