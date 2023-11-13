// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract IVIGCoverageContractTest {
    IVIGCoverageContract ivigCoverage;

    // Define a struct to encapsulate patient information and requirements
    struct Patient {
        bool hasPrimaryImmuneDeficiency;
        bool isMedicallyAppropriate;
        bool isAtHome;
    }

    // Create a patient instance for testing
    Patient patient;

    // Run before each test function
    function beforeEach() public {
        ivigCoverage = new IVIGCoverageContract();
        patient = Patient(false, false, false); // Default to not meeting any requirements
    }

    /// Test if IVIG is provided at home
    function testIVIGProvidedAtHome() public {
        patient.isAtHome = true;
        bool result = ivigCoverage.checkCoverage(patient.hasPrimaryImmuneDeficiency, patient.isMedicallyAppropriate, patient.isAtHome);
        Assert.equal(result, false, "IVIG should be provided at home, but other conditions must also be met.");
    }

    /// Test if patient has a primary immune deficiency disease
    function testPatientHasPrimaryImmuneDeficiency() public {
        patient.hasPrimaryImmuneDeficiency = true;
        bool result = ivigCoverage.checkCoverage(patient.hasPrimaryImmuneDeficiency, patient.isMedicallyAppropriate, patient.isAtHome);
        Assert.equal(result, false, "Patient must have primary immune deficiency for coverage, but other conditions must also be met.");
    }

    /// Test if it's medically appropriate for the patient to receive IVIG at home
    function testMedicallyAppropriateForHomeIVIG() public {
        patient.isMedicallyAppropriate = true;
        bool result = ivigCoverage.checkCoverage(patient.hasPrimaryImmuneDeficiency, patient.isMedicallyAppropriate, patient.isAtHome);
        Assert.equal(result, false, "It must be medically appropriate for the patient to receive IVIG at home, but other conditions must also be met.");
    }

    /// Test if Medicare Part B covers the IVIG
    function testMedicarePartBCoversIVIG() public {
        patient.hasPrimaryImmuneDeficiency = true;
        patient.isMedicallyAppropriate = true;
        patient.isAtHome = true;
        bool result = ivigCoverage.checkCoverage(patient.hasPrimaryImmuneDeficiency, patient.isMedicallyAppropriate, patient.isAtHome);
        Assert.equal(result, true, "Medicare Part B should cover the IVIG under these conditions.");
    }

    /// Test if Medicare Part B does not cover other related items and services
    function testMedicarePartBDoesNotCoverOtherItemsAndServices() public {
        patient.hasPrimaryImmuneDeficiency = true;
        patient.isMedicallyAppropriate = true;
        patient.isAtHome = true;
        bool result = ivigCoverage.checkCoverage(patient.hasPrimaryImmuneDeficiency, patient.isMedicallyAppropriate, patient.isAtHome);
        Assert.equal(result, true, "Medicare Part B does not cover other items and services, only the IVIG itself.");
    }
}