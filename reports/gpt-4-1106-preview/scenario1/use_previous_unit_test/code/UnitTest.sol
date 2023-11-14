// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


// Define a struct to encapsulate patient details for cleaner code
struct PatientDetails {
    bool isWoman;
    bool hasOsteoporosis;
    bool qualifiesForHomeHealthBenefit;
    bool hasCertifiedFracture;
    bool canSelfAdminister;
    bool hasAbleCaregiver;
}

contract MedicareContractTest {
    // Create a dummy instance of MedicareContract to interact with
    MedicareContract medicareContract;

    // Run before every test function
    function beforeEach() public {
        medicareContract = new MedicareContract();
    }

    /// Test if a woman with osteoporosis who meets the criteria for the Medicare home health benefit
    /// and has a certified fracture related to post-menopausal osteoporosis is covered
    function testCoverageForEligibleWomanWithOsteoporosis() public {
        PatientDetails memory patient = PatientDetails({
            isWoman: true,
            hasOsteoporosis: true,
            qualifiesForHomeHealthBenefit: true,
            hasCertifiedFracture: true,
            canSelfAdminister: false,
            hasAbleCaregiver: false
        });

        bool isCovered = medicareContract.checkCoverage(patient.isWoman, patient.hasOsteoporosis, patient.qualifiesForHomeHealthBenefit, patient.hasCertifiedFracture, patient.canSelfAdminister, patient.hasAbleCaregiver);
        Assert.equal(isCovered, true, "Eligible woman with osteoporosis should be covered.");
    }

    /// Test if a woman with osteoporosis who does not meet the criteria for the Medicare home health benefit is not covered
    function testCoverageForWomanWithoutHomeHealthBenefit() public {
        PatientDetails memory patient = PatientDetails({
            isWoman: true,
            hasOsteoporosis: true,
            qualifiesForHomeHealthBenefit: false,
            hasCertifiedFracture: true,
            canSelfAdminister: false,
            hasAbleCaregiver: false
        });

        bool isCovered = medicareContract.checkCoverage(patient.isWoman, patient.hasOsteoporosis, patient.qualifiesForHomeHealthBenefit, patient.hasCertifiedFracture, patient.canSelfAdminister, patient.hasAbleCaregiver);
        Assert.equal(isCovered, false, "Woman without home health benefit should not be covered.");
    }

    /// Test if a woman with osteoporosis and a non-certified fracture is not covered
    function testCoverageForWomanWithNonCertifiedFracture() public {
        PatientDetails memory patient = PatientDetails({
            isWoman: true,
            hasOsteoporosis: true,
            qualifiesForHomeHealthBenefit: true,
            hasCertifiedFracture: false,
            canSelfAdminister: false,
            hasAbleCaregiver: false
        });

        bool isCovered = medicareContract.checkCoverage(patient.isWoman, patient.hasOsteoporosis, patient.qualifiesForHomeHealthBenefit, patient.hasCertifiedFracture, patient.canSelfAdminister, patient.hasAbleCaregiver);
        Assert.equal(isCovered, false, "Woman with non-certified fracture should not be covered.");
    }

    /// Test if a woman who can self-administer the injection is not covered
    function testCoverageForWomanWhoCanSelfAdminister() public {
        PatientDetails memory patient = PatientDetails({
            isWoman: true,
            hasOsteoporosis: true,
            qualifiesForHomeHealthBenefit: true,
            hasCertifiedFracture: true,
            canSelfAdminister: true,
            hasAbleCaregiver: false
        });

        bool isCovered = medicareContract.checkCoverage(patient.isWoman, patient.hasOsteoporosis, patient.qualifiesForHomeHealthBenefit, patient.hasCertifiedFracture, patient.canSelfAdminister, patient.hasAbleCaregiver);
        Assert.equal(isCovered, false, "Woman who can self-administer should not be covered.");
    }

    /// Test if a woman with an able caregiver is not covered for home health nurse or aide services
    function testCoverageForWomanWithAbleCaregiver() public {
        PatientDetails memory patient = PatientDetails({
            isWoman: true,
            hasOsteoporosis: true,
            qualifiesForHomeHealthBenefit: true,
            hasCertifiedFracture: true,
            canSelfAdminister: false,
            hasAbleCaregiver: true
        });

        bool isCovered = medicareContract.checkCoverage(patient.isWoman, patient.hasOsteoporosis, patient.qualifiesForHomeHealthBenefit, patient.hasCertifiedFracture, patient.canSelfAdminister, patient.hasAbleCaregiver);
        Assert.equal(isCovered, false, "Woman with an able caregiver should not be covered for home health nurse or aide services.");
    }
}