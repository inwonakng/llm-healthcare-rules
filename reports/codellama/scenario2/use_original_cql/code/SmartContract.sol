pragma solidity ^0.8.0;

contract IVIG {
    struct Patient {
        address patientAddress;
        string diagnosis;
        bool medicareCoverage;
        bool primaryImmuneDeficiencyDisease;
        bool ivigAdministered;
    }

    mapping(address => Patient) public patients;

    function setPatient(address patientAddress, string memory diagnosis, bool medicareCoverage, bool primaryImmuneDeficiencyDisease, bool ivigAdministered) public {
        patients[patientAddress] = Patient(patientAddress, diagnosis, medicareCoverage, primaryImmuneDeficiencyDisease, ivigAdministered);
    }

    function getPatient(address patientAddress) public view returns (Patient memory) {
        return patients[patientAddress];
    }

    function isMedicareCovered(address patientAddress) public view returns (bool) {
        return patients[patientAddress].medicareCoverage;
    }

    function isPrimaryImmuneDeficiencyDisease(address patientAddress) public view returns (bool) {
        return patients[patientAddress].primaryImmuneDeficiencyDisease;
    }

    function isIVIGAdministered(address patientAddress) public view returns (bool) {
        return patients[patientAddress].ivigAdministered;
    }
}