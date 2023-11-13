pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract InsurancePolicyTest {
    InsurancePolicy insurancePolicy;

    function beforeEach() public {
        insurancePolicy = new InsurancePolicy();
    }

    function checkPolicyCoverage() public {
        // Test case 1: All conditions are met
        Assert.equal(insurancePolicy.isCovered(true, true, true, true), true, "Test Case 1 Failed");

        // Test case 2: Beneficiary is not a woman with osteoporosis who qualifies for the Medicare home health benefit
        Assert.equal(insurancePolicy.isCovered(false, true, true, true), false, "Test Case 2 Failed");

        // Test case 3: Beneficiary does not have a bone fracture that a doctor certifies is related to post-menopausal osteoporosis
        Assert.equal(insurancePolicy.isCovered(true, false, true, true), false, "Test Case 3 Failed");

        // Test case 4: Beneficiary's doctor does not certify that she cannot self-administer the injection or learn how to do so
        Assert.equal(insurancePolicy.isCovered(true, true, false, true), false, "Test Case 4 Failed");

        // Test case 5: Beneficiary's family or caregivers are able and willing to administer the drug by injection
        Assert.equal(insurancePolicy.isCovered(true, true, true, false), false, "Test Case 5 Failed");
    }

    function checkHomeHealthNurseCoverage() public {
        // Test case 1: Beneficiary's family or caregivers are unable or unwilling to administer the drug by injection
        Assert.equal(insurancePolicy.isNurseCovered(true), true, "Test Case 1 Failed");

        // Test case 2: Beneficiary's family or caregivers are able and willing to administer the drug by injection
        Assert.equal(insurancePolicy.isNurseCovered(false), false, "Test Case 2 Failed");
    }
}