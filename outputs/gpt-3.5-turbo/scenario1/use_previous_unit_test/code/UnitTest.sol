pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract InsuranceContractTest {
    InsuranceContract insuranceContract;

    function beforeEach() public {
        insuranceContract = new InsuranceContract();
    }

    function testCoverageConditions() public {
        bool meetsConditions = insuranceContract.checkCoverageConditions(
            true, // isWomanWithOsteoporosis
            true, // meetsCriteriaForHomeHealthBenefit
            true, // hasFractureRelatedToOsteoporosis
            true // unableToSelfAdministerInjection
        );

        Assert.isTrue(meetsConditions, "Should meet all coverage conditions");
    }

    function testCoverageConditions_FailsIfNotWomanWithOsteoporosis() public {
        bool meetsConditions = insuranceContract.checkCoverageConditions(
            false, // isWomanWithOsteoporosis
            true, // meetsCriteriaForHomeHealthBenefit
            true, // hasFractureRelatedToOsteoporosis
            true // unableToSelfAdministerInjection
        );

        Assert.isFalse(meetsConditions, "Should not meet coverage conditions if not a woman with osteoporosis");
    }

    function testCoverageConditions_FailsIfNotMeetingCriteriaForHomeHealthBenefit() public {
        bool meetsConditions = insuranceContract.checkCoverageConditions(
            true, // isWomanWithOsteoporosis
            false, // meetsCriteriaForHomeHealthBenefit
            true, // hasFractureRelatedToOsteoporosis
            true // unableToSelfAdministerInjection
        );

        Assert.isFalse(meetsConditions, "Should not meet coverage conditions if not meeting criteria for home health benefit");
    }

    function testCoverageConditions_FailsIfNoFractureRelatedToOsteoporosis() public {
        bool meetsConditions = insuranceContract.checkCoverageConditions(
            true, // isWomanWithOsteoporosis
            true, // meetsCriteriaForHomeHealthBenefit
            false, // hasFractureRelatedToOsteoporosis
            true // unableToSelfAdministerInjection
        );

        Assert.isFalse(meetsConditions, "Should not meet coverage conditions if no fracture related to osteoporosis");
    }

    function testCoverageConditions_FailsIfAbleToSelfAdministerInjection() public {
        bool meetsConditions = insuranceContract.checkCoverageConditions(
            true, // isWomanWithOsteoporosis
            true, // meetsCriteriaForHomeHealthBenefit
            true, // hasFractureRelatedToOsteoporosis
            false // unableToSelfAdministerInjection
        );

        Assert.isFalse(meetsConditions, "Should not meet coverage conditions if able to self-administer injection");
    }

    function testCoverageConditions_FailsIfFamilyOrCaregiversAbleToAdministerInjection() public {
        bool meetsConditions = insuranceContract.checkCoverageConditions(
            true, // isWomanWithOsteoporosis
            true, // meetsCriteriaForHomeHealthBenefit
            true, // hasFractureRelatedToOsteoporosis
            true // unableToSelfAdministerInjection
        );

        bool familyOrCaregiversAbleToAdminister = insuranceContract.checkFamilyOrCaregiversAbleToAdminister(
            true // familyOrCaregiversAbleToAdminister
        );

        Assert.isFalse(familyOrCaregiversAbleToAdminister, "Should not meet coverage conditions if family or caregivers able to administer injection");
    }

    function testCoverageConditions_PassesIfFamilyOrCaregiversUnableToAdministerInjection() public {
        bool meetsConditions = insuranceContract.checkCoverageConditions(
            true, // isWomanWithOsteoporosis
            true, // meetsCriteriaForHomeHealthBenefit
            true, // hasFractureRelatedToOsteoporosis
            true // unableToSelfAdministerInjection
        );

        bool familyOrCaregiversAbleToAdminister = insuranceContract.checkFamilyOrCaregiversAbleToAdminister(
            false // familyOrCaregiversAbleToAdminister
        );

        Assert.isTrue(familyOrCaregiversAbleToAdminister, "Should meet coverage conditions if family or caregivers unable to administer injection");
    }
}