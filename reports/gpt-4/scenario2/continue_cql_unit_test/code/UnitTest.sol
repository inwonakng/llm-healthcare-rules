pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract InsurancePolicyTest {
    InsurancePolicy insurancePolicy;
    
    function beforeEach() public {
        insurancePolicy = new InsurancePolicy();
    }
    
    function checkPrimaryImmuneDeficiencyDiseaseDiagnosis() public {
        bool result = insurancePolicy.checkPrimaryImmuneDeficiencyDiseaseDiagnosis();
        Assert.equal(result, true, "The patient should have a primary immune deficiency disease diagnosis");
    }
    
    function checkIVIGMedicallyAppropriate() public {
        bool result = insurancePolicy.checkIVIGMedicallyAppropriate();
        Assert.equal(result, true, "It should be medically appropriate for the patient to get IVIG");
    }
    
    function checkIVIGProvidedAtHome() public {
        bool result = insurancePolicy.checkIVIGProvidedAtHome();
        Assert.equal(result, true, "IVIG should be provided at home");
    }
    
    function checkPartBCoverage() public {
        bool result = insurancePolicy.checkPartBCoverage();
        Assert.equal(result, true, "The policy under Part B should cover the cost of the IVIG");
    }
    
    function checkFinalCoverageDecision() public {
        string memory result = insurancePolicy.checkFinalCoverageDecision();
        Assert.equal(result, "Covered", "The final coverage decision should be 'Covered'");
    }
}