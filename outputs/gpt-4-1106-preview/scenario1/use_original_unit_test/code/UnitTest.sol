// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


// Define a struct to encapsulate patient information and conditions
struct PatientInfo {
    bool isWoman;
    bool hasOsteoporosis;
    bool meetsHomeHealthCriteria;
    bool hasCertifiedFracture;
    bool cannotSelfAdminister;
    bool hasAideAvailable;
}

// Define a struct to encapsulate the test setup
struct TestSetup {
    OsteoporosisDrugCoverage coverageContract;
    PatientInfo patient;
}

contract OsteoporosisDrugCoverageTest {
    TestSetup setup;

    function beforeEach() public {
        setup.coverageContract = new OsteoporosisDrugCoverage();
        setup.patient = PatientInfo({
            isWoman: true,
            hasOsteoporosis: true,
            meetsHomeHealthCriteria: true,
            hasCertifiedFracture: true,
            cannotSelfAdminister: true,
            hasAideAvailable: true
        });
    }

    /// Test if a woman with osteoporosis who meets all criteria is covered
    function testCoverageForEligibleWoman(OsteoporosisDrugCoverageTest) public {
        bool isCovered = setup.coverageContract.isPatientCovered(
            setup.patient.isWoman,
            setup.patient.hasOsteoporosis,
            setup.patient.meetsHomeHealthCriteria,
            setup.patient.hasCertifiedFracture,
            setup.patient.cannotSelfAdminister,
            setup.patient.hasAideAvailable
        );
        Assert.equal(isCovered, true, "Eligible woman should be covered.");
    }

    /// Test if a man with osteoporosis is not covered
    function testCoverageForMan(OsteoporosisDrugCoverageTest) public {
        setup.patient.isWoman = false;
        bool isCovered = setup.coverageContract.isPatientCovered(
            setup.patient.isWoman,
            setup.patient.hasOsteoporosis,
            setup.patient.meetsHomeHealthCriteria,
            setup.patient.hasCertifiedFracture,
            setup.patient.cannotSelfAdminister,
            setup.patient.hasAideAvailable
        );
        Assert.equal(isCovered, false, "Man should not be covered.");
    }

    /// Test if a woman without a certified fracture is not covered
    function testCoverageWithoutCertifiedFracture(OsteoporosisDrugCoverageTest) public {
        setup.patient.hasCertifiedFracture = false;
        bool isCovered = setup.coverageContract.isPatientCovered(
            setup.patient.isWoman,
            setup.patient.hasOsteoporosis,
            setup.patient.meetsHomeHealthCriteria,
            setup.patient.hasCertifiedFracture,
            setup.patient.cannotSelfAdminister,
            setup.patient.hasAideAvailable
        );
        Assert.equal(isCovered, false, "Woman without certified fracture should not be covered.");
    }

    /// Test if a woman who can self-administer is not covered
    function testCoverageForSelfAdministeringWoman(OsteoporosisDrugCoverageTest) public {
        setup.patient.cannotSelfAdminister = false;
        bool isCovered = setup.coverageContract.isPatientCovered(
            setup.patient.isWoman,
            setup.patient.hasOsteoporosis,
            setup.patient.meetsHomeHealthCriteria,
            setup.patient.hasCertifiedFracture,
            setup.patient.cannotSelfAdminister,
            setup.patient.hasAideAvailable
        );
        Assert.equal(isCovered, false, "Woman who can self-administer should not be covered.");
    }

    /// Test if a woman without home health aide availability is not covered
    function testCoverageWithoutHomeHealthAide(OsteoporosisDrugCoverageTest) public {
        setup.patient.hasAideAvailable = false;
        bool isCovered = setup.coverageContract.isPatientCovered(
            setup.patient.isWoman,
            setup.patient.hasOsteoporosis,
            setup.patient.meetsHomeHealthCriteria,
            setup.patient.hasCertifiedFracture,
            setup.patient.cannotSelfAdminister,
            setup.patient.hasAideAvailable
        );
        Assert.equal(isCovered, false, "Woman without home health aide availability should not be covered.");
    }
}