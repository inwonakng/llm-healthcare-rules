pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract InsurancePolicy {
    // define the policy details
    address public policyHolder;
    uint public policyNumber;
    string public policyType;
    uint public premium;
    uint public coverageAmount;
    uint public deductible;
    uint public coinsurance;
    uint public copay;

    // define the policy conditions
    modifier onlyPolicyHolder() {
        require(msg.sender == policyHolder, "Only the policy holder can call this function");
        _;
    }

    // define the policy functions
    function setPolicyDetails(address _policyHolder, uint _policyNumber, string memory _policyType, uint _premium, uint _coverageAmount, uint _deductible, uint _coinsurance, uint _copay) public onlyPolicyHolder {
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

contract InsurancePolicyTest {
    InsurancePolicy policy;

    function beforeAll() public {
        policy = new InsurancePolicy();
    }

    function testSetPolicyDetails() public {
        policy.setPolicyDetails(address(this), 123456789, "Health Insurance", 1000000000000000000, 1000000000000000000, 1000000000000000000, 1000000000000000000, 1000000000000000000);
        assertEq(policy.getPolicyDetails(), (address(this), 123456789, "Health Insurance", 1000000000000000000, 1000000000000000000, 1000000000000000000, 1000000000000000000, 1000000000000000000));
    }

    function testGetPolicyDetails() public {
        policy.setPolicyDetails(address(this), 123456789, "Health Insurance", 1000000000000000000, 1000000000000000000, 1000000000000000000, 1000000000000000000, 1000000000000000000);
        assertEq(policy.getPolicyDetails(), (address(this), 123456789, "Health Insurance", 1000000000000000000, 1000000000000000000, 1000000000000000000, 1000000000000000000, 1000000000000000000));
    }

    function testGetCoverageAmount() public {
        policy.setPolicyDetails(address(this), 123456789, "Health Insurance", 1000000000000000000, 1000000000000000000, 1000000000000000000, 1000000000000000000, 1000000000000000000);
        assertEq(policy.getCoverageAmount(), 1000000000000000000);
    }

    function testGetDeductible() public {
        policy.setPolicyDetails(address(this), 123456789, "Health Insurance", 1000000000000000000, 1000000000000000000, 1000000000000000000, 1000000000000000000, 1000000000000000000);
        assertEq(policy.getDeductible(), 1000000000000000000);
    }

    function testGetCoinsurance() public {
        policy.setPolicyDetails(address(this), 123456789, "Health Insurance", 1000000000000000000, 1000000000000000000, 1000000000000000000, 1000000000000000000, 1000000000000000000);
        assertEq(policy.getCoinsurance(), 1000000000000000000);
    }

    function testGetCopay() public {
        policy.setPolicyDetails(address(this), 123456789, "Health Insurance", 1000000000000000000, 1000000000000000000, 1000000000000000000, 1000000000000000000, 1000000000000000000);
        assertEq(policy.getCopay(), 1000000000000000000);
    }
}