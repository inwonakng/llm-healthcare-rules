// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OsteoporosisDrugCoverage {
    // Struct to encapsulate patient information
    struct PatientInfo {
        bool isWoman;
        bool hasOsteoporosis;
        bool qualifiesForMedicareHomeHealth;
        bool hasCertifiedFracture;
        bool canSelfAdminister;
        bool hasAideAvailable;
    }

    // Function to check if the patient is eligible for injectable osteoporosis drugs coverage
    function isEligibleForCoverage(
        bool isWoman,
        bool hasOsteoporosis,
        bool qualifiesForMedicareHomeHealth,
        bool hasCertifiedFracture,
        bool canSelfAdminister
    ) public pure returns (bool) {
        return isWoman &&
               hasOsteoporosis &&
               qualifiesForMedicareHomeHealth &&
               hasCertifiedFracture &&
               !canSelfAdminister;
    }

    // Function to check if the patient is eligible for home health nurse or aide coverage
    function isNurseOrAideCovered(
        bool isWoman,
        bool hasOsteoporosis,
        bool qualifiesForMedicareHomeHealth,
        bool hasCertifiedFracture,
        bool canSelfAdminister,
        bool hasAideAvailable
    ) public pure returns (bool) {
        return isEligibleForCoverage(
            isWoman,
            hasOsteoporosis,
            qualifiesForMedicareHomeHealth,
            hasCertifiedFracture,
            canSelfAdminister
        ) && !hasAideAvailable;
    }

    // Function to make a coverage decision based on the patient's information
    function makeCoverageDecision(PatientInfo memory patient) public pure returns (bool drugCoverage, bool nurseAideCoverage) {
        drugCoverage = isEligibleForCoverage(
            patient.isWoman,
            patient.hasOsteoporosis,
            patient.qualifiesForMedicareHomeHealth,
            patient.hasCertifiedFracture,
            patient.canSelfAdminister
        );

        nurseAideCoverage = isNurseOrAideCovered(
            patient.isWoman,
            patient.hasOsteoporosis,
            patient.qualifiesForMedicareHomeHealth,
            patient.hasCertifiedFracture,
            patient.canSelfAdminister,
            patient.hasAideAvailable
        );

        return (drugCoverage, nurseAideCoverage);
    }
}