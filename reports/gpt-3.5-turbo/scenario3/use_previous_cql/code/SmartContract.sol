pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Policy {
        bool medicareCoversTransplantDrugTherapy;
        bool mustHavePartAAtTimeOfCoveredTransplant;
        bool mustHavePartBAtTimeOfImmunosuppressiveDrugs;
        bool partDDoesNotCoverImmunosuppressiveDrugs;
        bool originalMedicareAllowsJoiningMedicareDrugPlan;
        bool medicareCoverageEndsAfter36MonthsOfSuccessfulKidneyTransplant;
        bool medicareOffersBenefitForLossOfPartACoverage;
        bool benefitCoversImmunosuppressiveDrugsOnly;
        bool benefitIsNotSubstituteForFullHealthCoverage;
        bool canSignUpForBenefitAfterPartACoverageEnds;
        bool callSocialSecurityForSignUp;
        bool monthlyPremiumIn2023;
        bool deductibleIn2023;
        bool percentagePaymentForImmunosuppressiveDrugs;
    }
    
    Policy public policy;
    
    constructor() {
        policy.medicareCoversTransplantDrugTherapy = false;
        policy.mustHavePartAAtTimeOfCoveredTransplant = false;
        policy.mustHavePartBAtTimeOfImmunosuppressiveDrugs = false;
        policy.partDDoesNotCoverImmunosuppressiveDrugs = false;
        policy.originalMedicareAllowsJoiningMedicareDrugPlan = false;
        policy.medicareCoverageEndsAfter36MonthsOfSuccessfulKidneyTransplant = false;
        policy.medicareOffersBenefitForLossOfPartACoverage = false;
        policy.benefitCoversImmunosuppressiveDrugsOnly = false;
        policy.benefitIsNotSubstituteForFullHealthCoverage = false;
        policy.canSignUpForBenefitAfterPartACoverageEnds = false;
        policy.callSocialSecurityForSignUp = false;
        policy.monthlyPremiumIn2023 = false;
        policy.deductibleIn2023 = false;
        policy.percentagePaymentForImmunosuppressiveDrugs = false;
    }
    
    function setPolicyConditions(
        bool medicareCoversTransplantDrugTherapy,
        bool mustHavePartAAtTimeOfCoveredTransplant,
        bool mustHavePartBAtTimeOfImmunosuppressiveDrugs,
        bool partDDoesNotCoverImmunosuppressiveDrugs,
        bool originalMedicareAllowsJoiningMedicareDrugPlan,
        bool medicareCoverageEndsAfter36MonthsOfSuccessfulKidneyTransplant,
        bool medicareOffersBenefitForLossOfPartACoverage,
        bool benefitCoversImmunosuppressiveDrugsOnly,
        bool benefitIsNotSubstituteForFullHealthCoverage,
        bool canSignUpForBenefitAfterPartACoverageEnds,
        bool callSocialSecurityForSignUp,
        bool monthlyPremiumIn2023,
        bool deductibleIn2023,
        bool percentagePaymentForImmunosuppressiveDrugs
    ) external {
        policy.medicareCoversTransplantDrugTherapy = medicareCoversTransplantDrugTherapy;
        policy.mustHavePartAAtTimeOfCoveredTransplant = mustHavePartAAtTimeOfCoveredTransplant;
        policy.mustHavePartBAtTimeOfImmunosuppressiveDrugs = mustHavePartBAtTimeOfImmunosuppressiveDrugs;
        policy.partDDoesNotCoverImmunosuppressiveDrugs = partDDoesNotCoverImmunosuppressiveDrugs;
        policy.originalMedicareAllowsJoiningMedicareDrugPlan = originalMedicareAllowsJoiningMedicareDrugPlan;
        policy.medicareCoverageEndsAfter36MonthsOfSuccessfulKidneyTransplant = medicareCoverageEndsAfter36MonthsOfSuccessfulKidneyTransplant;
        policy.medicareOffersBenefitForLossOfPartACoverage = medicareOffersBenefitForLossOfPartACoverage;
        policy.benefitCoversImmunosuppressiveDrugsOnly = benefitCoversImmunosuppressiveDrugsOnly;
        policy.benefitIsNotSubstituteForFullHealthCoverage = benefitIsNotSubstituteForFullHealthCoverage;
        policy.canSignUpForBenefitAfterPartACoverageEnds = canSignUpForBenefitAfterPartACoverageEnds;
        policy.callSocialSecurityForSignUp = callSocialSecurityForSignUp;
        policy.monthlyPremiumIn2023 = monthlyPremiumIn2023;
        policy.deductibleIn2023 = deductibleIn2023;
        policy.percentagePaymentForImmunosuppressiveDrugs = percentagePaymentForImmunosuppressiveDrugs;
    }
    
    function checkPolicyConditions() external view returns (bool) {
        return (
            policy.medicareCoversTransplantDrugTherapy &&
            policy.mustHavePartAAtTimeOfCoveredTransplant &&
            policy.mustHavePartBAtTimeOfImmunosuppressiveDrugs &&
            policy.partDDoesNotCoverImmunosuppressiveDrugs &&
            policy.originalMedicareAllowsJoiningMedicareDrugPlan &&
            policy.medicareCoverageEndsAfter36MonthsOfSuccessfulKidneyTransplant &&
            policy.medicareOffersBenefitForLossOfPartACoverage &&
            policy.benefitCoversImmunosuppressiveDrugsOnly &&
            policy.benefitIsNotSubstituteForFullHealthCoverage &&
            policy.canSignUpForBenefitAfterPartACoverageEnds &&
            policy.callSocialSecurityForSignUp &&
            policy.monthlyPremiumIn2023 &&
            policy.deductibleIn2023 &&
            policy.percentagePaymentForImmunosuppressiveDrugs
        );
    }
}