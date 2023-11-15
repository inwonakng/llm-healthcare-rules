// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IVIGInsurancePolicy {
    // Define a struct to encapsulate patient details and IVIG treatment information
    struct Patient {
        string diagnosis;
        bool isMedicallyAppropriate;
        bool hasPrimaryImmuneDeficiencyDisease;
    }

    // Mapping to store patient details based on an identifier (e.g., social security number or patient ID)
    mapping(uint256 => Patient) public patients;

    // Event to emit when IVIG is approved for a patient
    event IVIGApproved(uint256 patientId);

    // Event to emit when IVIG is not approved for a patient
    event IVIGNotApproved(uint256 patientId, string reason);

    // Modifier to check if the patient has a primary immune deficiency disease
    modifier hasPrimaryImmuneDeficiency(uint256 patientId) {
        require(patients[patientId].hasPrimaryImmuneDeficiencyDisease, "Patient does not have a primary immune deficiency disease.");
        _;
    }

    // Function to add or update a patient's details
    function setPatientDetails(uint256 patientId, string memory diagnosis, bool isMedicallyAppropriate, bool hasPrimaryImmuneDeficiencyDisease) public {
        patients[patientId] = Patient(diagnosis, isMedicallyAppropriate, hasPrimaryImmuneDeficiencyDisease);
    }

    // Function to determine if IVIG is covered for a patient
    function isIVIGCovered(uint256 patientId) public hasPrimaryImmuneDeficiency(patientId) returns (bool) {
        Patient memory patient = patients[patientId];

        // Check if the patient's diagnosis is for primary immune deficiency disease and if it's medically appropriate to receive IVIG at home
        if (keccak256(abi.encodePacked(patient.diagnosis)) == keccak256(abi.encodePacked("primary immune deficiency disease")) && patient.isMedicallyAppropriate) {
            emit IVIGApproved(patientId);
            return true;
        } else {
            string memory reason = "IVIG is not covered: either the diagnosis is not for primary immune deficiency disease or it's not medically appropriate.";
            emit IVIGNotApproved(patientId, reason);
            return false;
        }
    }
}