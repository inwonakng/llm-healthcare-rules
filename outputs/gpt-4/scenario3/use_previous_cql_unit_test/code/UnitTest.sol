pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract MedicareContractTest {
    MedicareContract medicare = new MedicareContract();

    function testMedicareCoversTransplantDrugTherapy() public {
        bool result = medicare.isTransplantDrugTherapyCovered(true);
        Assert.equal(result, true, "Medicare should cover transplant drug therapy if it helped pay for the organ transplant");
    }

    function testPolicyHolderHasPartA() public {
        bool result = medicare.hasPartAAtTimeOfTransplant(true);
        Assert.equal(result, true, "Policy holder must have Part A at the time of the covered transplant");
    }

    function testPolicyHolderHasPartB() public {
        bool result = medicare.hasPartBAtTimeOfImmunosuppressiveDrugs(true);
        Assert.equal(result, true, "Policy holder must have Part B at the time they get immunosuppressive drugs");
    }

    function testMedicareDrugCoveragePartD() public {
        bool result = medicare.isPartDCoveringImmunosuppressiveDrugs(false);
        Assert.equal(result, true, "Medicare drug coverage (Part D) should cover immunosuppressive drugs if Part B doesn’t cover them");
    }

    function testPolicyHolderHasOriginalMedicare() public {
        bool result = medicare.canJoinMedicareDrugPlan(true);
        Assert.equal(result, true, "If the policy holder has Original Medicare, they may join a Medicare drug plan to get Medicare drug coverage");
    }

    function testMedicareCoverageEndsAfter36Months() public {
        bool result = medicare.isMedicareCoverageEnded(37);
        Assert.equal(result, true, "If the policy holder only has Medicare because of End-Stage Renal Disease (ESRD), their Medicare coverage, including immunosuppressive drug coverage, should end 36 months after a successful kidney transplant");
    }

    function testMedicareOffersBenefit() public {
        bool result = medicare.isBenefitOffered(true, false);
        Assert.equal(result, true, "Medicare should offer a benefit that may help the policy holder, if they lose Part A coverage 36 months after a kidney transplant, and they don’t have certain types of other health coverage");
    }

    function testBenefitCoversOnlyImmunosuppressiveDrugs() public {
        bool result = medicare.isBenefitCoveringOnlyImmunosuppressiveDrugs(true);
        Assert.equal(result, true, "This benefit should only cover immunosuppressive drugs and no other items or services");
    }

    function testBenefitIsNotSubstituteForFullHealthCoverage() public {
        bool result = medicare.isBenefitSubstituteForFullHealthCoverage(false);
        Assert.equal(result, true, "The benefit isn’t a substitute for full health coverage");
    }

    function testPolicyHolderCanSignUpAfterPartAEnds() public {
        bool result = medicare.canSignUpAfterPartAEnds(true);
        Assert.equal(result, true, "If the policy holder qualifies, they can sign up for this benefit any time after their Part A coverage ends");
    }

    function testPolicyHolderPaysMonthlyPremium() public {
        uint result = medicare.getMonthlyPremium(2023);
        Assert.equal(result, 97.10 ether, "In 2023, the policy holder will pay a monthly premium of $97.10 if they sign up for the immunosuppressive drug benefit");
    }

    function testPolicyHolderPaysDeductible() public {
        uint result = medicare.getDeductible(2023);
        Assert.equal(result, 226 ether, "In 2023, the policy holder will pay a $226 deductible if they sign up for the immunosuppressive drug benefit");
    }

    function testPolicyHolderPays20PercentAfterDeductible() public {
        uint result = medicare.getMedicareApprovedAmount(1000 ether);
        Assert.equal(result, 200 ether, "Once the policy holder has met the deductible, they will pay 20% of the Medicare-approved amount for their immunosuppressive drugs");
    }
}