// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Define a struct to encapsulate patient information for cleaner code
struct Patient {
    bool hasPrimaryImmuneDeficiency;
    bool hasDoctorApproval;
    bool receivesIVIGAtHome;
}

// The smart contract that handles Medicare Part B IVIG coverage eligibility
contract MedicarePartBIVIGCoverage {

    // Function to determine if a patient is eligible for Medicare Part B IVIG coverage
    function isEligibleForCoverage(Patient memory patient) public pure returns (bool eligible, bool coverageForIVIG, bool noCoverageForRelatedServices) {
        // Check all conditions for eligibility
        eligible = patient.hasPrimaryImmuneDeficiency && patient.hasDoctorApproval && patient.receivesIVIGAtHome;
        // If eligible, Medicare Part B covers IVIG but not related services
        coverageForIVIG = eligible;
        noCoverageForRelatedServices = eligible;
        return (eligible, coverageForIVIG, noCoverageForRelatedServices);
    }
}