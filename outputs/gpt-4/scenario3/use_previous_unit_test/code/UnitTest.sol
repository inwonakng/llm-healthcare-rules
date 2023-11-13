pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract MedicareContractTest {
    MedicareContract medicare = new MedicareContract();

    function testMedicareCoversTransplantDrugTherapy() public {
        bool result = medicare.coverTransplantDrugTherapy(true);
        Assert.equal(result, true, "Medicare should cover transplant drug therapy if it helped pay for the organ transplant");
    }

    function testPartAAtTimeOfTransplant() public {
        bool result = medicare.checkPartAAtTimeOfTransplant(true);
        Assert.equal(result, true, "Part A should be present at the time of the covered transplant");
    }

    function testPartBAtTimeOfImmunosuppressiveDrugs() public {
        bool result = medicare.checkPartBAtTimeOfImmunosuppressiveDrugs(true);
        Assert.equal(result, true, "Part B should be present at the time of getting immunosuppressive drugs");
    }

    function testPartDCoversImmunosuppressiveDrugs() public {
        bool result = medicare.checkPartDCoversImmunosuppressiveDrugs(false);
        Assert.equal(result, true, "Part D should cover immunosuppressive drugs if Part B doesn’t cover them");
    }

    function testMedicareCoverageEndsAfter36Months() public {
        bool result = medicare.checkMedicareCoverageEndsAfter36Months(true);
        Assert.equal(result, true, "Medicare coverage should end 36 months after a successful kidney transplant if you only have Medicare because of ESRD");
    }

    function testBenefitAfterPartACoverageEnds() public {
        bool result = medicare.checkBenefitAfterPartACoverageEnds(true, false);
        Assert.equal(result, true, "Medicare should offer a benefit if you lose Part A coverage 36 months after a kidney transplant and you don’t have certain types of other health coverage");
    }

    function testBenefitCoversImmunosuppressiveDrugsOnly() public {
        bool result = medicare.checkBenefitCoversImmunosuppressiveDrugsOnly(true);
        Assert.equal(result, true, "The benefit should only cover your immunosuppressive drugs and no other items or services");
    }

    function testSignupAfterPartACoverageEnds() public {
        bool result = medicare.checkSignupAfterPartACoverageEnds(true);
        Assert.equal(result, true, "You should be able to sign up for this benefit any time after your Part A coverage ends");
    }

    function testMonthlyPremiumAndDeductible() public {
        uint premium = 9710; // in wei
        uint deductible = 22600; // in wei
        bool result = medicare.checkMonthlyPremiumAndDeductible(premium, deductible);
        Assert.equal(result, true, "In 2023, you should pay a monthly premium of $97.10 and $226 deductible if you sign up for the immunosuppressive drug benefit");
    }

    function testPaymentAfterDeductible() public {
        uint approvedAmount = 100000; // in wei
        uint expectedPayment = approvedAmount * 20 / 100;
        uint actualPayment = medicare.calculatePaymentAfterDeductible(approvedAmount);
        Assert.equal(actualPayment, expectedPayment, "Once you’ve met the deductible, you should pay 20% of the Medicare-approved amount for your immunosuppressive drugs");
    }
}