// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicareTransplantDrugCoverage {
    // Define a struct to encapsulate patient parameters for cleaner code
    struct Patient {
        bool coveredTransplant;
        bool hasPartA;
        bool hasPartB;
        bool hasPartD;
        bool hasOriginalMedicare;
        bool hasDrugPlan;
        bool hasESRDCoverage;
        uint transplantDate;
        bool hasGroupHealthPlan;
        bool hasTRICARE;
        bool hasMedicaid;
    }

    // Define constants for premiums and deductibles
    uint constant public monthlyPremium2023 = 97.10 ether; // Monthly premium for the immunosuppressive drug benefit
    uint constant public annualDeductible2023 = 226 ether; // Annual deductible for the immunosuppressive drug benefit
    uint constant public coinsuranceRate = 20; // Coinsurance rate after meeting the deductible (20%)

    // Check if a patient is eligible for transplant drug therapy
    function isEligibleForTransplantDrugTherapy(bool coveredTransplant, bool hasPartA, bool hasPartB) public pure returns (bool) {
        return coveredTransplant && hasPartA && hasPartB;
    }

    // Check if a patient is covered by Part D when Part B doesn't cover
    function isCoveredByPartD(bool hasPartB, bool hasPartD) public pure returns (bool) {
        return !hasPartB && hasPartD;
    }

    // Check if a patient with Original Medicare can join a drug plan
    function hasOriginalMedicareAndDrugPlan(bool hasOriginalMedicare, bool hasDrugPlan) public pure returns (bool) {
        return hasOriginalMedicare && hasDrugPlan;
    }

    // Check if ESRD coverage ends after 36 months post successful kidney transplant
    function hasESRDCoverageEndsPost36Months(bool hasESRDCoverage, uint transplantDate) public view returns (bool) {
        return hasESRDCoverage && (block.timestamp - transplantDate > 36 * 30 days);
    }

    // Check if a patient is eligible for the immunosuppressive drug benefit
    function isEligibleForImmunosuppressiveDrugBenefit(uint transplantDate, bool hasGroupHealthPlan, bool hasTRICARE, bool hasMedicaid) public view returns (bool) {
        return (block.timestamp - transplantDate > 36 * 30 days) && !(hasGroupHealthPlan || hasTRICARE || hasMedicaid);
    }

    // Check the final decision for a patient's coverage
    function finalDecision(Patient memory patient) public view returns (bool) {
        bool eligibleForTransplantDrugTherapy = isEligibleForTransplantDrugTherapy(patient.coveredTransplant, patient.hasPartA, patient.hasPartB);
        bool coveredByPartD = isCoveredByPartD(patient.hasPartB, patient.hasPartD);
        bool originalMedicareAndDrugPlan = hasOriginalMedicareAndDrugPlan(patient.hasOriginalMedicare, patient.hasDrugPlan);
        bool esrdCoverageEnds = hasESRDCoverageEndsPost36Months(patient.hasESRDCoverage, patient.transplantDate);
        bool eligibleForImmunosuppressiveBenefit = isEligibleForImmunosuppressiveDrugBenefit(patient.transplantDate, patient.hasGroupHealthPlan, patient.hasTRICARE, patient.hasMedicaid);

        return eligibleForTransplantDrugTherapy || coveredByPartD || originalMedicareAndDrugPlan || (esrdCoverageEnds && eligibleForImmunosuppressiveBenefit);
    }
}