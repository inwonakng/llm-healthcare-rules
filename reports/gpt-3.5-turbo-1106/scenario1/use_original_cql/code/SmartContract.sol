// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OsteoporosisInsurance {

    struct Patient {
        bool isWoman;
        bool meetsHomeHealthCriteria;
        bool hasFractureRelatedToOsteoporosis;
        bool needsAssistanceWithInjection;
        bool familyOrCaregiversUnavailable;
    }

    function isCovered(Patient memory patient) public pure returns (bool) {
        if (patient.isWoman &&
            patient.meetsHomeHealthCriteria &&
            patient.hasFractureRelatedToOsteoporosis &&
            patient.needsAssistanceWithInjection &&
            (patient.familyOrCaregiversUnavailable || !patient.familyOrCaregiversUnavailable)) {
            return true;
        } else {
            return false;
        }
    }
}