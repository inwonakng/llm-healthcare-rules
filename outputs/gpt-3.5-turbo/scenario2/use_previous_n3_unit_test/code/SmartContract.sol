pragma solidity ^0.8.0;

contract InsuranceContract {
    struct Patient {
        bool hasPrimaryImmuneDeficiency;
        bool isMedicallyAppropriate;
        bool isIVIGCovered;
        bool isIVIGInHomeCovered;
        bool isIVIGCostCovered;
        bool doNotCoverOtherServices;
    }

    mapping(address => Patient) public patients;

    function addPatient(
        address patientAddress,
        bool hasPrimaryImmuneDeficiency,
        bool isMedicallyAppropriate
    ) external {
        patients[patientAddress] = Patient({
            hasPrimaryImmuneDeficiency: hasPrimaryImmuneDeficiency,
            isMedicallyAppropriate: isMedicallyAppropriate,
            isIVIGCovered: false,
            isIVIGInHomeCovered: false,
            isIVIGCostCovered: false,
            doNotCoverOtherServices: false
        });
    }

    function evaluateConditions(address patientAddress) external {
        Patient storage patient = patients[patientAddress];

        if (patient.hasPrimaryImmuneDeficiency && patient.isMedicallyAppropriate) {
            patient.isIVIGCovered = true;
        }

        if (patient.isIVIGCovered) {
            patient.isIVIGInHomeCovered = true;
            patient.isIVIGCostCovered = true;
        }

        if (patient.isIVIGInHomeCovered) {
            patient.doNotCoverOtherServices = true;
        }
    }

    function hasPrimaryImmuneDeficiency(address patientAddress) external view returns (bool) {
        return patients[patientAddress].hasPrimaryImmuneDeficiency;
    }

    function isMedicallyAppropriate(address patientAddress) external view returns (bool) {
        return patients[patientAddress].isMedicallyAppropriate;
    }

    function isIVIGCovered(address patientAddress) external view returns (bool) {
        return patients[patientAddress].isIVIGCovered;
    }

    function isIVIGInHomeCovered(address patientAddress) external view returns (bool) {
        return patients[patientAddress].isIVIGInHomeCovered;
    }

    function isIVIGCostCovered(address patientAddress) external view returns (bool) {
        return patients[patientAddress].isIVIGCostCovered;
    }

    function doNotCoverOtherServices(address patientAddress) external view returns (bool) {
        return patients[patientAddress].doNotCoverOtherServices;
    }
}