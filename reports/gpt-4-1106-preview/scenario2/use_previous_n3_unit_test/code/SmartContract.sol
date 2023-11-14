// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IVIGCoverageContract {
    // Define a struct to encapsulate patient information
    struct Patient {
        bool hasPrimaryImmuneDeficiency;
        bool hasDoctorApproval;
        bool receivesTreatmentAtHome;
    }

    // Define a struct to encapsulate insurance information
    struct Insurance {
        bool isMedicarePartB;
    }

    // Check if the patient is eligible for IVIG coverage
    function isEligibleForCoverage(Patient memory patient) public pure returns (bool) {
        return patient.hasPrimaryImmuneDeficiency && patient.hasDoctorApproval && patient.receivesTreatmentAtHome;
    }

    // Check if Medicare Part B covers the medication cost for an eligible patient
    function coversMedicationCost(Patient memory patient, Insurance memory insurance) public pure returns (bool) {
        bool eligibleForCoverage = isEligibleForCoverage(patient);
        return eligibleForCoverage && patient.receivesTreatmentAtHome && insurance.isMedicarePartB;
    }

    // Check if Medicare Part B does not cover additional items or services
    function doesNotCoverAdditionalItemsOrServices(Patient memory patient, Insurance memory insurance) public pure returns (bool) {
        bool eligibleForCoverage = isEligibleForCoverage(patient);
        return eligibleForCoverage && patient.receivesTreatmentAtHome && insurance.isMedicarePartB;
    }
}