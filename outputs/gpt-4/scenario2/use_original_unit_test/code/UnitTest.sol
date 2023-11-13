pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";

contract MedicareContractTest {
    MedicareContract medicare = MedicareContract(DeployedAddresses.MedicareContract());

    // Test for IVIG coverage for a patient with primary immune deficiency disease
    function testIVIGCoverageForPrimaryImmuneDeficiency() public {
        bool expected = true;
        bool result = medicare.isIVIGCovered("primary immune deficiency disease", true);
        Assert.equal(result, expected, "IVIG should be covered for primary immune deficiency disease patient if it's medically appropriate");
    }

    // Test for IVIG coverage for a patient without primary immune deficiency disease
    function testIVIGCoverageForNonPrimaryImmuneDeficiency() public {
        bool expected = false;
        bool result = medicare.isIVIGCovered("other disease", true);
        Assert.equal(result, expected, "IVIG should not be covered for non-primary immune deficiency disease patient even if it's medically appropriate");
    }

    // Test for IVIG coverage for a patient with primary immune deficiency disease but it's not medically appropriate
    function testIVIGCoverageForPrimaryImmuneDeficiencyNotMedicallyAppropriate() public {
        bool expected = false;
        bool result = medicare.isIVIGCovered("primary immune deficiency disease", false);
        Assert.equal(result, expected, "IVIG should not be covered for primary immune deficiency disease patient if it's not medically appropriate");
    }

    // Test for non-IVIG related items and services coverage
    function testNonIVIGRelatedItemsAndServicesCoverage() public {
        bool expected = false;
        bool result = medicare.isNonIVIGRelatedItemsAndServicesCovered();
        Assert.equal(result, expected, "Non-IVIG related items and services should not be covered");
    }
}