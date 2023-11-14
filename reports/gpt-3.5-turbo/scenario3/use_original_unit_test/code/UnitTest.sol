pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract InsuranceContractTest {
    InsuranceContract insuranceContract;

    function beforeEach() public {
        insuranceContract = new InsuranceContract();
    }

    function testMedicareCoverage() public {
        bool hasPartA = true;
        bool hasPartB = true;
        bool hasPartD = false;
        bool hasOriginalMedicare = true;
        bool hasESRD = false;
        bool hasGroupHealthPlan = false;
        bool hasTRICARE = false;
        bool hasMedicaid = false;
        bool hasImmunosuppressiveDrugCoverage = false;

        bool result = insuranceContract.isMedicareCoverageEligible(
            hasPartA,
            hasPartB,
            hasPartD,
            hasOriginalMedicare,
            hasESRD,
            hasGroupHealthPlan,
            hasTRICARE,
            hasMedicaid,
            hasImmunosuppressiveDrugCoverage
        );

        Assert.isTrue(result, "Medicare coverage should be eligible");
    }

    function testMedicareCoverageESRD() public {
        bool hasPartA = true;
        bool hasPartB = true;
        bool hasPartD = false;
        bool hasOriginalMedicare = true;
        bool hasESRD = true;
        bool hasGroupHealthPlan = false;
        bool hasTRICARE = false;
        bool hasMedicaid = false;
        bool hasImmunosuppressiveDrugCoverage = false;

        bool result = insuranceContract.isMedicareCoverageEligible(
            hasPartA,
            hasPartB,
            hasPartD,
            hasOriginalMedicare,
            hasESRD,
            hasGroupHealthPlan,
            hasTRICARE,
            hasMedicaid,
            hasImmunosuppressiveDrugCoverage
        );

        Assert.isFalse(result, "Medicare coverage should not be eligible for ESRD");
    }

    function testMedicareCoverageGroupHealthPlan() public {
        bool hasPartA = true;
        bool hasPartB = true;
        bool hasPartD = false;
        bool hasOriginalMedicare = true;
        bool hasESRD = false;
        bool hasGroupHealthPlan = true;
        bool hasTRICARE = false;
        bool hasMedicaid = false;
        bool hasImmunosuppressiveDrugCoverage = false;

        bool result = insuranceContract.isMedicareCoverageEligible(
            hasPartA,
            hasPartB,
            hasPartD,
            hasOriginalMedicare,
            hasESRD,
            hasGroupHealthPlan,
            hasTRICARE,
            hasMedicaid,
            hasImmunosuppressiveDrugCoverage
        );

        Assert.isFalse(result, "Medicare coverage should not be eligible with group health plan");
    }

    function testMedicareCoverageTRICARE() public {
        bool hasPartA = true;
        bool hasPartB = true;
        bool hasPartD = false;
        bool hasOriginalMedicare = true;
        bool hasESRD = false;
        bool hasGroupHealthPlan = false;
        bool hasTRICARE = true;
        bool hasMedicaid = false;
        bool hasImmunosuppressiveDrugCoverage = false;

        bool result = insuranceContract.isMedicareCoverageEligible(
            hasPartA,
            hasPartB,
            hasPartD,
            hasOriginalMedicare,
            hasESRD,
            hasGroupHealthPlan,
            hasTRICARE,
            hasMedicaid,
            hasImmunosuppressiveDrugCoverage
        );

        Assert.isFalse(result, "Medicare coverage should not be eligible with TRICARE");
    }

    function testMedicareCoverageMedicaid() public {
        bool hasPartA = true;
        bool hasPartB = true;
        bool hasPartD = false;
        bool hasOriginalMedicare = true;
        bool hasESRD = false;
        bool hasGroupHealthPlan = false;
        bool hasTRICARE = false;
        bool hasMedicaid = true;
        bool hasImmunosuppressiveDrugCoverage = false;

        bool result = insuranceContract.isMedicareCoverageEligible(
            hasPartA,
            hasPartB,
            hasPartD,
            hasOriginalMedicare,
            hasESRD,
            hasGroupHealthPlan,
            hasTRICARE,
            hasMedicaid,
            hasImmunosuppressiveDrugCoverage
        );

        Assert.isFalse(result, "Medicare coverage should not be eligible with Medicaid");
    }

    function testImmunosuppressiveDrugBenefit() public {
        uint256 currentYear = 2023;
        uint256 monthlyPremium = 9710;
        uint256 deductible = 226;
        uint256 coinsurancePercentage = 20;

        insuranceContract.setImmunosuppressiveDrugBenefit(
            currentYear,
            monthlyPremium,
            deductible,
            coinsurancePercentage
        );

        uint256 resultPremium = insuranceContract.getImmunosuppressiveDrugPremium();
        uint256 resultDeductible = insuranceContract.getImmunosuppressiveDrugDeductible();
        uint256 resultCoinsurancePercentage = insuranceContract.getImmunosuppressiveDrugCoinsurancePercentage();

        Assert.equal(resultPremium, monthlyPremium, "Premium should match");
        Assert.equal(resultDeductible, deductible, "Deductible should match");
        Assert.equal(resultCoinsurancePercentage, coinsurancePercentage, "Coinsurance percentage should match");
    }
}