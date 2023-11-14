pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract MedicareImmunosuppressiveDrugBenefitTest {
    function testPartACoverage() public {
        // Test that the patient has Part A coverage at the time of the covered transplant
        assertTrue(hasPartACoverage(), "Patient does not have Part A coverage");
    }

    function testPartBCoverage() public {
        // Test that the patient has Part B coverage at the time of receiving immunosuppressive drugs
        assertTrue(hasPartBCoverage(), "Patient does not have Part B coverage");
    }

    function testOriginalMedicareCoverage() public {
        // Test that the patient has Original Medicare coverage
        assertTrue(hasOriginalMedicareCoverage(), "Patient does not have Original Medicare coverage");
    }

    function testESRDCoverage() public {
        // Test that the patient has End-Stage Renal Disease (ESRD) coverage
        assertTrue(hasESRDCoverage(), "Patient does not have ESRD coverage");
    }

    function testImmunosuppressiveDrugBenefit() public {
        // Test that the patient is eligible for the immunosuppressive drug benefit
        assertTrue(isEligibleForImmunosuppressiveDrugBenefit(), "Patient is not eligible for the immunosuppressive drug benefit");
    }

    function testSignUpForBenefit() public {
        // Test that the patient can sign up for the immunosuppressive drug benefit
        assertTrue(canSignUpForBenefit(), "Patient cannot sign up for the immunosuppressive drug benefit");
    }

    function testPremiumAndDeductible() public {
        // Test that the patient pays a monthly premium of $97.10* and a $226 deductible if they sign up for the immunosuppressive drug benefit
        assertEquals(premiumAndDeductible(), (97.10, 226), "Incorrect premium and deductible amount");
    }

    function testDrugCoverage() public {
        // Test that the patient's immunosuppressive drugs are covered under the immunosuppressive drug benefit
        assertTrue(isDrugCovered(), "Patient's immunosuppressive drugs are not covered");
    }

    function testDeductibleMet() public {
        // Test that the patient has met the deductible for their immunosuppressive drugs
        assertTrue(hasMetDeductible(), "Patient has not met the deductible");
    }

    function testCopayment() public {
        // Test that the patient pays 20% of the Medicare-approved amount for their immunosuppressive drugs
        assertEquals(copayment(), 0.2, "Incorrect copayment amount");
    }
}