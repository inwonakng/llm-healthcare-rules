// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract OsteoporosisDrugCoverageContractTest {
    OsteoporosisDrugCoverageContract coverageContract;

    // Define a struct to encapsulate patient information for cleaner tests
    struct PatientInfo {
        bool isWoman;
        bool hasOsteoporosis;
        bool qualifiesForHomeHealthBenefit;
        bool hasCertifiedFracture;
        bool canSelfAdminister;
        bool hasAideAvailable;
    }

    // Create a setup function to initialize the contract before running each test
    function beforeEach() public {
        coverageContract = new OsteoporosisDrugCoverageContract();
    }

    /// Test if a woman with osteoporosis who meets all criteria is covered
    function testCoverageForEligibleWoman() public {
        PatientInfo memory patient = PatientInfo({
            isWoman: true,
            hasOsteoporosis: true,
            qualifiesForHomeHealthBenefit: true,
            hasCertifiedFracture: true,
            canSelfAdminister: false,
            hasAideAvailable: true
        });

        bool isCovered = coverageContract.isPatientCovered(patient);
        Assert.equal(isCovered, true, "Eligible woman should be covered.");
    }

    /// Test if a man with osteoporosis is not covered
    function testCoverageForMan() public {
        PatientInfo memory patient = PatientInfo({
            isWoman: false,
            hasOsteoporosis: true,
            qualifiesForHomeHealthBenefit: true,
            hasCertifiedFracture: true,
            canSelfAdminister: false,
            hasAideAvailable: true
        });

        bool isCovered = coverageContract.isPatientCovered(patient);
        Assert.equal(isCovered, false, "Man should not be covered.");
    }

    /// Test if a woman without a certified fracture is not covered
    function testCoverageWithoutCertifiedFracture() public {
        PatientInfo memory patient = PatientInfo({
            isWoman: true,
            hasOsteoporosis: true,
            qualifiesForHomeHealthBenefit: true,
            hasCertifiedFracture: false,
            canSelfAdminister: false,
            hasAideAvailable: true
        });

        bool isCovered = coverageContract.isPatientCovered(patient);
        Assert.equal(isCovered, false, "Woman without certified fracture should not be covered.");
    }

    /// Test if a woman who can self-administer is not covered
    function testCoverageForSelfAdministeringWoman() public {
        PatientInfo memory patient = PatientInfo({
            isWoman: true,
            hasOsteoporosis: true,
            qualifiesForHomeHealthBenefit: true,
            hasCertifiedFracture: true,
            canSelfAdminister: true,
            hasAideAvailable: true
        });

        bool isCovered = coverageContract.isPatientCovered(patient);
        Assert.equal(isCovered, false, "Woman who can self-administer should not be covered.");
    }

    /// Test if a woman without home health benefit qualification is not covered
    function testCoverageWithoutHomeHealthBenefit() public {
        PatientInfo memory patient = PatientInfo({
            isWoman: true,
            hasOsteoporosis: true,
            qualifiesForHomeHealthBenefit: false,
            hasCertifiedFracture: true,
            canSelfAdminister: false,
            hasAideAvailable: true
        });

        bool isCovered = coverageContract.isPatientCovered(patient);
        Assert.equal(isCovered, false, "Woman without home health benefit qualification should not be covered.");
    }

    /// Test if a woman with no aide available is not covered
    function testCoverageWithoutAideAvailable() public {
        PatientInfo memory patient = PatientInfo({
            isWoman: true,
            hasOsteoporosis: true,
            qualifiesForHomeHealthBenefit: true,
            hasCertifiedFracture: true,
            canSelfAdminister: false,
            hasAideAvailable: false
        });

        bool isCovered = coverageContract.isPatientCovered(patient);
        Assert.equal(isCovered, false, "Woman with no aide available should not be covered.");
    }
}