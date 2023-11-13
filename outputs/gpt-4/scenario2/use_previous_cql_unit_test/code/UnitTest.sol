pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";

contract InsurancePolicyTest {
    InsurancePolicy insurancePolicy = new InsurancePolicy();

    function testCoverageForIVIGAtHome() public {
        bool result = insurancePolicy.isCovered("IVIG", true, "primary immune deficiency disease", true);
        Assert.equal(result, true, "IVIG at home with primary immune deficiency disease should be covered");
    }

    function testCoverageForIVIGAtHomeWithoutPrimaryImmuneDeficiency() public {
        bool result = insurancePolicy.isCovered("IVIG", true, "other disease", true);
        Assert.equal(result, false, "IVIG at home without primary immune deficiency disease should not be covered");
    }

    function testCoverageForIVIGAtHomeWithoutDoctorApproval() public {
        bool result = insurancePolicy.isCovered("IVIG", true, "primary immune deficiency disease", false);
        Assert.equal(result, false, "IVIG at home without doctor's approval should not be covered");
    }

    function testCoverageForIVIGPartBCoverage() public {
        bool result = insurancePolicy.isPartBCovered("IVIG");
        Assert.equal(result, true, "IVIG should be covered under Part B");
    }

    function testCoverageForOtherItemsAndServices() public {
        bool result = insurancePolicy.isOtherItemsAndServicesCovered("IVIG", true);
        Assert.equal(result, false, "Other items and services related to IVIG at home should not be covered");
    }
}