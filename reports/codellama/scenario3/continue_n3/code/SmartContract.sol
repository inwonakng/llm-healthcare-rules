pragma solidity ^0.8.0;

contract ImmunosuppressiveDrugBenefit {
    address public owner;
    uint public deductible;
    uint public premium;
    uint public coverageStart;
    uint public coverageEnd;

    constructor(address _owner, uint _deductible, uint _premium, uint _coverageStart, uint _coverageEnd) public {
        owner = _owner;
        deductible = _deductible;
        premium = _premium;
        coverageStart = _coverageStart;
        coverageEnd = _coverageEnd;
    }

    function isCovered(uint _amount) public view returns (bool) {
        if (block.timestamp < coverageStart) {
            return false;
        }
        if (block.timestamp > coverageEnd) {
            return false;
        }
        if (_amount < deductible) {
            return false;
        }
        return true;
    }

    function getPremium() public view returns (uint) {
        return premium;
    }

    function getDeductible() public view returns (uint) {
        return deductible;
    }

    function getCoverageStart() public view returns (uint) {
        return coverageStart;
    }

    function getCoverageEnd() public view returns (uint) {
        return coverageEnd;
    }
}