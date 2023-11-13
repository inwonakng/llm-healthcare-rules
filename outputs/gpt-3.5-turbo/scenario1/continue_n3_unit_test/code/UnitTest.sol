pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract InsuranceContractTest {
    InsuranceContract insuranceContract;

    function beforeEach() public {
        insuranceContract = new InsuranceContract();
    }

    function testCondition1() public {
        bool result = insuranceContract.checkCondition1();
        Assert.isTrue(result, "Condition 1 should be true");
    }

    function testCondition2() public {
        bool result = insuranceContract.checkCondition2();
        Assert.isTrue(result, "Condition 2 should be true");
    }

    function testCondition3() public {
        bool result = insuranceContract.checkCondition3();
        Assert.isTrue(result, "Condition 3 should be true");
    }

    function testCondition4() public {
        bool result = insuranceContract.checkCondition4();
        Assert.isTrue(result, "Condition 4 should be true");
    }

    function testDecision1() public {
        bool result = insuranceContract.checkDecision1();
        Assert.isTrue(result, "Decision 1 should be true");
    }

    function testDecision2() public {
        bool result = insuranceContract.checkDecision2();
        Assert.isTrue(result, "Decision 2 should be true");
    }
}