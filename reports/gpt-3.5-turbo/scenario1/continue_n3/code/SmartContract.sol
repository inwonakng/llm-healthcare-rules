pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Patient {
        bool isEligible;
        bool hasCondition1;
        bool hasCondition2;
        bool hasCondition3;
        bool hasCondition4;
    }
    
    mapping(address => Patient) public patients;
    
    function checkEligibility(address patientAddress) external view returns (bool) {
        Patient storage patient = patients[patientAddress];
        
        if (patient.hasCondition1 && patient.hasCondition2 && patient.hasCondition3) {
            patient.isEligible = true;
        }
        
        if (patient.hasCondition4) {
            patient.isEligible = true;
        }
        
        return patient.isEligible;
    }
    
    function setCondition1(address patientAddress, bool value) external {
        patients[patientAddress].hasCondition1 = value;
    }
    
    function setCondition2(address patientAddress, bool value) external {
        patients[patientAddress].hasCondition2 = value;
    }
    
    function setCondition3(address patientAddress, bool value) external {
        patients[patientAddress].hasCondition3 = value;
    }
    
    function setCondition4(address patientAddress, bool value) external {
        patients[patientAddress].hasCondition4 = value;
    }
}