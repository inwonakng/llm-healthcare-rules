pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract InsuranceContractTest {
    InsuranceContract insuranceContract;

    function beforeEach() public {
        insuranceContract = new InsuranceContract();
    }

    function testIVIGCoverage() public {
        bool isCovered = insuranceContract.isIVIGCovered("primary immune deficiency disease");
        Assert.isTrue(isCovered, "IVIG should be covered for primary immune deficiency disease");
    }

    function testIVIGInHome() public {
        bool isInHome = insuranceContract.isIVIGInHome("primary immune deficiency disease");
        Assert.isTrue(isInHome, "IVIG should be provided in home for primary immune deficiency disease");
    }

    function testIVIGCostCoverage() public {
        bool isCostCovered = insuranceContract.isIVIGCostCovered();
        Assert.isTrue(isCostCovered, "Medicare Part B should cover the cost of IVIG");
    }

    function testOtherServicesCoverage() public {
        bool isOtherServicesCovered = insuranceContract.isOtherServicesCovered();
        Assert.isFalse(isOtherServicesCovered, "Medicare does not cover other items and services related to IVIG at home");
    }
}