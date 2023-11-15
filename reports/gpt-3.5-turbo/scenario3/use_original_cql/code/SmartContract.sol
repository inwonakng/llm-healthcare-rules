pragma solidity ^0.8.0;

contract MedicareInsurance {
    struct TransplantCoverage {
        bool hasPartA;
        bool hasPartB;
        bool hasPartD;
        bool hasMedicareDueToESRD;
        bool hasOtherHealthCoverage;
        bool hasLostPartACoverage;
        bool hasSignedUpForBenefit;
    }
    
    function getImmunosuppressiveDrugCoverage(TransplantCoverage memory coverage) public pure returns (string memory) {
        if (!coverage.hasPartA) {
            return "You must have Part A at the time of the covered transplant.";
        }
        
        if (!coverage.hasPartB) {
            return "You must have Part B at the time you get immunosuppressive drugs.";
        }
        
        if (!coverage.hasPartD && !coverage.hasMedicareDueToESRD) {
            return "Medicare drug coverage (Part D) covers immunosuppressive drugs if Part B doesn’t cover them.";
        }
        
        if (coverage.hasMedicareDueToESRD) {
            return "Your Medicare coverage, including immunosuppressive drug coverage, ends 36 months after a successful kidney transplant.";
        }
        
        if (coverage.hasLostPartACoverage && !coverage.hasOtherHealthCoverage) {
            return "Medicare offers a benefit that may help you, if you lose Part A coverage 36 months after a kidney transplant, and you don’t have certain types of other health coverage.";
        }
        
        if (coverage.hasSignedUpForBenefit) {
            return "You have signed up for the immunosuppressive drug benefit.";
        }
        
        return "You are eligible for immunosuppressive drug coverage.";
    }
    
    function calculateMonthlyPremium(uint256 year) public pure returns (uint256) {
        if (year == 2023) {
            return 9710;
        }
        
        return 0;
    }
    
    function calculateDeductible(uint256 year) public pure returns (uint256) {
        if (year == 2023) {
            return 226;
        }
        
        return 0;
    }
    
    function calculateDrugPayment(uint256 deductible, uint256 approvedAmount) public pure returns (uint256) {
        if (approvedAmount <= deductible) {
            return 0;
        }
        
        return (approvedAmount - deductible) * 20 / 100;
    }
}