// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


// Mock contract to simulate patient conditions and doctor's decisions
contract MockPatient {
    bool public hasPrimaryImmuneDeficiency;
    bool public medicallyAppropriateForHomeIVIG;

    function setPrimaryImmuneDeficiency(bool _hasPrimaryImmuneDeficiency) public {
        hasPrimaryImmuneDeficiency = _hasPrimaryImmuneDeficiency;
    }

    function setMedicallyAppropriateForHomeIVIG(bool _medicallyAppropriateForHomeIVIG) public {
        medicallyAppropriateForHomeIVIG = _medicallyAppropriateForHomeIVIG;
    }
}

// The actual IVIGCoverage contract should have functions that check the conditions
// and return whether the IVIG is covered, including medication and services.

/// @title Test suite for the IVIGCoverage contract
contract IVIGCoverageTest {
    MockPatient patient;
    IVIGCoverage coverageContract;

    // Run before every test function
    function beforeEach() public {
        patient = new MockPatient();
        coverageContract = new IVIGCoverage(address(patient));
    }

    /// @notice Test coverage when patient has primary immune deficiency and it's medically appropriate for home IVIG
    function testCoverageWithValidConditions() public {
        patient.setPrimaryImmuneDeficiency(true);
        patient.setMedicallyAppropriateForHomeIVIG(true);

        (bool isCovered, bool isMedicationCovered, bool isServiceCovered) = coverageContract.checkCoverage();
        Assert.equal(isCovered, true, "IVIG should be covered");
        Assert.equal(isMedicationCovered, true, "IVIG medication should be covered");
        Assert.equal(isServiceCovered, false, "IVIG related services should not be covered");
    }

    /// @notice Test coverage when patient does not have primary immune deficiency
    function testCoverageWithoutPrimaryImmuneDeficiency() public {
        patient.setPrimaryImmuneDeficiency(false);
        patient.setMedicallyAppropriateForHomeIVIG(true);

        (bool isCovered, bool isMedicationCovered, bool isServiceCovered) = coverageContract.checkCoverage();
        Assert.equal(isCovered, false, "IVIG should not be covered");
        Assert.equal(isMedicationCovered, false, "IVIG medication should not be covered");
        Assert.equal(isServiceCovered, false, "IVIG related services should not be covered");
    }

    /// @notice Test coverage when it's not medically appropriate for home IVIG
    function testCoverageWithNotMedicallyAppropriateForHomeIVIG() public {
        patient.setPrimaryImmuneDeficiency(true);
        patient.setMedicallyAppropriateForHomeIVIG(false);

        (bool isCovered, bool isMedicationCovered, bool isServiceCovered) = coverageContract.checkCoverage();
        Assert.equal(isCovered, false, "IVIG should not be covered");
        Assert.equal(isMedicationCovered, false, "IVIG medication should not be covered");
        Assert.equal(isServiceCovered, false, "IVIG related services should not be covered");
    }
}