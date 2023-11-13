// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicareInsurancePolicy {
    struct PolicyHolder {
        bool hasPartA;
        bool hasPartB;
        bool hasPartD;
        bool hasOriginalMedicare;
        bool hasESRD;
        uint256 transplantDate;
        bool isEligibleForSpecialBenefit;
        uint256 deductiblePaid;
        uint256 medicareApprovedAmount;
    }

    uint256 constant MONTHS_AFTER_TRANSPLANT = 36;
    uint256 constant DAYS_IN_MONTH = 30; // Approximation
    uint256 constant MONTHLY_PREMIUM_2023 = 97.10 ether;
    uint256 constant DEDUCTIBLE_2023 = 226 ether;
    uint256 constant COINSURANCE_RATE = 20;

    // Check if Medicare contributed to the payment for the organ transplant
    function isTransplantDrugCovered(bool hasPartA) public pure returns (bool) {
        return hasPartA;
    }

    // Check if the individual has Part B when receiving immunosuppressive drugs
    function isPartBCoverageApplicable(bool hasPartB) public pure returns (bool) {
        return hasPartB;
    }

    // Check if Part D covers immunosuppressive drugs when Part B does not
    function isPartDCoverageApplicable(bool hasPartB, bool hasPartD) public pure returns (bool) {
        return !hasPartB && hasPartD;
    }

    // Check if individuals with Original Medicare can join a drug plan
    function canJoinMedicareDrugPlan(bool hasOriginalMedicare) public pure returns (bool) {
        return hasOriginalMedicare;
    }

    // Check if Medicare coverage ends 36 months after a successful kidney transplant for ESRD patients
    function hasMedicareCoverageEnded(bool hasESRD, uint256 transplantDate) public view returns (bool) {
        return hasESRD && (block.timestamp - transplantDate > MONTHS_AFTER_TRANSPLANT * DAYS_IN_MONTH * 1 days);
    }

    // Check for eligibility for the specific benefit after 36 months post-kidney transplant
    function isEligibleForSpecialBenefit(bool isEligibleForSpecialBenefit, bool hasPartA) public pure returns (bool) {
        return isEligibleForSpecialBenefit && !hasPartA;
    }

    // Get the monthly premium and deductible for the immunosuppressive drug benefit
    function getBenefitCosts() public pure returns (uint256 premium, uint256 deductible) {
        return (MONTHLY_PREMIUM_2023, DEDUCTIBLE_2023);
    }

    // Calculate the 20% coinsurance after meeting the deductible
    function calculatePaymentAfterDeductible(uint256 deductiblePaid, uint256 medicareApprovedAmount) public pure returns (uint256) {
        if (deductiblePaid >= DEDUCTIBLE_2023) {
            return (medicareApprovedAmount * COINSURANCE_RATE) / 100;
        } else {
            return 0;
        }
    }

    // Final coverage decision that combines all the necessary conditions
    function finalCoverageDecision(PolicyHolder memory holder) public view returns (bool) {
        bool medicareContributionForTransplant = isTransplantDrugCovered(holder.hasPartA);
        bool coverageByPartB = isPartBCoverageApplicable(holder.hasPartB);
        bool coverageByPartD = isPartDCoverageApplicable(holder.hasPartB, holder.hasPartD);
        bool esrdCoverageEndsPostTransplant = hasMedicareCoverageEnded(holder.hasESRD, holder.transplantDate);
        bool specificBenefitForPost36Months = isEligibleForSpecialBenefit(holder.isEligibleForSpecialBenefit, holder.hasPartA);

        return medicareContributionForTransplant &&
               (coverageByPartB || coverageByPartD) &&
               (!esrdCoverageEndsPostTransplant || specificBenefitForPost36Months);
    }
}