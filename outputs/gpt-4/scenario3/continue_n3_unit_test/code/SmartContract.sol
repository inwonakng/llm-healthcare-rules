```
pragma solidity ^0.8.0;

contract MedicareContract {
    struct Patient {
        bool hasMedicare;
        bool hasPartA;
        bool hasPartB;
        bool hasTransplantPaidByMedicare;
        bool hasOriginalMedicare;
        bool hasMedicareForESRD;
        uint monthsAfterSuccessfulKidneyTransplant;
        bool lostPartAAfter36Months;
        bool hasOtherHealthCoverage;
        bool signedUpForImmunosuppressiveDrugBenefit;
        uint paidMonthlyPremium;
        uint paidDeductible;
        bool metDeductible;
    }

    function checkEligibilityForTransplantDrugTherapy(bool hasMedicare, bool hasPartA, bool hasPartB, bool hasTransplantPaidByMedicare) public pure returns (bool) {
        return hasMedicare && hasPartA && hasPartB && hasTransplantPaidByMedicare;
    }

    function checkCanJoinMedicareDrugPlan(bool hasOriginalMedicare) public pure returns (bool) {
        return hasOriginalMedicare;
    }

    function checkMedicareCoverageEnds(bool hasMedicareForESRD, uint monthsAfterSuccessfulKidneyTransplant) public pure returns (bool) {
        return hasMedicareForESRD && monthsAfterSuccessfulKidneyTransplant > 36;
    }

    function checkEligibilityForImmunosuppressiveDrugBenefit(bool lostPartAAfter36Months, bool hasOtherHealthCoverage) public pure returns (bool) {
        return lostPartAAfter36Months && !hasOtherHealthCoverage;
    }

    function checkMetDeductible(bool signedUpForImmunosuppressiveDrugBenefit, uint paidMonthlyPremium, uint paidDeductible) public pure returns (bool) {
        return signedUpForImmunosuppressiveDrugBenefit && paidMonthlyPremium >= 97.10 && paidDeductible >= 226;
    }

    function checkPays20PercentOfApprovedAmount(bool metDeductible) public pure returns (bool) {
        return metDeductible;
    }
}