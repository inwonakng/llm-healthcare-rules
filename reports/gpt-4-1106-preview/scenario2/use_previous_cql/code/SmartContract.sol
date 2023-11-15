// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IVIGCoveragePolicy {
    // Define a struct to encapsulate patient information
    struct Patient {
        string id;
        string homeLocation;
        bool hasPrimaryImmuneDeficiency;
        uint256 periodInHomeStart;
        uint256 periodInHomeEnd;
    }

    // Define a struct to encapsulate procedure information
    struct Procedure {
        string code;
        string location;
        uint256 occurrenceDateTime;
    }

    // Define a struct to encapsulate procedure request information
    struct ProcedureRequest {
        string code;
        string reasonCode;
        uint256 occurrenceDateTime;
        string performerQualificationCode;
        string performerQualificationSystem;
    }

    // Define a struct to encapsulate coverage information
    struct Coverage {
        string code;
        uint256 benefitPeriodStart;
        uint256 benefitPeriodEnd;
    }

    // Define a struct to encapsulate claim information
    struct Claim {
        string category;
        string insuranceReference;
    }

    // Check if IVIG is provided in the patient's home
    function IVIGProvidedInHome(Procedure memory procedure) private pure returns (bool) {
        return keccak256(abi.encodePacked(procedure.location)) == keccak256(abi.encodePacked("Patient's Home"));
    }

    // Check if the patient has a primary immune deficiency
    function HasPrimaryImmuneDeficiency(Patient memory patient) private pure returns (bool) {
        return patient.hasPrimaryImmuneDeficiency;
    }

    // Check if it is medically appropriate for the patient to receive IVIG at home
    function MedicallyAppropriateForHomeIVIG(ProcedureRequest memory procedureRequest, Patient memory patient) private pure returns (bool) {
        bool isDuringPeriodInHome = procedureRequest.occurrenceDateTime >= patient.periodInHomeStart && procedureRequest.occurrenceDateTime <= patient.periodInHomeEnd;
        bool isQualifiedMD = keccak256(abi.encodePacked(procedureRequest.performerQualificationCode)) == keccak256(abi.encodePacked("MD")) &&
                             keccak256(abi.encodePacked(procedureRequest.performerQualificationSystem)) == keccak256(abi.encodePacked("http://terminology.hl7.org/CodeSystem/v2-0360/2.7"));
        return isDuringPeriodInHome && isQualifiedMD;
    }

    // Check if Medicare Part B covers the cost of IVIG
    function PartBCoverageIVIG(Coverage memory coverage) private view returns (bool) {
        return keccak256(abi.encodePacked(coverage.code)) == keccak256(abi.encodePacked("Medicare Part B")) &&
               coverage.benefitPeriodStart <= block.timestamp && coverage.benefitPeriodEnd >= block.timestamp;
    }

    // Check if Medicare Part B does not cover the cost of other items and services related to the administration of IVIG at home
    function PartBDoesNotCoverRelatedServices(Claim memory claim) private pure returns (bool) {
        return !(keccak256(abi.encodePacked(claim.category)) == keccak256(abi.encodePacked("Related Services")) &&
                 keccak256(abi.encodePacked(claim.insuranceReference)) == keccak256(abi.encodePacked("Medicare Part B")));
    }

    // Determine the final coverage decision based on all conditions
    function FinalCoverageDecision(
        Patient memory patient,
        Procedure memory procedure,
        ProcedureRequest memory procedureRequest,
        Coverage memory coverage,
        Claim memory claim
    ) public view returns (bool) {
        return IVIGProvidedInHome(procedure) &&
               HasPrimaryImmuneDeficiency(patient) &&
               MedicallyAppropriateForHomeIVIG(procedureRequest, patient) &&
               PartBCoverageIVIG(coverage) &&
               PartBDoesNotCoverRelatedServices(claim);
    }
}