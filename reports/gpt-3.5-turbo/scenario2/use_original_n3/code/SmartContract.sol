pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct IVIG {
        bool isCovered;
        bool isMedicallyAppropriate;
        bool isHomeDelivery;
    }
    
    function getIVIGCoverage(bool hasPrimaryImmuneDeficiency, bool isMedicallyAppropriate, bool isHomeDelivery) public pure returns (bool) {
        IVIG memory ivig;
        ivig.isCovered = false;
        ivig.isMedicallyAppropriate = false;
        ivig.isHomeDelivery = false;
        
        if (hasPrimaryImmuneDeficiency && isMedicallyAppropriate && isHomeDelivery) {
            ivig.isCovered = true;
        }
        
        return ivig.isCovered;
    }
}