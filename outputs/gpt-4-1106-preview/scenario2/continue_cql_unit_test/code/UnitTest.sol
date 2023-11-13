// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract IVIGCoverageContractTest {
    IVIGCoverageContract ivigCoverageContract;

    // Define a struct to encapsulate patient information for cleaner code
    struct PatientInfo {
        bool hasPrimaryImmuneDeficiencyDisease;
        bool doctorApprovedHomeIVIG;
        bool ivigMedicationCoveredByPartB;
        bool otherItemsAndServicesNotCovered;
    }

    // Create a patient info instance for testing
    PatientInfo patientInfo;

    // Run before each test function
    function beforeEach() public {
        ivigCoverageContract = new IVIGCoverageContract();
        // Initialize patient info with default values
        patientInfo = PatientInfo(false, false, false, true);
    }

    /// Test if a patient with all conditions met is eligible for coverage
    function testEligibilityWithAllConditionsMet() public {
        patientInfo.hasPrimaryImmuneDeficiencyDisease = true;
        patientInfo.doctorApprovedHomeIVIG = true;
        patientInfo.ivigMedicationCoveredByPartB = true;
        patientInfo.otherItemsAndServicesNotCovered = true;

        bool isEligible = ivigCoverageContract.checkEligibility(
            patientInfo.hasPrimaryImmuneDeficiencyDisease,
            patientInfo.doctorApprovedHomeIVIG,
            patientInfo.ivigMedicationCoveredByPartB,
            patientInfo.otherItemsAndServicesNotCovered
        );

        Assert.equal(isEligible, true, "Patient should be eligible for coverage");
    }

    /// Test if a patient without a primary immune deficiency disease is not eligible for coverage
    function testEligibilityWithoutPrimaryImmuneDeficiencyDisease() public {
        patientInfo.hasPrimaryImmuneDeficiencyDisease = false;
        patientInfo.doctorApprovedHomeIVIG = true;
        patientInfo.ivigMedicationCoveredByPartB = true;
        patientInfo.otherItemsAndServicesNotCovered = true;

        bool isEligible = ivigCoverageContract.checkEligibility(
            patientInfo.hasPrimaryImmuneDeficiencyDisease,
            patientInfo.doctorApprovedHomeIVIG,
            patientInfo.ivigMedicationCoveredByPartB,
            patientInfo.otherItemsAndServicesNotCovered
        );

        Assert.equal(isEligible, false, "Patient should not be eligible for coverage without a primary immune deficiency disease");
    }

    /// Test if a patient without doctor's approval for home IVIG is not eligible for coverage
    function testEligibilityWithoutDoctorApproval() public {
        patientInfo.hasPrimaryImmuneDeficiencyDisease = true;
        patientInfo.doctorApprovedHomeIVIG = false;
        patientInfo.ivigMedicationCoveredByPartB = true;
        patientInfo.otherItemsAndServicesNotCovered = true;

        bool isEligible = ivigCoverageContract.checkEligibility(
            patientInfo.hasPrimaryImmuneDeficiencyDisease,
            patientInfo.doctorApprovedHomeIVIG,
            patientInfo.ivigMedicationCoveredByPartB,
            patientInfo.otherItemsAndServicesNotCovered
        );

        Assert.equal(isEligible, false, "Patient should not be eligible for coverage without doctor's approval for home IVIG");
    }

    /// Test if a patient with IVIG not covered by Medicare Part B is not eligible for coverage
    function testEligibilityWithIVIGNotCoveredByPartB() public {
        patientInfo.hasPrimaryImmuneDeficiencyDisease = true;
        patientInfo.doctorApprovedHomeIVIG = true;
        patientInfo.ivigMedicationCoveredByPartB = false;
        patientInfo.otherItemsAndServicesNotCovered = true;

        bool isEligible = ivigCoverageContract.checkEligibility(
            patientInfo.hasPrimaryImmuneDeficiencyDisease,
            patientInfo.doctorApprovedHomeIVIG,
            patientInfo.ivigMedicationCoveredByPartB,
            patientInfo.otherItemsAndServicesNotCovered
        );

        Assert.equal(isEligible, false, "Patient should not be eligible for coverage if IVIG is not covered by Medicare Part B");
    }

    /// Test if a patient with other items and services related to IVIG covered is not eligible for coverage
    function testEligibilityWithOtherItemsAndServicesCovered() public {
        patientInfo.hasPrimaryImmuneDeficiencyDisease = true;
        patientInfo.doctorApprovedHomeIVIG = true;
        patientInfo.ivigMedicationCoveredByPartB = true;
        patientInfo.otherItemsAndServicesNotCovered = false;

        bool isEligible = ivigCoverageContract.checkEligibility(
            patientInfo.hasPrimaryImmuneDeficiencyDisease,
            patientInfo.doctorApprovedHomeIVIG,
            patientInfo.ivigMedicationCoveredByPartB,
            patientInfo.otherItemsAndServicesNotCovered
        );

        Assert.equal(isEligible, false, "Patient should not be eligible for coverage if other items and services related to IVIG are covered");
    }
}