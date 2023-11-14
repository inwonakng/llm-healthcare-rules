pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract InsurancePolicyTest {
    InsurancePolicy insurancePolicy;

    function beforeEach() public {
        insurancePolicy = new InsurancePolicy();
    }

    function checkPolicyCoverage() public {
        bool result = insurancePolicy.isCovered(
            true, // isWoman
            true, // hasOsteoporosis
            true, // qualifiesForMedicareHomeHealthBenefit
            true, // hasCertifiedFracture
            true  // cannotSelfAdminister
        );
        Assert.equal(result, true, "The policy should cover this case");
    }

    function checkPolicyCoverageWithoutQualificationForMedicare() public {
        bool result = insurancePolicy.isCovered(
            true, // isWoman
            true, // hasOsteoporosis
            false, // qualifiesForMedicareHomeHealthBenefit
            true, // hasCertifiedFracture
            true  // cannotSelfAdminister
        );
        Assert.equal(result, false, "The policy should not cover this case");
    }

    function checkPolicyCoverageWithoutCertifiedFracture() public {
        bool result = insurancePolicy.isCovered(
            true, // isWoman
            true, // hasOsteoporosis
            true, // qualifiesForMedicareHomeHealthBenefit
            false, // hasCertifiedFracture
            true  // cannotSelfAdminister
        );
        Assert.equal(result, false, "The policy should not cover this case");
    }

    function checkPolicyCoverageWithSelfAdministerAbility() public {
        bool result = insurancePolicy.isCovered(
            true, // isWoman
            true, // hasOsteoporosis
            true, // qualifiesForMedicareHomeHealthBenefit
            true, // hasCertifiedFracture
            false  // cannotSelfAdminister
        );
        Assert.equal(result, false, "The policy should not cover this case");
    }

    function checkPolicyCoverageForMan() public {
        bool result = insurancePolicy.isCovered(
            false, // isWoman
            true, // hasOsteoporosis
            true, // qualifiesForMedicareHomeHealthBenefit
            true, // hasCertifiedFracture
            true  // cannotSelfAdminister
        );
        Assert.equal(result, false, "The policy should not cover this case");
    }
}