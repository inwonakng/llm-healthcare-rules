pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract InsurancePolicyContractTest {
    InsurancePolicyContract insurancePolicyContract;

    function beforeEach() public {
        insurancePolicyContract = new InsurancePolicyContract();
    }

    function coverageForPrimaryImmuneDeficiencyTest() public {
        bool result = insurancePolicyContract.coverageForPrimaryImmuneDeficiency("Primary Immune Deficiency Disease");
        Assert.isTrue(result, "Coverage for primary immune deficiency should be true");
    }

    function ivigInHomeMedicallyAppropriateTest() public {
        bool result = insurancePolicyContract.ivigInHomeMedicallyAppropriate(
            "Intravenous Immune Globulin (IVIG)",
            18,
            block.timestamp,
            block.timestamp + 1 days,
            "General Practice"
        );
        Assert.isTrue(result, "IVIG in home medically appropriate should be true");
    }

    function ivigCoverageByMedicarePartBTest() public {
        bool result = insurancePolicyContract.ivigCoverageByMedicarePartB("Medicare Part B");
        Assert.isTrue(result, "IVIG coverage by Medicare Part B should be true");
    }

    function nonCoveredItemsAndServicesTest() public {
        bool result = insurancePolicyContract.nonCoveredItemsAndServices(
            "Other Items and Services",
            18,
            block.timestamp,
            block.timestamp + 1 days,
            "General Practice"
        );
        Assert.isTrue(result, "Non-covered items and services should be true");
    }

    function finalDecisionTest() public {
        bool result = insurancePolicyContract.finalDecision(
            "Primary Immune Deficiency Disease",
            "Intravenous Immune Globulin (IVIG)",
            18,
            block.timestamp,
            block.timestamp + 1 days,
            "General Practice",
            "Medicare Part B",
            "Other Items and Services"
        );
        Assert.isTrue(result, "Final decision should be true");
    }
}