// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract IVIGInsuranceContractTest {
    IVIGInsuranceContract insuranceContract;

    // Create a new instance of IVIGInsuranceContract before each test
    function beforeEach() public {
        insuranceContract = new IVIGInsuranceContract();
    }

    // Test case to check if IVIG is covered for a patient with primary immune deficiency disease
    function testCoverageForPrimaryImmuneDeficiency(IVIGInsuranceContractTest) public {
        // Mock patient data
        address patient = address(0x123);
        bool hasPrimaryImmuneDeficiency = true;
        bool medicallyAppropriate = true;

        // Expected result
        bool expectedCoverage = true;

        // Simulate the coverage check
        bool actualCoverage = insuranceContract.isCovered(patient, hasPrimaryImmuneDeficiency, medicallyAppropriate);

        // Assert that the coverage is as expected
        Assert.equal(actualCoverage, expectedCoverage, "IVIG should be covered for primary immune deficiency disease.");
    }

    // Test case to check if IVIG is not covered when it's not medically appropriate
    function testCoverageWhenNotMedicallyAppropriate(IVIGInsuranceContractTest) public {
        // Mock patient data
        address patient = address(0x456);
        bool hasPrimaryImmuneDeficiency = true;
        bool medicallyAppropriate = false;

        // Expected result
        bool expectedCoverage = false;

        // Simulate the coverage check
        bool actualCoverage = insuranceContract.isCovered(patient, hasPrimaryImmuneDeficiency, medicallyAppropriate);

        // Assert that the coverage is as expected
        Assert.equal(actualCoverage, expectedCoverage, "IVIG should not be covered when it's not medically appropriate.");
    }

    // Test case to check if IVIG is not covered for other diagnoses
    function testCoverageForOtherDiagnoses(IVIGInsuranceContractTest) public {
        // Mock patient data
        address patient = address(0x789);
        bool hasPrimaryImmuneDeficiency = false;
        bool medicallyAppropriate = true;

        // Expected result
        bool expectedCoverage = false;

        // Simulate the coverage check
        bool actualCoverage = insuranceContract.isCovered(patient, hasPrimaryImmuneDeficiency, medicallyAppropriate);

        // Assert that the coverage is as expected
        Assert.equal(actualCoverage, expectedCoverage, "IVIG should not be covered for other diagnoses.");
    }

    // Test case to check if Part B covers the IVIG itself but not other related items and services
    function testPartBCoverageExclusions(IVIGInsuranceContractTest) public {
        // Mock patient data
        address patient = address(0xABC);
        bool hasPrimaryImmuneDeficiency = true;
        bool medicallyAppropriate = true;

        // Expected results
        bool expectedIVIGCoverage = true;
        bool expectedServiceCoverage = false;

        // Simulate the coverage check for IVIG
        bool actualIVIGCoverage = insuranceContract.isIVIGCoveredUnderPartB(patient, hasPrimaryImmuneDeficiency, medicallyAppropriate);

        // Simulate the coverage check for related items and services
        bool actualServiceCoverage = insuranceContract.areRelatedServicesCovered(patient, hasPrimaryImmuneDeficiency, medicallyAppropriate);

        // Assert that the coverage is as expected
        Assert.equal(actualIVIGCoverage, expectedIVIGCoverage, "Part B should cover the IVIG itself for primary immune deficiency disease.");
        Assert.equal(actualServiceCoverage, expectedServiceCoverage, "Part B should not cover other items and services related to getting IVIG at home.");
    }
}