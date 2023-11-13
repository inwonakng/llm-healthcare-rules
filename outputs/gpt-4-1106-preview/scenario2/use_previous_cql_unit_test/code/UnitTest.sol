// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract IVIGCoverageContractTest {
    
    IVIGCoverageContract ivigCoverageContract;

    // Define a struct to encapsulate patient details for cleaner code
    struct PatientDetails {
        bool hasPrimaryImmuneDeficiency;
        bool isMedicallyAppropriate;
        bool isAtHome;
    }

    // Run before every test function
    function beforeEach() public {
        ivigCoverageContract = new IVIGCoverageContract();
    }

    /// Test if IVIG is provided at home
    function testIVIGProvidedAtHome(IVIGCoverageContractTest) public {
        PatientDetails memory patient = PatientDetails(true, true, true);
        bool result = ivigCoverageContract.isCovered(patient.hasPrimaryImmuneDeficiency, patient.isMedicallyAppropriate, patient.isAtHome);
        Assert.equal(result, true, "IVIG should be covered when provided at home.");
    }

    /// Test if patient has primary immune deficiency disease
    function testPatientHasPrimaryImmuneDeficiency(IVIGCoverageContractTest) public {
        PatientDetails memory patient = PatientDetails(true, true, true);
        bool result = ivigCoverageContract.isCovered(patient.hasPrimaryImmuneDeficiency, patient.isMedicallyAppropriate, patient.isAtHome);
        Assert.equal(result, true, "IVIG should be covered for patients with primary immune deficiency disease.");
    }

    /// Test if it's medically appropriate for the patient to receive IVIG at home
    function testMedicallyAppropriateForHomeIVIG(IVIGCoverageContractTest) public {
        PatientDetails memory patient = PatientDetails(true, true, true);
        bool result = ivigCoverageContract.isCovered(patient.hasPrimaryImmuneDeficiency, patient.isMedicallyAppropriate, patient.isAtHome);
        Assert.equal(result, true, "IVIG should be covered if it's medically appropriate for the patient to receive it at home.");
    }

    /// Test if Medicare Part B covers the IVIG medication
    function testMedicarePartBCoversIVIGMedication(IVIGCoverageContractTest) public {
        PatientDetails memory patient = PatientDetails(true, true, true);
        bool result = ivigCoverageContract.isMedicationCovered(patient.hasPrimaryImmuneDeficiency, patient.isMedicallyAppropriate, patient.isAtHome);
        Assert.equal(result, true, "Medicare Part B should cover the IVIG medication.");
    }

    /// Test if Medicare Part B does not cover other items and services
    function testMedicarePartBDoesNotCoverOtherItemsAndServices(IVIGCoverageContractTest) public {
        PatientDetails memory patient = PatientDetails(true, true, true);
        bool result = ivigCoverageContract.isServicesCovered(patient.hasPrimaryImmuneDeficiency, patient.isMedicallyAppropriate, patient.isAtHome);
        Assert.equal(result, false, "Medicare Part B should not cover other items and services related to IVIG administration at home.");
    }

    /// Test if IVIG is not covered when not provided at home
    function testIVIGNotCoveredWhenNotAtHome(IVIGCoverageContractTest) public {
        PatientDetails memory patient = PatientDetails(true, true, false);
        bool result = ivigCoverageContract.isCovered(patient.hasPrimaryImmuneDeficiency, patient.isMedicallyAppropriate, patient.isAtHome);
        Assert.equal(result, false, "IVIG should not be covered when not provided at home.");
    }

    /// Test if IVIG is not covered without a primary immune deficiency diagnosis
    function testIVIGNotCoveredWithoutPrimaryImmuneDeficiency(IVIGCoverageContractTest) public {
        PatientDetails memory patient = PatientDetails(false, true, true);
        bool result = ivigCoverageContract.isCovered(patient.hasPrimaryImmuneDeficiency, patient.isMedicallyAppropriate, patient.isAtHome);
        Assert.equal(result, false, "IVIG should not be covered without a primary immune deficiency diagnosis.");
    }

    /// Test if IVIG is not covered when not medically appropriate
    function testIVIGNotCoveredWhenNotMedicallyAppropriate(IVIGCoverageContractTest) public {
        PatientDetails memory patient = PatientDetails(true, false, true);
        bool result = ivigCoverageContract.isCovered(patient.hasPrimaryImmuneDeficiency, patient.isMedicallyAppropriate, patient.isAtHome);
        Assert.equal(result, false, "IVIG should not be covered when it's not medically appropriate to receive at home.");
    }
}