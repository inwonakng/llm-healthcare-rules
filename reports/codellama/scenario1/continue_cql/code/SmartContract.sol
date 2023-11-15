pragma solidity ^0.8.0;

contract MedicareCoverage {
    address public owner;
    mapping(address => bool) public isFemale;
    mapping(address => bool) public hasOsteoporosis;
    mapping(address => bool) public hasBoneFracture;
    mapping(address => bool) public fractureRelatedToOsteoporosis;
    mapping(address => bool) public canSelfAdministerDrug;
    mapping(address => bool) public hasCaregiver;
    mapping(address => bool) public caregiverUnwillingOrUnableToAdministerDrug;
    mapping(address => bool) public medicareCoverage;
    mapping(address => bool) public injectableOsteoporosisDrugCoverage;

    constructor() public {
        owner = msg.sender;
    }

    function setIsFemale(address patient, bool value) public {
        require(msg.sender == owner, "Only the owner can set this value");
        isFemale[patient] = value;
    }

    function setHasOsteoporosis(address patient, bool value) public {
        require(msg.sender == owner, "Only the owner can set this value");
        hasOsteoporosis[patient] = value;
    }

    function setHasBoneFracture(address patient, bool value) public {
        require(msg.sender == owner, "Only the owner can set this value");
        hasBoneFracture[patient] = value;
    }

    function setFractureRelatedToOsteoporosis(address patient, bool value) public {
        require(msg.sender == owner, "Only the owner can set this value");
        fractureRelatedToOsteoporosis[patient] = value;
    }

    function setCanSelfAdministerDrug(address patient, bool value) public {
        require(msg.sender == owner, "Only the owner can set this value");
        canSelfAdministerDrug[patient] = value;
    }

    function setHasCaregiver(address patient, bool value) public {
        require(msg.sender == owner, "Only the owner can set this value");
        hasCaregiver[patient] = value;
    }

    function setCaregiverUnwillingOrUnableToAdministerDrug(address patient, bool value) public {
        require(msg.sender == owner, "Only the owner can set this value");
        caregiverUnwillingOrUnableToAdministerDrug[patient] = value;
    }

    function setMedicareCoverage(address patient, bool value) public {
        require(msg.sender == owner, "Only the owner can set this value");
        medicareCoverage[patient] = value;
    }

    function setInjectableOsteoporosisDrugCoverage(address patient, bool value) public {
        require(msg.sender == owner, "Only the owner can set this value");
        injectableOsteoporosisDrugCoverage[patient] = value;
    }

    function getMedicareCoverage(address patient) public view returns (bool) {
        return medicareCoverage[patient];
    }

    function getInjectableOsteoporosisDrugCoverage(address patient) public view returns (bool) {
        return injectableOsteoporosisDrugCoverage[patient];
    }
}