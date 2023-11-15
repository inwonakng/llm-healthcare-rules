// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IVIGInsurancePolicy {
    // Define a struct to encapsulate patient details and IVIG treatment information
    struct Patient {
        string diagnosis;
        bool isMedicallyAppropriate;
        bool hasPrimaryImmuneDeficiencyDisease;
    }

    // Mapping to store patient details based on an identifier (e.g., patient ID)
    mapping(uint256 => Patient) public patients;

    // Event to emit when IVIG is approved for a patient
    event IVIGApproved(uint256 patientId);

    // Event to emit when IVIG is not approved for a patient
    event IVIGNotApproved(uint256 patientId, string reason);

    // Function to add or update a patient's details
    function setPatientDetails(
        uint256 patientId,
        string memory diagnosis,
        bool isMedicallyAppropriate,
        bool hasPrimaryImmuneDeficiencyDisease
    ) public {
        patients[patientId] = Patient({
            diagnosis: diagnosis,
            isMedicallyAppropriate: isMedicallyAppropriate,
            hasPrimaryImmuneDeficiencyDisease: hasPrimaryImmuneDeficiencyDisease
        });
    }

    // Function to check if a patient is eligible for IVIG coverage
    function checkIVIGEligibility(uint256 patientId) public returns (bool) {
        Patient memory patient = patients[patientId];

        // Check if the patient has a primary immune deficiency disease
        if (!patient.hasPrimaryImmuneDeficiencyDisease) {
            emit IVIGNotApproved(patientId, "Patient does not have a primary immune deficiency disease.");
            return false;
        }

        // Check if it's medically appropriate for the patient to get IVIG at home
        if (!patient.isMedicallyAppropriate) {
            emit IVIGNotApproved(patientId, "It is not medically appropriate for the patient to get IVIG at home.");
            return false;
        }

        // If all conditions are met, approve IVIG
        emit IVIGApproved(patientId);
        return true;
    }

    // Function to simulate the coverage of IVIG under Part B
    function coverIVIG(uint256 patientId) public returns (string memory) {
        bool isEligible = checkIVIGEligibility(patientId);

        if (isEligible) {
            // Part B covers the IVIG itself
            return "IVIG is covered under Part B for the patient.";
        } else {
            // Part B does not cover other items and services related to getting IVIG at home
            return "IVIG is not covered under Part B for the patient.";
        }
    }
}