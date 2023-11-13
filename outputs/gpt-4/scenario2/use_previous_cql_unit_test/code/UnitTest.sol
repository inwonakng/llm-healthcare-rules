pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract InsurancePolicyTest {
    InsurancePolicy insurancePolicy;

    function beforeEach() public {
        insurancePolicy = new InsurancePolicy();
    }

    /// Test if the insurance policy covers IVIG provided at home
    function testCoverageOfIVIGAtHome() public {
        bool result = insurancePolicy.isIVIGCovered(true);
        Assert.equal(result, true, "The insurance policy should cover IVIG if it is provided at home");
    }

    /// Test if the insurance policy covers IVIG when the insured has a diagnosis of primary immune deficiency disease
    function testCoverageWithPrimaryImmuneDeficiency() public {
        bool result = insurancePolicy.isCoveredWithDisease(true);
        Assert.equal(result, true, "The coverage is applicable only if the insured has a diagnosis of primary immune deficiency disease");
    }

    /// Test if the insurance policy covers IVIG when it is medically appropriate for the insured to receive IVIG at home
    function testCoverageWithDoctorApproval() public {
        bool result = insurancePolicy.isCoveredWithDoctorApproval(true);
        Assert.equal(result, true, "The decision of whether it is medically appropriate for the insured to receive IVIG at home must be made by a doctor");
    }

    /// Test if the insurance policy under Part B covers the cost of IVIG itself
    function testCoverageUnderPartB() public {
        bool result = insurancePolicy.isCoveredUnderPartB(true);
        Assert.equal(result, true, "The insurance policy under Part B should cover the cost of IVIG itself");
    }

    /// Test if the insurance policy does not cover the cost of other items and services related to the insured receiving IVIG at home
    function testNoCoverageForOtherItems() public {
        bool result = insurancePolicy.isOtherItemsCovered(false);
        Assert.equal(result, false, "The policy should not cover the cost of other items and services related to the insured receiving IVIG at home");
    }
}