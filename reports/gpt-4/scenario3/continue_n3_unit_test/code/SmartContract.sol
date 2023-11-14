```
pragma solidity ^0.8.0;

contract MedicareContract {
    struct Patient {
        bool hasMedicare;
        bool organTransplantPaidByMedicare;
        bool hasPartAAtTransplantTime;
        bool hasPartBAtDrugTime;
        bool hasESRD;
        uint monthsAfterKidneyTransplant;
        bool signedUpForBenefit;
        bool paidMonthlyPremium;
        bool paidDeductible;
    }

    Patient patient;

    function setPatientDetails(bool _hasMedicare, bool _organTransplantPaidByMedicare, bool _hasPartAAtTransplantTime, bool _hasPartBAtDrugTime, bool _hasESRD, uint _monthsAfterKidneyTransplant) public {
        patient.hasMedicare = _hasMedicare;
        patient.organTransplantPaidByMedicare = _organTransplantPaidByMedicare;
        patient.hasPartAAtTransplantTime = _hasPartAAtTransplantTime;
        patient.hasPartBAtDrugTime = _hasPartBAtDrugTime;
        patient.hasESRD = _hasESRD;
        patient.monthsAfterKidneyTransplant = _monthsAfterKidneyTransplant;
    }

    function signUpForBenefit(bool _paidMonthlyPremium, bool _paidDeductible) public {
        patient.signedUpForBenefit = true;
        patient.paidMonthlyPremium = _paidMonthlyPremium;
        patient.paidDeductible = _paidDeductible;
    }

    function checkEligibilityForTransplantDrugTherapy() public view returns (bool) {
        return patient.hasMedicare && patient.organTransplantPaidByMedicare && patient.hasPartAAtTransplantTime && patient.hasPartBAtDrugTime;
    }

    function checkEligibilityForPartDCoverage() public view returns (bool) {
        return patient.hasMedicare && !patient.hasPartBAtDrugTime;
    }

    function checkMedicareCoverageEnds() public view returns (bool) {
        return patient.hasMedicare && patient.hasESRD && patient.monthsAfterKidneyTransplant > 36;
    }

    function checkEligibilityForImmunosuppressiveDrugBenefit() public view returns (bool) {
        return !patient.hasPartAAtTransplantTime && patient.monthsAfterKidneyTransplant > 36;
    }

    function checkEligibilityForImmunosuppressiveDrugs() public view returns (bool) {
        return patient.signedUpForBenefit && patient.paidMonthlyPremium && patient.paidDeductible;
    }
}