// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract OsteoporosisDrugCoverageContractTest {
    OsteoporosisDrugCoverageContract coverageContract;

    // Create a new instance of the contract before each test
    function beforeEach() public {
        coverageContract = new OsteoporosisDrugCoverageContract();
    }

    // Test for a woman with osteoporosis who meets the criteria for the Medicare home health benefit
    function testEligibleWomanWithMedicareHomeHealthBenefit() public {
        bool isWoman = true;
        bool hasOsteoporosis = true;
        bool meetsMedicareHomeHealthCriteria = true;
        bool hasCertifiedFracture = true;
        bool unableToSelfInject = true;
        bool familyUnableToInject = true;

        bool result = coverageContract.isEligibleForCoverage(
            isWoman,
            hasOsteoporosis,
            meetsMedicareHomeHealthCriteria,
            hasCertifiedFracture,
            unableToSelfInject,
            familyUnableToInject
        );

        Assert.equal(result, true, "Eligible woman should be covered.");
    }

    // Test for a man with osteoporosis (should not be covered)
    function testIneligibleManWithOsteoporosis() public {
        bool isWoman = false;
        bool hasOsteoporosis = true;
        bool meetsMedicareHomeHealthCriteria = true;
        bool hasCertifiedFracture = true;
        bool unableToSelfInject = true;
        bool familyUnableToInject = true;

        bool result = coverageContract.isEligibleForCoverage(
            isWoman,
            hasOsteoporosis,
            meetsMedicareHomeHealthCriteria,
            hasCertifiedFracture,
            unableToSelfInject,
            familyUnableToInject
        );

        Assert.equal(result, false, "Men should not be covered.");
    }

    // Test for a woman without a certified fracture related to post-menopausal osteoporosis
    function testWomanWithoutCertifiedFracture() public {
        bool isWoman = true;
        bool hasOsteoporosis = true;
        bool meetsMedicareHomeHealthCriteria = true;
        bool hasCertifiedFracture = false;
        bool unableToSelfInject = true;
        bool familyUnableToInject = true;

        bool result = coverageContract.isEligibleForCoverage(
            isWoman,
            hasOsteoporosis,
            meetsMedicareHomeHealthCriteria,
            hasCertifiedFracture,
            unableToSelfInject,
            familyUnableToInject
        );

        Assert.equal(result, false, "Woman without certified fracture should not be covered.");
    }

    // Test for a woman who can self-inject
    function testWomanAbleToSelfInject() public {
        bool isWoman = true;
        bool hasOsteoporosis = true;
        bool meetsMedicareHomeHealthCriteria = true;
        bool hasCertifiedFracture = true;
        bool unableToSelfInject = false;
        bool familyUnableToInject = true;

        bool result = coverageContract.isEligibleForCoverage(
            isWoman,
            hasOsteoporosis,
            meetsMedicareHomeHealthCriteria,
            hasCertifiedFracture,
            unableToSelfInject,
            familyUnableToInject
        );

        Assert.equal(result, false, "Woman able to self-inject should not be covered.");
    }

    // Test for a woman with family or caregivers willing and able to give the injection
    function testWomanWithAbleFamily() public {
        bool isWoman = true;
        bool hasOsteoporosis = true;
        bool meetsMedicareHomeHealthCriteria = true;
        bool hasCertifiedFracture = true;
        bool unableToSelfInject = true;
        bool familyUnableToInject = false;

        bool result = coverageContract.isEligibleForCoverage(
            isWoman,
            hasOsteoporosis,
            meetsMedicareHomeHealthCriteria,
            hasCertifiedFracture,
            unableToSelfInject,
            familyUnableToInject
        );

        Assert.equal(result, false, "Woman with able family should not be covered.");
    }
}