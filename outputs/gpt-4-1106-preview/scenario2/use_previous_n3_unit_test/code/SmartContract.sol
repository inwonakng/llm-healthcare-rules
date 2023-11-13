// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IVIGCoverageContract {
    // Define a struct to encapsulate the parameters for cleaner code
    struct IVIGCoverageParams {
        bool providedInHome;
        bool hasPrimaryImmuneDeficiency;
        bool medicallyAppropriate;
    }

    // Function to determine if IVIG is covered
    function isIVIGCovered(IVIGCoverageParams memory params) public pure returns (bool coverage, bool partBCoversIVIG, bool partBDoesNotCoverRelatedServices) {
        // Check if all conditions for coverage are met
        bool isEligibleForCoverage = params.providedInHome && params.hasPrimaryImmuneDeficiency && params.medicallyAppropriate;

        // Medicare Part B covers the cost of IVIG if eligible
        partBCoversIVIG = isEligibleForCoverage;

        // Medicare Part B does not cover the cost of other items and services related to the administration of IVIG at home
        partBDoesNotCoverRelatedServices = isEligibleForCoverage;

        // Return the coverage status along with details about what Medicare Part B covers
        return (isEligibleForCoverage, partBCoversIVIG, partBDoesNotCoverRelatedServices);
    }
}