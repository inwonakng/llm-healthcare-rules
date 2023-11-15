pragma solidity ^0.8.0;

contract InjectableOsteoporosisDrugsCoverage {
    struct Condition {
        string code;
        string gender;
    }
    
    struct Procedure {
        string code;
        string gender;
    }
    
    struct MedicationAdministration {
        string code;
        string reasonCode;
        string performerType;
    }
    
    function checkInjectableOsteoporosisDrugsCoverage(
        Condition[] memory conditions,
        Procedure[] memory procedures,
        MedicationAdministration[] memory medicationAdministrations
    ) public pure returns (bool) {
        bool hasOsteoporosis = false;
        bool hasBoneFracture = false;
        bool isFemale = false;
        bool hasInjectableOsteoporosisDrug = false;
        bool hasNurseOrAide = false;
        
        for (uint i = 0; i < conditions.length; i++) {
            if (keccak256(bytes(conditions[i].code)) == keccak256(bytes("Osteoporosis")) && keccak256(bytes(conditions[i].gender)) == keccak256(bytes("female"))) {
                hasOsteoporosis = true;
            }
        }
        
        for (uint i = 0; i < procedures.length; i++) {
            if (keccak256(bytes(procedures[i].code)) == keccak256(bytes("BoneFracture")) && keccak256(bytes(procedures[i].gender)) == keccak256(bytes("female"))) {
                hasBoneFracture = true;
            }
        }
        
        for (uint i = 0; i < medicationAdministrations.length; i++) {
            if (keccak256(bytes(medicationAdministrations[i].code)) == keccak256(bytes("InjectableOsteoporosisDrug"))) {
                hasInjectableOsteoporosisDrug = true;
            }
            
            if (keccak256(bytes(medicationAdministrations[i].performerType)) == keccak256(bytes("nurse")) || keccak256(bytes(medicationAdministrations[i].performerType)) == keccak256(bytes("aide"))) {
                hasNurseOrAide = true;
            }
        }
        
        if (hasOsteoporosis && hasBoneFracture && isFemale && hasInjectableOsteoporosisDrug && hasNurseOrAide) {
            return true;
        }
        
        return false;
    }
    
    function checkUnableToSelfAdminister(
        Condition[] memory conditions,
        Procedure[] memory procedures,
        MedicationAdministration[] memory medicationAdministrations
    ) public pure returns (bool) {
        bool hasOsteoporosis = false;
        bool hasBoneFracture = false;
        bool hasInjectableOsteoporosisDrug = false;
        bool hasNurseOrAide = false;
        bool hasSelfAdministerProcedure = false;
        
        for (uint i = 0; i < conditions.length; i++) {
            if (keccak256(bytes(conditions[i].code)) == keccak256(bytes("Osteoporosis"))) {
                hasOsteoporosis = true;
            }
        }
        
        for (uint i = 0; i < procedures.length; i++) {
            if (keccak256(bytes(procedures[i].code)) == keccak256(bytes("BoneFracture"))) {
                hasBoneFracture = true;
            }
            
            if (keccak256(bytes(procedures[i].code)) == keccak256(bytes("SelfAdminister"))) {
                hasSelfAdministerProcedure = true;
            }
        }
        
        for (uint i = 0; i < medicationAdministrations.length; i++) {
            if (keccak256(bytes(medicationAdministrations[i].code)) == keccak256(bytes("InjectableOsteoporosisDrug"))) {
                hasInjectableOsteoporosisDrug = true;
            }
            
            if (keccak256(bytes(medicationAdministrations[i].performerType)) == keccak256(bytes("nurse")) || keccak256(bytes(medicationAdministrations[i].performerType)) == keccak256(bytes("aide"))) {
                hasNurseOrAide = true;
            }
        }
        
        if (hasOsteoporosis && hasBoneFracture && hasInjectableOsteoporosisDrug && hasNurseOrAide && !hasSelfAdministerProcedure) {
            return true;
        }
        
        return false;
    }
    
    function checkFamilyOrCaregiversUnableOrUnwilling(
        Condition[] memory conditions,
        Procedure[] memory procedures,
        MedicationAdministration[] memory medicationAdministrations
    ) public pure returns (bool) {
        bool hasOsteoporosis = false;
        bool hasBoneFracture = false;
        bool hasInjectableOsteoporosisDrug = false;
        bool hasNurseOrAide = false;
        bool hasFamilyOrCaregiversUnableOrUnwillingProcedure = false;
        
        for (uint i = 0; i < conditions.length; i++) {
            if (keccak256(bytes(conditions[i].code)) == keccak256(bytes("Osteoporosis"))) {
                hasOsteoporosis = true;
            }
        }
        
        for (uint i = 0; i < procedures.length; i++) {
            if (keccak256(bytes(procedures[i].code)) == keccak256(bytes("BoneFracture"))) {
                hasBoneFracture = true;
            }
            
            if (keccak256(bytes(procedures[i].code)) == keccak256(bytes("FamilyOrCaregiversUnableOrUnwilling"))) {
                hasFamilyOrCaregiversUnableOrUnwillingProcedure = true;
            }
        }
        
        for (uint i = 0; i < medicationAdministrations.length; i++) {
            if (keccak256(bytes(medicationAdministrations[i].code)) == keccak256(bytes("InjectableOsteoporosisDrug"))) {
                hasInjectableOsteoporosisDrug = true;
            }
            
            if (keccak256(bytes(medicationAdministrations[i].performerType)) == keccak256(bytes("nurse")) || keccak256(bytes(medicationAdministrations[i].performerType)) == keccak256(bytes("aide"))) {
                hasNurseOrAide = true;
            }
        }
        
        if (hasOsteoporosis && hasBoneFracture && hasInjectableOsteoporosisDrug && hasNurseOrAide && hasFamilyOrCaregiversUnableOrUnwillingProcedure) {
            return true;
        }
        
        return false;
    }
}