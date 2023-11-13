// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicareContract {
    struct Patient {
        bool isFemale;
        bool hasOsteoporosis;
        bool qualifiesForMedicareHomeHealthBenefit;
        bool hasBoneFractureRelatedToPostmenopausalOsteoporosis;
        bool cannotSelfAdministerInjection;
        bool familyOrCaregiversCannotAdministerInjection;
    }

    mapping(address => Patient) public patients;

    function setPatient(
        address _patientAddress,
        bool _isFemale,
        bool _hasOsteoporosis,
        bool _qualifiesForMedicareHomeHealthBenefit,
        bool _hasBoneFractureRelatedToPostmenopausalOsteoporosis,
        bool _cannotSelfAdministerInjection,
        bool _familyOrCaregiversCannotAdministerInjection
    ) public {
        Patient storage patient = patients[_patientAddress];
        patient.isFemale = _isFemale;
        patient.hasOsteoporosis = _hasOsteoporosis;
        patient.qualifiesForMedicareHomeHealthBenefit = _qualifiesForMedicareHomeHealthBenefit;
        patient.hasBoneFractureRelatedToPostmenopausalOsteoporosis = _hasBoneFractureRelatedToPostmenopausalOsteoporosis;
        patient.cannotSelfAdministerInjection = _cannotSelfAdministerInjection;
        patient.familyOrCaregiversCannotAdministerInjection = _familyOrCaregiversCannotAdministerInjection;
    }

    function checkCoverage(address _patientAddress) public view returns (bool) {
        Patient storage patient = patients[_patientAddress];
        if (
            patient.isFemale &&
            patient.hasOsteoporosis &&
            patient.qualifiesForMedicareHomeHealthBenefit &&
            patient.hasBoneFractureRelatedToPostmenopausalOsteoporosis &&
            patient.cannotSelfAdministerInjection &&
            patient.familyOrCaregiversCannotAdministerInjection
        ) {
            return true;
        } else {
            return false;
        }
    }
}