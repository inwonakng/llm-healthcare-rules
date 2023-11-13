pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract InsurancePolicyTest {
    InsurancePolicy insurancePolicy;

    function beforeEach() public {
        insurancePolicy = new InsurancePolicy();
    }

    function checkEligibilityForInjectableOsteoporosisDrugs() public {
        // Test data
        bool isWoman = true;
        bool hasOsteoporosis = true;
        bool meetsHomeHealthBenefit = true;
        bool hasBoneFracture = true;
        bool fractureRelatedToOsteoporosis = true;
        bool canSelfInject = false;
        bool canLearnSelfInjection = false;
        bool hasCaregiver = false;

        // Expected result
        bool expectedResult = true;

        // Test
        bool result = insurancePolicy.isEligibleForInjectableOsteoporosisDrugs(
            isWoman,
            hasOsteoporosis,
            meetsHomeHealthBenefit,
            hasBoneFracture,
            fractureRelatedToOsteoporosis,
            canSelfInject,
            canLearnSelfInjection,
            hasCaregiver
        );

        Assert.equal(result, expectedResult, "The patient should be eligible for injectable osteoporosis drugs");
    }

    function checkIneligibilityForInjectableOsteoporosisDrugs() public {
        // Test data
        bool isWoman = false; // Changed to false
        bool hasOsteoporosis = true;
        bool meetsHomeHealthBenefit = true;
        bool hasBoneFracture = true;
        bool fractureRelatedToOsteoporosis = true;
        bool canSelfInject = false;
        bool canLearnSelfInjection = false;
        bool hasCaregiver = false;

        // Expected result
        bool expectedResult = false; // Changed to false

        // Test
        bool result = insurancePolicy.isEligibleForInjectableOsteoporosisDrugs(
            isWoman,
            hasOsteoporosis,
            meetsHomeHealthBenefit,
            hasBoneFracture,
            fractureRelatedToOsteoporosis,
            canSelfInject,
            canLearnSelfInjection,
            hasCaregiver
        );

        Assert.equal(result, expectedResult, "The patient should not be eligible for injectable osteoporosis drugs");
    }
}