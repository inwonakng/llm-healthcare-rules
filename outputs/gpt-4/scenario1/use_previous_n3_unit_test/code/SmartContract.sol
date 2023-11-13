// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Beneficiary {
        bool isWoman;
        bool hasOsteoporosis;
        bool qualifiesForMedicareHomeHealthBenefit;
        bool hasBoneFracture;
        bool boneFractureRelatedToPostMenopausalOsteoporosis;
        bool cannotSelfAdministerInjection;
        bool familyOrCaregiversCannotAdministerInjection;
    }

    function isCovered(Beneficiary memory beneficiary) public pure returns (bool) {
        if (
            beneficiary.isWoman &&
            beneficiary.hasOsteoporosis &&
            beneficiary.qualifiesForMedicareHomeHealthBenefit &&
            beneficiary.hasBoneFracture &&
            beneficiary.boneFractureRelatedToPostMenopausalOsteoporosis &&
            beneficiary.cannotSelfAdministerInjection
        ) {
            return true;
        } else {
            return false;
        }
    }

    function isNurseCovered(Beneficiary memory beneficiary) public pure returns (bool) {
        if (isCovered(beneficiary) && beneficiary.familyOrCaregiversCannotAdministerInjection) {
            return true;
        } else {
            return false;
        }
    }
}