pragma solidity ^0.8.0;

contract MedicareCoverage {
    address private owner;
    mapping(address => bool) private patients;
    mapping(address => bool) private doctors;

    constructor() public {
        owner = msg.sender;
    }

    function addPatient(address patient) public {
        require(msg.sender == owner, "Only the owner can add patients");
        patients[patient] = true;
    }

    function addDoctor(address doctor) public {
        require(msg.sender == owner, "Only the owner can add doctors");
        doctors[doctor] = true;
    }

    function isPatient(address patient) public view returns (bool) {
        return patients[patient];
    }

    function isDoctor(address doctor) public view returns (bool) {
        return doctors[doctor];
    }

    function isCovered(address patient, address doctor) public view returns (bool) {
        return isPatient(patient) && isDoctor(doctor);
    }
}