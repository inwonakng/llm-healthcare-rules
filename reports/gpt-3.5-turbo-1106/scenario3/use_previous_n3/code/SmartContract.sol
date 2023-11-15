// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicareInsurancePolicy {
    
    struct Patient {
        bool medicareHelpedPayForOrganTransplant;
        bool coveredTransplant;
        bool getImmunosuppressiveDrugs;
        bool partBCoversImmunosuppressiveDrugs;
        bool originalMedicare;
        bool onlyMedicareDueToESRD;
        bool successfulKidneyTransplant;
        bool losePartACoverageAfter36Months;
        bool notHaveCertainHealthCoverage;
        bool immunosuppressiveDrugBenefit;
        bool deductibleMet;
    }
    
    function transplantDrugTherapyCovered(Patient memory patient) public pure returns (bool) {
        return patient.medicareHelpedPayForOrganTransplant;
    }
    
    function partAAtTimeOfTransplant(Patient memory patient) public pure returns (bool) {
        return patient.coveredTransplant;
    }
    
    function partBAtTimeOfImmunosuppressiveDrugs(Patient memory patient) public pure returns (bool) {
        return patient.getImmunosuppressiveDrugs;
    }
    
    function partDCoversImmunosuppressiveDrugs(Patient memory patient) public pure returns (bool) {
        return !patient.partBCoversImmunosuppressiveDrugs;
    }
    
    function joinMedicareDrugPlan(Patient memory patient) public pure returns (bool) {
        return patient.originalMedicare;
    }
    
    function coverageEndsAfter36Months(Patient memory patient) public pure returns (bool) {
        return patient.onlyMedicareDueToESRD && patient.successfulKidneyTransplant;
    }
    
    function benefitOffered(Patient memory patient) public pure returns (bool) {
        return patient.losePartACoverageAfter36Months && patient.notHaveCertainHealthCoverage;
    }
    
    function benefitCoversOnlyImmunosuppressiveDrugs(Patient memory patient) public pure returns (bool) {
        return patient.benefitOffered;
    }
    
    function qualifyForBenefit(Patient memory patient) public pure returns (bool) {
        return patient.benefitOffered;
    }
    
    function monthlyPremiumIn2023() public pure returns (uint) {
        return 9710; // $97.10 in cents
    }
    
    function deductible() public pure returns (uint) {
        return 226;
    }
    
    function pay20PercentAfterDeductibleMet(Patient memory patient) public pure returns (bool) {
        return patient.deductibleMet;
    }
}