// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract MedicareSupplementContractTest {
    MedicareSupplementContract medicareSupplementContract;

    // Run before every test function
    function beforeEach() public {
        medicareSupplementContract = new MedicareSupplementContract();
    }

    // Test Rule 1: Medicare covers transplant drug therapy if it paid for the organ transplant
    function testTransplantDrugTherapyCoverage() public {
        bool paidByMedicare = true;
        bool result = medicareSupplementContract.checkTransplantDrugTherapyEligibility(paidByMedicare);
        Assert.isTrue(result, "Medicare should cover transplant drug therapy if it paid for the organ transplant.");
    }

    // Test Rule 2: Must have Part A at the time of transplant
    function testPartAAtTimeOfTransplant() public {
        bool hasPartA = true;
        bool atTimeOfTransplant = true;
        bool result = medicareSupplementContract.checkPartAEligibility(hasPartA, atTimeOfTransplant);
        Assert.isTrue(result, "Individual should be eligible if they have Part A at the time of the transplant.");
    }

    // Test Rule 3: Must have Part B to get immunosuppressive drugs
    function testPartBForImmunosuppressiveDrugs() public {
        bool hasPartB = true;
        bool result = medicareSupplementContract.checkPartBEligibility(hasPartB);
        Assert.isTrue(result, "Individual should be eligible for immunosuppressive drugs if they have Part B.");
    }

    // Test Rule 6: ESRD coverage ends 36 months after transplant
    function testESRDCoverageEnds() public {
        bool hasESRDCoverage = true;
        uint monthsAfterTransplant = 36;
        bool result = medicareSupplementContract.checkESRDCoverageEnd(hasESRDCoverage, monthsAfterTransplant);
        Assert.isTrue(result, "ESRD coverage should end 36 months after a successful kidney transplant.");
    }

    // Test Rule 7: Specific benefit for lost Part A coverage after 36 months without other coverage
    function testSpecificBenefitEligibility() public {
        bool partAEnded = true;
        bool hasOtherHealthCoverage = false;
        bool result = medicareSupplementContract.checkSpecificBenefitEligibility(partAEnded, hasOtherHealthCoverage);
        Assert.isTrue(result, "Individual should be eligible for the specific benefit if Part A ended and they have no other health coverage.");
    }

    // Test Rule 12: Premium and deductible costs for 2023
    function testPremiumAndDeductibleCosts() public {
        uint year = 2023;
        (uint premium, uint deductible) = medicareSupplementContract.getCosts(year);
        uint expectedPremium = 9710; // Represented in the smallest unit, e.g., cents
        uint expectedDeductible = 22600; // Represented in the smallest unit, e.g., cents
        Assert.equal(premium, expectedPremium, "The premium for 2023 should be 9710 cents.");
        Assert.equal(deductible, expectedDeductible, "The deductible for 2023 should be 22600 cents.");
    }

    // Test Rule 13: Pay 20% after deductible
    function testCoinsuranceAfterDeductible() public {
        bool deductibleMet = true;
        uint coinsuranceRate = medicareSupplementContract.getCoinsuranceRate(deductibleMet);
        uint expectedCoinsuranceRate = 20;
        Assert.equal(coinsuranceRate, expectedCoinsuranceRate, "The coinsurance rate after meeting the deductible should be 20%.");
    }

    // Additional test: Final decision rule
    function testFinalEligibilityAndCosts() public {
        // Assuming a function that takes all the parameters and returns eligibility and costs
        bool paidByMedicare = true;
        bool hasPartA = true;
        bool atTimeOfTransplant = true;
        bool hasPartB = true;
        bool hasESRDCoverage = true;
        uint monthsAfterTransplant = 36;
        bool partAEnded = true;
        bool hasOtherHealthCoverage = false;
        uint year = 2023;

        (bool eligible, uint premium, uint deductible, uint coinsuranceRate) = medicareSupplementContract.finalEligibilityAndCosts(
            paidByMedicare,
            hasPartA,
            atTimeOfTransplant,
            hasPartB,
            hasESRDCoverage,
            monthsAfterTransplant,
            partAEnded,
            hasOtherHealthCoverage,
            year
        );

        Assert.isTrue(eligible, "The individual should be eligible for the immunosuppressive drug benefit.");
        Assert.equal(premium, 9710, "The premium should match the expected value for 2023.");
        Assert.equal(deductible, 22600, "The deductible should match the expected value for 2023.");
        Assert.equal(coinsuranceRate, 20, "The coinsurance rate should be 20% after the deductible is met.");
    }
}