pragma solidity ^0.8.0;

contract ImmunosuppressiveDrugBenefit {
    address private owner;
    mapping(address => bool) private eligiblePatients;
    mapping(address => uint256) private premiums;
    mapping(address => uint256) private deductibles;
    mapping(address => uint256) private copays;
    mapping(address => uint256) private maximumOutOfPockets;

    constructor() public {
        owner = msg.sender;
    }

    function setEligiblePatients(address[] memory patients) public {
        require(msg.sender == owner, "Only the owner can set eligible patients");
        for (uint256 i = 0; i < patients.length; i++) {
            eligiblePatients[patients[i]] = true;
        }
    }

    function setPremiums(address[] memory patients, uint256[] memory premiums) public {
        require(msg.sender == owner, "Only the owner can set premiums");
        for (uint256 i = 0; i < patients.length; i++) {
            premiums[patients[i]] = premiums[i];
        }
    }

    function setDeductibles(address[] memory patients, uint256[] memory deductibles) public {
        require(msg.sender == owner, "Only the owner can set deductibles");
        for (uint256 i = 0; i < patients.length; i++) {
            deductibles[patients[i]] = deductibles[i];
        }
    }

    function setCopays(address[] memory patients, uint256[] memory copays) public {
        require(msg.sender == owner, "Only the owner can set copays");
        for (uint256 i = 0; i < patients.length; i++) {
            copays[patients[i]] = copays[i];
        }
    }

    function setMaximumOutOfPockets(address[] memory patients, uint256[] memory maximumOutOfPockets) public {
        require(msg.sender == owner, "Only the owner can set maximum out-of-pockets");
        for (uint256 i = 0; i < patients.length; i++) {
            maximumOutOfPockets[patients[i]] = maximumOutOfPockets[i];
        }
    }

    function isEligibleForImmunosuppressiveDrugBenefit(address patient) public view returns (bool) {
        return eligiblePatients[patient];
    }

    function getPremium(address patient) public view returns (uint256) {
        return premiums[patient];
    }

    function getDeductible(address patient) public view returns (uint256) {
        return deductibles[patient];
    }

    function getCopay(address patient) public view returns (uint256) {
        return copays[patient];
    }

    function getMaximumOutOfPocket(address patient) public view returns (uint256) {
        return maximumOutOfPockets[patient];
    }
}