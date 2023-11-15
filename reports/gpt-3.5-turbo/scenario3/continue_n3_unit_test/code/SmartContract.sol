pragma solidity ^0.8.0;

contract InsuranceContract {
    struct Policy {
        bool hasPartA;
        bool hasPartB;
        bool hasOriginalMedicare;
        bool hasESRD;
        bool hasLossOfCoverage;
        bool qualifiesForBenefit;
    }

    Policy public policy;

    constructor() {
        policy = Policy(false, false, false, false, false, false);
    }

    function setPartA(bool value) external {
        policy.hasPartA = value;
    }

    function setPartB(bool value) external {
        policy.hasPartB = value;
    }

    function setOriginalMedicare(bool value) external {
        policy.hasOriginalMedicare = value;
    }

    function setESRD(bool value) external {
        policy.hasESRD = value;
    }

    function setLossOfCoverage(bool value) external {
        policy.hasLossOfCoverage = value;
    }

    function setQualifiesForBenefit(bool value) external {
        policy.qualifiesForBenefit = value;
    }

    function coverTransplantDrugTherapy() public view returns (bool) {
        return policy.hasPartA;
    }

    function coverImmunosuppressiveDrugs() public view returns (bool) {
        return policy.hasPartB || policy.hasOriginalMedicare;
    }

    function joinDrugPlan() public view returns (bool) {
        return policy.hasOriginalMedicare;
    }

    function benefitCoverage() public view returns (bool) {
        return policy.hasESRD && policy.hasLossOfCoverage;
    }

    function benefitOnlyDrugs() public view returns (bool) {
        return policy.qualifiesForBenefit;
    }

    function benefitNotSubstitute() public view returns (bool) {
        return policy.qualifiesForBenefit;
    }

    function signUpBenefit() public view returns (bool) {
        return policy.qualifiesForBenefit;
    }

    function callSocialSecurity() public view returns (bool) {
        return policy.qualifiesForBenefit;
    }

    function getPremium() public pure returns (uint256) {
        return 9710;
    }

    function getDeductible() public pure returns