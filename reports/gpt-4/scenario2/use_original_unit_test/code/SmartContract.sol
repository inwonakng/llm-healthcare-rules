// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InsurancePolicy {
    enum Status { NotProvided, Provided }
    enum Diagnosis { None, PrimaryImmuneDeficiencyDisease }

    struct Patient {
        Diagnosis diagnosis;
        bool isMedicallyAppropriate;
        bool isAtHome;
        Status ivigStatus;
    }

    mapping(address => Patient) public patients;

    function setPatient(
        address _patientAddress,
        Diagnosis _diagnosis,
        bool _isMedicallyAppropriate,
        bool _isAtHome
    ) public {
        patients[_patientAddress] = Patient(_diagnosis, _isMedicallyAppropriate, _isAtHome, Status.NotProvided);
    }

    function provideIVIG(address _patientAddress) public returns (string memory) {
        Patient storage patient = patients[_patientAddress];

        if (patient.diagnosis == Diagnosis.PrimaryImmuneDeficiencyDisease && patient.isMedicallyAppropriate && patient.isAtHome) {
            patient.ivigStatus = Status.Provided;
            return "IVIG provided at home.";
        } else {
            return "IVIG not provided. Patient does not meet the conditions.";
        }
    }

    function getIVIGStatus(address _patientAddress) public view returns (string memory) {
        Patient storage patient = patients[_patientAddress];

        if (patient.ivigStatus == Status.Provided) {
            return "IVIG provided at home.";
        } else {
            return "IVIG not provided.";
        }
    }
}