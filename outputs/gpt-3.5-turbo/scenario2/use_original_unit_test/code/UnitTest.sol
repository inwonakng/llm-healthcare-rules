pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract InsuranceContractTest {
    InsuranceContract insuranceContract;

    function beforeEach() public {
        insuranceContract = new InsuranceContract();
    }

    function testIVIGCoverage() public {
        // Set the diagnosis of the patient to primary immune deficiency disease
        insuranceContract.setDiagnosis("primary immune deficiency disease");

        // Set the location of the treatment to home
        insuranceContract.setLocation("home");

        // Set the medical appropriateness of IVIG treatment to true
        insuranceContract.setMedicalAppropriateness(true);

        // Check if IVIG is covered by Medicare
        bool isCovered = insuranceContract.isIVIGCovered();

        // Assert that IVIG is covered by Medicare
        Assert.isTrue(isCovered, "IVIG should be covered by Medicare");
    }

    function testIVIGCoverage_NotPrimaryImmuneDeficiencyDisease() public {
        // Set the diagnosis of the patient to a different condition
        insuranceContract.setDiagnosis("other condition");

        // Set the location of the treatment to home
        insuranceContract.setLocation("home");

        // Set the medical appropriateness of IVIG treatment to true
        insuranceContract.setMedicalAppropriateness(true);

        // Check if IVIG is covered by Medicare
        bool isCovered = insuranceContract.isIVIGCovered();

        // Assert that IVIG is not covered by Medicare
        Assert.isFalse(isCovered, "IVIG should not be covered by Medicare");
    }

    function testIVIGCoverage_NotHomeTreatment() public {
        // Set the diagnosis of the patient to primary immune deficiency disease
        insuranceContract.setDiagnosis("primary immune deficiency disease");

        // Set the location of the treatment to a different location
        insuranceContract.setLocation("hospital");

        // Set the medical appropriateness of IVIG treatment to true
        insuranceContract.setMedicalAppropriateness(true);

        // Check if IVIG is covered by Medicare
        bool isCovered = insuranceContract.isIVIGCovered();

        // Assert that IVIG is not covered by Medicare
        Assert.isFalse(isCovered, "IVIG should not be covered by Medicare");
    }

    function testIVIGCoverage_NotMedicallyAppropriate() public {
        // Set the diagnosis of the patient to primary immune deficiency disease
        insuranceContract.setDiagnosis("primary immune deficiency disease");

        // Set the location of the treatment to home
        insuranceContract.setLocation("home");

        // Set the medical appropriateness of IVIG treatment to false
        insuranceContract.setMedicalAppropriateness(false);

        // Check if IVIG is covered by Medicare
        bool isCovered = insuranceContract.isIVIGCovered();

        // Assert that IVIG is not covered by Medicare
        Assert.isFalse(isCovered, "IVIG should not be covered by Medicare");
    }
}