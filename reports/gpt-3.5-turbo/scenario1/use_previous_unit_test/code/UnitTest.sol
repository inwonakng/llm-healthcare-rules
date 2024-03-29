pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract InjectableOsteoporosisDrugsCoverageTest {
    InjectableOsteoporosisDrugsCoverage insurance;

    function beforeEach() public {
        insurance = new InjectableOsteoporosisDrugsCoverage();
    }

    function testCoverageConditions() public {
        // Condition 1a: You are a woman with osteoporosis who meets the criteria for the Medicare home health benefit.
        bool meetsCriteria = insurance.meetsCriteriaForHomeHealthBenefit(true);
        Assert.isTrue(meetsCriteria, "Condition 1a not met");

        // Condition 1b: You have a bone fracture that a doctor certifies was related to post-menopausal osteoporosis.
        bool hasCertifiedFracture = insurance.hasCertifiedFracture(true);
        Assert.isTrue(hasCertifiedFracture, "Condition 1b not met");

        // Condition 1c: Your doctor certifies that you are unable to give yourself the injection or learn how to give yourself the drug by injection.
        bool unableToInject = insurance.isUnableToInject(true);
        Assert.isTrue(unableToInject, "Condition 1c not met");
    }

    function testCoverageForHomeHealthNurse() public {
        // Condition 2: If your family or caregivers are unable or unwilling to give you the drug by injection, Medicare will cover the home health nurse or aide to provide the injection.
        bool requiresHomeHealthNurse = insurance.requiresHomeHealthNurse(true);
        Assert.isTrue(requiresHomeHealthNurse, "Condition 2 not met");
    }
}