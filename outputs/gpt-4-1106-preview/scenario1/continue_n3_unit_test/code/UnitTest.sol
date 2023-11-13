// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract OsteoporosisDrugCoverageTest {
    OsteoporosisDrugCoverage coverageContract;

    // Define a struct to encapsulate patient information for cleaner tests
    struct PatientInfo {
        bool isWoman;
        bool diagnosedWithOsteoporosis;
        bool qualifiesForMedicareHomeHealthBenefit;
        bool hasDoctorCertifiedFracture;
        bool unableToSelfAdministerInjection;
        bool hasUnwillingOrUnableFamily;
    }

    // Create a setup function which initializes the contract
    // before running each test
    function beforeEach() public {
        coverageContract = new OsteoporosisDrugCoverage();
    }

    /// Test coverage for a woman who meets all the criteria
    function testCoverageForEligibleWoman() public {
        PatientInfo memory patient = PatientInfo({
            isWoman: true,
            diagnosedWithOsteoporosis: true,
            qualifiesForMedicareHomeHealthBenefit: true,
            hasDoctorCertifiedFracture: true,
            unableToSelfAdministerInjection: true,
            hasUnwillingOrUnableFamily: false // Not relevant for this test
        });

        bool isCovered = coverageContract.isPatientCovered(patient);
        Assert.equal(isCovered, true, "Eligible woman should be covered.");
    }

    /// Test coverage for a woman who does not meet all the criteria
    function testCoverageForIneligibleWoman() public {
        PatientInfo memory patient = PatientInfo({
            isWoman: true,
            diagnosedWithOsteoporosis: false, // Does not meet this criteria
            qualifiesForMedicareHomeHealthBenefit: true,
            hasDoctorCertifiedFracture: true,
            unableToSelfAdministerInjection: true,
            hasUnwillingOrUnableFamily: false
        });

        bool isCovered = coverageContract.isPatientCovered(patient);
        Assert.equal(isCovered, false, "Ineligible woman should not be covered.");
    }

    /// Test coverage for a woman who needs a home health aide
    function testCoverageWithHomeHealthAide() public {
        PatientInfo memory patient = PatientInfo({
            isWoman: true,
            diagnosedWithOsteoporosis: true,
            qualifiesForMedicareHomeHealthBenefit: true,
            hasDoctorCertifiedFracture: true,
            unableToSelfAdministerInjection: true,
            hasUnwillingOrUnableFamily: true
        });

        bool isCovered = coverageContract.isPatientCovered(patient);
        bool aideCovered = coverageContract.isHomeHealthAideCovered(patient);
        Assert.equal(isCovered, true, "Eligible woman should be covered.");
        Assert.equal(aideCovered, true, "Home health aide should be covered for eligible woman with unwilling or unable family.");
    }

    /// Test coverage for a woman who does not need a home health aide
    function testCoverageWithoutHomeHealthAide() public {
        PatientInfo memory patient = PatientInfo({
            isWoman: true,
            diagnosedWithOsteoporosis: true,
            qualifiesForMedicareHomeHealthBenefit: true,
            hasDoctorCertifiedFracture: true,
            unableToSelfAdministerInjection: true,
            hasUnwillingOrUnableFamily: false
        });

        bool isCovered = coverageContract.isPatientCovered(patient);
        bool aideCovered = coverageContract.isHomeHealthAideCovered(patient);
        Assert.equal(isCovered, true, "Eligible woman should be covered.");
        Assert.equal(aideCovered, false, "Home health aide should not be covered if family can administer injection.");
    }
}