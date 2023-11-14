// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


// The contract name should be the same as the contract we are testing with "Test" appended
contract IVIGInsurancePolicyTest {

    IVIGInsurancePolicy policyContract;

    // Create a new instance of the contract before each test
    function beforeEach() public {
        policyContract = new IVIGInsurancePolicy();
    }

    /// Test if Medicare covers IVIG when administered at home
    function testMedicareCoversIVIGAtHome() public {
        // Assuming the function in IVIGInsurancePolicy contract is isCovered()
        bool isCovered = policyContract.isCovered("IVIG", true, true, true);
        Assert.equal(isCovered, true, "Medicare should cover IVIG when administered at home.");
    }

    /// Test if Medicare does not cover IVIG without a proper diagnosis
    function testMedicareDoesNotCoverWithoutDiagnosis() public {
        bool isCovered = policyContract.isCovered("IVIG", false, true, true);
        Assert.equal(isCovered, false, "Medicare should not cover IVIG without a proper diagnosis.");
    }

    /// Test if Medicare does not cover IVIG if it's not medically appropriate to administer at home
    function testMedicareDoesNotCoverIfNotMedicallyAppropriate() public {
        bool isCovered = policyContract.isCovered("IVIG", true, false, true);
        Assert.equal(isCovered, false, "Medicare should not cover IVIG if it's not medically appropriate to administer at home.");
    }

    /// Test if Medicare Part B covers the cost of IVIG medication
    function testMedicarePartBCoversIVIGMedication() public {
        // Assuming the function in IVIGInsurancePolicy contract is partBCoverage()
        bool partBCovered = policyContract.partBCoverage("IVIG");
        Assert.equal(partBCovered, true, "Medicare Part B should cover the cost of IVIG medication.");
    }

    /// Test if Medicare Part B does not cover additional items or services
    function testMedicarePartBDoesNotCoverAdditionalItemsOrServices() public {
        // Assuming the function in IVIGInsurancePolicy contract is partBCoverageForServices()
        bool partBCoveredServices = policyContract.partBCoverageForServices("IVIG");
        Assert.equal(partBCoveredServices, false, "Medicare Part B should not cover additional items or services.");
    }
}