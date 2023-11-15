pragma solidity ^0.8.0;

contract OsteoporosisCoverage {
    address private owner;
    mapping(address => bool) private patients;
    mapping(address => bool) private doctors;
    mapping(address => bool) private nurses;

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

    function addNurse(address nurse) public {
        require(msg.sender == owner, "Only the owner can add nurses");
        nurses[nurse] = true;
    }

    function isPatient(address patient) public view returns (bool) {
        return patients[patient];
    }

    function isDoctor(address doctor) public view returns (bool) {
        return doctors[doctor];
    }

    function isNurse(address nurse) public view returns (bool) {
        return nurses[nurse];
    }

    function getPatient(address patient) public view returns (address) {
        require(isPatient(patient), "Patient not found");
        return patient;
    }

    function getDoctor(address doctor) public view returns (address) {
        require(isDoctor(doctor), "Doctor not found");
        return doctor;
    }

    function getNurse(address nurse) public view returns (address) {
        require(isNurse(nurse), "Nurse not found");
        return nurse;
    }

    function getCoverage(address patient) public view returns (bool) {
        require(isPatient(patient), "Patient not found");
        return true;
    }

    function getCoverage(address doctor) public view returns (bool) {
        require(isDoctor(doctor), "Doctor not found");
        return true;
    }

    function getCoverage(address nurse) public view returns (bool) {
        require(isNurse(nurse), "Nurse not found");
        return true;
    }
}