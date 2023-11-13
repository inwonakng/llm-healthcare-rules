pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract MedicareContractTest {
    MedicareContract medicare = MedicareContract(DeployedAddresses.MedicareContract());

    function testWomanWithOsteoporosis() public {
        bool result = medicare.isWomanWithOsteoporosis("patientId");
        Assert.equal(result, true, "The patient should be a woman with osteoporosis who meets the criteria for the Medicare home health benefit.");
    }

    function testBoneFractureRelatedToOsteoporosis() public {
        bool result = medicare.hasBoneFractureRelatedToOsteoporosis("patientId");
        Assert.equal(result, true, "The patient should have a bone fracture that a doctor certifies was related to post-menopausal osteoporosis.");
    }

    function testUnableToSelfInject() public {
        bool result = medicare.isUnableToSelfInject("patientId");
        Assert.equal(result, true, "The doctor should certify that the patient can't give herself the injection or learn how to give herself the drug by injection.");
    }

    function testCoverHomeHealthNurse() public {
        bool result = medicare.isCoverHomeHealthNurse("patientId");
        Assert.equal(result, true, "Medicare should cover the home health nurse or aide to provide the injection if the patient's family or caregivers are unable or unwilling to give the patient the drug by injection.");
    }
}