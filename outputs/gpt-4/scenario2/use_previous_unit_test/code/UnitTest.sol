pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";

contract InsurancePolicyTest {
    InsurancePolicy insurancePolicy = new InsurancePolicy();

    function testCoverageForIVIGAtHome() public {
        bool result = insurancePolicy.isCovered("IVIG", true, true, true);
        Assert.equal(result, true, "IVIG at home should be covered if all conditions are met");
    }

    function testCoverageForIVIGAtHomeWithoutPrimaryImmuneDeficiency() public {
        bool result = insurancePolicy.isCovered("IVIG", true, false, true);
        Assert.equal(result, false, "IVIG at home should not be covered if patient does not have primary immune deficiency");
    }

    function testCoverageForIVIGAtHomeWithoutDoctorApproval() public {
        bool result = insurancePolicy.isCovered("IVIG", true, true, false);
        Assert.equal(result, false, "IVIG at home should not be covered if doctor does not approve");
    }

    function testCoverageForIVIGAtHomeWithPartB() public {
        bool result = insurancePolicy.isCoveredUnderPartB("IVIG", true);
        Assert.equal(result, true, "IVIG at home should be covered under Part B");
    }

    function testCoverageForOtherItemsAndServicesAtHome() public {
        bool result = insurancePolicy.isOtherItemsAndServicesCovered("IVIG", true);
        Assert.equal(result, false, "Other items and services related to IVIG at home should not be covered");
    }
}