pragma solidity ^0.8.0;

contract ImmunosuppressiveDrugBenefit {
    address private owner;
    uint256 private deductible;
    uint256 private copay;

    constructor(address _owner, uint256 _deductible, uint256 _copay) public {
        owner = _owner;
        deductible = _deductible;
        copay = _copay;
    }

    function hasPartA() public view returns (bool) {
        return owner.hasPartA();
    }

    function hasPartB() public view returns (bool) {
        return owner.hasPartB();
    }

    function hasImmunosuppressiveDrugCoverage() public view returns (bool) {
        return hasPartA() && hasPartB();
    }

    function getDeductible() public view returns (uint256) {
        return deductible;
    }

    function getCopay() public view returns (uint256) {
        return copay;
    }
}