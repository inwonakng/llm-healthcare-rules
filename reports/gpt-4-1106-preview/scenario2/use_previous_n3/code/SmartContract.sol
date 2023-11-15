// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicareCoverageContract {
    struct Patient {
        string diagnosis;
        bool hasDoctorApproval;
        bool eligibleForHomeIVIGCoverage;
    }

    struct Medicare {
        bool partBCoversIVIG;
        bool coversIVIG;
        bool coversIVIGMedication;
        bool doesNotCoverRelatedItemsAndServices;
    }

    Medicare public medicare;

    constructor() {
        // Initialize Medicare coverage according to the policy
        medicare.partBCoversIVIG = true;
        medicare.coversIVIG = false;
        medicare.coversIVIGMedication = false;
        medicare.doesNotCoverRelatedItemsAndServices = false;
    }

    function checkEligibilityForHomeIVIGCoverage(Patient memory patient) public returns (bool) {
        // Check if the patient is diagnosed with primary immune deficiency disease and has doctor's approval
        if (keccak256(abi.encodePacked(patient.diagnosis)) == keccak256(abi.encodePacked("primary immune deficiency disease")) && patient.hasDoctorApproval) {
            patient.eligibleForHomeIVIGCoverage = true;
            medicare.coversIVIG = true;
        } else {
            patient.eligibleForHomeIVIGCoverage = false;
            medicare.coversIVIG = false;
        }
        return patient.eligibleForHomeIVIGCoverage;
    }

    function updateMedicareCoverage() public {
        if (medicare.coversIVIG && medicare.partBCoversIVIG) {
            medicare.coversIVIGMedication = true;
            medicare.doesNotCoverRelatedItemsAndServices = true;
        } else {
            medicare.coversIVIGMedication = false;
            medicare.doesNotCoverRelatedItemsAndServices = false;
        }
    }

    // Function to simulate the process of checking coverage for a patient
    function processCoverage(string memory diagnosis, bool hasDoctorApproval) public returns (bool, bool, bool) {
        Patient memory patient = Patient({
            diagnosis: diagnosis,
            hasDoctorApproval: hasDoctorApproval,
            eligibleForHomeIVIGCoverage: false
        });

        bool isEligible = checkEligibilityForHomeIVIGCoverage(patient);
        updateMedicareCoverage();

        return (
            isEligible,
            medicare.coversIVIGMedication,
            medicare.doesNotCoverRelatedItemsAndServices
        );
    }
}