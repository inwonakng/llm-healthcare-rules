pragma solidity ^0.8.0;

contract MedicareIVIG {
    address public owner;
    mapping(address => bool) public primaryImmuneDeficiency;
    mapping(address => bool) public medicallyAppropriate;
    mapping(address => bool) public ivigCovered;
    mapping(address => bool) public otherItemsServicesCovered;

    constructor() public {
        owner = msg.sender;
    }

    function setPrimaryImmuneDeficiency(address patient, bool value) public {
        require(msg.sender == owner, "Only the owner can set primary immune deficiency");
        primaryImmuneDeficiency[patient] = value;
    }

    function setMedicallyAppropriate(address patient, bool value) public {
        require(msg.sender == owner, "Only the owner can set medically appropriate");
        medicallyAppropriate[patient] = value;
    }

    function setIVIGCovered(address patient, bool value) public {
        require(msg.sender == owner, "Only the owner can set IVIG covered");
        ivigCovered[patient] = value;
    }

    function setOtherItemsServicesCovered(address patient, bool value) public {
        require(msg.sender == owner, "Only the owner can set other items and services covered");
        otherItemsServicesCovered[patient] = value;
    }

    function getFinalDecision(address patient) public view returns (bool) {
        return primaryImmuneDeficiency[patient] && medicallyAppropriate[patient] && ivigCovered[patient] && otherItemsServicesCovered[patient];
    }
}