pragma solidity ^0.8.0;

contract MedicareInsurancePolicy {
    struct Patient {
        bool hasMedicare;
        bool organTransplantPaidByMedicare;
        bool hasPartAAtTransplantTime;
        bool hasPartBAtDrugTime;
        bool hasMedicareDrugCoverage;
        bool hasMedicareForESRD;
        uint monthsAfterKidneyTransplant;
        bool lostPartAAfter36Months;
        bool hasOtherHealthCoverage;
        bool eligibleForImmunosuppressiveDrugBenefit;
        bool partACoverageEnds;
        bool signUpForImmunosuppressiveDrugBenefit;
        bool metDeductible;
    }

    mapping(address => Patient) public patients;

    function checkEligibilityForTransplantDrugTherapy(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return patient.hasMedicare && patient.organTransplantPaidByMedicare && patient.hasPartAAtTransplantTime && patient.hasPartBAtDrugTime;
    }

    function checkEligibilityForImmunosuppressiveDrugs(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return !patient.hasPartBAtDrugTime && patient.hasMedicareDrugCoverage;
    }

    function checkMedicareCoverageEnds(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return patient.hasMedicareForESRD && patient.monthsAfterKidneyTransplant > 36;
    }

    function checkEligibilityForImmunosuppressiveDrugBenefit(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return patient.lostPartAAfter36Months && !patient.hasOtherHealthCoverage;
    }

    function checkCanSignUpForBenefit(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return patient.eligibleForImmunosuppressiveDrugBenefit && patient.partACoverageEnds;
    }

    function checkPaymentDetails(address _patient) public view returns (string memory, string memory) {
        Patient memory patient = patients[_patient];
        if(patient.signUpForImmunosuppressiveDrugBenefit) {
            return ("$97.10", "$226");
        } else {
            return ("$0", "$0");
        }
    }

    function checkPayPercentageOfApprovedAmount(address _patient) public view returns (uint) {
        Patient memory patient = patients[_patient];
        if(patient.metDeductible) {
            return 20;
        } else {
            return 0;
        }
    }
}