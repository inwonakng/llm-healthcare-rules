pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract MedicareContractTest {
    MedicareContract medicareContract;

    function beforeEach() public {
        medicareContract = new MedicareContract();
    }

    function checkWomanWithOsteoporosisTest() public {
        bool result = medicareContract.isWomanWithOsteoporosis(true, true);
        Assert.equal(result, true, "The patient is a woman with osteoporosis who qualifies for the Medicare home health benefit.");
    }

    function checkBoneFractureTest() public {
        bool result = medicareContract.hasBoneFracture(true);
        Assert.equal(result, true, "The patient has a bone fracture that a doctor certifies is related to post-menopausal osteoporosis.");
    }

    function checkSelfAdministerTest() public {
        bool result = medicareContract.canSelfAdminister(false);
        Assert.equal(result, false, "The doctor certifies that the patient is unable to self-administer the injection or learn how to do so.");
    }

    function checkFamilyAdministerTest() public {
        bool result = medicareContract.canFamilyAdminister(false);
        Assert.equal(result, false, "Medicare will also cover the services of a home health nurse or aide to administer the injection if the patient's family or caregivers are unable or unwilling to do so.");
    }
}