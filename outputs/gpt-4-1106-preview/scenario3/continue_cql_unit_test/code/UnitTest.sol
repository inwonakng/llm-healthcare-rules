// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract MedicareTransplantDrugCoverageTest {
    MedicareTransplantDrugCoverage medicareContract;

    // Define a struct to encapsulate patient parameters for cleaner code
    struct PatientParams {
        bool coveredTransplant;
        bool hasPartA;
        bool hasPartB;
        bool hasPartD;
        bool hasOriginalMedicare;
        bool hasDrugPlan;
        bool hasESRDCoverage;
        uint transplantDate;
        bool hasGroupHealthPlan;
        bool hasTRICARE;
        bool hasMedicaid;
    }

    // Create a patientParams struct with default values
    PatientParams defaultPatient = PatientParams({
        coveredTransplant: true,
        hasPartA: true,
        hasPartB: true,
        hasPartD: false,
        hasOriginalMedicare: true,
        hasDrugPlan: true,
        hasESRDCoverage: false,
        transplantDate: block.timestamp - 40 months,
        hasGroupHealthPlan: false,
        hasTRICARE: false,
        hasMedicaid: false
    });

    // Run before each test function
    function beforeEach() public {
        medicareContract = new MedicareTransplantDrugCoverage();
    }

    /// Test if a patient is eligible for transplant drug therapy
    function isEligibleForTransplantDrugTherapyTest() public {
        bool result = medicareContract.isEligibleForTransplantDrugTherapy(
            defaultPatient.coveredTransplant,
            defaultPatient.hasPartA,
            defaultPatient.hasPartB
        );
        Assert.equal(result, true, "Patient should be eligible for transplant drug therapy");
    }

    /// Test if a patient is covered by Part D when Part B doesn't cover
    function isCoveredByPartDTest() public {
        bool result = medicareContract.isCoveredByPartD(
            !defaultPatient.hasPartB,
            defaultPatient.hasPartD
        );
        Assert.equal(result, true, "Patient should be covered by Part D");
    }

    /// Test if a patient with Original Medicare can join a drug plan
    function hasOriginalMedicareAndDrugPlanTest() public {
        bool result = medicareContract.hasOriginalMedicareAndDrugPlan(
            defaultPatient.hasOriginalMedicare,
            defaultPatient.hasDrugPlan
        );
        Assert.equal(result, true, "Patient with Original Medicare should be able to join a drug plan");
    }

    /// Test if ESRD coverage ends after 36 months post successful kidney transplant
    function hasESRDCoverageEndsPost36MonthsTest() public {
        bool result = medicareContract.hasESRDCoverageEndsPost36Months(
            defaultPatient.hasESRDCoverage,
            defaultPatient.transplantDate
        );
        Assert.equal(result, true, "ESRD coverage should end after 36 months post successful kidney transplant");
    }

    /// Test if a patient is eligible for the immunosuppressive drug benefit
    function isEligibleForImmunosuppressiveDrugBenefitTest() public {
        bool result = medicareContract.isEligibleForImmunosuppressiveDrugBenefit(
            defaultPatient.transplantDate,
            defaultPatient.hasGroupHealthPlan,
            defaultPatient.hasTRICARE,
            defaultPatient.hasMedicaid
        );
        Assert.equal(result, true, "Patient should be eligible for the immunosuppressive drug benefit");
    }

    /// Test the monthly premium for the immunosuppressive drug benefit in 2023
    function monthlyPremium2023Test() public {
        uint result = medicareContract.monthlyPremium2023();
        Assert.equal(result, 97.10 ether, "Monthly premium for the immunosuppressive drug benefit should be 97.10");
    }

    /// Test the annual deductible for the immunosuppressive drug benefit in 2023
    function annualDeductible2023Test() public {
        uint result = medicareContract.annualDeductible2023();
        Assert.equal(result, 226 ether, "Annual deductible for the immunosuppressive drug benefit should be 226");
    }

    /// Test the coinsurance rate after meeting the deductible
    function coinsuranceAfterDeductibleTest() public {
        uint result = medicareContract.coinsuranceAfterDeductible();
        Assert.equal(result, 20, "Coinsurance rate after meeting the deductible should be 20%");
    }

    /// Test the final decision for a patient's coverage
    function finalDecisionTest() public {
        bool result = medicareContract.finalDecision(defaultPatient);
        Assert.equal(result, true, "Patient should be covered under the final decision");
    }
}