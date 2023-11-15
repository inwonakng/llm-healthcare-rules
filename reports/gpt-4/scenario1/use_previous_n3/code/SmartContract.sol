pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Beneficiary {
        bool isWoman;
        bool hasOsteoporosis;
        bool qualifiesForMedicareHomeHealthBenefit;
        bool hasCertifiedFractureRelatedToPostMenopausalOsteoporosis;
        bool unableToSelfAdministerOrLearn;
        bool hasUnwillingOrUnableFamilyOrCaregivers;
    }

    mapping(address => Beneficiary) public beneficiaries;

    function isEligibleForInjectableOsteoporosisDrugCoverage(address _beneficiary) public view returns (bool) {
        Beneficiary memory beneficiary = beneficiaries[_beneficiary];
        return beneficiary.isWoman && beneficiary.hasOsteoporosis && beneficiary.qualifiesForMedicareHomeHealthBenefit && beneficiary.hasCertifiedFractureRelatedToPostMenopausalOsteoporosis && beneficiary.unableToSelfAdministerOrLearn;
    }

    function isEligibleForHomeHealthNurseOrAideCoverage(address _beneficiary) public view returns (bool) {
        Beneficiary memory beneficiary = beneficiaries[_beneficiary];
        return isEligibleForInjectableOsteoporosisDrugCoverage(_beneficiary) && beneficiary.hasUnwillingOrUnableFamilyOrCaregivers;
    }

    function addBeneficiary(address _beneficiary, bool _isWoman, bool _hasOsteoporosis, bool _qualifiesForMedicareHomeHealthBenefit, bool _hasCertifiedFractureRelatedToPostMenopausalOsteoporosis, bool _unableToSelfAdministerOrLearn, bool _hasUnwillingOrUnableFamilyOrCaregivers) public {
        Beneficiary memory newBeneficiary = Beneficiary({
            isWoman: _isWoman,
            hasOsteoporosis: _hasOsteoporosis,
            qualifiesForMedicareHomeHealthBenefit: _qualifiesForMedicareHomeHealthBenefit,
            hasCertifiedFractureRelatedToPostMenopausalOsteoporosis: _hasCertifiedFractureRelatedToPostMenopausalOsteoporosis,
            unableToSelfAdministerOrLearn: _unableToSelfAdministerOrLearn,
            hasUnwillingOrUnableFamilyOrCaregivers: _hasUnwillingOrUnableFamilyOrCaregivers
        });

        beneficiaries[_beneficiary] = newBeneficiary;
    }
}