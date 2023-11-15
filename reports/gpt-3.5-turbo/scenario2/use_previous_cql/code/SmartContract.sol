pragma solidity ^0.8.0;

contract InsurancePolicyDocument {
    struct Patient {
        bool hasPrimaryImmuneDeficiency;
        bool isMedicallyAppropriateForHomeIVIG;
        bool isMedicareCoverage;
        bool isMedicareCoverageAtHome;
        bool isMedicareCoverageForIVIG;
        bool isMedicareCoverageForOtherItems;
    }
    
    function checkDiagnosisOfPrimaryImmuneDeficiency(Patient memory patient) internal pure returns (bool) {
        return patient.hasPrimaryImmuneDeficiency;
    }
    
    function checkMedicallyAppropriateForHomeIVIG(Patient memory patient) internal pure returns (bool) {
        return patient.isMedicallyAppropriateForHomeIVIG;
    }
    
    function checkMedicareCoversIVIG(Patient memory patient) internal pure returns (bool) {
        return patient.isMedicareCoverage;
    }
    
    function checkMedicareCoversIVIGAtHome(Patient memory patient) internal pure returns (bool) {
        return patient.isMedicareCoverage && patient.isMedicareCoverageAtHome;
    }
    
    function checkMedicareCoversIVIGItself(Patient memory patient) internal pure returns (bool) {
        return patient.isMedicareCoverage && patient.isMedicareCoverageForIVIG;
    }
    
    function checkMedicareDoesNotCoverOtherItemsAndServices(Patient memory patient) internal pure returns (bool) {
        return patient.isMedicareCoverage && !patient.isMedicareCoverageAtHome && patient.isMedicareCoverageForOtherItems;
    }
}