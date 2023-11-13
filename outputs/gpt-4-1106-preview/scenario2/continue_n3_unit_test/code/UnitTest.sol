// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract IVIGCoverageContractTest {
    IVIGCoverageContract ivigCoverageContract;

    // Define a struct to encapsulate patient information for cleaner tests
    struct Patient {
        bool hasPrimaryImmuneDeficiencyDisease;
        bool hasDoctorApproval;
        bool receivesIVIGAtHome;
    }

    // Create a patient eligible for coverage
    Patient eligiblePatient = Patient(true, true, true);
    // Create a patient not eligible for coverage due to lack of doctor's approval
    Patient ineligiblePatientNoApproval = Patient(true, false, true);
    // Create a patient not eligible for coverage due to not receiving IVIG at home
    Patient ineligiblePatientNotAtHome = Patient(true, true, false);

    // Run before each test to reset contract state
    function beforeEach() public {
        ivigCoverageContract = new IVIGCoverageContract();
    }

    /// Test if an eligible patient is covered for IVIG by Medicare Part B
    function eligibleForIVIGCoverageTest() public {
        bool isCovered = ivigCoverageContract.checkCoverage(
            eligiblePatient.hasPrimaryImmuneDeficiencyDisease,
            eligiblePatient.hasDoctorApproval,
            eligiblePatient.receivesIVIGAtHome
        );
        Assert.equal(isCovered, true, "Eligible patient should be covered for IVIG.");
    }

    /// Test if a patient without doctor's approval is not covered for IVIG
    function ineligibleNoDoctorApprovalTest() public {
        bool isCovered = ivigCoverageContract.checkCoverage(
            ineligiblePatientNoApproval.hasPrimaryImmuneDeficiencyDisease,
            ineligiblePatientNoApproval.hasDoctorApproval,
            ineligiblePatientNoApproval.receivesIVIGAtHome
        );
        Assert.equal(isCovered, false, "Patient without doctor's approval should not be covered for IVIG.");
    }

    /// Test if a patient not receiving IVIG at home is not covered for IVIG
    function ineligibleNotAtHomeTest() public {
        bool isCovered = ivigCoverageContract.checkCoverage(
            ineligiblePatientNotAtHome.hasPrimaryImmuneDeficiencyDisease,
            ineligiblePatientNotAtHome.hasDoctorApproval,
            ineligiblePatientNotAtHome.receivesIVIGAtHome
        );
        Assert.equal(isCovered, false, "Patient not receiving IVIG at home should not be covered for IVIG.");
    }

    /// Test if an eligible patient is not covered for related services
    function notCoveredForRelatedServicesTest() public {
        bool isCoveredForServices = ivigCoverageContract.checkRelatedServicesCoverage(
            eligiblePatient.receivesIVIGAtHome
        );
        Assert.equal(isCoveredForServices, false, "Eligible patient should not be covered for related services.");
    }
}