pragma solidity ^0.8.0;

contract MedicareImmunosuppressiveDrugBenefit {
    struct Policyholder {
        address policyholder;
        bool hasPartACoverage;
        bool hasPartBCoverage;
        bool hasMedicareDrugCoverage;
        bool hasESRDCoverageEnded;
        bool isEligibleForBenefit;
        bool canSignUpForBenefit;
        bool hasPaidPremiumAndDeductible;
        bool hasImmunosuppressiveDrugCoverageOnly;
        bool isNotFullHealthCoverage;
        bool hasMetDeductible;
        bool hasPaidCopay;
    }

    mapping(address => Policyholder) policyholders;

    function hasPartACoverage(address policyholder) public view returns (bool) {
        return policyholders[policyholder].hasPartACoverage;
    }

    function hasPartBCoverage(address policyholder) public view returns (bool) {
        return policyholders[policyholder].hasPartBCoverage;
    }

    function hasMedicareDrugCoverage(address policyholder) public view returns (bool) {
        return policyholders[policyholder].hasMedicareDrugCoverage;
    }

    function hasESRDCoverageEnded(address policyholder) public view returns (bool) {
        return policyholders[policyholder].hasESRDCoverageEnded;
    }

    function isEligibleForBenefit(address policyholder) public view returns (bool) {
        return policyholders[policyholder].isEligibleForBenefit;
    }

    function canSignUpForBenefit(address policyholder) public view returns (bool) {
        return policyholders[policyholder].canSignUpForBenefit;
    }

    function hasPaidPremiumAndDeductible(address policyholder) public view returns (bool) {
        return policyholders[policyholder].hasPaidPremiumAndDeductible;
    }

    function hasImmunosuppressiveDrugCoverageOnly(address policyholder) public view returns (bool) {
        return policyholders[policyholder].hasImmunosuppressiveDrugCoverageOnly;
    }

    function isNotFullHealthCoverage(address policyholder) public view returns (bool) {
        return policyholders[policyholder].isNotFullHealthCoverage;
    }

    function hasMetDeductible(address policyholder) public view returns (bool) {
        return policyholders[policyholder].hasMetDeductible;
    }

    function hasPaidCopay(address policyholder) public view returns (bool) {
        return policyholders[policyholder].hasPaidCopay;
    }
}