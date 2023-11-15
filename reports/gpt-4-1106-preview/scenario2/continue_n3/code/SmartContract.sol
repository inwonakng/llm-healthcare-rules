// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IVIGCoverageContract {
    // Define a struct to encapsulate patient information
    struct Patient {
        bool hasPrimaryImmuneDeficiencyDisease;
        bool hasDoctorApproval;
        bool receivesIVIGAtHome;
    }

    // Mapping to store patient's eligibility for IVIG coverage
    mapping(address => Patient) public patients;

    // Event to emit the coverage result
    event CoverageResult(address patientAddress, bool isEligibleForCoverage, bool medicarePartBCoversIVIG, bool medicarePartBDoesNotCoverRelatedServices);

    // Function to set patient information
    function setPatientInfo(address _patientAddress, bool _hasPrimaryImmuneDeficiencyDisease, bool _hasDoctorApproval, bool _receivesIVIGAtHome) public {
        patients[_patientAddress] = Patient({
            hasPrimaryImmuneDeficiencyDisease: _hasPrimaryImmuneDeficiencyDisease,
            hasDoctorApproval: _hasDoctorApproval,
            receivesIVIGAtHome: _receivesIVIGAtHome
        });
    }

    // Function to check coverage eligibility
    function checkCoverageEligibility(address _patientAddress) public {
        Patient memory patient = patients[_patientAddress];
        bool isEligibleForCoverage = false;
        bool medicarePartBCoversIVIG = false;
        bool medicarePartBDoesNotCoverRelatedServices = false;

        // Check if all conditions are met for IVIG coverage
        if (patient.hasPrimaryImmuneDeficiencyDisease && patient.hasDoctorApproval && patient.receivesIVIGAtHome) {
            isEligibleForCoverage = true;
            medicarePartBCoversIVIG = true;
            medicarePartBDoesNotCoverRelatedServices = true;
        }

        // Emit the result
        emit CoverageResult(_patientAddress, isEligibleForCoverage, medicarePartBCoversIVIG, medicarePartBDoesNotCoverRelatedServices);
    }
}