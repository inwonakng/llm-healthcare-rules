```
pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Beneficiary {
        bool isFemale;
        bool hasOsteoporosis;
        bool qualifiesForMedicareHomeHealthBenefit;
        bool hasCertifiedPostMenopausalOsteoporosisFracture;
        bool unableToSelfAdministerInjection;
        bool hasUnwillingOrUnableFamilyOrCaregiver;
    }

    function checkEligibility(Beneficiary memory beneficiary) public pure returns (bool) {
        if (beneficiary.isFemale && beneficiary.hasOsteoporosis && beneficiary.qualifiesForMedicareHomeHealthBenefit && beneficiary.hasCertifiedPostMenopausalOsteoporosisFracture && beneficiary.unableToSelfAdministerInjection) {
            if (beneficiary.hasUnwillingOrUnableFamilyOrCaregiver) {
                return true; // Eligible for both injectable osteoporosis drug coverage and home health nurse or aide coverage
            }
            return true; // Eligible for injectable osteoporosis drug coverage only
        }
        return false; // Not eligible
    }
}