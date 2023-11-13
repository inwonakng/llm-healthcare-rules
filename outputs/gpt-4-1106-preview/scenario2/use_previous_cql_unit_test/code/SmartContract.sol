// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IVIGCoverageContract {
    // Define a struct to encapsulate patient information and service request
    struct PatientServiceRequest {
        bool isProvidedInHome;
        bool hasPrimaryImmuneDeficiency;
        bool isMedicallyAppropriate;
        bool isCoveredByMedicarePartB;
        bool hasOtherItemsAndServices;
    }

    // Check if IVIG is provided in the patient's home
    function isIVIGProvidedInHome(bool isProvidedInHome) public pure returns (bool) {
        return isProvidedInHome;
    }

    // Check if the patient has a diagnosis of primary immune deficiency disease
    function hasDiagnosisOfPrimaryImmuneDeficiency(bool hasPrimaryImmuneDeficiency) public pure returns (bool) {
        return hasPrimaryImmuneDeficiency;
    }

    // Check if it is medically appropriate for the patient to receive IVIG at home
    function isMedicallyAppropriateForHomeIVIG(bool isMedicallyAppropriate) public pure returns (bool) {
        return isMedicallyAppropriate;
    }

    // Check if Medicare Part B covers the cost of IVIG
    function isCoveredByMedicarePartB(bool isCoveredByMedicarePartB) public pure returns (bool) {
        return isCoveredByMedicarePartB;
    }

    // Check if Medicare Part B does not cover the cost of other items and services related to IVIG at home
    function isExclusionOfOtherItemsAndServices(bool hasOtherItemsAndServices) public pure returns (bool) {
        return !hasOtherItemsAndServices;
    }

    // Determine IVIG coverage eligibility based on the provided information
    function determineIVIGCoverageEligibility(PatientServiceRequest memory request) public pure returns (bool) {
        return isIVIGProvidedInHome(request.isProvidedInHome) &&
               hasDiagnosisOfPrimaryImmuneDeficiency(request.hasPrimaryImmuneDeficiency) &&
               isMedicallyAppropriateForHomeIVIG(request.isMedicallyAppropriate) &&
               isCoveredByMedicarePartB(request.isCoveredByMedicarePartB) &&
               isExclusionOfOtherItemsAndServices(request.hasOtherItemsAndServices);
    }
}