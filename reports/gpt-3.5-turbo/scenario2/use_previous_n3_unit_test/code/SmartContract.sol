pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Patient {
        bool hasConditionPrimaryImmuneDeficiencyDisease;
        bool hasConditionMedicallyAppropriate;
        bool hasDecisionCoverIVIG;
        bool hasDecisionCoverIVIGInHome;
        bool hasDecisionCoverIVIGCost;
        bool hasDecisionDoNotCoverOtherServices;
    }
    
    mapping(address => Patient) public patients;
    
    function checkMedicareCoverage(string memory condition) public view returns (bool) {
        if (keccak256(bytes(condition)) == keccak256(bytes("primary immune deficiency disease"))) {
            return patients[msg.sender].hasDecisionCoverIVIG;
        }
        return false;
    }
    
    function checkHomeDelivery(string memory condition) public view returns (bool) {
        if (keccak256(bytes(condition)) == keccak256(bytes("primary immune deficiency disease"))) {
            return patients[msg.sender].hasDecisionCoverIVIGInHome;
        }
        return false;
    }
    
    function checkIVIGCostCoverage() public view returns (bool) {
        return patients[msg.sender].hasDecisionCoverIVIGCost;
    }
    
    function checkOtherServicesCoverage() public view returns (bool) {
        return patients[msg.sender].hasDecisionDoNotCoverOtherServices;
    }
    
    function determineMedicallyAppropriate(address patient) public {
        patients[patient].hasConditionMedicallyAppropriate = true;
    }
    
    function determineCoverIVIG(address patient) public {
        patients[patient].hasDecisionCoverIVIG = true;
    }
    
    function determineCoverIVIGInHome(address patient) public {
        patients[patient].hasDecisionCoverIVIGInHome = true;
    }
    
    function determineCoverIVIGCost(address patient) public {
        patients[patient].hasDecisionCoverIVIGCost = true;
    }
    
    function determineDoNotCoverOtherServices(address patient) public {
        patients[patient].hasDecisionDoNotCoverOtherServices = true;
    }
}