// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract TransplantDrugCoverageTest {
    TransplantDrugCoverage transplantDrugCoverage;

    // Run before every test function
    function beforeEach() public {
        transplantDrugCoverage = new TransplantDrugCoverage();
    }

    // Test 1: Medicare covers transplant drug therapy if it contributed to the payment for the organ transplant.
    function testMedicareContributionForTransplantCoverage() public {
        bool hasMedicareContribution = true;
        bool isCovered = transplantDrugCoverage.checkTransplantDrugCoverage(hasMedicareContribution);
        Assert.isTrue(isCovered, "Medicare should cover transplant drug therapy if it contributed to the payment.");
    }

    // Test 2: The individual must have Medicare Part A at the time of the transplant.
    function testMedicarePartAAtTimeOfTransplant() public {
        bool hasPartA = true;
        bool isEligible = transplantDrugCoverage.checkPartAEligibility(hasPartA);
        Assert.isTrue(isEligible, "Individual should have Medicare Part A at the time of the transplant.");
    }

    // Test 3: The individual must have Medicare Part B when receiving immunosuppressive drugs.
    function testMedicarePartBForImmunosuppressiveDrugs() public {
        bool hasPartB = true;
        bool isEligible = transplantDrugCoverage.checkPartBEligibility(hasPartB);
        Assert.isTrue(isEligible, "Individual should have Medicare Part B when receiving immunosuppressive drugs.");
    }

    // Test 4: If Medicare Part B does not cover, Part D should.
    function testMedicarePartDForImmunosuppressiveDrugs() public {
        bool hasPartB = false;
        bool hasPartD = true;
        bool isCovered = transplantDrugCoverage.checkPartDCoverage(hasPartB, hasPartD);
        Assert.isTrue(isCovered, "Medicare Part D should cover if Part B does not.");
    }

    // Test 6: ESRD-based Medicare coverage ends 36 months after a successful kidney transplant.
    function testESRDMedicareCoverageEndsAfter36Months() public {
        bool hasESRD = true;
        uint transplantDate = block.timestamp - 37 months;
        bool isCoverageEnded = transplantDrugCoverage.checkESRDCoverageEnd(transplantDate, hasESRD);
        Assert.isTrue(isCoverageEnded, "ESRD-based Medicare coverage should end 36 months after a successful kidney transplant.");
    }

    // Test 7 & 8: Specific benefit for immunosuppressive drugs after Part A ends, without other coverage.
    function testImmunosuppressiveDrugBenefitAfterPartAEnds() public {
        bool hasOtherCoverage = false;
        uint partAEndDate = block.timestamp - 1 days;
        bool isEligibleForBenefit = transplantDrugCoverage.checkImmunosuppressiveDrugBenefitEligibility(partAEndDate, hasOtherCoverage);
        Assert.isTrue(isEligibleForBenefit, "Should be eligible for immunosuppressive drug benefit after Part A ends and without other coverage.");
    }

    // Test 12 & 13: Monthly premium and deductible for immunosuppressive drug benefit.
    function testImmunosuppressiveDrugBenefitCosts() public {
        uint premium = 9710; // Represented in cents to avoid decimals
        uint deductible = 22600; // Represented in cents to avoid decimals
        (uint calculatedPremium, uint calculatedDeductible) = transplantDrugCoverage.getImmunosuppressiveDrugBenefitCosts();
        Assert.equal(calculatedPremium, premium, "Monthly premium should be $97.10.");
        Assert.equal(calculatedDeductible, deductible, "Deductible should be $226.");
    }

    // Additional tests would be needed to cover all aspects of the policy, including the 20% payment after deductible,
    // and the ability to sign up for the benefit via a call (which would be simulated in a smart contract context).
}