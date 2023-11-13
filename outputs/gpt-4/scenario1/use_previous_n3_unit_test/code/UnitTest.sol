pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";

contract MedicareContractTest {
    MedicareContract medicareContract = new MedicareContract();

    // Test for condition 2
    function testWomanWithOsteoporosisQualifiesForMedicare() public {
        bool result = medicareContract.checkEligibility(true, true);
        Assert.equal(result, true, "Woman with osteoporosis who qualifies for the Medicare home health benefit should be eligible");
    }

    // Test for condition 3
    function testBoneFractureRelatedToPostMenopausalOsteoporosis() public {
        bool result = medicareContract.checkBoneFracture(true);
        Assert.equal(result, true, "Patient with a bone fracture related to post-menopausal osteoporosis should be eligible");
    }

    // Test for condition 4
    function testPatientUnableToSelfAdminister() public {
        bool result = medicareContract.checkSelfAdministerAbility(false);
        Assert.equal(result, true, "Patient unable to self-administer the injection should be eligible");
    }

    // Test for condition 5
    function testMedicareCoversHomeHealthNurse() public {
        bool result = medicareContract.checkHomeHealthNurseCoverage(true, false);
        Assert.equal(result, true, "Medicare should cover the services of a home health nurse if the patient's family or caregivers are unable or unwilling to do so");
    }
}