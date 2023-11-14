pragma solidity ^0.8.0;

contract InsurancePolicy {
    address public policyHolder;
    uint public policyNumber;
    string public policyType;
    uint public premium;
    uint public coverageAmount;
    uint public deductible;
    uint public coinsurance;
    uint public copay;

    constructor(address _policyHolder, uint _policyNumber, string memory _policyType, uint _premium, uint _coverageAmount, uint _deductible, uint _coinsurance, uint _copay) public {
        policyHolder = _policyHolder;
        policyNumber = _policyNumber;
        policyType = _policyType;
        premium = _premium;
        coverageAmount = _coverageAmount;
        deductible = _deductible;
        coinsurance = _coinsurance;
        copay = _copay;
    }

    function getPolicyDetails() public view returns (address, uint, string memory, uint, uint, uint, uint, uint) {
        return (policyHolder, policyNumber, policyType, premium, coverageAmount, deductible, coinsurance, copay);
    }

    function getCoverageAmount() public view returns (uint) {
        return coverageAmount;
    }

    function getDeductible() public view returns (uint) {
        return deductible;
    }

    function getCoinsurance() public view returns (uint) {
        return coinsurance;
    }

    function getCopay() public view returns (uint) {
        return copay;
    }
}