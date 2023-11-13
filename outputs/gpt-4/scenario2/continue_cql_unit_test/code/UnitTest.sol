```
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";

contract IVIGCoverageTest {
    IVIGCoverage ivigCoverage = IVIGCoverage(DeployedAddresses.IVIGCoverage());

    function testPrimaryImmuneDeficiencyDiseaseDiagnosis() public {
        bool diagnosis = ivigCoverage.primaryImmuneDeficiencyDiseaseDiagnosis();
        Assert.equal(diagnosis, true, "Primary Immune Deficiency Disease Diagnosis should be true");
    }

    function testIVIGMedicallyAppropriate() public {
        bool medicallyAppropriate = ivigCoverage.ivigMedicallyAppropriate();
        Assert.equal(medicallyAppropriate, true, "IVIG Medically Appropriate should be true");
    }

    function testIVIGProvidedAtHome() public {
        bool providedAtHome = ivigCoverage.ivigProvidedAtHome();
        Assert.equal(providedAtHome, true, "IVIG Provided at Home should be true");
    }

    function testPartBCoverage() public {
        bool partBCoverage = ivigCoverage.partBCoverage();
        Assert.equal(partBCoverage, true, "Part B Coverage should be true");
    }

    function testFinalCoverageDecision() public {
        string memory decision = ivigCoverage.finalCoverageDecision();
        Assert.equal(decision, "Covered", "Final Coverage Decision should be 'Covered'");
    }
}