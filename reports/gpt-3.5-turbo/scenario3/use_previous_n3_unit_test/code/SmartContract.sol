pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Policy {
        bool medicareCoversTransplantDrugTherapy;
        bool mustHavePartA;
        bool mustHavePartB;
        bool partDCoversImmunosuppressiveDrugs;
        bool joinMedicareDrugPlan;
        bool medicareCoverageEndsAfterKidneyTransplant;
        bool benefitForLostPartACoverage;
        bool benefitCoversImmunosuppressiveDrugs;
        bool benefitNotSubstituteForFullCoverage;
        bool qualifyForBenefit;
        bool signUpForBenefit;
        uint monthlyPremium;
        uint deductible;
        uint payPercentage;
    }
    
    Policy public policy;
    
    constructor() {
        policy = Policy(
            true,   // medicareCoversTransplantDrugTherapy
            true,   // mustHavePartA
            true,   // mustHavePartB
            true,   // partDCoversImmunosuppressiveDrugs
            true,   // joinMedicareDrugPlan
            true,   // medicareCoverageEndsAfterKidneyTransplant
            true,   // benefitForLostPartACoverage
            true,   // benefitCoversImmunosuppressiveDrugs
            true,   // benefitNotSubstituteForFullCoverage
            true,   // qualifyForBenefit
            true,   // signUpForBenefit
            9710,   // monthlyPremium
            226,    // deductible
            20      // payPercentage
        );
    }
    
    function medicareCoversTransplantDrugTherapy() public view returns (bool) {
        return policy.medicareCoversTransplantDrugTherapy;
    }
    
    function mustHavePartAAtTimeOfCoveredTransplant() public view returns (bool) {
        return policy.mustHavePartA;
    }
    
    function mustHavePartBAtTimeOfImmunosuppressiveDrugs() public view returns (bool) {
        return policy.mustHavePartB;
    }
    
    function medicareDrugCoverageCoversImmunosuppressiveDrugs() public view returns (bool) {
        return policy.partDCoversImmunosuppressiveDrugs;
    }
    
    function joinMedicareDrugPlanForMedicareDrugCoverage() public view returns (bool) {
        return policy.joinMedicareDrugPlan;
    }
    
    function medicareCoverageEndsAfter36MonthsForESRD() public view returns (bool) {
        return policy.medicareCoverageEndsAfterKidneyTransplant;
    }
    
    function medicareBenefitForLossOfPartAAfter36Months() public view returns (bool) {
        return policy.benefitForLostPartACoverage;
    }
    
    function benefitOnlyCoversImmunosuppressiveDrugs() public view returns (bool) {
        return policy.benefitCoversImmunosuppressiveDrugs;
    }
    
    function benefitIsNotSubstituteForFullHealthCoverage() public view returns (bool) {
        return policy.benefitNotSubstituteForFullCoverage;
    }
    
    function canSignUpForBenefitAfterPartACoverageEnds() public view returns (bool) {
        return policy.qualifyForBenefit;
    }
    
    function callSocialSecurityToSignUpForBenefit() public view returns (bool) {
        return policy.signUpForBenefit;
    }
    
    function getMonthlyPremiumIn2023() public view returns (uint) {
        return policy.monthlyPremium;
    }
    
    function getDeductibleIn2023() public view returns (uint) {
        return policy.deductible;
    }
    
    function getPayPercentageForImmunosuppressiveDrugs() public view returns (uint) {
        return policy.payPercentage;
    }
}