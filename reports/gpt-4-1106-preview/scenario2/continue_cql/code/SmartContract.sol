// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IVIGCoverageContract {
    // Define a struct to encapsulate patient information and claims
    struct Patient {
        bool hasPrimaryImmuneDeficiency;
        bool isMedicallyAppropriateForHomeIVIG;
        bool hasIVIGMedicationCoveredByPartB;
        bool hasNonCoveredItemsOrServices;
    }

    // Mapping from patient ID to patient information
    mapping(address => Patient) public patients;

    // Events to log changes
    event PatientUpdated(address indexed patientId, Patient patient);

    // Function to set patient information
    function setPatientInfo(
        address patientId,
        bool hasPrimaryImmuneDeficiency,
        bool isMedicallyAppropriateForHomeIVIG,
        bool hasIVIGMedicationCoveredByPartB,
        bool hasNonCoveredItemsOrServices
    ) public {
        patients[patientId] = Patient({
            hasPrimaryImmuneDeficiency: hasPrimaryImmuneDeficiency,
            isMedicallyAppropriateForHomeIVIG: isMedicallyAppropriateForHomeIVIG,
            hasIVIGMedicationCoveredByPartB: hasIVIGMedicationCoveredByPartB,
            hasNonCoveredItemsOrServices: hasNonCoveredItemsOrServices
        });
        emit PatientUpdated(patientId, patients[patientId]);
    }

    // Function to check IVIG coverage eligibility
    function checkIVIGCoverageEligibility(address patientId) public view returns (bool) {
        Patient memory patient = patients[patientId];
        return patient.hasPrimaryImmuneDeficiency &&
               patient.isMedicallyAppropriateForHomeIVIG &&
               patient.hasIVIGMedicationCoveredByPartB &&
               !patient.hasNonCoveredItemsOrServices;
    }
}