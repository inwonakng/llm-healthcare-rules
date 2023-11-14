pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";

contract Medicare {
    function isCovered(address patient, string memory diagnosis) public view returns (bool) {
        // Check if patient has a diagnosis of primary immune deficiency disease
        if (diagnosis == "primary immune deficiency disease") {
            return true;
        }
        return false;
    }

    function isCoveredAtHome(address patient, string memory diagnosis) public view returns (bool) {
        // Check if patient has a diagnosis of primary immune deficiency disease
        if (diagnosis == "primary immune deficiency disease") {
            // Check if patient's doctor determines it is medically appropriate for them to receive IVIG at home
            if (patient.doctor.isMedicallyAppropriate(patient, "IVIG")) {
                return true;
            }
        }
        return false;
    }
}

contract MedicareTest {
    function testIsCovered() public {
        Medicare medicare = new Medicare();
        address patient = address(0x123);
        string memory diagnosis = "primary immune deficiency disease";
        assertTrue(medicare.isCovered(patient, diagnosis));
    }

    function testIsCoveredAtHome() public {
        Medicare medicare = new Medicare();
        address patient = address(0x123);
        string memory diagnosis = "primary immune deficiency disease";
        assertTrue(medicare.isCoveredAtHome(patient, diagnosis));
    }
}