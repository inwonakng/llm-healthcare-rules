```
pragma solidity ^0.8.0;

contract OsteoporosisDrugCoverage {
    struct Patient {
        string gender;
        bool hasOsteoporosis;
        string medicareHomeHealthBenefitStatus;
        bool hasFractureDueToPostMenopausalOsteoporosis;
        string selfAdministerAbility;
        string caregiverAdministerAbility;
    }

    function isWomanWithOsteoporosis(string memory gender, bool hasOsteoporosis) public pure returns (bool) {
        return (keccak256(abi.encodePacked(gender)) == keccak256(abi.encodePacked('female')) && hasOsteoporosis);
    }

    function qualifiesForMedicareHomeHealthBenefit(string memory status) public pure returns (bool) {
        return (keccak256(abi.encodePacked(status)) == keccak256(abi.encodePacked('active')));
    }

    function fractureDueToPostMenopausalOsteoporosis(bool hasFracture) public pure returns (bool) {
        return hasFracture;
    }

    function unableToSelfAdminister(string memory ability) public pure returns (bool) {
        return (keccak256(abi.encodePacked(ability)) == keccak256(abi.encodePacked('unable')));
    }

    function familyOrCaregiversUnableOrUnwilling(string memory ability) public pure returns (bool) {
        return (keccak256(abi.encodePacked(ability)) == keccak256(abi.encodePacked('unable')) || keccak256(abi.encodePacked(ability)) == keccak256(abi.encodePacked('unwilling')));
    }

    function eligibleForCoverage(string memory gender, bool hasOsteoporosis, string memory status, bool hasFracture, string memory selfAbility, string memory caregiverAbility) public pure returns (bool) {
        return isWomanWithOsteoporosis(gender, hasOsteoporosis) && qualifiesForMedicareHomeHealthBenefit(status) && fractureDueToPostMenopausalOsteoporosis(hasFracture) && unableToSelfAdminister(selfAbility) && familyOrCaregiversUnableOrUnwilling(caregiverAbility);
    }
}