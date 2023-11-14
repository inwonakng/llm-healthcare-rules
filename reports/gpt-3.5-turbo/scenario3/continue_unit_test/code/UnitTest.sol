pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract YourContractTest {
    YourContract yourContract;

    function beforeEach() public {
        yourContract = new YourContract();
    }

    function testMedicareCoversTransplantDrugTherapy() public {
        bool isCovered = yourContract.isTransplantDrugTherapyCovered();
        Assert.isTrue(isCovered, "Medicare should cover transplant drug therapy");
    }

    function testMustHavePartAAtTimeOfCoveredTransplant() public {
        bool hasPartA = yourContract.hasPartA();
        Assert.isTrue(hasPartA, "Must have Part A at the time of the covered transplant");
    }

    function testMustHavePartBAtTimeOfImmunosuppressiveDrugs() public {
        bool hasPartB = yourContract.hasPartB();
        Assert.isTrue(hasPartB, "Must have Part B at the time of getting immunosuppressive drugs");
    }

    function testMedicareDrugCoverageCoversImmunosuppressiveDrugs() public {
        bool hasDrugCoverage = yourContract.hasMedicareDrugCoverage();
        Assert.isTrue(hasDrugCoverage, "Medicare drug coverage should cover immunosuppressive drugs");
    }

    function testJoinMedicareDrugPlanForDrugCoverage() public {
        bool joinedDrugPlan = yourContract.joinMedicareDrugPlan();
        Assert.isTrue(joinedDrugPlan, "Should be able to join a Medicare drug plan for drug coverage");
    }

    function testMedicareCoverageEndsAfterSuccessfulKidneyTransplant() public {
        bool coverageEnds = yourContract.isCoverageEndsAfterKidneyTransplant();
        Assert.isTrue(coverageEnds, "Medicare coverage, including immunosuppressive drug coverage, should end 36 months after a successful kidney transplant");
    }

    function testMedicareBenefitForLossOfPartAAfterKidneyTransplant() public {
        bool hasMedicareBenefit = yourContract.hasMedicareBenefitForLossOfPartA();
        Assert.isTrue(hasMedicareBenefit, "Medicare offers a benefit for loss of Part A coverage 36 months after a kidney transplant");
    }

    function testMedicareBenefitOnlyCoversImmunosuppressiveDrugs() public {
        bool onlyCoversDrugs = yourContract.doesMedicareBenefitOnlyCoverDrugs();
        Assert.isTrue(onlyCoversDrugs, "Medicare benefit should only cover immunosuppressive drugs and no other items or services");
    }

    function testMedicareBenefitIsNotSubstituteForFullHealthCoverage() public {
        bool isSubstitute = yourContract.isMedicareBenefitSubstituteForFullCoverage();
        Assert.isFalse(isSubstitute, "Medicare benefit should not be a substitute for full health coverage");
    }

    function testCanSignUpForMedicareBenefitAfterPartACoverageEnds() public {
        bool canSignUp = yourContract.canSignUpForMedicareBenefit();
        Assert.isTrue(canSignUp, "Should be able to sign up for Medicare benefit any time after Part A coverage ends");
    }

    function testPremiumAndDeductibleForImmunosuppressiveDrugBenefit() public {
        (uint premium, uint deductible) = yourContract.getPremiumAndDeductible();
        Assert.equal(premium, 9710, "Premium should be $97.10");
        Assert.equal(deductible, 226, "Deductible should be $226");
    }

    function testPaymentForImmunosuppressiveDrugsAfterDeductible() public {
        uint payment = yourContract.calculatePaymentAfterDeductible();
        Assert.equal(payment, 20, "Payment should be 20% of the Medicare-approved amount for immunosuppressive drugs");
    }
}