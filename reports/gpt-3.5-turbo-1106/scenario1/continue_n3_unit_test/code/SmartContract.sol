// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicareCoverageContract {
    struct Individual {
        bool meetsCriteriaForHomeHealthBenefit;
        bool hasFractureRelatedToOsteoporosis;
        bool unableToSelfAdminister;
        bool familyOrCaregiversUnableOrUnwilling;
    }

    function checkCoverage(Individual memory individual) public pure returns (bool) {
        if (individual.meetsCriteriaForHomeHealthBenefit &&
            individual.hasFractureRelatedToOsteoporosis &&
            individual.unableToSelfAdminister) {
            return true;
        } else if (individual.meetsCriteriaForHomeHealthBenefit &&
            individual.hasFractureRelatedToOsteoporosis &&
            individual.familyOrCaregiversUnableOrUnwilling) {
            return true;
        } else {
            return false;
        }
    }
}