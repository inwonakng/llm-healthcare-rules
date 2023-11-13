pragma solidity ^0.8.0;

contract Medicare {
    struct Patient {
        bool hasMedicare;
        bool hasPartA;
        bool hasPartB;
        bool hasPartD;
        bool hasOriginalMedicare;
        bool hasESRD;
        bool hasSuccessfulKidneyTransplant;
        uint monthsAfterTransplant;
        bool hasOtherHealthCoverage;
        bool qualifiesForBenefit;
        bool signsUpForBenefit;
        bool metDeductible;
    }

    mapping(address => Patient) public patients;

    function isTransplantCovered(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return patient.hasMedicare && patient.hasPartA;
    }

    function hasPartAAtTimeOfTransplant(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return patient.hasPartA;
    }

    function hasPartBAtTimeOfImmunosuppressiveDrugs(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return patient.hasPartB;
    }

    function isPartDCoveringImmunosuppressiveDrugs(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return !patient.hasPartB && patient.hasPartD;
    }

    function isMedicareCoverageEnded(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return patient.hasESRD && patient.hasSuccessfulKidneyTransplant && patient.monthsAfterTransplant > 36;
    }

    function isBenefitCoveringImmunosuppressiveDrugsOnly(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return patient.qualifiesForBenefit && !patient.hasOtherHealthCoverage;
    }

    function canSignupAfterPartAEnds(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return !patient.hasPartA && patient.qualifiesForBenefit;
    }

    function isPremiumAndDeductibleCorrect(address _patient, uint _premium, uint _deductible) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return patient.signsUpForBenefit && _premium == 9710 && _deductible == 22600;
    }

    function isPaymentAfterDeductibleCorrect(address _patient, uint _payment) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return patient.metDeductible && _payment == 20;
    }
}