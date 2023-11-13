// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract TransplantDrugCoverageContractTest {
    TransplantDrugCoverageContract coverageContract;

    // Run before every test function
    function beforeEach() public {
        coverageContract = new TransplantDrugCoverageContract();
    }

    /// Test if transplant drug therapy is covered when Medicare contributed to the organ transplant
    function testTransplantDrugTherapyCoverage() public {
        bool isCovered = coverageContract.checkTransplantDrugTherapyCoverage(true);
        Assert.equal(isCovered, true, "Transplant drug therapy should be covered when Medicare contributed to the organ transplant.");
    }

    /// Test if having Part A at the time of transplant is required for coverage
    function testPartACoverageRequirement() public {
        bool hasPartA = coverageContract.checkPartACoverage(true);
        Assert.equal(hasPartA, true, "Having Part A at the time of transplant is required for coverage.");
    }

    /// Test if having Part B at the time of receiving immunosuppressive drugs is required for coverage
    function testPartBCoverageRequirement() public {
        bool hasPartB = coverageContract.checkPartBCoverage(true);
        Assert.equal(hasPartB, true, "Having Part B at the time of receiving immunosuppressive drugs is required for coverage.");
    }

    /// Test if Medicare Part D covers immunosuppressive drugs when Part B does not
    function testPartDCoverageWhenPartBDoesNot() public {
        bool isCovered = coverageContract.checkPartDCoverage(false);
        Assert.equal(isCovered, true, "Medicare Part D should cover immunosuppressive drugs when Part B does not.");
    }

    /// Test if individuals with Original Medicare can join a Medicare drug plan
    function testOriginalMedicareDrugPlanEnrollment() public {
        bool canJoin = coverageContract.checkOriginalMedicareDrugPlanEnrollment(true);
        Assert.equal(canJoin, true, "Individuals with Original Medicare should be able to join a Medicare drug plan.");
    }

    /// Test if Medicare coverage ends 36 months after a successful kidney transplant for ESRD patients
    function testMedicareCoverageEndsAfter36Months() public {
        bool coverageEnds = coverageContract.checkMedicareCoverageEnds(37);
        Assert.equal(coverageEnds, true, "Medicare coverage should end 36 months after a successful kidney transplant for ESRD patients.");
    }

    /// Test if the specific benefit for immunosuppressive drugs is available after Part A coverage ends
    function testBenefitAvailabilityAfterPartAEnds() public {
        bool benefitAvailable = coverageContract.checkBenefitAvailabilityAfterPartAEnds(true);
        Assert.equal(benefitAvailable, true, "The specific benefit for immunosuppressive drugs should be available after Part A coverage ends.");
    }

    /// Test if the specific benefit only covers immunosuppressive drugs
    function testBenefitCoversOnlyDrugs() public {
        bool coversOnlyDrugs = coverageContract.checkBenefitCoversOnlyDrugs();
        Assert.equal(coversOnlyDrugs, true, "The specific benefit should only cover immunosuppressive drugs.");
    }

    /// Test if the specific benefit is not a substitute for full health coverage
    function testBenefitIsNotFullCoverageSubstitute() public {
        bool isSubstitute = coverageContract.checkBenefitIsNotFullCoverageSubstitute();
        Assert.equal(isSubstitute, false, "The specific benefit should not be a substitute for full health coverage.");
    }

    /// Test the monthly premium and deductible for the immunosuppressive drug benefit
    function testImmunosuppressiveDrugBenefitCosts() public {
        (uint256 premium, uint256 deductible) = coverageContract.getImmunosuppressiveDrugBenefitCosts();
        Assert.equal(premium, 97.10 ether, "The monthly premium for the immunosuppressive drug benefit should be $97.10.");
        Assert.equal(deductible, 226 ether, "The deductible for the immunosuppressive drug benefit should be $226.");
    }

    /// Test the cost after deductible for immunosuppressive drugs
    function testCostAfterDeductible() public {
        uint256 cost = coverageContract.getCostAfterDeductible(1000 ether);
        Assert.equal(cost, 200 ether, "The cost after deductible for immunosuppressive drugs should be 20% of the Medicare-approved amount.");
    }
}