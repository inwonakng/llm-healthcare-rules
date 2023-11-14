pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract ImmunosuppressiveDrugBenefitTest {
    function testIsEligibleForImmunosuppressiveDrugBenefit() public {
        // Arrange
        ImmunosuppressiveDrugBenefit benefit = new ImmunosuppressiveDrugBenefit();
        benefit.setPatient(new Patient(1, "John Doe", "Male", "1990-01-01"));
        benefit.setCoverage(new Coverage(1, "Part A", "Medicare"));
        benefit.setCoverage(new Coverage(2, "Part B", "Medicare"));
        benefit.setCoverage(new Coverage(3, "Medicare Drug", "Medicare"));
        benefit.setCoverage(new Coverage(4, "Other Health", "Medicare"));

        // Act
        bool eligible = benefit.isEligibleForImmunosuppressiveDrugBenefit();

        // Assert
        assertTrue(eligible);
    }

    function testGetImmunosuppressiveDrugBenefitPremium() public {
        // Arrange
        ImmunosuppressiveDrugBenefit benefit = new ImmunosuppressiveDrugBenefit();
        benefit.setPatient(new Patient(1, "John Doe", "Male", "1990-01-01"));
        benefit.setCoverage(new Coverage(1, "Part A", "Medicare"));
        benefit.setCoverage(new Coverage(2, "Part B", "Medicare"));
        benefit.setCoverage(new Coverage(3, "Medicare Drug", "Medicare"));
        benefit.setCoverage(new Coverage(4, "Other Health", "Medicare"));

        // Act
        uint256 premium = benefit.getImmunosuppressiveDrugBenefitPremium();

        // Assert
        assertEquals(premium, 97.10);
    }

    function testGetImmunosuppressiveDrugBenefitDeductible() public {
        // Arrange
        ImmunosuppressiveDrugBenefit benefit = new ImmunosuppressiveDrugBenefit();
        benefit.setPatient(new Patient(1, "John Doe", "Male", "1990-01-01"));
        benefit.setCoverage(new Coverage(1, "Part A", "Medicare"));
        benefit.setCoverage(new Coverage(2, "Part B", "Medicare"));
        benefit.setCoverage(new Coverage(3, "Medicare Drug", "Medicare"));
        benefit.setCoverage(new Coverage(4, "Other Health", "Medicare"));

        // Act
        uint256 deductible = benefit.getImmunosuppressiveDrugBenefitDeductible();

        // Assert
        assertEquals(deductible, 226);
    }

    function testGetImmunosuppressiveDrugBenefitCopay() public {
        // Arrange
        ImmunosuppressiveDrugBenefit benefit = new ImmunosuppressiveDrugBenefit();
        benefit.setPatient(new Patient(1, "John Doe", "Male", "1990-01-01"));
        benefit.setCoverage(new Coverage(1, "Part A", "Medicare"));
        benefit.setCoverage(new Coverage(2, "Part B", "Medicare"));
        benefit.setCoverage(new Coverage(3, "Medicare Drug", "Medicare"));
        benefit.setCoverage(new Coverage(4, "Other Health", "Medicare"));

        // Act
        uint256 copay = benefit.getImmunosuppressiveDrugBenefitCopay();

        // Assert
        assertEquals(copay, 20);
    }

    function testGetImmunosuppressiveDrugBenefitMaximumOutOfPocket() public {
        // Arrange
        ImmunosuppressiveDrugBenefit benefit = new ImmunosuppressiveDrugBenefit();
        benefit.setPatient(new Patient(1, "John Doe", "Male", "1990-01-01"));
        benefit.setCoverage(new Coverage(1, "Part A", "Medicare"));
        benefit.setCoverage(new Coverage(2, "Part B", "Medicare"));
        benefit.setCoverage(new Coverage(3, "Medicare Drug", "Medicare"));
        benefit.setCoverage(new Coverage(4, "Other Health", "Medicare"));

        // Act
        uint256 maximumOutOfPocket = benefit.getImmunosuppressiveDrugBenefitMaximumOutOfPocket();

        // Assert
        assertEquals(maximumOutOfPocket, 1000);
    }
}