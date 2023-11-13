pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract MedicareContractTest {
    MedicareContract medicare;
    
    function beforeEach() public {
        medicare = new MedicareContract();
    }
    
    function checkTransplantDrugCoverage() public {
        medicare.setPartA(true);
        medicare.setPartB(true);
        medicare.setTransplantPaidByMedicare(true);
        Assert.equal(medicare.isTransplantDrugCovered(), true, "Transplant drug should be covered");
    }
    
    function checkImmunosuppressiveDrugCoverageWithPartB() public {
        medicare.setPartB(true);
        Assert.equal(medicare.isImmunosuppressiveDrugCovered(), true, "Immunosuppressive drug should be covered with Part B");
    }
    
    function checkImmunosuppressiveDrugCoverageWithPartD() public {
        medicare.setPartB(false);
        medicare.setPartD(true);
        Assert.equal(medicare.isImmunosuppressiveDrugCovered(), true, "Immunosuppressive drug should be covered with Part D");
    }
    
    function checkCoverageEndAfterKidneyTransplant() public {
        medicare.setESRD(true);
        medicare.setMonthsAfterKidneyTransplant(37);
        Assert.equal(medicare.isImmunosuppressiveDrugCovered(), false, "Coverage should end 36 months after a successful kidney transplant");
    }
    
    function checkImmunosuppressiveDrugBenefit() public {
        medicare.setPartA(false);
        medicare.setOtherHealthCoverage(false);
        Assert.equal(medicare.isImmunosuppressiveDrugBenefitAvailable(), true, "Immunosuppressive drug benefit should be available");
    }
    
    function checkPremiumAndDeductible() public {
        medicare.setSignedUpForImmunosuppressiveDrugBenefit(true);
        Assert.equal(medicare.getMonthlyPremium(), 97.10, "Monthly premium should be $97.10");
        Assert.equal(medicare.getDeductible(), 226, "Deductible should be $226");
    }
    
    function checkPaymentAfterDeductible() public {
        medicare.setSignedUpForImmunosuppressiveDrugBenefit(true);
        medicare.setMedicareApprovedAmount(1000);
        Assert.equal(medicare.getPaymentAfterDeductible(), 200, "Payment after deductible should be 20% of the Medicare-approved amount");
    }
}