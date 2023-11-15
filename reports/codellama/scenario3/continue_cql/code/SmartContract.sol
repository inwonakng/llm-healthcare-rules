pragma solidity ^0.8.0;

contract ImmunosuppressiveDrugBenefit {
    address public owner;
    uint public premium;
    uint public deductible;
    uint public copay;
    uint public maximumOutOfPocket;

    constructor(address _owner, uint _premium, uint _deductible, uint _copay, uint _maximumOutOfPocket) public {
        owner = _owner;
        premium = _premium;
        deductible = _deductible;
        copay = _copay;
        maximumOutOfPocket = _maximumOutOfPocket;
    }

    function isEligibleForBenefit(address patient) public view returns (bool) {
        return patient.hasCondition('Transplant') && patient.hasCoverage('Part A') && patient.hasCoverage('Part B') && !patient.hasCoverage('Medicare Drug') && !patient.hasCoverage('Other Health');
    }

    function getBenefitPremium() public view returns (uint) {
        return premium;
    }

    function getBenefitDeductible() public view returns (uint) {
        return deductible;
    }

    function getBenefitCopay() public view returns (uint) {
        return copay;
    }

    function getBenefitMaximumOutOfPocket() public view returns (uint) {
        return maximumOutOfPocket;
    }
}