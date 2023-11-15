pragma solidity ^0.8.0;

contract InjectableOsteoporosisDrugsCoverage {
    
    struct Patient {
        bool isWoman;
        bool hasOsteoporosis;
        bool meetsCriteriaForHomeHealthBenefit;
        bool hasPostMenopausalOsteoporosisFracture;
        bool unableToSelfAdministerInjection;
        bool familyOrCaregiversUnableOrUnwilling;
    }
    
    function checkCoverage(
        bool isWoman,
        bool hasOsteoporosis,
        bool meetsCriteriaForHomeHealthBenefit,
        bool hasPostMenopausalOsteoporosisFracture,
        bool unableToSelfAdministerInjection,
        bool familyOrCaregiversUnableOrUnwilling
    ) external pure returns (bool) {
        Patient memory patient = Patient(
            isWoman,
            hasOsteoporosis,
            meetsCriteriaForHomeHealthBenefit,
            hasPostMenopausalOsteoporosisFracture,
            unableToSelfAdministerInjection,
            familyOrCaregiversUnableOrUnwilling
        );
        
        return coverage(patient);
    }
    
    function coverage(Patient memory patient) private pure returns (bool) {
        if (
            patient.isWoman &&
            patient.hasOsteoporosis &&
            patient.meetsCriteriaForHomeHealthBenefit &&
            patient.hasPostMenopausalOsteoporosisFracture &&
            patient.unableToSelfAdministerInjection &&
            patient.familyOrCaregiversUnableOrUnwilling
        ) {
            return true;
        }
        
        return false;
    }
}