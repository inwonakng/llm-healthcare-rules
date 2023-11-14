// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicareInsurance {
    
    struct TransplantBeneficiary {
        bool hasPartA;
        bool hasPartB;
        bool hasPartD;
        bool hasOriginalMedicare;
        bool hasESRD;
        bool hasLostPartAAfterTransplant;
        bool hasOtherHealthCoverage;
        bool hasSignedUpForBenefit;
        bool hasMetDeductible;
    }
    
    uint256 public monthlyPremium = 9710; // $97.10 in cents
    uint256 public deductible = 22600; // $226 in cents
    uint256 public coinsurancePercentage = 20; // 20%
    
    mapping(address => TransplantBeneficiary) public beneficiaries;
    
    function enrollInPartA(address beneficiary) external {
        beneficiaries[beneficiary].hasPartA = true;
    }
    
    function enrollInPartB(address beneficiary) external {
        beneficiaries[beneficiary].hasPartB = true;
    }
    
    function enrollInPartD(address beneficiary) external {
        beneficiaries[beneficiary].hasPartD = true;
    }
    
    function joinMedicareDrugPlan(address beneficiary) external {
        beneficiaries[beneficiary].hasOriginalMedicare = true;
    }
    
    function reportESRD(address beneficiary) external {
        beneficiaries[beneficiary].hasESRD = true;
    }
    
    function losePartAAfterTransplant(address beneficiary) external {
        beneficiaries[beneficiary].hasLostPartAAfterTransplant = true;
    }
    
    function haveOtherHealthCoverage(address beneficiary) external {
        beneficiaries[beneficiary].hasOtherHealthCoverage = true;
    }
    
    function signUpForBenefit(address beneficiary) external {
        beneficiaries[beneficiary].hasSignedUpForBenefit = true;
    }
    
    function reportDeductibleMet(address beneficiary) external {
        beneficiaries[beneficiary].hasMetDeductible = true;
    }
    
    function getMonthlyPremium() external view returns (uint256) {
        return monthlyPremium;
    }
    
    function getDeductible() external view returns (uint256) {
        return deductible;
    }
    
    function getCoinsurancePercentage() external view returns (uint256) {
        return coinsurancePercentage;
    }
    
    function calculateCoinsuranceAmount(uint256 drugCost) external view returns (uint256) {
        return (drugCost * coinsurancePercentage) / 100;
    }
}