pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";

contract InsurancePolicyTest {
    InsurancePolicy insurancePolicy = new InsurancePolicy();

    // Test for rule 1 and 2
    function testCoverageForIVIGWithPrimaryImmuneDeficiency() public {
        bool result = insurancePolicy.isCovered("IVIG", true, "home", "primary immune deficiency");
        Assert.equal(result, true, "The policy should cover IVIG for primary immune deficiency patients at home");
    }

    // Test for rule 3
    function testCoverageForIVIGWithoutDoctorApproval() public {
        bool result = insurancePolicy.isCovered("IVIG", false, "home", "primary immune deficiency");
        Assert.equal(result, false, "The policy should not cover IVIG without doctor's approval");
    }

    // Test for rule 4
    function testCoverageUnderPartBForIVIG() public {
        uint coveredAmount = insurancePolicy.getCoveredAmount("IVIG", "Part B");
        Assert.equal(coveredAmount, 100, "Part B should cover the full cost of IVIG");
    }

    // Test for rule 5
    function testCoverageUnderPartBForOtherItems() public {
        uint coveredAmount = insurancePolicy.getCoveredAmount("Other Items", "Part B");
        Assert.equal(coveredAmount, 0, "Part B should not cover the cost of other items and services");
    }
}