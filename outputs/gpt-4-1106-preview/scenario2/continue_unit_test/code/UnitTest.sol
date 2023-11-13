// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract IVIGCoverageContractTest {
    IVIGCoverageContract ivigCoverageContract;

    // Define a struct to encapsulate patient information and test parameters
    struct PatientInfo {
        bool hasPrimaryImmuneDeficiency;
        bool isIVIGMedicallyAppropriate;
        bool isAtHome;
    }

    // Run before every test function
    function beforeEach() public {
        ivigCoverageContract = new IVIGCoverageContract();
    }

    /// Test if IVIG is provided at home
    function testIVIGProvidedAtHome(IVIGCoverageContractTest) public {
        PatientInfo memory patient = PatientInfo(true, true, true);
        bool result = ivigCoverageContract.isIVIGCovered(patient);
        Assert.equal(result, true, "IVIG should be covered when provided at home.");
    }

    /// Test if patient has a primary immune deficiency disease
    function testPatientHasPrimaryImmuneDeficiency(IVIGCoverageContractTest) public {
        PatientInfo memory patient = PatientInfo(true, true, true);
        bool result = ivigCoverageContract.isIVIGCovered(patient);
        Assert.equal(result, true, "IVIG should be covered for patients with primary immune deficiency.");
    }

    /// Test if doctor determines IVIG at home is medically appropriate
    function testIVIGMedicallyAppropriateAtHome(IVIGCoverageContractTest) public {
        PatientInfo memory patient = PatientInfo(true, true, true);
        bool result = ivigCoverageContract.isIVIGCovered(patient);
        Assert.equal(result, true, "IVIG should be covered if it's medically appropriate at home.");
    }

    /// Test if Medicare Part B covers the IVIG
    function testMedicarePartBCoversIVIG(IVIGCoverageContractTest) public {
        PatientInfo memory patient = PatientInfo(true, true, true);
        bool result = ivigCoverageContract.isIVIGCovered(patient);
        Assert.equal(result, true, "Medicare Part B should cover the IVIG.");
    }

    /// Test if Medicare Part B does not cover other related items and services
    function testMedicarePartBDoesNotCoverRelatedItemsAndServices(IVIGCoverageContractTest) public {
        PatientInfo memory patient = PatientInfo(true, true, true);
        bool result = ivigCoverageContract.doesMedicareCoverRelatedItemsAndServices(patient);
        Assert.equal(result, false, "Medicare Part B should not cover other related items and services.");
    }

    // Additional tests to cover negative scenarios
    /// Test if IVIG is not covered when not provided at home
    function testIVIGNotCoveredWhenNotAtHome(IVIGCoverageContractTest) public {
        PatientInfo memory patient = PatientInfo(true, true, false);
        bool result = ivigCoverageContract.isIVIGCovered(patient);
        Assert.equal(result, false, "IVIG should not be covered when not provided at home.");
    }

    /// Test if IVIG is not covered when patient does not have primary immune deficiency
    function testIVIGNotCoveredWithoutPrimaryImmuneDeficiency(IVIGCoverageContractTest) public {
        PatientInfo memory patient = PatientInfo(false, true, true);
        bool result = ivigCoverageContract.isIVIGCovered(patient);
        Assert.equal(result, false, "IVIG should not be covered without primary immune deficiency.");
    }

    /// Test if IVIG is not covered when not medically appropriate
    function testIVIGNotCoveredWhenNotMedicallyAppropriate(IVIGCoverageContractTest) public {
        PatientInfo memory patient = PatientInfo(true, false, true);
        bool result = ivigCoverageContract.isIVIGCovered(patient);
        Assert.equal(result, false, "IVIG should not be covered when not medically appropriate.");
    }
}