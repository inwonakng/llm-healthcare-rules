pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Patient {
        bool isWoman;
        bool hasOsteoporosis;
        bool meetsHomeHealthBenefit;
        bool hasBoneFracture;
        bool canSelfInject;
    }

    struct Medicare {
        bool coversInjectableOsteoporosisDrugs;
        bool coversHomeHealthNurse;
    }

    mapping(address => Patient) public patients;
    mapping(address => Medicare) public medicares;

    function setPatient(
        address _patient,
        bool _isWoman,
        bool _hasOsteoporosis,
        bool _meetsHomeHealthBenefit,
        bool _hasBoneFracture,
        bool _canSelfInject
    ) public {
        patients[_patient] = Patient(_isWoman, _hasOsteoporosis, _meetsHomeHealthBenefit, _hasBoneFracture, _canSelfInject);
    }

    function setMedicare(
        address _patient,
        bool _coversInjectableOsteoporosisDrugs,
        bool _coversHomeHealthNurse
    ) public {
        medicares[_patient] = Medicare(_coversInjectableOsteoporosisDrugs, _coversHomeHealthNurse);
    }

    function checkCoverage(address _patient) public view returns (string memory) {
        Patient memory patient = patients[_patient];
        Medicare memory medicare = medicares[_patient];

        if (!patient.isWoman || !patient.hasOsteoporosis || !patient.meetsHomeHealthBenefit || !patient.hasBoneFracture || patient.canSelfInject) {
            return "Medicare does not cover injectable osteoporosis drugs for this patient.";
        } else if (!medicare.coversInjectableOsteoporosisDrugs) {
            return "Medicare does not cover injectable osteoporosis drugs.";
        } else if (!medicare.coversHomeHealthNurse) {
            return "Medicare does not cover home health nurse or aide to provide the injection.";
        } else {
            return "Medicare covers injectable osteoporosis drugs and home health nurse or aide to provide the injection for this patient.";
        }
    }
}