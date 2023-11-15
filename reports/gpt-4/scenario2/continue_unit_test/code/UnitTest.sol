pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract InsurancePolicyTest {
    InsurancePolicy insurancePolicy;

    function beforeEach() public {
        insurancePolicy = new InsurancePolicy();
    }

    function checkIVIGCoverageWithPrimaryImmuneDeficiency() public {
        bool result = insurancePolicy.checkCoverage(true, true, true);
        Assert.equal(result, true, "The policy should cover IVIG for patients with primary immune deficiency disease.");
    }

    function checkIVIGCoverageWithoutPrimaryImmuneDeficiency() public {
        bool result = insurancePolicy.checkCoverage(true, false, true);
        Assert.equal(result, false, "The policy should not cover IVIG for patients without primary immune deficiency disease.");
    }

    function checkIVIGCoverageWithoutDoctorApproval() public {
        bool result = insurancePolicy.checkCoverage(true, true, false);
        Assert.equal(result, false, "The policy should not cover IVIG without doctor's approval.");
    }

    function checkIVIGCoverageWithoutIVIG() public {
        bool result = insurancePolicy.checkCoverage(false, true, true);
        Assert.equal(result, false, "The policy should not cover if IVIG is not provided.");
    }

    function checkNonIVIGCoverage() public {
        bool result = insurancePolicy.checkNonIVIGCoverage();
        Assert.equal(result, false, "The policy should not cover other items and services related to IVIG at home.");
    }
}