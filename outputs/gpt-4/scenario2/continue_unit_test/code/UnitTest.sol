```solidity
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";

contract InsurancePolicyTest {
    InsurancePolicy insurance = new InsurancePolicy();

    // Test for requirement 1 and 2
    function testIVIGCoverageWithPrimaryImmuneDeficiency() public {
        bool result = insurance.isIVIGCovered(true, true, true);
        Assert.equal(result, true, "IVIG should be covered for primary immune deficiency disease");
    }

    // Test for requirement 3
    function testIVIGCoverageWithoutDoctorApproval() public {
        bool result = insurance.isIVIGCovered(true, true, false);
        Assert.equal(result, false, "IVIG should not be covered without doctor's approval");
    }

    // Test for requirement 4
    function testIVIGCoverageUnderPartB() public {
        uint coveredAmount = insurance.getIVIGCoverageAmount("PartB", 1000);
        Assert.equal(coveredAmount, 1000, "Part B should cover the cost of IVIG itself");
    }

    // Test for requirement 5
    function testIVIGCoverageForOtherItems() public {
        uint coveredAmount = insurance.getIVIGCoverageAmount("PartB", 1000, 200);
        Assert.equal(coveredAmount, 1000, "Part B should not cover the cost of other items and services");
    }
}