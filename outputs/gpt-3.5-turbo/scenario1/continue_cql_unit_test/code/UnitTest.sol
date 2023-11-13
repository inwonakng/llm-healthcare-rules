pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract InjectableOsteoporosisDrugsCoverageTest {
    InjectableOsteoporosisDrugsCoverage coverageContract;

    function beforeEach() public {
        coverageContract = new InjectableOsteoporosisDrugsCoverage();
    }

    function testMeetsCriteriaForHomeHealthBenefit() public {
        bool result = coverageContract.meetsCriteriaForHomeHealthBenefit();
        Assert.isTrue(result, "Patient should meet the criteria for the Medicare home health benefit");
    }

    function testHasPostMenopausalOsteoporosisFracture() public {
        bool result = coverageContract.hasPostMenopausalOsteoporosisFracture();
        Assert.isTrue(result, "Patient should have a bone fracture related to post-menopausal osteoporosis");
    }

    function testUnableToSelfAdministerInjection() public {
        bool result = coverageContract.unableToSelfAdministerInjection();
        Assert.isTrue(result, "Patient should be unable to self-administer the injection or learn how to do it");
    }

    function testFamilyOrCaregiversUnableOrUnwilling() public {
        bool result = coverageContract.familyOrCaregiversUnableOrUnwilling();
        Assert.isTrue(result, "Patient's family or caregivers should be unable or unwilling to give the drug by injection");
    }

    function testCoverage() public {
        bool result = coverageContract.coverage();
        Assert.isTrue(result, "Injectable osteoporosis drugs should be covered under Medicare");
    }
}