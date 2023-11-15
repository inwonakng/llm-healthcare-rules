pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract YourContractTest {
    YourContract yourContract;

    function beforeEach() public {
        yourContract = new YourContract();
    }

    function testCoverTransplantDrugTherapy() public {
        bool result = yourContract.coverTransplantDrugTherapy();
        Assert.isTrue(result, "Transplant drug therapy should be covered");
    }

    function testCoverImmunosuppressiveDrugs() public {
        bool result = yourContract.coverImmunosuppressiveDrugs();
        Assert.isTrue(result, "Immunosuppressive drugs should be covered");
    }

    function testJoinDrugPlan() public {
        bool result = yourContract.joinDrugPlan();
        Assert.isTrue(result, "Should be able to join a Medicare drug plan");
    }

    function testBenefitCoverage() public {
        bool result = yourContract.benefitCoverage();
        Assert.isTrue(result, "Benefit should be available for coverage");
    }

    function testBenefitOnlyDrugs() public {
        bool result = yourContract.benefitOnlyDrugs();
        Assert.isTrue(result, "Benefit should only cover drugs");
    }

    function testBenefitNotSubstitute() public {
        bool result = yourContract.benefitNotSubstitute();
        Assert.isTrue(result, "Benefit should not be a substitute for full health coverage");
    }

    function testSignUpBenefit() public {
        bool result = yourContract.signUpBenefit();
        Assert.isTrue(result, "Should be able to sign up for the benefit");
    }

    function testCallSocialSecurity() public {
        bool result = yourContract.callSocialSecurity();
        Assert.isTrue(result, "Should be able to call Social Security for sign up");
    }

    function testPremium() public {
        uint256 premium = yourContract.getPremium();
        Assert.equal(premium, 9710, "Premium should be 9710");
    }

    function testDeductible() public {
        uint256 deductible = yourContract.getDeductible();
        Assert.equal(deductible, 226, "Deductible should be 226");
    }

    function testPaymentPercentage() public {
        uint256 paymentPercentage = yourContract.getPaymentPercentage();
        Assert.equal(paymentPercentage, 20, "Payment percentage should be 20");
    }
}