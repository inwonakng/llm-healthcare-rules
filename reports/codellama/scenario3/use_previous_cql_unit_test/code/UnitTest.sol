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

    function testMedicareDrugCoverage() public {
        // Test that the patient has Medicare drug coverage if they have Original Medicare
        assertTrue(hasMedicareDrugCoverage(), "Patient does not have Medicare drug coverage");
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
        // Test that the patient pays a monthly premium of $97.10 and a $226 deductible if they sign up for the immunosuppressive drug benefit
        assertEquals(premiumAndDeductible(), (97.10, 226), "Incorrect premium and deductible amount");
    }

    function testDrugCoverage() public {
        // Test that the patient's immunosuppressive drugs are covered under the immunosuppressive drug benefit
        assertTrue(isDrugCovered(), "Immunosuppressive drugs are not covered under the immunosuppressive drug benefit");
    }

    function testDeductible() public {
        // Test that the patient has met the deductible for the immunosuppressive drug benefit
        assertTrue(hasMetDeductible(), "Patient has not met the deductible for the immunosuppressive drug benefit");
    }

    function testCopay() public {
        // Test that the patient pays 20% of the Medicare-approved amount for their immunosuppressive drugs after meeting the deductible
        assertEquals(copay(), 0.2, "Incorrect copay amount");
    }
}