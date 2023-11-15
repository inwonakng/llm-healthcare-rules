pragma solidity ^0.8.0;

contract MedicareIVIG {
    struct Patient {
        address patientAddress;
        string diagnosis;
        bool doctorApproval;
    }

    mapping(address => Patient) public patients;

    function addPatient(address patientAddress, string memory diagnosis, bool doctorApproval) public {
        patients[patientAddress] = Patient(patientAddress, diagnosis, doctorApproval);
    }

    function isCovered(address patientAddress) public view returns (bool) {
        Patient memory patient = patients[patientAddress];
        if (patient.diagnosis == "primary immune deficiency disease" && patient.doctorApproval) {
            return true;
        }
        return false;
    }

    function isNotCovered(address patientAddress) public view returns (bool) {
        Patient memory patient = patients[patientAddress];
        if (patient.diagnosis != "primary immune deficiency disease" || !patient.doctorApproval) {
            return true;
        }
        return false;
    }
}