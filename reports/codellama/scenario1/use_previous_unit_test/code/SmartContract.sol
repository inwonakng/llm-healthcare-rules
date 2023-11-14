pragma solidity ^0.8.0;

contract InjectableOsteoporosisDrugs {
    struct Patient {
        address patientAddress;
        bool isWomanWithOsteoporosis;
        bool hasBoneFracture;
        bool isPostMenopausalOsteoporosis;
        bool cannotGiveInjection;
        bool cannotLearnInjection;
        bool hasHomeHealthCoverage;
        bool isUnableToGiveInjection;
    }

    mapping(address => Patient) public patients;

    function addPatient(address patientAddress, bool isWomanWithOsteoporosis, bool hasBoneFracture, bool isPostMenopausalOsteoporosis, bool cannotGiveInjection, bool cannotLearnInjection, bool hasHomeHealthCoverage, bool isUnableToGiveInjection) public {
        patients[patientAddress] = Patient(patientAddress, isWomanWithOsteoporosis, hasBoneFracture, isPostMenopausalOsteoporosis, cannotGiveInjection, cannotLearnInjection, hasHomeHealthCoverage, isUnableToGiveInjection);
    }

    function isWomanWithOsteoporosis(address patientAddress) public view returns (bool) {
        return patients[patientAddress].isWomanWithOsteoporosis;
    }

    function hasBoneFracture(address patientAddress) public view returns (bool) {
        return patients[patientAddress].hasBoneFracture;
    }

    function isPostMenopausalOsteoporosis(address patientAddress) public view returns (bool) {
        return patients[patientAddress].isPostMenopausalOsteoporosis;
    }

    function cannotGiveInjection(address patientAddress) public view returns (bool) {
        return patients[patientAddress].cannotGiveInjection;
    }

    function cannotLearnInjection(address patientAddress) public view returns (bool) {
        return patients[patientAddress].cannotLearnInjection;
    }

    function hasHomeHealthCoverage(address patientAddress) public view returns (bool) {
        return patients[patientAddress].hasHomeHealthCoverage;
    }

    function isUnableToGiveInjection(address patientAddress) public view returns (bool) {
        return patients[patientAddress].isUnableToGiveInjection;
    }
}