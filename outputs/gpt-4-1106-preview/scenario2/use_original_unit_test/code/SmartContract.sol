// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IVIGInsurancePolicy {
    // Define a struct to encapsulate patient information
    struct Patient {
        uint256 id;
        string diagnosis;
        bool isHomeTreatmentAppropriate;
    }

    // Define a struct to encapsulate IVIG treatment information
    struct IVIGTreatment {
        uint256 patientId;
        bool isIVIGProvidedAtHome;
        bool isMedicareCovered;
    }

    // Mapping of patient ID to Patient struct
    mapping(uint256 => Patient) public patients;

    // Mapping of treatment ID to IVIGTreatment struct
    mapping(uint256 => IVIGTreatment) public treatments;

    // Event to log insurance coverage decisions
    event InsuranceCoverageDecision(uint256 patientId, bool isCovered);

    // Function to add a patient's information
    function addPatientInfo(uint256 _patientId, string memory _diagnosis, bool _isHomeTreatmentAppropriate) public {
        patients[_patientId] = Patient(_patientId, _diagnosis, _isHomeTreatmentAppropriate);
    }

    // Function to add IVIG treatment information
    function addIVIGTreatmentInfo(uint256 _treatmentId, uint256 _patientId, bool _isIVIGProvidedAtHome) public {
        treatments[_treatmentId] = IVIGTreatment(_patientId, _isIVIGProvidedAtHome, false);
    }

    // Function to check if IVIG is covered by Medicare
    function checkCoverage(uint256 _treatmentId) public returns (bool) {
        IVIGTreatment memory treatment = treatments[_treatmentId];
        Patient memory patient = patients[treatment.patientId];

        // Check if the patient has a primary immune deficiency disease and if it's appropriate to get IVIG at home
        if (keccak256(abi.encodePacked(patient.diagnosis)) == keccak256(abi.encodePacked("primary immune deficiency disease")) && patient.isHomeTreatmentAppropriate && treatment.isIVIGProvidedAtHome) {
            treatments[_treatmentId].isMedicareCovered = true;
            emit InsuranceCoverageDecision(treatment.patientId, true);
            return true;
        } else {
            emit InsuranceCoverageDecision(treatment.patientId, false);
            return false;
        }
    }
}