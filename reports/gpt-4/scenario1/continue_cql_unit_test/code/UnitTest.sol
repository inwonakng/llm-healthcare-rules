pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract OsteoporosisDrugCoverageTest {
    OsteoporosisDrugCoverage drugCoverage;

    function beforeEach() public {
        drugCoverage = new OsteoporosisDrugCoverage();
    }

    function checkWomanWithOsteoporosis() public {
        Assert.equal(drugCoverage.isWomanWithOsteoporosis('female', true), true, "The patient should be a woman with osteoporosis");
    }

    function checkQualifiesForMedicareHomeHealthBenefit() public {
        Assert.equal(drugCoverage.qualifiesForMedicareHomeHealthBenefit('active'), true, "The patient should qualify for the Medicare home health benefit");
    }

    function checkFractureDueToPostMenopausalOsteoporosis() public {
        Assert.equal(drugCoverage.fractureDueToPostMenopausalOsteoporosis(true), true, "The patient should have a fracture due to post-menopausal osteoporosis");
    }

    function checkUnableToSelfAdminister() public {
        Assert.equal(drugCoverage.unableToSelfAdminister('unable'), true, "The patient should be unable to self-administer the drug");
    }

    function checkFamilyOrCaregiversUnableOrUnwilling() public {
        Assert.equal(drugCoverage.familyOrCaregiversUnableOrUnwilling('unable'), true, "The family or caregivers should be unable or unwilling to administer the drug");
        Assert.equal(drugCoverage.familyOrCaregiversUnableOrUnwilling('unwilling'), true, "The family or caregivers should be unable or unwilling to administer the drug");
    }

    function checkEligibleForCoverage() public {
        Assert.equal(drugCoverage.eligibleForCoverage('female', true, 'active', true, 'unable', 'unable'), true, "The patient should be eligible for coverage");
    }
}