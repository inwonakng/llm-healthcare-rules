// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IVIGCoverageContract {
    // Define a struct to encapsulate patient information for cleaner code
    struct PatientInfo {
        bool hasPrimaryImmuneDeficiencyDisease;
        bool doctorApprovedHomeIVIG;
        bool ivigMedicationCoveredByPartB;
        bool otherItemsAndServicesNotCovered;
    }

    // Function to check the eligibility of IVIG coverage based on the patient's information
    function checkEligibility(
        bool hasPrimaryImmuneDeficiencyDisease,
        bool doctorApprovedHomeIVIG,
        bool ivigMedicationCoveredByPartB,
        bool otherItemsAndServicesNotCovered
    ) public pure returns (bool) {
        // Check all conditions for eligibility
        return (
            hasPrimaryImmuneDeficiencyDisease &&
            doctorApprovedHomeIVIG &&
            ivigMedicationCoveredByPartB &&
            otherItemsAndServicesNotCovered
        );
    }
}