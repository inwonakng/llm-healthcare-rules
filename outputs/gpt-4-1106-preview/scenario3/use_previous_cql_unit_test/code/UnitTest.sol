// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


// Define a struct to encapsulate policy holder information for cleaner tests
struct PolicyHolder {
    bool hasPartA;
    bool hasPartB;
    bool hasPartD;
    bool hasOriginalMedicare;
    bool hasESRD;
    uint256 transplantDate;
    bool isEligibleForSpecialBenefit;
    uint256 deductiblePaid;
}

contract MedicareContractTest {
    MedicareContract medicareContract; // The contract instance

    // Run before every test function
    function beforeEach() public {
        medicareContract = new MedicareContract();
    }

    /// Test if transplant drug therapy is covered when Medicare contributed to the payment for the organ transplant
    function testTransplantDrugCoverage() public {
        PolicyHolder memory holder = PolicyHolder(true, true, false, false, false, block.timestamp, false, 0);
        bool isCovered = medicareContract.isTransplantDrugCovered(holder.hasPartA);
        Assert.equal(isCovered, true, "Transplant drug therapy should be covered");
    }

    /// Test if coverage applies when the individual has Part B at the time they receive immunosuppressive drugs
    function testPartBCoverageForDrugs() public {
        PolicyHolder memory holder = PolicyHolder(true, true, false, false, false, block.timestamp, false, 0);
        bool isCovered = medicareContract.isPartBCoverageApplicable(holder.hasPartB);
        Assert.equal(isCovered, true, "Part B should cover immunosuppressive drugs");
    }

    /// Test if Medicare Part D provides coverage when Part B does not
    function testPartDCoverageWhenPartBDoesNot() public {
        PolicyHolder memory holder = PolicyHolder(true, false, true, false, false, block.timestamp, false, 0);
        bool isCovered = medicareContract.isPartDCoverageApplicable(holder.hasPartB, holder.hasPartD);
        Assert.equal(isCovered, true, "Part D should cover when Part B does not");
    }

    /// Test if individuals with Original Medicare can join a Medicare drug plan
    function testOriginalMedicareDrugPlanEnrollment() public {
        PolicyHolder memory holder = PolicyHolder(true, true, false, true, false, block.timestamp, false, 0);
        bool canJoin = medicareContract.canJoinMedicareDrugPlan(holder.hasOriginalMedicare);
        Assert.equal(canJoin, true, "Individuals with Original Medicare should be able to join a drug plan");
    }

    /// Test if Medicare coverage ends 36 months after a successful kidney transplant for individuals with ESRD
    function testMedicareCoverageEndAfterESRD() public {
        PolicyHolder memory holder = PolicyHolder(true, true, true, false, true, block.timestamp - 37 months, false, 0);
        bool hasCoverageEnded = medicareContract.hasMedicareCoverageEnded(holder.hasESRD, holder.transplantDate);
        Assert.equal(hasCoverageEnded, true, "Medicare coverage should end 36 months after a successful kidney transplant for ESRD patients");
    }

    /// Test if the specific benefit for immunosuppressive drugs is available after losing Part A coverage
    function testSpecialBenefitAvailability() public {
        PolicyHolder memory holder = PolicyHolder(false, true, false, false, false, block.timestamp - 37 months, true, 0);
        bool isEligible = medicareContract.isEligibleForSpecialBenefit(holder.isEligibleForSpecialBenefit, holder.hasPartA);
        Assert.equal(isEligible, true, "Should be eligible for the special immunosuppressive drug benefit after losing Part A coverage");
    }

    /// Test the payment of monthly premium and deductible for the immunosuppressive drug benefit
    function testPaymentOfPremiumAndDeductible() public {
        PolicyHolder memory holder = PolicyHolder(false, true, false, false, false, block.timestamp, true, 226);
        (uint256 premium, uint256 deductible) = medicareContract.getBenefitCosts();
        Assert.equal(premium, 97.10 ether, "Monthly premium should be $97.10");
        Assert.equal(deductible, holder.deductiblePaid, "Deductible should match the amount paid by the policyholder");
    }

    /// Test the payment of 20% of the Medicare-approved amount after meeting the deductible
    function testPaymentAfterDeductible() public {
        PolicyHolder memory holder = PolicyHolder(false, true, false, false, false, block.timestamp, true, 226);
        uint256 medicareApprovedAmount = 1000; // Hypothetical approved amount
        uint256 amountToPay = medicareContract.calculatePaymentAfterDeductible(holder.deductiblePaid, medicareApprovedAmount);
        Assert.equal(amountToPay, 200, "Should pay 20% of the Medicare-approved amount after meeting the deductible");
    }
}