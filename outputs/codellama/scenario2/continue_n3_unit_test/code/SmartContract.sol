pragma solidity ^0.8.0;

contract Medicare {
    address public patient;
    string public diagnosis;
    bool public isCovered;

    constructor(address _patient, string memory _diagnosis) public {
        patient = _patient;
        diagnosis = _diagnosis;
        isCovered = false;
    }

    function isCovered() public view returns (bool) {
        if (diagnosis == "primary immune deficiency disease") {
            return true;
        }
        return false;
    }

    function isCoveredAtHome() public view returns (bool) {
        if (diagnosis == "primary immune deficiency disease" && patient.doctor.isMedicallyAppropriate(patient, "IVIG")) {
            return true;
        }
        return false;
    }
}