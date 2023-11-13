// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicareContract {
    // Define a struct to encapsulate patient details for cleaner code
    struct PatientDetails {
        bool isWoman;
        bool hasOsteoporosis;
        bool qualifiesForHomeHealthBenefit;
        bool hasCertifiedFracture;
        bool canSelfAdminister;
        bool hasAbleCaregiver;
    }

    // Function to check if the patient is covered by the insurance policy
    function checkCoverage(
        bool isWoman,
        bool hasOsteoporosis,
        bool qualifiesForHomeHealthBenefit,
        bool hasCertifiedFracture,
        bool canSelfAdminister,
        bool hasAbleCaregiver
    ) public pure returns (bool) {
        // Check if all conditions for coverage are met
        if (isWoman && hasOsteoporosis && qualifiesForHomeHealthBenefit && hasCertifiedFracture) {
            // Check if the patient is unable to self-administer or has no able caregiver
            if (!canSelfAdminister && !hasAbleCaregiver) {
                return true; // Covered
            }
        }
        return false; // Not covered
    }
}