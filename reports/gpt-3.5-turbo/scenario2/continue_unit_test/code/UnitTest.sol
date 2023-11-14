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

    function testIVIGCoverageWithDifferentDiagnosis() public {
        bool isCovered = insuranceContract.isIVIGCovered("some other diagnosis");
        Assert.isFalse(isCovered, "IVIG should not be covered for a different diagnosis");
    }

    function testIVIGInHome() public {
        bool isInHome = insuranceContract.isIVIGInHome("primary immune deficiency disease");
        Assert.isTrue(isInHome, "IVIG should be provided in home for primary immune deficiency disease");
    }

    function testIVIGInHomeWithDifferentDiagnosis() public {
        bool isInHome = insuranceContract.isIVIGInHome("some other diagnosis");
        Assert.isFalse(isInHome, "IVIG should not be provided in home for a different diagnosis");
    }

    function testIVIGCostCoverage() public {
        bool isCovered = insuranceContract.isIVIGCostCovered();
        Assert.isTrue(isCovered, "IVIG cost should be covered by Medicare Part B");
    }

    function testOtherItemsAndServicesCoverage() public {
        bool isCovered = insuranceContract.isOtherItemsAndServicesCovered();
        Assert.isFalse(isCovered, "Other items and services related to IVIG at home are not covered");
    }
}