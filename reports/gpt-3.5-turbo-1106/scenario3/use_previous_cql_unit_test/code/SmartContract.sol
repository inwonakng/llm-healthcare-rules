// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicarePolicy {
    struct Transplant {
        bool medicareHelpedPay;
        bool hasPartAAtTransplantTime;
        bool hasPartBAtDrugTime;
        bool partDCoversDrugs;
        bool joinMedicareDrugPlan;
        bool coverageEndsAfter36Months;
        bool hasBenefitForLostPartA;
        bool benefitNotSubstitute;
        bool canSignUpAfterPartALoss;
    }

    struct DrugBenefit {
        uint monthlyPremium;
        uint deductible;
        uint paymentPercentageAfterDeductibleMet;
    }

    mapping(uint => Transplant) public transplantPolicies;
    mapping(uint => DrugBenefit) public drugBenefitPolicies;

    function setTransplantPolicy(
        uint policyId,
        bool medicareHelpedPay,
        bool hasPartAAtTransplantTime,
        bool hasPartBAtDrugTime,
        bool partDCoversDrugs,
        bool joinMedicareDrugPlan,
        bool coverageEndsAfter36Months,
        bool hasBenefitForLostPartA,
        bool benefitNotSubstitute,
        bool canSignUpAfterPartALoss
    ) external {
        transplantPolicies[policyId] = Transplant(
            medicareHelpedPay,
            hasPartAAtTransplantTime,
            hasPartBAtDrugTime,
            partDCoversDrugs,
            joinMedicareDrugPlan,
            coverageEndsAfter36Months,
            hasBenefitForLostPartA,
            benefitNotSubstitute,
            canSignUpAfterPartALoss
        );
    }

    function setDrugBenefitPolicy(
        uint year,
        uint monthlyPremium,
        uint deductible,
        uint paymentPercentageAfterDeductibleMet
    ) external {
        drugBenefitPolicies[year] = DrugBenefit(
            monthlyPremium,
            deductible,
            paymentPercentageAfterDeductibleMet
        );
    }

    function isMedicareCoveringTransplantDrugTherapy(uint policyId) public view returns (bool) {
        return transplantPolicies[policyId].medicareHelpedPay;
    }

    function hasPartAAtTimeOfTransplant(uint policyId) public view returns (bool) {
        return transplantPolicies[policyId].hasPartAAtTransplantTime;
    }

    function hasPartBAtTimeOfImmunosuppressiveDrugs(uint policyId) public view returns (bool) {
        return transplantPolicies[policyId].hasPartBAtDrugTime;
    }

    function hasMedicareDrugCoverageForImmunosuppressiveDrugs(uint policyId) public view returns (bool) {
        return transplantPolicies[policyId].partDCoversDrugs;
    }

    function canJoinMedicareDrugPlan(uint policyId) public view returns (bool) {
        return transplantPolicies[policyId].joinMedicareDrugPlan;
    }

    function isMedicareCoverageEndingAfterKidneyTransplant(uint policyId) public view returns (bool) {
        return transplantPolicies[policyId].coverageEndsAfter36Months;
    }

    function hasBenefitForLosingPartAAfterKidneyTransplant(uint policyId) public view returns (bool) {
        return transplantPolicies[policyId].hasBenefitForLostPartA;
    }

    function isBenefitNotSubstituteForFullHealthCoverage(uint policyId) public view returns (bool) {
        return transplantPolicies[policyId].benefitNotSubstitute;
    }

    function canSignUpForBenefitAfterLosingPartA(uint policyId) public view returns (bool) {
        return transplantPolicies[policyId].canSignUpAfterPartALoss;
    }

    function getMonthlyPremiumAndDeductible(uint year) public view returns (uint, uint) {
        return (drugBenefitPolicies[year].monthlyPremium, drugBenefitPolicies[year].deductible);
    }

    function getPaymentPercentageAfterDeductibleMet(uint year) public view returns (uint) {
        return drugBenefitPolicies[year].paymentPercentageAfterDeductibleMet;
    }
}