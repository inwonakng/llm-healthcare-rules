pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Policy {
        string label;
    }
    
    struct Condition {
        string label;
        string description;
    }
    
    struct Decision {
        string label;
        string description;
    }
    
    Policy public policy;
    Condition[] public conditions;
    Decision[] public decisions;
    
    constructor(string memory _policyLabel) {
        policy = Policy(_policyLabel);
    }
    
    function addCondition(string memory _label, string memory _description) external {
        conditions.push(Condition(_label, _description));
    }
    
    function addDecision(string memory _label, string memory _description) external {
        decisions.push(Decision(_label, _description));
    }
    
    function checkEligibility() external view returns (bool) {
        bool condition1Met = false;
        bool condition2Met = false;
        
        for (uint i = 0; i < conditions.length; i++) {
            if (keccak256(bytes(conditions[i].label)) == keccak256(bytes("Condition 1"))) {
                condition1Met = true;
            }
            if (keccak256(bytes(conditions[i].label)) == keccak256(bytes("Condition 2"))) {
                condition2Met = true;
            }
        }
        
        if (condition1Met && condition2Met) {
            return true;
        } else {
            return false;
        }
    }
}