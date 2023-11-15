// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicareInsurance {
    
    struct TransplantBenefit {
        bool partAAtTransplant;
        bool partBAtDrugTime;
        bool partDForDrugs;
        bool originalMedicare;
        bool esrdMedicare;
        bool lostPartAAfter36Months;
        bool certainHealthCoverage;
    }
    
    struct DrugCost {
        uint monthlyPremium;
        uint deductible;
        uint coinsurancePercentage;
    }
    
    mapping(address => TransplantBenefit) public beneficiaries;
    mapping(address => DrugCost) public drugCosts;
    
    function enrollTransplantBenefit(bool _partAAtTransplant, bool _partBAtDrugTime, bool _partDForDrugs, bool _originalMedicare, bool _esrdMedicare, bool _lostPartAAfter36Months, bool _certainHealthCoverage) external {
        beneficiaries[msg.sender] = TransplantBenefit(_partAAtTransplant, _partBAtDrugTime, _partDForDrugs, _originalMedicare, _esrdMedicare, _lostPartAAfter36Months, _certainHealthCoverage);
    }
    
    function setDrugCost(uint _monthlyPremium, uint _deductible, uint _coinsurancePercentage) external {
        drugCosts[msg.sender] = DrugCost(_monthlyPremium, _deductible, _coinsurancePercentage);
    }
    
    function calculateDrugCost(address _beneficiary, uint _drugCost) external view returns (uint) {
        require(beneficiaries[_beneficiary].partAAtTransplant, "Must have Part A at the time of the covered transplant");
        require(beneficiaries[_beneficiary].partBAtDrugTime, "Must have Part B at the time of getting immunosuppressive drugs");
        
        if (!beneficiaries[_beneficiary].partDForDrugs) {
            require(beneficiaries[_beneficiary].originalMedicare, "Must have Original Medicare to join a Medicare drug plan");
        }
        
        if (beneficiaries[_beneficiary].esrdMedicare) {
            // Check if 36 months have passed after successful kidney transplant
            // Logic to handle coverage ending after 36 months
        }
        
        if (beneficiaries[_beneficiary].lostPartAAfter36Months && !beneficiaries[_beneficiary].certainHealthCoverage) {
            // Logic to handle coverage after losing Part A
        }
        
        uint coinsuranceAmount = (_drugCost * drugCosts[_beneficiary].coinsurancePercentage) / 100;
        if (coinsuranceAmount < drugCosts[_beneficiary].deductible) {
            return drugCosts[_beneficiary].deductible;
        } else {
            return coinsuranceAmount;
        }
    }
}