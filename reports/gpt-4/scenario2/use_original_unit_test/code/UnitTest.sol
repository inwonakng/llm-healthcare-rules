// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract InsurancePolicyTest {
    InsurancePolicy insurancePolicy;

    function beforeEach() public {
        insurancePolicy = new InsurancePolicy();
    }

    /// Test if the patient has a diagnosis of primary immune deficiency disease
    function testPrimaryImmuneDeficiencyDiagnosis() public {
        bool hasDiagnosis = insurancePolicy.checkPrimaryImmuneDeficiencyDiagnosis("patientId");
        Assert.equal(hasDiagnosis, true, "The patient should have a primary immune deficiency disease diagnosis");
    }

    /// Test if the doctor decides that it’s medically appropriate for the patient to get the IVIG in their home
    function testDoctorApprovalForHomeIVIG() public {
        bool hasApproval = insurancePolicy.checkDoctorApprovalForHomeIVIG("patientId");
        Assert.equal(hasApproval, true, "The doctor should approve the patient to get the IVIG at home");
    }

    /// Test if Part B covers the IVIG itself
    function testPartBCoverageForIVIG() public {
        bool isCovered = insurancePolicy.checkPartBCoverageForIVIG("patientId");
        Assert.equal(isCovered, true, "Part B should cover the IVIG itself");
    }

    /// Test if Part B doesn’t pay for other items and services related to the patient getting the IVIG at home
    function testPartBDoesNotCoverOtherItemsAndServices() public {
        bool isCovered = insurancePolicy.checkPartBCoverageForOtherItemsAndServices("patientId");
        Assert.equal(isCovered, false, "Part B should not cover other items and services related to the patient getting the IVIG at home");
    }
}