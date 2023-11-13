pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract YourContractTest {
    YourContract yourContract;

    function beforeEach() public {
        yourContract = new YourContract();
    }

    function womanWithOsteoporosisTest() public {
        bool result = yourContract.checkWomanWithOsteoporosis();
        Assert.isTrue(result, "Failed: Woman with osteoporosis check");
    }

    function meetsMedicareHomeHealthBenefitTest() public {
        bool result = yourContract.checkMeetsMedicareHomeHealthBenefit();
        Assert.isTrue(result, "Failed: Meets Medicare home health benefit check");
    }

    function boneFractureTest() public {
        bool result = yourContract.checkBoneFracture();
        Assert.isTrue(result, "Failed: Bone fracture check");
    }

    function relatedToPostMenopausalOsteoporosisTest() public {
        bool result = yourContract.checkRelatedToPostMenopausalOsteoporosis();
        Assert.isTrue(result, "Failed: Related to post-menopausal osteoporosis check");
    }

    function doctorCertifiesInabilityTest() public {
        bool result = yourContract.checkDoctorCertifiesInability();
        Assert.isTrue(result, "Failed: Doctor certifies inability check");
    }

    function familyOrCaregiversUnableOrUnwillingTest() public {
        bool result = yourContract.checkFamilyOrCaregiversUnableOrUnwilling();
        Assert.isTrue(result, "Failed: Family or caregivers unable or unwilling check");
    }

    function injectableOsteoporosisDrugCoverageTest() public {
        bool result = yourContract.checkInjectableOsteoporosisDrugCoverage();
        Assert.isTrue(result, "Failed: Injectable osteoporosis drug coverage check");
    }
}