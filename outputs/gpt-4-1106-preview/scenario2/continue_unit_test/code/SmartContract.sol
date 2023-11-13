// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IVIGCoverageContract {
    // Define a struct to encapsulate patient information and requirements
    struct Patient {
        bool hasPrimaryImmuneDeficiency;
        bool isMedicallyAppropriate;
        bool isAtHome;
    }

    // Function to check if the patient is eligible for IVIG coverage
    function checkCoverage(bool hasPrimaryImmuneDeficiency, bool isMedicallyAppropriate, bool isAtHome) public pure returns (bool) {
        // Check all conditions for IVIG coverage
        if (hasPrimaryImmuneDeficiency && isMedicallyAppropriate && isAtHome) {
            // If all conditions are met, return true for coverage
            return true;
        } else {
            // If any condition is not met, return false for no coverage
            return false;
        }
    }
}