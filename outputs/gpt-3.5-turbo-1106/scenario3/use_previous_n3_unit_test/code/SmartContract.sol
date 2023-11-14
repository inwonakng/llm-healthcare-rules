// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicareInsurancePolicy {
    
    struct Person {
        bool isMedicareBeneficiary;
        bool hadOrganTransplant;
        bool receivedMedicareCoverage;
        bool hasPartA;
        bool hasPartB;
        bool receivedImmunosuppressiveDrugs;
        bool hasPartD;
        bool hasOriginalMedicare;
        bool hasESRD;
        bool hadSuccessfulKidneyTransplant;
        uint monthsSinceTransplant;
        bool lostPartACoverage;
        uint monthsSinceKidneyTransplant;
        bool hasCertainHealthCoverage;
        bool eligibleForTransplantDrugTherapy;
        bool eligibleForMedicareDrugCoverage;
        bool immunosuppressiveDrugCoverageEnds;
        bool eligibleForImmunosuppressiveDrugBenefit;
        bool canSignUpForBenefit;
        uint signUpYear;
        uint monthlyPremium;
        uint deductible;
        bool metDeductible;
        uint paysPercentage;
    }
    
    mapping(address => Person) public persons;
    
    function applyForMedicareCoverage(
        bool _hadOrganTransplant,
        bool _receivedMedicareCoverage,
        bool _hasPartA,
        bool _hasPartB,
        bool _receivedImmunosuppressiveDrugs,
        bool _hasPartD,
        bool _hasOriginalMedicare,
        bool _hasESRD,
        bool _hadSuccessfulKidneyTransplant,
        uint _monthsSinceTransplant,
        bool _lostPartACoverage,
        uint _monthsSinceKidneyTransplant,
        bool _hasCertainHealthCoverage
    ) external {
        Person storage person = persons[msg.sender];
        person.isMedicareBeneficiary = true;
        person.hadOrganTransplant = _hadOrganTransplant;
        person.receivedMedicareCoverage = _receivedMedicareCoverage;
        person.hasPartA = _hasPartA;
        person.hasPartB = _hasPartB;
        person.receivedImmunosuppressiveDrugs = _receivedImmunosuppressiveDrugs;
        person.hasPartD = _hasPartD;
        person.hasOriginalMedicare = _hasOriginalMedicare;
        person.hasESRD = _hasESRD;
        person.hadSuccessfulKidneyTransplant = _hadSuccessfulKidneyTransplant;
        person.monthsSinceTransplant = _monthsSinceTransplant;
        person.lostPartACoverage = _lostPartACoverage;
        person.monthsSinceKidneyTransplant = _monthsSinceKidneyTransplant;
        person.hasCertainHealthCoverage = _hasCertainHealthCoverage;
        
        // Apply N3 logic rules
        if (person.hadOrganTransplant && person.receivedMedicareCoverage) {
            person.eligibleForTransplantDrugTherapy = true;
        }
        if (person.hadOrganTransplant && person.hasPartA) {
            person.eligibleForTransplantDrugTherapy = true;
        }
        if (person.receivedImmunosuppressiveDrugs && person.hasPartB) {
            person.eligibleForTransplantDrugTherapy = true;
        }
        if (person.receivedImmunosuppressiveDrugs && !person.hasPartB && person.hasPartD) {
            person.eligibleForTransplantDrugTherapy = true;
        }
        if (person.hasOriginalMedicare) {
            person.eligibleForMedicareDrugCoverage = true;
        }
        if (person.hasESRD && person.hadSuccessfulKidneyTransplant && person.monthsSinceTransplant == 36) {
            person.immunosuppressiveDrugCoverageEnds = true;
        }
        if (person.lostPartACoverage && person.monthsSinceKidneyTransplant == 36 && !person.hasCertainHealthCoverage) {
            person.eligibleForImmunosuppressiveDrugBenefit = true;
        }
        if (person.eligibleForImmunosuppressiveDrugBenefit) {
            person.canSignUpForBenefit = true;
        }
        if (person.signUpYear == 2023 && person.monthlyPremium == 97.10 && person.deductible == 226) {
            person.eligibleForImmunosuppressiveDrugBenefit = true;
        }
        if (person.metDeductible && person.paysPercentage == 20) {
            person.eligibleForImmunosuppressiveDrugBenefit = true;
        }
    }
    
    function signUpForBenefit() external view returns (bool) {
        return persons[msg.sender].canSignUpForBenefit;
    }
}