// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract InsurancePolicyContractTest {
    InsurancePolicyContract insurancePolicyContract;

    // Run before every test function
    function beforeEach() public {
        insurancePolicyContract = new InsurancePolicyContract();
    }

    /// Test if a person is eligible for transplant drug therapy coverage
    function eligibleForTransplantDrugTherapyCoverageTest() public {
        bool result = insurancePolicyContract.checkTransplantDrugTherapyEligibility(true, true, true);
        Assert.equal(result, true, "Person should be eligible for transplant drug therapy coverage");
    }

    /// Test if a person can join a Medicare drug plan
    function canJoinMedicareDrugPlanTest() public {
        bool result = insurancePolicyContract.checkCanJoinMedicareDrugPlan(true);
        Assert.equal(result, true, "Person with Original Medicare should be able to join a Medicare drug plan");
    }

    /// Test if a person is eligible for immunosuppressive drugs coverage under Part D
    function eligibleForImmunosuppressiveDrugsCoveragePartDTest() public {
        bool result = insurancePolicyContract.checkImmunosuppressiveDrugsCoverage(false, true);
        Assert.equal(result, true, "Person should be eligible for immunosuppressive drugs coverage under Part D");
    }

    /// Test if Medicare coverage ends after 36 months post-kidney transplant for ESRD patients
    function medicareCoverageEndsAfterESRDTest() public {
        bool result = insurancePolicyContract.checkMedicareCoverageEnds(true, 36);
        Assert.equal(result, true, "Medicare coverage should end after 36 months post-kidney transplant for ESRD patients");
    }

    /// Test if a person is eligible for the immunosuppressive drug benefit
    function eligibleForImmunosuppressiveDrugBenefitTest() public {
        bool result = insurancePolicyContract.checkEligibilityForImmunosuppressiveDrugBenefit(true, true);
        Assert.equal(result, true, "Person should be eligible for the immunosuppressive drug benefit");
    }

    /// Test if a person can sign up for the immunosuppressive drug benefit
    function canSignUpForImmunosuppressiveDrugBenefitTest() public {
        bool result = insurancePolicyContract.checkCanSignUpForBenefit(true);
        Assert.equal(result, true, "Person should be able to sign up for the immunosuppressive drug benefit");
    }

    /// Test the monthly premium and annual deductible for the immunosuppressive drug benefit
    function immunosuppressiveDrugBenefitCostsTest() public {
        (uint256 premium, uint256 deductible) = insurancePolicyContract.getImmunosuppressiveDrugBenefitCosts(true);
        Assert.equal(premium, 97.10 ether, "Monthly premium should be 97.10");
        Assert.equal(deductible, 226 ether, "Annual deductible should be 226");
    }

    /// Test the owed amount after deductible is met
    function owedAmountAfterDeductibleTest() public {
        uint256 approvedAmount = 1000 ether; // Example Medicare-approved amount
        uint256 owedAmount = insurancePolicyContract.calculateOwedAmount(true, approvedAmount);
        uint256 expectedOwedAmount = approvedAmount * 20 / 100; // 20% of approved amount
        Assert.equal(owedAmount, expectedOwedAmount, "Owed amount should be 20% of the Medicare-approved amount");
    }
}