pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract InsuranceContractTest {
    InsuranceContract insuranceContract;

    function beforeEach() public {
        insuranceContract = new InsuranceContract();
    }

    function testMedicareCoversInjectableOsteoporosisDrugs() public {
        // Condition: You’re a woman with osteoporosis who meets the criteria for the Medicare home health benefit.
        bool meetsCriteria = insuranceContract.meetsMedicareCriteria();
        Assert.isTrue(meetsCriteria, "Should meet the criteria for the Medicare home health benefit");

        // Condition: You have a bone fracture that a doctor certifies was related to post-menopausal osteoporosis.
        bool hasCertifiedFracture = insuranceContract.hasCertifiedFracture();
        Assert.isTrue(hasCertifiedFracture, "Should have a certified bone fracture related to post-menopausal osteoporosis");

        // Condition: Your doctor certifies that you can’t give yourself the injection or learn how to give yourself the drug by injection.
        bool cannotSelfInject = insuranceContract.cannotSelfInject();
        Assert.isTrue(cannotSelfInject, "Doctor should certify that you cannot self-inject the drug");

        // Condition: Medicare will cover the home health nurse or aide to provide the injection if your family or caregivers are unable or unwilling to give you the drug by injection.
        bool canReceiveInjection = insuranceContract.canReceiveInjection();
        Assert.isTrue(canReceiveInjection, "Medicare should cover the home health nurse or aide to provide the injection");
    }
}