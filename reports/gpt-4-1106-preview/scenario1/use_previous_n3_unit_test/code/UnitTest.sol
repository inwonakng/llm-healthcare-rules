// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract MedicareContractTest {
    
    // Define a struct to encapsulate the insured's information for cleaner code
    struct InsuredInfo {
        bool isWoman;
        bool diagnosedWithOsteoporosis;
        bool meetsHomeHealthCriteria;
        bool hasCertifiedFracture;
        bool unableToSelfAdminister;
        bool familyUnableToAdminister;
        bool familyUnwillingToAdminister;
    }

    // Create a dummy instance of the MedicareContract to interact with
    MedicareContract medicareContract;

    // Run before every test function
    function beforeEach() public {
        medicareContract = new MedicareContract();
    }

    /// Test if a woman with osteoporosis who meets all criteria is covered
    function testCoverageForEligibleWomanMedicareContractTest() public {
        InsuredInfo memory insured = InsuredInfo({
            isWoman: true,
            diagnosedWithOsteoporosis: true,
            meetsHomeHealthCriteria: true,
            hasCertifiedFracture: true,
            unableToSelfAdminister: true,
            familyUnableToAdminister: false, // Not relevant for this test
            familyUnwillingToAdminister: false // Not relevant for this test
        });

        bool isCovered = medicareContract.isCovered(insured.isWoman, insured.diagnosedWithOsteoporosis, insured.meetsHomeHealthCriteria, insured.hasCertifiedFracture, insured.unableToSelfAdminister);
        Assert.equal(isCovered, true, "Eligible woman should be covered");
    }

    /// Test if a man with osteoporosis is not covered
    function testCoverageForManMedicareContractTest() public {
        InsuredInfo memory insured = InsuredInfo({
            isWoman: false, // Man
            diagnosedWithOsteoporosis: true,
            meetsHomeHealthCriteria: true,
            hasCertifiedFracture: true,
            unableToSelfAdminister: true,
            familyUnableToAdminister: true,
            familyUnwillingToAdminister: true
        });

        bool isCovered = medicareContract.isCovered(insured.isWoman, insured.diagnosedWithOsteoporosis, insured.meetsHomeHealthCriteria, insured.hasCertifiedFracture, insured.unableToSelfAdminister);
        Assert.equal(isCovered, false, "Man should not be covered");
    }

    /// Test if a woman without a certified fracture is not covered
    function testCoverageWithoutCertifiedFractureMedicareContractTest() public {
        InsuredInfo memory insured = InsuredInfo({
            isWoman: true,
            diagnosedWithOsteoporosis: true,
            meetsHomeHealthCriteria: true,
            hasCertifiedFracture: false, // No certified fracture
            unableToSelfAdminister: true,
            familyUnableToAdminister: true,
            familyUnwillingToAdminister: true
        });

        bool isCovered = medicareContract.isCovered(insured.isWoman, insured.diagnosedWithOsteoporosis, insured.meetsHomeHealthCriteria, insured.hasCertifiedFracture, insured.unableToSelfAdminister);
        Assert.equal(isCovered, false, "Woman without certified fracture should not be covered");
    }

    /// Test if a woman who can self-administer is not covered
    function testCoverageForSelfAdministeringWomanMedicareContractTest() public {
        InsuredInfo memory insured = InsuredInfo({
            isWoman: true,
            diagnosedWithOsteoporosis: true,
            meetsHomeHealthCriteria: true,
            hasCertifiedFracture: true,
            unableToSelfAdminister: false, // Can self-administer
            familyUnableToAdminister: true,
            familyUnwillingToAdminister: true
        });

        bool isCovered = medicareContract.isCovered(insured.isWoman, insured.diagnosedWithOsteoporosis, insured.meetsHomeHealthCriteria, insured.hasCertifiedFracture, insured.unableToSelfAdminister);
        Assert.equal(isCovered, false, "Woman who can self-administer should not be covered");
    }

    /// Test if a woman is covered when family is unable to administer
    function testCoverageWhenFamilyUnableToAdministerMedicareContractTest() public {
        InsuredInfo memory insured = InsuredInfo({
            isWoman: true,
            diagnosedWithOsteoporosis: true,
            meetsHomeHealthCriteria: true,
            hasCertifiedFracture: true,
            unableToSelfAdminister: true,
            familyUnableToAdminister: true, // Family unable to administer
            familyUnwillingToAdminister: false
        });

        bool isCoveredForNurse = medicareContract.isCoveredForNurse(insured.familyUnableToAdminister, insured.familyUnwillingToAdminister);
        Assert.equal(isCoveredForNurse, true, "Woman should be covered for nurse when family is unable to administer");
    }

    /// Test if a woman is covered when family is unwilling to administer
    function testCoverageWhenFamilyUnwillingToAdministerMedicareContractTest() public {
        InsuredInfo memory insured = InsuredInfo({
            isWoman: true,
            diagnosedWithOsteoporosis: true,
            meetsHomeHealthCriteria: true,
            hasCertifiedFracture: true,
            unableToSelfAdminister: true,
            familyUnableToAdminister: false,
            familyUnwillingToAdminister: true // Family unwilling to administer
        });

        bool isCoveredForNurse = medicareContract.isCoveredForNurse(insured.familyUnableToAdminister, insured.familyUnwillingToAdminister);
        Assert.equal(isCoveredForNurse, true, "Woman should be covered for nurse when family is unwilling to administer");
    }

    /// Test if a woman is not covered for a nurse when family can and is willing to administer
    function testNoCoverageForNurseWhenFamilyCanAndWillingMedicareContractTest() public {
        InsuredInfo memory insured = InsuredInfo({
            isWoman: true,
            diagnosedWithOsteoporosis: true,
            meetsHomeHealthCriteria: true,
            hasCertifiedFracture: true,
            unableToSelfAdminister: true,
            familyUnableToAdminister: false, // Family able to administer
            familyUnwillingToAdminister: false // Family willing to administer
        });

        bool isCoveredForNurse = medicareContract.isCoveredForNurse(insured.familyUnableToAdminister, insured.familyUnwillingToAdminister);
        Assert.equal(isCoveredForNurse, false, "Woman should not be covered for nurse when family can and is willing to administer");
    }
}