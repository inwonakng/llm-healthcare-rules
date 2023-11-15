pragma solidity ^0.8.0;

contract InsurancePolicy {

    struct Patient {
        bool isWoman;
        bool hasOsteoporosis;
        bool meetsHomeHealthBenefit;
        bool hasBoneFracture;
        bool canSelfInject;
        bool hasCaregiver;
    }

    mapping(address => Patient) public patients;

    function registerPatient(
        address _patient,
        bool _isWoman,
        bool _hasOsteoporosis,
        bool _meetsHomeHealthBenefit,
        bool _hasBoneFracture,
        bool _canSelfInject,
        bool _hasCaregiver
    ) public {
        patients[_patient] = Patient(_isWoman, _hasOsteoporosis, _meetsHomeHealthBenefit, _hasBoneFracture, _canSelfInject, _hasCaregiver);
    }

    function isEligibleForInjectableOsteoporosisDrugs(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];

        if (!patient.isWoman) {
            return false;
        }

        if (!patient.hasOsteoporosis || !patient.meetsHomeHealthBenefit) {
            return false;
        }

        if (!patient.hasBoneFracture) {
            return false;
        }

        if (patient.canSelfInject) {
            return false;
        }

        return true;
    }

    function isEligibleForHomeHealthNurse(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];

        if (!isEligibleForInjectableOsteoporosisDrugs(_patient)) {
            return false;
        }

        if (patient.hasCaregiver) {
            return false;
        }

        return true;
    }
}