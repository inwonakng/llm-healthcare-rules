pragma solidity ^0.8.0;

contract MedicareContract {
    struct Patient {
        string gender;
        bool hasOsteoporosis;
        bool hasBoneFracture;
        bool isPostMenopausal;
        bool canSelfAdminister;
    }

    struct HealthCareProvider {
        bool isHomeHealthNurseOrAide;
        bool canAdministerInjection;
    }

    mapping(string => bool) public coveredDrugs;

    constructor() public {
        coveredDrugs["Injectable Osteoporosis Drugs"] = true;
    }

    function isCovered(string memory drug) public view returns(bool) {
        return coveredDrugs[drug];
    }

    function isEligible(string memory gender, string memory condition) public pure returns(bool) {
        return (keccak256(abi.encodePacked(gender)) == keccak256(abi.encodePacked("Woman")) && keccak256(abi.encodePacked(condition)) == keccak256(abi.encodePacked("Osteoporosis")));
    }

    function isFractureRelatedToPostMenopausalOsteoporosis(bool hasBoneFracture, bool isPostMenopausal) public pure returns(bool) {
        return (hasBoneFracture && isPostMenopausal);
    }

    function isPatientUnableToSelfAdminister(bool canSelfAdminister) public pure returns(bool) {
        return !canSelfAdminister;
    }

    function isHomeHealthNurseOrAideCovered(bool isHomeHealthNurseOrAide, bool canAdministerInjection) public pure returns(bool) {
        return (isHomeHealthNurseOrAide && canAdministerInjection);
    }
}