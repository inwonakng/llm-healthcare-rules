pragma solidity ^0.8.0;

contract OsteoporosisInsurance {
    
    struct Patient {
        bool isWoman;
        bool hasOsteoporosis;
        bool meetsHomeHealthCriteria;
        bool hasFracture;
        bool hasCertification;
        bool hasInjectionCapability;
        bool hasFamilyOrCaregivers;
    }
    
    function isCovered(Patient memory patient) public pure returns (bool) {
        if (patient.isWoman &&
            patient.hasOsteoporosis &&
            patient.meetsHomeHealthCriteria &&
            patient.hasFracture &&
            patient.hasCertification &&
            (!patient.hasInjectionCapability || !patient.hasFamilyOrCaregivers)
        ) {
            return true;
        }
        return false;
    }
}