pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract MedicareContractTest {
    MedicareContract medicare = new MedicareContract();

    function testMedicareCoverageForTransplantDrugTherapy() public {
        bool hasPartA = true;
        bool hasPartB = true;
        bool hasPartD = false;
        bool hasOriginalMedicare = true;
        bool hasESRD = false;
        uint monthsAfterSuccessfulKidneyTransplant = 0;
        bool hasOtherHealthCoverage = false;
        bool result = medicare.isTransplantDrugTherapyCovered(hasPartA, hasPartB, hasPartD, hasOriginalMedicare, hasESRD, monthsAfterSuccessfulKidneyTransplant, hasOtherHealthCoverage);
        Assert.equal(result, true, "Medicare should cover transplant drug therapy");
    }

    function testMedicareCoverageEndsAfter36Months() public {
        bool hasPartA = true;
        bool hasPartB = true;
        bool hasPartD = false;
        bool hasOriginalMedicare = true;
        bool hasESRD = true;
        uint monthsAfterSuccessfulKidneyTransplant = 37;
        bool hasOtherHealthCoverage = false;
        bool result = medicare.isTransplantDrugTherapyCovered(hasPartA, hasPartB, hasPartD, hasOriginalMedicare, hasESRD, monthsAfterSuccessfulKidneyTransplant, hasOtherHealthCoverage);
        Assert.equal(result, false, "Medicare coverage, including immunosuppressive drug coverage, should end 36 months after a successful kidney transplant");
    }

    function testBenefitCoverageForImmunosuppressiveDrugs() public {
        bool hasPartA = false;
        bool hasOtherHealthCoverage = false;
        uint monthsAfterSuccessfulKidneyTransplant = 37;
        bool result = medicare.isBenefitCovered(hasPartA, hasOtherHealthCoverage, monthsAfterSuccessfulKidneyTransplant);
        Assert.equal(result, true, "Benefit should cover immunosuppressive drugs after Part A coverage ends");
    }

    function testMonthlyPremiumAndDeductible() public {
        uint premium = 9710; // in cents
        uint deductible = 22600; // in cents
        bool result = medicare.checkPremiumAndDeductible(premium, deductible);
        Assert.equal(result, true, "Monthly premium should be $97.10 and deductible should be $226");
    }

    function testMedicareApprovedAmount() public {
        uint approvedAmount = 10000; // in cents
        uint patientAmount = 2000; // in cents
        bool result = medicare.checkMedicareApprovedAmount(approvedAmount, patientAmount);
        Assert.equal(result, true, "Patient should pay 20% of the Medicare-approved amount for immunosuppressive drugs");
    }
}