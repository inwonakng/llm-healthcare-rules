pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract ImmunosuppressiveDrugBenefitTest {
    function testPatientHasPartA() public {
        // Arrange
        Patient patient = new Patient();
        patient.setPartA(true);

        // Act
        bool result = patient.hasPartA();

        // Assert
        assertTrue(result, "Patient should have Part A");
    }

    function testPatientDoesNotHavePartA() public {
        // Arrange
        Patient patient = new Patient();
        patient.setPartA(false);

        // Act
        bool result = patient.hasPartA();

        // Assert
        assertFalse(result, "Patient should not have Part A");
    }

    function testPatientHasPartB() public {
        // Arrange
        Patient patient = new Patient();
        patient.setPartB(true);

        // Act
        bool result = patient.hasPartB();

        // Assert
        assertTrue(result, "Patient should have Part B");
    }

    function testPatientDoesNotHavePartB() public {
        // Arrange
        Patient patient = new Patient();
        patient.setPartB(false);

        // Act
        bool result = patient.hasPartB();

        // Assert
        assertFalse(result, "Patient should not have Part B");
    }

    function testPatientHasImmunosuppressiveDrugCoverage() public {
        // Arrange
        Patient patient = new Patient();
        patient.setPartA(true);
        patient.setPartB(true);

        // Act
        bool result = patient.hasImmunosuppressiveDrugCoverage();

        // Assert
        assertTrue(result, "Patient should have immunosuppressive drug coverage");
    }

    function testPatientDoesNotHaveImmunosuppressiveDrugCoverage() public {
        // Arrange
        Patient patient = new Patient();
        patient.setPartA(false);
        patient.setPartB(false);

        // Act
        bool result = patient.hasImmunosuppressiveDrugCoverage();

        // Assert
        assertFalse(result, "Patient should not have immunosuppressive drug coverage");
    }

    function testPatientHasDeductible() public {
        // Arrange
        Patient patient = new Patient();
        patient.setPartA(true);
        patient.setPartB(true);

        // Act
        uint256 result = patient.getDeductible();

        // Assert
        assertEquals(result, 226, "Patient should have a deductible of 226");
    }

    function testPatientDoesNotHaveDeductible() public {
        // Arrange
        Patient patient = new Patient();
        patient.setPartA(false);
        patient.setPartB(false);

        // Act
        uint256 result = patient.getDeductible();

        // Assert
        assertEquals(result, 0, "Patient should not have a deductible");
    }

    function testPatientHasCopay() public {
        // Arrange
        Patient patient = new Patient();
        patient.setPartA(true);
        patient.setPartB(true);

        // Act
        uint256 result = patient.getCopay();

        // Assert
        assertEquals(result, 97.10, "Patient should have a copay of 97.10");
    }

    function testPatientDoesNotHaveCopay() public {
        // Arrange
        Patient patient = new Patient();
        patient.setPartA(false);
        patient.setPartB(false);

        // Act
        uint256 result = patient.getCopay();

        // Assert
        assertEquals(result, 0, "Patient should not have a copay");
    }
}