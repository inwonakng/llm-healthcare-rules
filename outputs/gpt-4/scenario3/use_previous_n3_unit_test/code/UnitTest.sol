pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract MedicareTest {
    Medicare medicare = new Medicare();

    function testMedicareCoversTransplantDrugTherapy() public {
        bool result = medicare.isTransplantCovered(true);
        Assert.equal(result, true, "Medicare should cover transplant drug therapy if it helped pay for the organ transplant");
    }

    function testPartARequiredAtTimeOfTransplant() public {
        bool result = medicare.hasPartAAtTimeOfTransplant(true);
        Assert.equal(result, true, "Part A must be present at the time of the covered transplant");
    }

    function testPartBRequiredAtTimeOfImmunosuppressiveDrugs() public {
        bool result = medicare.hasPartBAtTimeOfImmunosuppressiveDrugs(true);
        Assert.equal(result, true, "Part B must be present at the time of getting immunosuppressive drugs");
    }

    function testPartDCoversImmunosuppressiveDrugs() public {
        bool result = medicare.isPartDCoveringImmunosuppressiveDrugs(true);
        Assert.equal(result, true, "Part D should cover immunosuppressive drugs if Part B doesn’t cover them");
    }

    function testMedicareCoverageEndsAfter36Months() public {
        bool result = medicare.isMedicareCoverageEnded(37);
        Assert.equal(result, true, "Medicare coverage should end 36 months after a successful kidney transplant");
    }

    function testBenefitCoversImmunosuppressiveDrugsOnly() public {
        bool result = medicare.isBenefitCoveringImmunosuppressiveDrugsOnly(true);
        Assert.equal(result, true, "The benefit should only cover immunosuppressive drugs and no other items or services");
    }

    function testSignupAfterPartAEnds() public {
        bool result = medicare.canSignupAfterPartAEnds(true);
        Assert.equal(result, true, "Should be able to sign up for the benefit any time after Part A coverage ends");
    }

    function testMonthlyPremiumAndDeductible() public {
        uint premium = 9710; // in cents
        uint deductible = 22600; // in cents
        bool result = medicare.isPremiumAndDeductibleCorrect(premium, deductible);
        Assert.equal(result, true, "In 2023, the monthly premium should be $97.10 and deductible should be $226 if you sign up for the immunosuppressive drug benefit");
    }

    function testPaymentAfterDeductible() public {
        uint payment = 20; // in percentage
        bool result = medicare.isPaymentAfterDeductibleCorrect(payment);
        Assert.equal(result, true, "Once the deductible is met, you should pay 20% of the Medicare-approved amount for your immunosuppressive drugs");
    }
}