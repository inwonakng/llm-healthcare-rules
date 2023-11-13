// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract MedicareCoverageContractTest {
    
    // Define a struct to encapsulate patient information for cleaner code
    struct PatientInfo {
        bool isWoman;
        bool hasOsteoporosis;
        bool qualifiesForHomeHealthBenefit;
        bool hasCertifiedFracture;
        bool canSelfAdminister;
        bool hasAideAvailable;
    }

    // Create a test instance of the MedicareCoverageContract
    MedicareCoverageContract coverageContract;

    // This is run before every test to set up the contract's state
    function beforeEach() public {
        coverageContract = new MedicareCoverageContract();
    }

    /// Test if a woman with osteoporosis who meets all criteria is covered
    function testCoverageForEligibleWoman() public {
        // Create a patient info struct with all conditions met
        PatientInfo memory patient = PatientInfo({
            isWoman: true,
            hasOsteoporosis: true,
            qualifiesForHomeHealthBenefit: true,
            hasCertifiedFracture: true,
            canSelfAdminister: false,
            hasAideAvailable: false
        });

        // Assert that the coverage should be true
        Assert.equal(
            coverageContract.isCovered(
                patient.isWoman,
                patient.hasOsteoporosis,
                patient.qualifiesForHomeHealthBenefit,
                patient.hasCertifiedFracture,
                patient.canSelfAdminister,
                patient.hasAideAvailable
            ),
            true,
            "Eligible woman should be covered"
        );
    }

    /// Test if a man with osteoporosis is not covered
    function testCoverageForMan() public {
        PatientInfo memory patient = PatientInfo({
            isWoman: false,
            hasOsteoporosis: true,
            qualifiesForHomeHealthBenefit: true,
            hasCertifiedFracture: true,
            canSelfAdminister: false,
            hasAideAvailable: false
        });

        Assert.equal(
            coverageContract.isCovered(
                patient.isWoman,
                patient.hasOsteoporosis,
                patient.qualifiesForHomeHealthBenefit,
                patient.hasCertifiedFracture,
                patient.canSelfAdminister,
                patient.hasAideAvailable
            ),
            false,
            "Man should not be covered"
        );
    }

    /// Test if a woman without a certified fracture is not covered
    function testCoverageWithoutCertifiedFracture() public {
        PatientInfo memory patient = PatientInfo({
            isWoman: true,
            hasOsteoporosis: true,
            qualifiesForHomeHealthBenefit: true,
            hasCertifiedFracture: false,
            canSelfAdminister: false,
            hasAideAvailable: false
        });

        Assert.equal(
            coverageContract.isCovered(
                patient.isWoman,
                patient.hasOsteoporosis,
                patient.qualifiesForHomeHealthBenefit,
                patient.hasCertifiedFracture,
                patient.canSelfAdminister,
                patient.hasAideAvailable
            ),
            false,
            "Woman without certified fracture should not be covered"
        );
    }

    /// Test if a woman who can self-administer is not covered
    function testCoverageForSelfAdministeringWoman() public {
        PatientInfo memory patient = PatientInfo({
            isWoman: true,
            hasOsteoporosis: true,
            qualifiesForHomeHealthBenefit: true,
            hasCertifiedFracture: true,
            canSelfAdminister: true,
            hasAideAvailable: false
        });

        Assert.equal(
            coverageContract.isCovered(
                patient.isWoman,
                patient.hasOsteoporosis,
                patient.qualifiesForHomeHealthBenefit,
                patient.hasCertifiedFracture,
                patient.canSelfAdminister,
                patient.hasAideAvailable
            ),
            false,
            "Self-administering woman should not be covered"
        );
    }

    /// Test if a woman with all conditions met but with an available aide is covered
    function testCoverageWithAvailableAide() public {
        PatientInfo memory patient = PatientInfo({
            isWoman: true,
            hasOsteoporosis: true,
            qualifiesForHomeHealthBenefit: true,
            hasCertifiedFracture: true,
            canSelfAdminister: false,
            hasAideAvailable: true
        });

        Assert.equal(
            coverageContract.isCovered(
                patient.isWoman,
                patient.hasOsteoporosis,
                patient.qualifiesForHomeHealthBenefit,
                patient.hasCertifiedFracture,
                patient.canSelfAdminister,
                patient.hasAideAvailable
            ),
            true,
            "Woman with all conditions met but with an available aide should be covered"
        );
    }
}