pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Patient {
        bool hasPrimaryImmuneDeficiencyDisease;
        bool isMedicallyAppropriate;
        bool coverIVIG;
        bool coverIVIGInHome;
        bool coverIVIGCost;
        bool doNotCoverOtherServices;
    }
    
    mapping(address => Patient) public patients;
    
    function setPrimaryImmuneDeficiencyDisease(address patientAddress, bool hasCondition) external {
        patients[patientAddress].hasPrimaryImmuneDeficiencyDisease = hasCondition;
    }
    
    function setMedicallyAppropriate(address patientAddress, bool isMedicallyAppropriate) external {
        patients[patientAddress].isMedicallyAppropriate = isMedicallyAppropriate;
    }
    
    function checkCoverIVIG(address patientAddress) external {
        Patient storage patient = patients[patientAddress];
        
        if (patient.hasPrimaryImmuneDeficiencyDisease && patient.isMedicallyAppropriate) {
            patient.coverIVIG = true;
        } else {
            patient.coverIVIG = false;
        }
    }
    
    function checkCoverIVIGInHome(address patientAddress) external {
        Patient storage patient = patients[patientAddress];
        
        if (patient.coverIVIG && patient.isMedicallyAppropriate) {
            patient.coverIVIGInHome = true;
        } else {
            patient.coverIVIGInHome = false;
        }
    }
    
    function checkCoverIVIGCost(address patientAddress) external {
        Patient storage patient = patients[patientAddress];
        
        if (patient.coverIVIG && patient.coverIVIGInHome) {
            patient.coverIVIGCost = true;
        } else {
            patient.coverIVIGCost = false;
        }
    }
    
    function checkDoNotCoverOtherServices(address patientAddress) external {
        Patient storage patient = patients[patientAddress];
        
        if (patient.coverIVIGInHome) {
            patient.doNotCoverOtherServices = true;
        } else {
            patient.doNotCoverOtherServices = false;
        }
    }
}