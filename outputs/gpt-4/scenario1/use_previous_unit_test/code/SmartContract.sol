// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct PolicyHolder {
        bool isWoman;
        bool hasOsteoporosis;
        bool qualifiesForMedicareHomeHealthBenefit;
        bool hasCertifiedFracture;
        bool cannotSelfAdminister;
    }

    mapping(address => PolicyHolder) public policyHolders;

    function setPolicyHolder(
        address _policyHolder,
        bool _isWoman,
        bool _hasOsteoporosis,
        bool _qualifiesForMedicareHomeHealthBenefit,
        bool _hasCertifiedFracture,
        bool _cannotSelfAdminister
    ) public {
        PolicyHolder memory newPolicyHolder = PolicyHolder({
            isWoman: _isWoman,
            hasOsteoporosis: _hasOsteoporosis,
            qualifiesForMedicareHomeHealthBenefit: _qualifiesForMedicareHomeHealthBenefit,
            hasCertifiedFracture: _hasCertifiedFracture,
            cannotSelfAdminister: _cannotSelfAdminister
        });

        policyHolders[_policyHolder] = newPolicyHolder;
    }

    function isCovered(address _policyHolder) public view returns (bool) {
        PolicyHolder memory policyHolder = policyHolders[_policyHolder];

        if (
            policyHolder.isWoman &&
            policyHolder.hasOsteoporosis &&
            policyHolder.qualifiesForMedicareHomeHealthBenefit &&
            policyHolder.hasCertifiedFracture &&
            policyHolder.cannotSelfAdminister
        ) {
            return true;
        }

        return false;
    }
}