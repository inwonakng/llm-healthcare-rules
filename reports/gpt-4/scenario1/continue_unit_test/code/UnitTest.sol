pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract MedicareContractTest {
    MedicareContract medicareContract;

    function beforeEach() public {
        medicareContract = new MedicareContract();
    }

    function checkWomanWithOsteoporosisTest() public {
        bool result = medicareContract.checkWomanWithOsteoporosis(true, true);
        Assert.equal(result, true, "The patient should be a woman with osteoporosis who qualifies for the Medicare home health benefit.");
    }

    function checkBoneFractureTest() public {
        bool result = medicareContract.checkBoneFracture(true);
        Assert.equal(result, true, "The patient should have a bone fracture that a doctor certifies is related to post-menopausal osteoporosis.");
    }

    function checkSelfInjectionAbilityTest() public {
        bool result = medicareContract.checkSelfInjectionAbility(false);
        Assert.equal(result, true, "The doctor should certify that the patient is unable to self-administer the injection or learn how to do so.");
    }

    function checkFamilyInjectionAbilityTest() public {
        bool result = medicareContract.checkFamilyInjectionAbility(false);
        Assert.equal(result, true, "Medicare should cover the services of a home health nurse or aide to administer the injection if the patient's family or caregivers are unable or unwilling to do so.");
    }
}