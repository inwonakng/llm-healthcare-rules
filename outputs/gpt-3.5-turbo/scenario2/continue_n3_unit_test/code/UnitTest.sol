pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract InsuranceContractTest {
    InsuranceContract insuranceContract;

    function beforeEach() public {
        insuranceContract = InsuranceContract(DeployedAddresses.InsuranceContract());
    }

    function testCoverIVIG() public {
        // Set the conditions
        bool hasPrimaryImmuneDeficiencyDisease = true;
        bool isMedicallyAppropriate = true;

        // Call the contract function
        bool result = insuranceContract.checkCoverage(hasPrimaryImmuneDeficiencyDisease, isMedicallyAppropriate);

        // Assert the decision
        Assert.isTrue(result, "IVIG should be covered");
    }

    function testNotCoverIVIG() public {
        // Set the conditions
        bool hasPrimaryImmuneDeficiencyDisease = false;
        bool isMedicallyAppropriate = true;

        // Call the contract function
        bool result = insuranceContract.checkCoverage(hasPrimaryImmuneDeficiencyDisease, isMedicallyAppropriate);

        // Assert the decision
        Assert.isFalse(result, "IVIG should not be covered");
    }

    function testNotCoverRelatedItems() public {
        // Set the conditions
        bool hasPrimaryImmuneDeficiencyDisease = true;
        bool isMedicallyAppropriate = true;

        // Call the contract function
        bool result = insuranceContract.checkCoverage(hasPrimaryImmuneDeficiencyDisease, isMedicallyAppropriate);

        // Assert the decision
        Assert.isFalse(result, "Related items should not be covered");
    }
}