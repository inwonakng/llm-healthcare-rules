// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicareInsurancePolicy {
    struct Person {
        bool hasMedicareContribution;
        bool hasPartA;
        bool hasPartB;
        bool hasOriginalMedicare;
        bool hasESRDMedicare;
        bool losesPartA36MonthsPostTransplant;
        bool lacksOtherHealthCoverage;
        bool wantsToEnrollInDrugBenefit;
        bool enrollsIn2023;
        bool metDeductible;
    }

    struct CoverageDetails {
        bool eligibleForTransplantDrugTherapy;
        bool eligibleForTransplantCoverage;
        bool eligibleForImmunosuppressiveDrugsCoverage;
        bool eligibleForPartDCoverage;
        bool canJoinMedicareDrugPlan;
        string medicareCoverageEnds;
        bool eligibleForSpecificBenefit;
        bool benefitCoversImmunosuppressiveDrugsOnly;
        bool benefitNotFullCoverageReplacement;
        bool canEnrollAfterPartAEnds;
        bool shouldCallSocialSecurity;
        uint256 monthlyPremium;
        uint256 annualDeductible;
        uint256 paysPercentageOfApprovedAmount;
    }

    mapping(address => Person) public persons;
    mapping(address => CoverageDetails) public coverageDetails;

    // Constants
    uint256 public constant monthlyPremium2023 = 97.10 ether;
    uint256 public constant annualDeductible2023 = 226 ether;
    uint256 public constant paysPercentageAfterDeductible = 20;

    // Functions to update person details
    function updatePersonDetails(address _personAddress, Person memory _person) public {
        persons[_personAddress] = _person;
        updateCoverageDetails(_personAddress);
    }

    // Internal function to update coverage details based on person details
    function updateCoverageDetails(address _personAddress) internal {
        Person memory person = persons[_personAddress];
        CoverageDetails storage details = coverageDetails[_personAddress];

        // Rule 1
        details.eligibleForTransplantDrugTherapy = person.hasMedicareContribution;

        // Rule 2
        details.eligibleForTransplantCoverage = person.hasPartA;

        // Rule 3
        details.eligibleForImmunosuppressiveDrugsCoverage = person.hasPartB;

        // Rule 4
        details.eligibleForPartDCoverage = !person.hasPartB;

        // Rule 5
        details.canJoinMedicareDrugPlan = person.hasOriginalMedicare;

        // Rule 6
        if (person.hasESRDMedicare) {
            details.medicareCoverageEnds = "36MonthsAfterTransplant";
        }

        // Rule 7
        if (person.losesPartA36MonthsPostTransplant && person.lacksOtherHealthCoverage) {
            details.eligibleForSpecificBenefit = true;
        }

        // Rule 8
        details.benefitCoversImmunosuppressiveDrugsOnly = details.eligibleForSpecificBenefit;

        // Rule 9
        details.benefitNotFullCoverageReplacement = details.eligibleForSpecificBenefit;

        // Rule 10
        details.canEnrollAfterPartAEnds = details.eligibleForSpecificBenefit;

        // Rule 11
        details.shouldCallSocialSecurity = person.wantsToEnrollInDrugBenefit;

        // Rule 12
        if (person.enrollsIn2023) {
            details.monthlyPremium = monthlyPremium2023;
            details.annualDeductible = annualDeductible2023;
        }

        // Rule 13
        if (person.metDeductible) {
            details.paysPercentageOfApprovedAmount = paysPercentageAfterDeductible;
        }
    }

    // Function to get coverage details
    function getCoverageDetails(address _personAddress) public view returns (CoverageDetails memory) {
        return coverageDetails[_personAddress];
    }
}