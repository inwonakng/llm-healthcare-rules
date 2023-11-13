pragma solidity ^0.8.0;

contract InsuranceContract {
    struct Policy {
        string diagnosis;
        bool isIVIGCovered;
        bool isInHome;
        bool isCostCovered;
        bool isOtherServicesCovered;
    }

    Policy public policy;

    constructor() {
        policy = Policy("", false, false, false, false);
    }

    function setPolicy(string memory _diagnosis, bool _isIVIGCovered, bool _isInHome, bool _isCostCovered, bool _isOtherServicesCovered) public {
        policy = Policy(_diagnosis, _isIVIGCovered, _isInHome, _isCostCovered, _isOtherServicesCovered);
    }

    function isIVIGCovered(string memory _diagnosis) public view returns (bool) {
        return (keccak256(bytes(_diagnosis)) == keccak256(bytes(policy.diagnosis)) && policy.isIVIGCovered);
    }

    function isIVIGInHome(string memory _diagnosis) public view returns (bool) {
        return (keccak256(bytes(_diagnosis)) == keccak256(bytes(policy.diagnosis)) && policy.isInHome);
    }

    function isIVIGCostCovered() public view returns (bool) {
        return policy.isCostCovered;
    }

    function isOtherServicesCovered() public view returns (bool) {
        return policy.isOtherServicesCovered;
    }
}