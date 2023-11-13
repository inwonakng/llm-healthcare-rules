// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicareContract {
    struct Patient {
        bool hasMedicare;
        bool hasPartA;
        bool hasPartB;
        bool hasPartD;
        bool hasOriginalMedicare;
        bool hasESRD;
        bool hasTransplant;
        bool hasImmunosuppressiveDrugs;
        uint monthsAfterTransplant;
        bool hasOtherHealthCoverage;
        uint year;
        uint approvedAmount;
        bool deductibleMet;
    }

    function checkTransplantCoverage(bool hasMedicare, bool hasPartA) public pure returns (bool) {
        return hasMedicare && hasPartA;
    }

    function checkImmunosuppressiveDrugCoverage(bool hasPartB, bool hasPartD) public pure returns (bool) {
        return !hasPartB && hasPartD;
    }

    function checkMedicarePlanEnrollment(bool hasOriginalMedicare) public pure returns (bool) {
        return hasOriginalMedicare;
    }

    function checkCoverageEndAfterKidneyTransplant(bool hasESRD, uint monthsAfterTransplant) public pure returns (bool) {
        return hasESRD && monthsAfterTransplant > 36;
    }

    function checkBenefitAfterPartACoverageEnds(bool hasPartA, uint monthsAfterTransplant, bool hasOtherHealthCoverage) public pure returns (bool) {
        return !hasPartA && monthsAfterTransplant > 36 && !hasOtherHealthCoverage;
    }

    function checkBenefitCoverage(string memory item) public pure returns (bool) {
        return keccak256(bytes(item)) == keccak256(bytes("Immunosuppressive drugs"));
    }

    function checkBenefitSignupAfterPartAEnds(bool hasPartA) public pure returns (bool) {
        return !hasPartA;
    }

    function checkMonthlyPremiumAndDeductible(uint year) public pure returns (uint, uint) {
        if (year == 2023) {
            return (9710, 22600); // values in wei
        } else {
            return (0, 0);
        }
    }

    function checkPaymentAfterDeductible(uint approvedAmount, bool deductibleMet) public pure returns (uint) {
        if (deductibleMet) {
            return approvedAmount / 5; // 20% of the approved amount
        } else {
            return 0;
        }
    }
}