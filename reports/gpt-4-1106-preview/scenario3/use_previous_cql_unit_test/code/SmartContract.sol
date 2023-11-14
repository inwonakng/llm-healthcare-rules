// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicareContract {
    struct Patient {
        bool hasPartA;
        bool hasPartB;
        bool hasPartD;
        bool hasOriginalMedicare;
        bool hasESRD;
        bool hasOtherHealthCoverage;
        uint transplantDate; // Timestamp of the transplant
    }

    struct Coverage {
        bool drugCoverageOnly;
        bool fullHealthCoverage;
    }

    uint public constant MONTHLY_PREMIUM_2023 = 97.10 ether;
    uint public constant DEDUCTIBLE_2023 = 226 ether;
    uint public constant COINSURANCE_RATE = 20;

    mapping(address => Patient) public patients;
    mapping(address => Coverage) public coverages;

    // Helper function to determine if 36 months have passed since the transplant
    function _isMoreThan36MonthsSinceTransplant(uint transplantDate) private view returns (bool) {
        return (block.timestamp - transplantDate) > 36 * 30 days;
    }

    function isTransplantDrugTherapyCovered(bool medicareContributed) public pure returns (bool) {
        return medicareContributed;
    }

    function hasPartAAtTimeOfTransplant(address patientAddress) public view returns (bool) {
        Patient memory patient = patients[patientAddress];
        return patient.hasPartA && patient.transplantDate != 0;
    }

    function hasPartBForImmunosuppressiveDrugs(address patientAddress) public view returns (bool) {
        return patients[patientAddress].hasPartB;
    }

    function isPartDCoverageAvailable(address patientAddress) public view returns (bool) {
        Patient memory patient = patients[patientAddress];
        return !patient.hasPartB && patient.hasPartD;
    }

    function canJoinMedicareDrugPlan(address patientAddress) public view returns (bool) {
        return patients[patientAddress].hasOriginalMedicare;
    }

    function doesCoverageEndAfter36Months(address patientAddress) public view returns (bool) {
        Patient memory patient = patients[patientAddress];
        return patient.hasESRD && _isMoreThan36MonthsSinceTransplant(patient.transplantDate);
    }

    function isSpecificBenefitAvailable(address patientAddress) public view returns (bool) {
        Patient memory patient = patients[patientAddress];
        return doesCoverageEndAfter36Months(patientAddress) && !patient.hasOtherHealthCoverage;
    }

    function doesBenefitOnlyCoverDrugs(address patientAddress) public view returns (bool) {
        Coverage memory coverage = coverages[patientAddress];
        return isSpecificBenefitAvailable(patientAddress) && coverage.drugCoverageOnly;
    }

    function isBenefitFullCoverageSubstitute(address patientAddress) public view returns (bool) {
        Coverage memory coverage = coverages[patientAddress];
        return doesBenefitOnlyCoverDrugs(patientAddress) && !coverage.fullHealthCoverage;
    }

    function canEnrollAfterPartAEnds(address patientAddress) public view returns (bool) {
        return isSpecificBenefitAvailable(patientAddress);
    }

    function getPremiumAndDeductibleFor2023() public pure returns (uint, uint) {
        return (MONTHLY_PREMIUM_2023, DEDUCTIBLE_2023);
    }

    function getAmountPaidAfterDeductible(uint medicareApprovedAmount, bool deductibleMet) public pure returns (uint) {
        if (deductibleMet) {
            return (medicareApprovedAmount * COINSURANCE_RATE) / 100;
        } else {
            return medicareApprovedAmount + DEDUCTIBLE_2023;
        }
    }

    // Functions to set patient and coverage data for testing purposes
    function setPatientData(address patientAddress, bool hasPartA, bool hasPartB, bool hasPartD, bool hasOriginalMedicare, bool hasESRD, bool hasOtherHealthCoverage, uint transplantDate) public {
        patients[patientAddress] = Patient(hasPartA, hasPartB, hasPartD, hasOriginalMedicare, hasESRD, hasOtherHealthCoverage, transplantDate);
    }

    function setCoverageData(address patientAddress, bool drugCoverageOnly, bool fullHealthCoverage) public {
        coverages[patientAddress] = Coverage(drugCoverageOnly, fullHealthCoverage);
    }
}