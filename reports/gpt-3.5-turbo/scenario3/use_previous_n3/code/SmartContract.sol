pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Policy {
        bool medicareCoversTransplantDrugTherapy;
        bool mustHavePartA;
        bool mustHavePartB;
        bool partDCoversImmunosuppressiveDrugs;
        bool joinMedicareDrugPlan;
        bool medicareCoverageEndsAfterKidneyTransplant;
        bool medicareBenefitForLostPartACoverage;
        bool benefitCoversImmunosuppressiveDrugs;
        bool notSubstituteForFullCoverage;
        bool qualifyForBenefit;
        bool signUpForBenefit;
        uint256 monthlyPremium;
        uint256 deductible;
        uint256 payPercentage;
    }
    
    Policy public policy;
    
    constructor() {
        policy.medicareCoversTransplantDrugTherapy = true;
        policy.mustHavePartA = true;
        policy.mustHavePartB = true;
        policy.partDCoversImmunosuppressiveDrugs = true;
        policy.joinMedicareDrugPlan = true;
        policy.medicareCoverageEndsAfterKidneyTransplant = true;
        policy.medicareBenefitForLostPartACoverage = true;
        policy.benefitCoversImmunosuppressiveDrugs = true;
        policy.notSubstituteForFullCoverage = true;
        policy.qualifyForBenefit = true;
        policy.signUpForBenefit = true;
        policy.monthlyPremium = 9710;
        policy.deductible = 226;
        policy.payPercentage = 20;
    }
    
    function getPolicy() public view returns (Policy memory) {
        return policy;
    }
}