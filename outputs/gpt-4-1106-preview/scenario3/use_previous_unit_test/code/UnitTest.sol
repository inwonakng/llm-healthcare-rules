// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


// Define a struct to encapsulate policy parameters for cleaner code
struct PolicyHolder {
    bool hasPartA;
    bool hasPartB;
    bool hasPartD;
    bool hasOriginalMedicare;
    bool hasESRD;
    uint256 transplantDate;
    uint256 monthlyPremium;
    uint256 deductiblePaid;
    uint256 approvedDrugCost;
}

contract MedicareContractTest {
    // Define a PolicyHolder for testing purposes
    PolicyHolder policyHolder;

    // Initialize the policyHolder before each test
    function beforeEach() public {
        policyHolder = PolicyHolder({
            hasPartA: false,
            hasPartB: false,
            hasPartD: false,
            hasOriginalMedicare: false,
            hasESRD: false,
            transplantDate: 0,
            monthlyPremium: 0,
            deductiblePaid: 0,
            approvedDrugCost: 0
        });
    }

    /// Test if Medicare covers transplant drug therapy when it paid for the organ transplant and the individual has Part A and B
    function testMedicareCoverageForTransplantDrugTherapy() public {
        policyHolder.hasPartA = true;
        policyHolder.hasPartB = true;
        // Assuming the contract has a function checkDrugTherapyCoverage that returns a boolean
        bool isCovered = MedicareContract.checkDrugTherapyCoverage(policyHolder.hasPartA, policyHolder.hasPartB);
        Assert.equal(isCovered, true, "Medicare should cover transplant drug therapy when it paid for the organ transplant and the individual has Part A and B");
    }

    /// Test if Medicare Part D covers immunosuppressive drugs when Part B does not
    function testMedicarePartDCoverage() public {
        policyHolder.hasPartB = false;
        policyHolder.hasPartD = true;
        // Assuming the contract has a function checkPartDCoverage that returns a boolean
        bool isCovered = MedicareContract.checkPartDCoverage(policyHolder.hasPartB, policyHolder.hasPartD);
        Assert.equal(isCovered, true, "Medicare Part D should cover immunosuppressive drugs when Part B does not");
    }

    /// Test if Medicare coverage ends 36 months after a successful kidney transplant for ESRD patients
    function testMedicareCoverageEndsForESRDPatients() public {
        policyHolder.hasESRD = true;
        policyHolder.transplantDate = block.timestamp - 37 months; // Simulate a transplant that occurred 37 months ago
        // Assuming the contract has a function checkESRDCoverageEnd that returns a boolean
        bool hasCoverageEnded = MedicareContract.checkESRDCoverageEnd(policyHolder.hasESRD, policyHolder.transplantDate);
        Assert.equal(hasCoverageEnded, true, "Medicare coverage should end 36 months after a successful kidney transplant for ESRD patients");
    }

    /// Test the enrollment in the immunosuppressive drug benefit after Part A coverage ends
    function testEnrollmentAfterPartACoverageEnds() public {
        policyHolder.hasPartA = false;
        policyHolder.transplantDate = block.timestamp - 37 months; // Simulate a transplant that occurred 37 months ago
        // Assuming the contract has a function enrollImmunosuppressiveDrugBenefit that returns a boolean
        bool hasEnrolled = MedicareContract.enrollImmunosuppressiveDrugBenefit(policyHolder.hasPartA, policyHolder.transplantDate);
        Assert.equal(hasEnrolled, true, "Individual should be able to enroll in the immunosuppressive drug benefit after Part A coverage ends");
    }

    /// Test the payment calculation after the deductible is met
    function testPaymentAfterDeductible() public {
        policyHolder.deductiblePaid = 226; // Simulate that the deductible has been paid
        policyHolder.approvedDrugCost = 1000; // Simulate an approved drug cost of $1000
        // Assuming the contract has a function calculatePaymentAfterDeductible that returns the amount to be paid by the policyholder
        uint256 payment = MedicareContract.calculatePaymentAfterDeductible(policyHolder.deductiblePaid, policyHolder.approvedDrugCost);
        uint256 expectedPayment = (policyHolder.approvedDrugCost - policyHolder.deductiblePaid) * 20 / 100; // Calculate 20% of the cost after deductible
        Assert.equal(payment, expectedPayment, "The payment after deductible should be 20% of the Medicare-approved amount for immunosuppressive drugs");
    }
}