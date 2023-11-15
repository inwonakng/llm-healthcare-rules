// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicareInsurancePolicy {
    
    struct TransplantCoverage {
        bool coversTransplantDrugTherapy;
        bool hasPartAAtTimeOfTransplant;
        bool hasPartBAtTimeOfImmunosuppressiveDrugs;
        bool partDCoversImmunosuppressiveDrugs;
        bool joinMedicareDrugPlan;
        bool coverageEndsAfter36MonthsPostTransplant;
        bool MedicareBenefitCoversImmunosuppressiveDrugsOnly;
        bool benefitNotSubstituteForFullCoverage;
        uint monthlyPremium2023;
        uint deductible2023;
        bool pay20PercentAfterDeductibleMet;
    }
    
    TransplantCoverage public policy;
    
    constructor() {
        policy = TransplantCoverage({
            coversTransplantDrugTherapy: true,
            hasPartAAtTimeOfTransplant: true,
            hasPartBAtTimeOfImmunosuppressiveDrugs: true,
            partDCoversImmunosuppressiveDrugs: true,
            joinMedicareDrugPlan: true,
            coverageEndsAfter36MonthsPostTransplant: true,
            MedicareBenefitCoversImmunosuppressiveDrugsOnly: true,
            benefitNotSubstituteForFullCoverage: true,
            monthlyPremium2023: 9710,
            deductible2023: 226,
            pay20PercentAfterDeductibleMet: true
        });
    }
    
    function checkTransplantCoverage() public view returns (TransplantCoverage memory) {
        return policy;
    }
}