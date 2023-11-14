// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IVIGInsurancePolicy {
    // Define a struct to encapsulate patient details and IVIG treatment information
    struct Patient {
        address id;
        bool hasPrimaryImmuneDeficiency;
        bool isMedicallyAppropriateForHomeIVIG;
        bool doctorApprovalReceived;
    }

    // State variable to store patient information
    mapping(address => Patient) public patients;

    // Event to log insurance claims
    event InsuranceClaimProcessed(address patientId, bool isCovered, string reason);

    // Function to register a patient's diagnosis and doctor's approval
    function registerPatient(
        address _patientId,
        bool _hasPrimaryImmuneDeficiency,
        bool _isMedicallyAppropriateForHomeIVIG,
        bool _doctorApprovalReceived
    ) public {
        patients[_patientId] = Patient({
            id: _patientId,
            hasPrimaryImmuneDeficiency: _hasPrimaryImmuneDeficiency,
            isMedicallyAppropriateForHomeIVIG: _isMedicallyAppropriateForHomeIVIG,
            doctorApprovalReceived: _doctorApprovalReceived
        });
    }

    // Function to process an insurance claim for IVIG treatment
    function processInsuranceClaim(address _patientId) public {
        Patient memory patient = patients[_patientId];

        // Check if the patient has a primary immune deficiency
        if (!patient.hasPrimaryImmuneDeficiency) {
            emit InsuranceClaimProcessed(_patientId, false, "Patient does not have a primary immune deficiency disease.");
            return;
        }

        // Check if it's medically appropriate for the patient to get IVIG at home
        if (!patient.isMedicallyAppropriateForHomeIVIG) {
            emit InsuranceClaimProcessed(_patientId, false, "It is not medically appropriate for the patient to get IVIG at home.");
            return;
        }

        // Check if the doctor's approval has been received
        if (!patient.doctorApprovalReceived) {
            emit InsuranceClaimProcessed(_patientId, false, "Doctor's approval has not been received.");
            return;
        }

        // If all conditions are met, the insurance covers the IVIG
        emit InsuranceClaimProcessed(_patientId, true, "IVIG is covered by insurance.");
    }
}