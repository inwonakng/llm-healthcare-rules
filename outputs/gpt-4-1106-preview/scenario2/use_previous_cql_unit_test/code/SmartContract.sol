// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IVIGCoverageContract {
    // Define a struct to encapsulate patient details for cleaner code
    struct PatientDetails {
        bool hasPrimaryImmuneDeficiency;
        bool isMedicallyAppropriate;
        bool isAtHome;
        bool isMedicationCoveredByPartB;
        bool isServicesCovered;
    }

    // Check if IVIG is provided at home
    function IVIGProvidedInHome(bool isAtHome) private pure returns (bool) {
        return isAtHome;
    }

    // Check if patient has a diagnosis of primary immune deficiency disease
    function PrimaryImmuneDeficiencyDiseaseDiagnosis(bool hasPrimaryImmuneDeficiency) private pure returns (bool) {
        return hasPrimaryImmuneDeficiency;
    }

    // Check if it is medically appropriate for the patient to receive IVIG at home
    function MedicallyAppropriateForHomeIVIG(bool isMedicallyAppropriate, bool isAtHome) private pure returns (bool) {
        return isMedicallyAppropriate && isAtHome;
    }

    // Check if Medicare Part B covers the IVIG medication
    function IVIGMedicationCoveredByPartB(bool isMedicationCoveredByPartB) private pure returns (bool) {
        return isMedicationCoveredByPartB;
    }

    // Check if Medicare Part B does not cover other items and services
    function NonCoveredItemsAndServices(bool isServicesCovered) private pure returns (bool) {
        return !isServicesCovered;
    }

    // Determine IVIG coverage eligibility
    function isCovered(PatientDetails memory patient) public pure returns (bool) {
        return IVIGProvidedInHome(patient.isAtHome) &&
               PrimaryImmuneDeficiencyDiseaseDiagnosis(patient.hasPrimaryImmuneDeficiency) &&
               MedicallyAppropriateForHomeIVIG(patient.isMedicallyAppropriate, patient.isAtHome) &&
               IVIGMedicationCoveredByPartB(patient.isMedicationCoveredByPartB) &&
               NonCoveredItemsAndServices(patient.isServicesCovered);
    }

    // Separate functions for unit tests to call
    function isMedicationCovered(bool hasPrimaryImmuneDeficiency, bool isMedicallyAppropriate, bool isAtHome) public pure returns (bool) {
        return IVIGMedicationCoveredByPartB(hasPrimaryImmuneDeficiency && isMedicallyAppropriate && isAtHome);
    }

    function isServicesCovered(bool hasPrimaryImmuneDeficiency, bool isMedicallyAppropriate, bool isAtHome) public pure returns (bool) {
        return NonCoveredItemsAndServices(hasPrimaryImmuneDeficiency && isMedicallyAppropriate && isAtHome);
    }
}