pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct IVIG {
        bool isCovered;
        bool isMedicallyAppropriate;
        bool isHomeDelivery;
    }
    
    function checkCoverage(bool hasPrimaryImmuneDeficiency, bool isMedicallyAppropriate, bool isHomeDelivery) external pure returns (bool) {
        IVIG memory ivig;
        ivig.isCovered = hasPrimaryImmuneDeficiency && isMedicallyAppropriate && isHomeDelivery;
        ivig.isMedicallyAppropriate = isMedicallyAppropriate;
        ivig.isHomeDelivery = isHomeDelivery;
        
        return ivig.isCovered;
    }
}