// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InsurancePolicyContract {
    struct Person {
        bool hadTransplant;
        bool hasMedicarePartA;
        bool hasMedicarePartB;
        bool hasMedicarePartD;
        bool hasOriginalMedicare;
        bool hasESRDMedicareCoverage;
        uint monthsAfterKidneyTransplant;
        bool lostPartACoverage;
        bool lacksOtherHealthCoverage;
        bool signedUpForImmunosuppressiveDrugBenefit;
        bool metDeductible;
        uint medicareApprovedAmount;
    }

    // Assuming these values are set by the contract owner or through some external input
    uint256 public constant monthlyPremium = 97.10 ether;
    uint256 public constant annualDeductible = 226 ether;

    // Check if a person is eligible for transplant drug therapy coverage
    function checkTransplantDrugTherapyEligibility(bool hadTransplant, bool hasMedicarePartA, bool hasMedicarePartB) public pure returns (bool) {
        return hadTransplant && hasMedicarePartA && hasMedicarePartB;
    }

    // Check if a person can join a Medicare drug plan
    function checkCanJoinMedicareDrugPlan(bool hasOriginalMedicare) public pure returns (bool) {
        return hasOriginalMedicare;
    }

    // Check if a person is eligible for immunosuppressive drugs coverage under Part D
    function checkImmunosuppressiveDrugsCoverage(bool hasMedicarePartB, bool hasMedicarePartD) public pure returns (bool) {
        return !hasMedicarePartB && hasMedicarePartD;
    }

    // Check if Medicare coverage ends after 36 months post-kidney transplant for ESRD patients
    function checkMedicareCoverageEnds(bool hasESRDMedicareCoverage, uint monthsAfterKidneyTransplant) public pure returns (bool) {
        return hasESRDMedicareCoverage && monthsAfterKidneyTransplant >= 36;
    }

    // Check if a person is eligible for the immunosuppressive drug benefit
    function checkEligibilityForImmunosuppressiveDrugBenefit(bool lostPartACoverage, bool lacksOtherHealthCoverage) public pure returns (bool) {
        return lostPartACoverage && lacksOtherHealthCoverage;
    }

    // Check if a person can sign up for the immunosuppressive drug benefit
    function checkCanSignUpForBenefit(bool eligibleForImmunosuppressiveDrugBenefit) public pure returns (bool) {
        return eligibleForImmunosuppressiveDrugBenefit;
    }

    // Get the monthly premium and annual deductible for the immunosuppressive drug benefit
    function getImmunosuppressiveDrugBenefitCosts(bool signedUpForImmunosuppressiveDrugBenefit) public pure returns (uint256, uint256) {
        if (signedUpForImmunosuppressiveDrugBenefit) {
            return (monthlyPremium, annualDeductible);
        } else {
            return (0, 0);
        }
    }

    // Calculate the owed amount after deductible is met
    function calculateOwedAmount(bool metDeductible, uint medicareApprovedAmount) public pure returns (uint256) {
        if (metDeductible) {
            return medicareApprovedAmount * 20 / 100; // 20% of approved amount
        } else {
            return 0;
        }
    }
}