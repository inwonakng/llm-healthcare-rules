pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract InsuranceContractTest {
    InsuranceContract insuranceContract;

    function beforeEach() public {
        insuranceContract = new InsuranceContract();
    }

    function testIVIGCoverage() public {
        // Set the diagnosis of the patient
        insuranceContract.setDiagnosis("primary immune deficiency disease");

        // Set the medical appropriateness of IVIG in home
        insuranceContract.setMedicalAppropriateness(true);

        // Check if IVIG is covered by Medicare
        bool isCovered = insuranceContract.isIVIGCovered();

        Assert.isTrue(isCovered, "IVIG should be covered by Medicare");
    }

    function testIVIGCoverage_NotCovered() public {
        // Set the diagnosis of the patient
        insuranceContract.setDiagnosis("other disease");

        // Set the medical appropriateness of IVIG in home
        insuranceContract.setMedicalAppropriateness(true);

        // Check if IVIG is covered by Medicare
        bool isCovered = insuranceContract.isIVIGCovered();

        Assert.isFalse(isCovered, "IVIG should not be covered by Medicare");
    }

    function testIVIGCoverage_NotMedicallyAppropriate() public {
        // Set the diagnosis of the patient
        insuranceContract.setDiagnosis("primary immune deficiency disease");

        // Set the medical appropriateness of IVIG in home
        insuranceContract.setMedicalAppropriateness(false);

        // Check if IVIG is covered by Medicare
        bool isCovered = insuranceContract.isIVIGCovered();

        Assert.isFalse(isCovered, "IVIG should not be covered by Medicare");
    }
}