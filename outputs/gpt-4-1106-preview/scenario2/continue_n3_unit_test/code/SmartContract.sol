// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IVIGCoverageContract {
    // Define a struct to encapsulate patient information
    struct Patient {
        bool hasPrimaryImmuneDeficiencyDisease;
        bool hasDoctorApproval;
        bool receivesIVIGAtHome;
    }

    // Function to check if the patient is eligible for IVIG coverage
    function checkCoverage(
        bool hasPrimaryImmuneDeficiencyDisease,
        bool hasDoctorApproval,
        bool receivesIVIGAtHome
    ) public pure returns (bool) {
        // Check all conditions for eligibility
        return hasPrimaryImmuneDeficiencyDisease && hasDoctorApproval && receivesIVIGAtHome;
    }

    // Function to check if the patient is covered for related services
    function checkRelatedServicesCoverage(
        bool receivesIVIGAtHome
    ) public pure returns (bool) {
        // Patients are not covered for related services when receiving IVIG at home
        return !receivesIVIGAtHome;
    }
}