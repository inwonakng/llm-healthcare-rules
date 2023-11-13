pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract InsurancePolicyTest {
    InsurancePolicy insurancePolicy;

    function beforeEach() public {
        insurancePolicy = new InsurancePolicy();
    }

    /// Test if the policy covers IVIG at home
    function testIVIGCoverageAtHome() public {
        bool result = insurancePolicy.isIVIGCoveredAtHome();
        Assert.equal(result, true, "The policy should cover IVIG at home");
    }

    /// Test if the policy covers only if the insured has a diagnosis of primary immune deficiency disease
    function testCoverageForPrimaryImmuneDeficiency() public {
        bool result = insurancePolicy.isCoveredForPrimaryImmuneDeficiency();
        Assert.equal(result, true, "The policy should cover only if the insured has a diagnosis of primary immune deficiency disease");
    }

    /// Test if the decision of whether it's medically appropriate for the insured to receive IVIG at home must be made by a doctor
    function testMedicalAppropriateness() public {
        bool result = insurancePolicy.isMedicallyAppropriate();
        Assert.equal(result, true, "The decision of whether it's medically appropriate for the insured to receive IVIG at home must be made by a doctor");
    }

    /// Test if the coverage under Part B of the policy includes the cost of IVIG itself
    function testPartBCoverage() public {
        bool result = insurancePolicy.isPartBCoveringIVIG();
        Assert.equal(result, true, "The coverage under Part B of the policy should include the cost of IVIG itself");
    }

    /// Test if Part B of the policy does not cover the cost of other items and services related to the insured receiving IVIG at home
    function testPartBNonCoverage() public {
        bool result = insurancePolicy.isPartBNotCoveringOtherItems();
        Assert.equal(result, true, "Part B of the policy should not cover the cost of other items and services related to the insured receiving IVIG at home");
    }
}