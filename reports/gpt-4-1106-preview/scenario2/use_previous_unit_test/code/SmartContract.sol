// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IVIGInsurancePolicy {
    // Struct to encapsulate patient details and treatment conditions
    struct PatientTreatment {
        bool hasPrimaryImmuneDeficiency;
        bool isMedicallyAppropriate;
        bool isAtHome;
    }

    // Function to check if IVIG is covered under the policy
    function isCovered(
        string memory treatmentType,
        bool hasPrimaryImmuneDeficiency,
        bool isMedicallyAppropriate,
        bool isAtHome
    ) public pure returns (bool) {
        // Check if the treatment is IVIG
        if (keccak256(abi.encodePacked(treatmentType)) == keccak256(abi.encodePacked("IVIG"))) {
            // Check if all conditions are met
            if (hasPrimaryImmuneDeficiency && isMedicallyAppropriate && isAtHome) {
                return true;
            }
        }
        return false;
    }

    // Function to check if Medicare Part B covers the IVIG medication
    function partBCoverage(string memory treatmentType) public pure returns (bool) {
        // Check if the treatment is IVIG
        return keccak256(abi.encodePacked(treatmentType)) == keccak256(abi.encodePacked("IVIG"));
    }

    // Function to check if Medicare Part B covers additional items or services
    function partBCoverageForServices(string memory treatmentType) public pure returns (bool) {
        // Medicare Part B does not cover additional items or services for IVIG
        return false;
    }
}