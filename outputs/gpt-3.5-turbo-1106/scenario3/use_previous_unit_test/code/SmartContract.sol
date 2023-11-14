// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicareInsurance {
    struct Patient {
        bool hasPartA;
        bool hasPartB;
        bool hasTransplantCoverage;
        bool hasESRD;
    }

    struct DrugBenefit {
        uint256 monthlyPremium;
        uint256 deductible;
    }

    function isTransplantDrugTherapyCovered(bool helpedPayForTransplant) public pure returns (bool) {
        return helpedPayForTransplant;
    }

    function hasPartAAtTransplant(bool hasPartA) public pure returns (bool) {
        return hasPartA;
    }

    function hasPartBAtImmunosuppressiveDrugs(bool hasPartB) public pure returns (bool) {
        return hasPartB;
    }

    function isMedicareDrugCoverage(bool partDCovers, bool partBCovers) public pure returns (bool) {
        return partDCovers || !partBCovers;
    }

    function canJoinMedicareDrugPlan(bool hasOriginalMedicare) public pure returns (bool) {
        return hasOriginalMedicare;
    }

    function doesMedicareCoverageEnd(bool hasESRD, bool successfulTransplant) public pure returns (bool) {
        return hasESRD && successfulTransplant;
    }

    function doesMedicareOfferBenefit(bool losesPartA, bool hasOtherHealthCoverage) public pure returns (bool) {
        return losesPartA && !hasOtherHealthCoverage;
    }

    function getPremiumAndDeductible(uint16 year) public pure returns (uint256, uint256) {
        if (year == 2023) {
            return (9710, 226);
        }
        return (0, 0);
    }

    function calculatePaymentAfterDeductible(uint256 totalCost) public pure returns (uint256) {
        uint256 deductible = 226;
        if (totalCost > deductible) {
            return (totalCost - deductible) * 20 / 100;
        }
        return 0;
    }
}