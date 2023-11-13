// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title IVIGCoverage contract for determining coverage of IVIG under Medicare Part B
contract IVIGCoverage {
    // Struct to encapsulate patient information
    struct PatientInfo {
        bool hasPrimaryImmuneDeficiency;
        bool medicallyAppropriateForHomeIVIG;
    }

    // Mapping to store patient information based on an identifier (e.g., Ethereum address)
    mapping(address => PatientInfo) private patientRecords;

    // Event to emit the result of coverage check
    event CoverageCheckCompleted(address patient, bool isCovered, bool isMedicationCovered, bool isServiceCovered);

    /// @notice Set patient's primary immune deficiency condition
    /// @param patient The address identifier of the patient
    /// @param hasCondition Whether the patient has primary immune deficiency
    function setPrimaryImmuneDeficiency(address patient, bool hasCondition) public {
        patientRecords[patient].hasPrimaryImmuneDeficiency = hasCondition;
    }

    /// @notice Set whether it's medically appropriate for the patient to receive home IVIG
    /// @param patient The address identifier of the patient
    /// @param isAppropriate Whether it's medically appropriate for home IVIG
    function setMedicallyAppropriateForHomeIVIG(address patient, bool isAppropriate) public {
        patientRecords[patient].medicallyAppropriateForHomeIVIG = isAppropriate;
    }

    /// @notice Check the coverage for IVIG under Medicare Part B for a patient
    /// @param patient The address identifier of the patient
    /// @return isCovered Whether IVIG is covered
    /// @return isMedicationCovered Whether the IVIG medication is covered
    /// @return isServiceCovered Whether the services related to IVIG administration are covered
    function checkCoverage(address patient) public returns (bool isCovered, bool isMedicationCovered, bool isServiceCovered) {
        PatientInfo memory info = patientRecords[patient];

        // Check if the patient has primary immune deficiency and it's medically appropriate for home IVIG
        isCovered = info.hasPrimaryImmuneDeficiency && info.medicallyAppropriateForHomeIVIG;
        // Medicare Part B covers the IVIG medication itself
        isMedicationCovered = isCovered;
        // Medicare Part B does not cover other items and services related to IVIG administration at home
        isServiceCovered = false;

        emit CoverageCheckCompleted(patient, isCovered, isMedicationCovered, isServiceCovered);
        return (isCovered, isMedicationCovered, isServiceCovered);
    }
}