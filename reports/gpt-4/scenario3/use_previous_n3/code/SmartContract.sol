pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Patient {
        bool hasMedicare;
        bool medicarePaidForTransplant;
        bool hasPartA;
        bool hasPartB;
        bool hasPartD;
        bool hasOriginalMedicare;
        bool hasMedicareDueToESRD;
        uint monthsAfterSuccessfulKidneyTransplant;
        bool lostPartA;
        bool hasOtherHealthCoverage;
        bool signUpForImmunosuppressiveDrugBenefit;
        bool metDeductible;
        uint year;
    }

    mapping(address => Patient) public patients;

    function isEligibleForTransplantDrugTherapy(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return patient.hasMedicare && patient.medicarePaidForTransplant && patient.hasPartA && patient.hasPartB;
    }

    function isEligibleForImmunosuppressiveDrugs(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return patient.hasMedicare && !patient.hasPartB && patient.hasPartD;
    }

    function canJoinMedicareDrugPlan(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return patient.hasOriginalMedicare;
    }

    function medicareCoverageEnds(address _patient) public view returns (uint) {
        Patient memory patient = patients[_patient];
        if(patient.hasMedicare && patient.hasMedicareDueToESRD && patient.monthsAfterSuccessfulKidneyTransplant <= 36) {
            return patient.monthsAfterSuccessfulKidneyTransplant;
        }
        return 0;
    }

    function isEligibleForImmunosuppressiveDrugBenefit(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return patient.lostPartA && patient.monthsAfterSuccessfulKidneyTransplant >= 36 && !patient.hasOtherHealthCoverage;
    }

    function canSignUpForBenefit(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return !patient.hasPartA;
    }

    function monthlyPremiumAndDeductible(address _patient) public view returns (string memory, string memory) {
        Patient memory patient = patients[_patient];
        if(patient.signUpForImmunosuppressiveDrugBenefit && patient.year == 2023) {
            return ("$97.10", "$226");
        }
        return ("", "");
    }

    function payPercentage(address _patient) public view returns (string memory) {
        Patient memory patient = patients[_patient];
        if(patient.metDeductible) {
            return "20%";
        }
        return "0%";
    }
}