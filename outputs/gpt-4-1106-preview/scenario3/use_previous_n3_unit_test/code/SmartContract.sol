// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicareContract {
    struct PolicyHolder {
        bool hasMedicarePartA;
        bool hasMedicarePartB;
        bool receivedOrganTransplant;
        bool medicareContributedToTransplant;
        bool needsImmunosuppressiveDrugs;
        bool hasOriginalMedicare;
        bool hasMedicareDueToESRD;
        uint256 monthsAfterKidneyTransplant;
        bool lostPartACoveragePost36Months;
        bool lacksOtherHealthCoverage;
        bool signedUpForImmunosuppressiveDrugBenefit;
        uint256 year;
        bool metDeductible;
        uint256 medicareApprovedAmount;
    }

    uint256 public constant MONTHLY_PREMIUM = 97.10 ether; // 1 ether is used to represent $1
    uint256 public constant DEDUCTIBLE = 226 ether;

    function isTransplantDrugTherapyCovered(PolicyHolder memory holder) public pure returns (bool) {
        return holder.hasMedicarePartA && holder.hasMedicarePartB && holder.receivedOrganTransplant && holder.medicareContributedToTransplant;
    }

    function isEligibleForCoverageAtTransplant(PolicyHolder memory holder) public pure returns (bool) {
        return holder.hasMedicarePartA;
    }

    function isCoveredForImmunosuppressiveDrugs(PolicyHolder memory holder) public pure returns (bool) {
        return holder.hasMedicarePartB && holder.needsImmunosuppressiveDrugs;
    }

    function isCoveredUnderPartDWhenPartBDoesNot(PolicyHolder memory holder) public pure returns (bool) {
        return !holder.hasMedicarePartB && holder.needsImmunosuppressiveDrugs;
    }

    function canJoinMedicareDrugPlan(PolicyHolder memory holder) public pure returns (bool) {
        return holder.hasOriginalMedicare;
    }

    function hasMedicareCoverageEndedForESRD(PolicyHolder memory holder) public view returns (bool) {
        return holder.hasMedicareDueToESRD && holder.monthsAfterKidneyTransplant >= 36;
    }

    function isSpecificBenefitAvailable(PolicyHolder memory holder) public pure returns (bool) {
        return holder.lostPartACoveragePost36Months && holder.lacksOtherHealthCoverage;
    }

    function isOnlyDrugsCovered(PolicyHolder memory holder) public pure returns (bool) {
        return holder.eligibleForSpecificBenefit;
    }

    function isFullCoverage(PolicyHolder memory holder) public pure returns (bool) {
        return !holder.specificBenefitIsNotFullHealthCoverage;
    }

    function getImmunosuppressiveDrugBenefitCosts(PolicyHolder memory holder) public pure returns (uint256, uint256) {
        if (holder.signedUpForImmunosuppressiveDrugBenefit && holder.year == 2023) {
            return (MONTHLY_PREMIUM, DEDUCTIBLE);
        } else {
            return (0, 0);
        }
    }

    function getCostAfterDeductible(PolicyHolder memory holder) public pure returns (uint256) {
        if (holder.metDeductible) {
            return (holder.medicareApprovedAmount * 20) / 100;
        } else {
            return 0;
        }
    }
}