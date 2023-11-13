pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract MedicareContractTest {
    MedicareContract medicareContract = new MedicareContract();

    function testCoverageForInjectableOsteoporosisDrugs() public {
        bool result = medicareContract.isCovered("Injectable Osteoporosis Drugs");
        Assert.equal(result, true, "Injectable Osteoporosis Drugs should be covered");
    }

    function testCoverageForWomanWithOsteoporosis() public {
        bool result = medicareContract.isEligible("Woman", "Osteoporosis");
        Assert.equal(result, true, "Woman with Osteoporosis should be eligible");
    }

    function testCoverageForBoneFractureRelatedToPostMenopausalOsteoporosis() public {
        bool result = medicareContract.isFractureRelatedToPostMenopausalOsteoporosis(true);
        Assert.equal(result, true, "Bone fracture related to post-menopausal osteoporosis should be covered");
    }

    function testCoverageForPatientUnableToSelfAdminister() public {
        bool result = medicareContract.isPatientUnableToSelfAdminister(true);
        Assert.equal(result, true, "Patient unable to self-administer should be covered");
    }

    function testCoverageForHomeHealthNurseOrAide() public {
        bool result = medicareContract.isHomeHealthNurseOrAideCovered(true);
        Assert.equal(result, true, "Home health nurse or aide should be covered if family or caregivers are unable or unwilling to administer the drug by injection");
    }
}