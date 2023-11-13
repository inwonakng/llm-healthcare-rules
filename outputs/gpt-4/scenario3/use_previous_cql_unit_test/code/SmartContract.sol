// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicareInsurancePolicy {
    struct PolicyHolder {
        bool hasPartA;
        bool hasPartB;
        bool hasPartD;
        bool hasOriginalMedicare;
        bool hasESRD;
        bool hasOtherHealthCoverage;
        bool hasTransplant;
        bool hasImmunosuppressiveDrugs;
        uint256 transplantTime;
        uint256 partAEndTime;
        uint256 monthlyPremium;
        uint256 deductible;
        uint256 deductibleMet;
    }

    mapping(address => PolicyHolder) public policyHolders;

    function isTransplantDrugTherapyCovered(address _policyHolder) public view returns (bool) {
        return policyHolders[_policyHolder].hasTransplant && policyHolders[_policyHolder].hasImmunosuppressiveDrugs;
    }

    function hasPartAAtTimeOfTransplant(address _policyHolder) public view returns (bool) {
        return policyHolders[_policyHolder].hasPartA && policyHolders[_policyHolder].transplantTime <= block.timestamp;
    }

    function hasPartBAtTimeOfImmunosuppressiveDrugs(address _policyHolder) public view returns (bool) {
        return policyHolders[_policyHolder].hasPartB && policyHolders[_policyHolder].hasImmunosuppressiveDrugs;
    }

    function isPartDCoveringImmunosuppressiveDrugs(address _policyHolder) public view returns (bool) {
        return !policyHolders[_policyHolder].hasPartB && policyHolders[_policyHolder].hasPartD && policyHolders[_policyHolder].hasImmunosuppressiveDrugs;
    }

    function canJoinMedicareDrugPlan(address _policyHolder) public view returns (bool) {
        return policyHolders[_policyHolder].hasOriginalMedicare;
    }

    function isMedicareCoverageEnded(address _policyHolder) public view returns (bool) {
        return policyHolders[_policyHolder].hasESRD && (block.timestamp - policyHolders[_policyHolder].transplantTime) >= 36 months;
    }

    function isBenefitOffered(address _policyHolder) public view returns (bool) {
        return (block.timestamp - policyHolders[_policyHolder].partAEndTime) >= 36 months && !policyHolders[_policyHolder].hasOtherHealthCoverage;
    }

    function isBenefitCoveringOnlyImmunosuppressiveDrugs(address _policyHolder) public view returns (bool) {
        return policyHolders[_policyHolder].hasImmunosuppressiveDrugs;
    }

    function isBenefitSubstituteForFullHealthCoverage(address _policyHolder) public view returns (bool) {
        return !policyHolders[_policyHolder].hasPartA && !policyHolders[_policyHolder].hasPartB && !policyHolders[_policyHolder].hasPartD;
    }

    function canSignUpAfterPartAEnds(address _policyHolder) public view returns (bool) {
        return block.timestamp > policyHolders[_policyHolder].partAEndTime;
    }

    function getMonthlyPremium(address _policyHolder) public view returns (uint256) {
        return policyHolders[_policyHolder].monthlyPremium;
    }

    function getDeductible(address _policyHolder) public view returns (uint256) {
        return policyHolders[_policyHolder].deductible;
    }

    function getMedicareApprovedAmount(address _policyHolder, uint256 _amount) public view returns (uint256) {
        if (policyHolders[_policyHolder].deductibleMet) {
            return (_amount * 20) / 100;
        } else {
            return 0;
        }
    }
}