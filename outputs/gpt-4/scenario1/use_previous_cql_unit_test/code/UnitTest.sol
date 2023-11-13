pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";

contract MedicareContractTest {
    MedicareContract medicare = MedicareContract(DeployedAddresses.MedicareContract());

    function testCoverageForInjectableOsteoporosisDrugs() public {
        bool result = medicare.isCovered("injectable osteoporosis drugs");
        Assert.equal(result, true, "Injectable osteoporosis drugs should be covered");
    }

    function testCoverageForWomanWithOsteoporosis() public {
        bool result = medicare.isEligible("woman", "osteoporosis", true);
        Assert.equal(result, true, "Woman with osteoporosis who qualifies for the Medicare home health benefit should be covered");
    }

    function testCoverageForBoneFractureRelatedToPostMenopausalOsteoporosis() public {
        bool result = medicare.isFractureCovered("post-menopausal osteoporosis");
        Assert.equal(result, true, "Bone fracture related to post-menopausal osteoporosis should be covered");
    }

    function testCoverageForPatientUnableToSelfAdminister() public {
        bool result = medicare.isSelfAdministerPossible(false);
        Assert.equal(result, true, "Coverage should be applicable if patient is unable to self-administer the injection");
    }

    function testCoverageForHomeHealthNurseOrAide() public {
        bool result = medicare.isHomeHealthNurseOrAideCovered(true);
        Assert.equal(result, true, "Medicare should cover the services of a home health nurse or aide to administer the injection");
    }

    function testCoverageForUnwillingFamilyOrCaregivers() public {
        bool result = medicare.isFamilyOrCaregiverUnwilling(true);
        Assert.equal(result, true, "Medicare should cover the services of a home health nurse or aide if the patient's family or caregivers are unable or unwilling to do so");
    }
}