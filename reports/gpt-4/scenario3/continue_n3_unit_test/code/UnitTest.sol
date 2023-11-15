pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract MedicareContractTest {
    MedicareContract medicareContract;

    function beforeEach() public {
        medicareContract = new MedicareContract();
    }

    function checkEligibilityForTransplantDrugTherapy() public {
        medicareContract.setPatientDetails(true, true, true, true, false, 0);
        Assert.equal(medicareContract.checkEligibilityForTransplantDrugTherapy(), true, "Patient should be eligible for transplant drug therapy");
    }

    function checkEligibilityForPartDCoverage() public {
        medicareContract.setPatientDetails(true, true, false, false, false, 0);
        Assert.equal(medicareContract.checkEligibilityForPartDCoverage(), true, "Patient should be eligible for Part D coverage");
    }

    function checkMedicareCoverageEnds() public {
        medicareContract.setPatientDetails(true, false, false, false, true, 37);
        Assert.equal(medicareContract.checkMedicareCoverageEnds(), true, "Medicare coverage should end");
    }

    function checkEligibilityForImmunosuppressiveDrugBenefit() public {
        medicareContract.setPatientDetails(true, false, false, false, false, 37);
        Assert.equal(medicareContract.checkEligibilityForImmunosuppressiveDrugBenefit(), true, "Patient should be eligible for immunosuppressive drug benefit");
    }

    function checkEligibilityForImmunosuppressiveDrugs() public {
        medicareContract.setPatientDetails(true, false, false, false, false, 37);
        medicareContract.signUpForBenefit(true, true);
        Assert.equal(medicareContract.checkEligibilityForImmunosuppressiveDrugs(), true, "Patient should be eligible for immunosuppressive drugs");
    }
}