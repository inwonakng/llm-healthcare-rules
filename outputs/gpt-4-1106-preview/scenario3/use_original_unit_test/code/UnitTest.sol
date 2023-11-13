// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


// Define a struct to encapsulate policy parameters for cleaner code
struct PolicyParameters {
    bool hasPartA;
    bool hasPartB;
    bool hasPartD;
    bool hadTransplantCoveredByMedicare;
    bool hasESRD;
    uint monthsAfterKidneyTransplant;
    uint drugCost;
}

// Define a struct to encapsulate benefit parameters
struct BenefitParameters {
    uint monthlyPremium;
    uint deductible;
    uint medicareApprovedAmount;
}

// Define the test contract
contract MedicareContractTest {
    
    // Test if transplant drug therapy is covered
    function testTransplantDrugTherapyCoverage() public {
        PolicyParameters memory policy = PolicyParameters(true, true, false, true, false, 0, 1000);
        MedicareContract medicare = new MedicareContract();
        bool isCovered = medicare.checkTransplantDrugTherapyCoverage(policy.hasPartA, policy.hasPartB, policy.hadTransplantCoveredByMedicare);
        Assert.equal(isCovered, true, "Transplant drug therapy should be covered");
    }
    
    // Test if Part D covers immunosuppressive drugs when Part B doesn’t
    function testPartDCoverage() public {
        PolicyParameters memory policy = PolicyParameters(false, false, true, true, false, 0, 1000);
        MedicareContract medicare = new MedicareContract();
        bool isCovered = medicare.checkPartDCoverage(policy.hasPartD, policy.hasPartB);
        Assert.equal(isCovered, true, "Part D should cover immunosuppressive drugs when Part B doesn’t");
    }
    
    // Test if Medicare coverage ends 36 months after a successful kidney transplant
    function testMedicareCoverageEndAfterKidneyTransplant() public {
        PolicyParameters memory policy = PolicyParameters(true, true, true, true, true, 36, 1000);
        MedicareContract medicare = new MedicareContract();
        bool hasCoverage = medicare.checkMedicareCoverageEnd(policy.hasESRD, policy.monthsAfterKidneyTransplant);
        Assert.equal(hasCoverage, false, "Medicare coverage should end 36 months after a successful kidney transplant");
    }
    
    // Test the immunosuppressive drug benefit eligibility
    function testImmunosuppressiveDrugBenefitEligibility() public {
        PolicyParameters memory policy = PolicyParameters(false, false, false, true, true, 37, 1000);
        MedicareContract medicare = new MedicareContract();
        bool isEligible = medicare.checkImmunosuppressiveDrugBenefitEligibility(policy.hasPartA, policy.hasESRD, policy.monthsAfterKidneyTransplant);
        Assert.equal(isEligible, true, "Should be eligible for the immunosuppressive drug benefit");
    }
    
    // Test the immunosuppressive drug benefit costs
    function testImmunosuppressiveDrugBenefitCosts() public {
        BenefitParameters memory benefit = BenefitParameters(97.10 ether, 226 ether, 1000 ether);
        PolicyParameters memory policy = PolicyParameters(false, false, false, true, true, 37, benefit.medicareApprovedAmount);
        MedicareContract medicare = new MedicareContract();
        (uint monthlyPremium, uint deductible, uint coinsurance) = medicare.calculateImmunosuppressiveDrugBenefitCosts(benefit.monthlyPremium, benefit.deductible, policy.drugCost, benefit.medicareApprovedAmount);
        
        Assert.equal(monthlyPremium, benefit.monthlyPremium, "Monthly premium should be $97.10");
        Assert.equal(deductible, benefit.deductible, "Deductible should be $226");
        Assert.equal(coinsurance, policy.drugCost * 20 / 100, "Coinsurance should be 20% of the Medicare-approved amount");
    }
}