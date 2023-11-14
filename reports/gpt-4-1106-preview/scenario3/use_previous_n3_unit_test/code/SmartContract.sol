// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicareContract {
    struct Person {
        bool medicarePaidForTransplant;
        bool hadPartAAtTimeOfTransplant;
        bool hasPartB;
        bool hasOriginalMedicare;
        bool hasESRD;
        bool successfulKidneyTransplant;
        uint monthsAfterTransplant;
        bool hasOtherHealthCoverage;
        bool partAEnded;
        bool wantsToEnrollInSpecificBenefit;
        bool contactedSocialSecurity;
        bool enrolledIn2023;
        bool metDeductible;
    }

    // Constants for the year 2023
    uint constant public premium2023 = 97.10 ether;
    uint constant public deductible2023 = 226 ether;
    uint constant public percentageOfApprovedAmount = 20;

    // Check if transplant drug therapy is covered
    function isTransplantDrugTherapyCovered(bool medicarePaidForTransplant) public pure returns (bool) {
        return medicarePaidForTransplant;
    }

    // Check if individual is eligible for coverage
    function isEligibleForCoverage(bool hadPartAAtTimeOfTransplant, bool hasPartB) public pure returns (bool) {
        return hadPartAAtTimeOfTransplant && hasPartB;
    }

    // Check if drug coverage is applicable
    function isDrugCoverageApplicable(bool hasPartB) public pure returns (bool) {
        return hasPartB;
    }

    // Check if Part D coverage is applicable
    function isPartDCoverageApplicable(bool hasPartB) public pure returns (bool) {
        return !hasPartB;
    }

    // Check if a person can join Medicare drug plan
    function canJoinMedicareDrugPlan(bool hasOriginalMedicare) public pure returns (bool) {
        return hasOriginalMedicare;
    }

    // Check if Medicare coverage ends after transplant
    function doesCoverageEndAfterTransplant(bool hasESRD, uint monthsAfterTransplant) public pure returns (bool) {
        return hasESRD && monthsAfterTransplant >= 36;
    }

    // Check if specific benefit is available
    function isSpecificBenefitAvailable(bool hasOtherHealthCoverage, bool partAEnded) public pure returns (bool) {
        return !hasOtherHealthCoverage && partAEnded;
    }

    // Check if benefit covers only drugs
    function doesBenefitCoverOnlyDrugs(bool eligibleForSpecificBenefit) public pure returns (bool) {
        return eligibleForSpecificBenefit;
    }

    // Check if benefit is a full coverage substitute
    function isBenefitFullCoverageSubstitute(bool eligibleForSpecificBenefit) public pure returns (bool) {
        return !eligibleForSpecificBenefit;
    }

    // Get premium and deductible for 2023
    function getPremiumAndDeductibleFor2023() public pure returns (uint, uint) {
        return (premium2023, deductible2023);
    }

    // Calculate payment after deductible
    function calculatePaymentAfterDeductible(uint approvedAmount) public pure returns (uint) {
        return (approvedAmount * percentageOfApprovedAmount) / 100;
    }
}