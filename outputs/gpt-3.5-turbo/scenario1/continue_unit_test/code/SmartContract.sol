pragma solidity ^0.8.0;

contract InsuranceContract {
    struct Patient {
        bool meetsCriteria;
        bool hasFracture;
        bool unableToSelfInject;
        bool familyOrCaregiversUnableOrUnwilling;
    }

    function checkCoverageConditions(Patient memory patient) public pure returns (bool) {
        if (patient.meetsCriteria && patient.hasFracture && patient.unableToSelfInject) {
            return true;
        }
        return false;
    }
}