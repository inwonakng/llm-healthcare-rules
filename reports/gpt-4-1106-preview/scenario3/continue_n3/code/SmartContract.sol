// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicareInsurancePolicy {
    struct Person {
        bool hadTransplant;
        bool hasPartA;
        bool hasPartB;
        bool hasPartD;
        bool hasOriginalMedicare;
        bool hasESRD;
        uint monthsAfterTransplant;
        bool hasOtherHealthCoverage;
        bool partAEnded;
        bool enrolledIn2023;
        bool metDeductible;
    }

    struct Benefit {
        bool eligibleForDrugTherapyCoverage;
        bool eligibleForTransplantCoverage;
        bool eligibleForImmunosuppressiveDrugs;
        bool canJoinDrugPlan;
        bool esrdCoverageEnds;
        bool eligibleForSpecificBenefit;
        bool benefitCoversDrugsOnly;
        bool benefitIsNotFullCoverage;
        bool canEnrollInBenefit;
        bool shouldContactSocialSecurity;
        uint monthlyPremium;
        uint annualDeductible;
        uint payPercentageAfterDeductible;
    }

    mapping(address => Person) public persons;
    mapping(address => Benefit) public benefits;

    function updatePersonStatus(address _personAddress, Person memory _person) public {
        persons[_personAddress] = _person;
        updateBenefits(_personAddress);
    }

    function updateBenefits(address _personAddress) internal {
        Person memory person = persons[_personAddress];
        Benefit storage benefit = benefits[_personAddress];

        benefit.eligibleForDrugTherapyCoverage = person.hadTransplant;
        benefit.eligibleForTransplantCoverage = person.hasPartA && person.hadTransplant;
        benefit.eligibleForImmunosuppressiveDrugs = person.hasPartB;
        benefit.canJoinDrugPlan = person.hasOriginalMedicare;
        benefit.esrdCoverageEnds = person.hasESRD && person.monthsAfterTransplant > 36;
        benefit.eligibleForSpecificBenefit = person.partAEnded && !person.hasOtherHealthCoverage && person.monthsAfterTransplant > 36;
        benefit.benefitCoversDrugsOnly = benefit.eligibleForSpecificBenefit;
        benefit.benefitIsNotFullCoverage = benefit.eligibleForSpecificBenefit;
        benefit.canEnrollInBenefit = person.partAEnded;
        benefit.shouldContactSocialSecurity = benefit.canEnrollInBenefit;

        if (person.enrolledIn2023) {
            benefit.monthlyPremium = 97;
            benefit.annualDeductible = 226;
        }

        benefit.payPercentageAfterDeductible = person.metDeductible ? 20 : 0;
    }

    function getBenefit(address _personAddress) public view returns (Benefit memory) {
        return benefits[_personAddress];
    }
}