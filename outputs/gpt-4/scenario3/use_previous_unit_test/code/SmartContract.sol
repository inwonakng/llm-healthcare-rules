// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicareContract {
    struct Patient {
        bool hasPartA;
        bool hasPartB;
        bool hasPartD;
        bool hasESRD;
        bool hasOtherHealthCoverage;
        uint monthsAfterKidneyTransplant;
    }

    mapping(address => Patient) public patients;

    function checkTransplantCoverage(bool medicarePaidForTransplant, bool hasPartA) public view returns(bool) {
        return medicarePaidForTransplant && hasPartA;
    }

    function checkImmunosuppressiveDrugCoverage(bool hasPartB, bool hasPartD, bool partBCovers) public view returns(bool) {
        return (hasPartB && partBCovers) || (hasPartD && !partBCovers);
    }

    function checkCoverageEndAfterKidneyTransplant(bool hasESRD, uint monthsAfterKidneyTransplant) public view returns(bool) {
        return !(hasESRD && monthsAfterKidneyTransplant > 36);
    }

    function checkBenefitAfterPartACoverageEnds(bool hasPartA, uint monthsAfterKidneyTransplant, bool hasOtherHealthCoverage) public view returns(bool) {
        return !hasPartA && monthsAfterKidneyTransplant > 36 && !hasOtherHealthCoverage;
    }

    function checkBenefitCoverage() public pure returns(bool) {
        return true;
    }

    function checkSignupAfterPartACoverageEnds(bool hasPartA) public view returns(bool) {
        return !hasPartA;
    }

    function checkMonthlyPremiumAndDeductible(uint year) public pure returns(uint, uint) {
        if(year == 2023) {
            return (97.10 ether, 226 ether);
        } else {
            return (0, 0);
        }
    }

    function checkPaymentAfterDeductible(uint medicareApprovedAmount) public pure returns(uint) {
        return medicareApprovedAmount * 20 / 100;
    }
}