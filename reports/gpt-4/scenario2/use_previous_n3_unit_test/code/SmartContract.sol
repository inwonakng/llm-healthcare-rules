// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Patient {
        bool hasDiagnosis;
        bool receivesIVIGAtHome;
        bool doctorDecidesMedicallyAppropriate;
        bool hasInsuranceCoverageUnderPartB;
        bool hasInsuranceCoverageForOtherItemsAndServices;
    }

    mapping(address => Patient) public patients;

    function setPatient(
        address _patientAddress,
        bool _hasDiagnosis,
        bool _receivesIVIGAtHome,
        bool _doctorDecidesMedicallyAppropriate,
        bool _hasInsuranceCoverageUnderPartB,
        bool _hasInsuranceCoverageForOtherItemsAndServices
    ) public {
        Patient storage patient = patients[_patientAddress];
        patient.hasDiagnosis = _hasDiagnosis;
        patient.receivesIVIGAtHome = _receivesIVIGAtHome;
        patient.doctorDecidesMedicallyAppropriate = _doctorDecidesMedicallyAppropriate;
        patient.hasInsuranceCoverageUnderPartB = _hasInsuranceCoverageUnderPartB;
        patient.hasInsuranceCoverageForOtherItemsAndServices = _hasInsuranceCoverageForOtherItemsAndServices;
    }

    function checkIVIGCoverage(address _patientAddress) public view returns (bool) {
        Patient storage patient = patients[_patientAddress];
        if (patient.hasDiagnosis && patient.receivesIVIGAtHome && patient.doctorDecidesMedicallyAppropriate) {
            return true;
        } else {
            return false;
        }
    }

    function checkPartBCoverage(address _patientAddress) public view returns (bool) {
        Patient storage patient = patients[_patientAddress];
        if (patient.receivesIVIGAtHome && patient.hasInsuranceCoverageUnderPartB) {
            return true;
        } else {
            return false;
        }
    }

    function checkOtherItemsCoverage(address _patientAddress) public view returns (bool) {
        Patient storage patient = patients[_patientAddress];
        if (patient.receivesIVIGAtHome && !patient.hasInsuranceCoverageForOtherItemsAndServices) {
            return true;
        } else {
            return false;
        }
    }
}