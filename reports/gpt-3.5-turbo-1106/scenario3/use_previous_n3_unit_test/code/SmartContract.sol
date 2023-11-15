// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "remix_tests.sol";

// Define a struct to represent the Medicare coverage details
struct MedicareCoverage {
    bool partAAtTransplant;
    bool partBAtDrugTime;
    bool partDCoversDrugs;
    bool originalMedicareJoinPlan;
    bool esrdCoverageEnds;
    bool partALossBenefit;
    uint monthlyPremium;
    uint deductible;
    uint coinsurancePercentage;
}

// The smart contract that will implement the Medicare coverage logic
contract MedicareCoverageContract {
    MedicareCoverage public coverage;

    // Function to set the Medicare coverage details
    function setMedicareCoverage(
        bool _partAAtTransplant,
        bool _partBAtDrugTime,
        bool _partDCoversDrugs,
        bool _originalMedicareJoinPlan,
        bool _esrdCoverageEnds,
        bool _partALossBenefit,
        uint _monthlyPremium,
        uint _deductible,
        uint _coinsurancePercentage
    ) public {
        coverage = MedicareCoverage(
            _partAAtTransplant,
            _partBAtDrugTime,
            _partDCoversDrugs,
            _originalMedicareJoinPlan,
            _esrdCoverageEnds,
            _partALossBenefit,
            _monthlyPremium,
            _deductible,
            _coinsurancePercentage
        );
    }

    // Function to check if Medicare covers transplant drug therapy
    function isTransplantDrugTherapyCovered() public view returns (bool) {
        return coverage.partAAtTransplant;
    }

    // Function to check if Part D covers immunosuppressive drugs
    function isPartDCoveringDrugs() public view returns (bool) {
        return coverage.partDCoversDrugs;
    }

    // Function to check if Medicare offers a benefit if Part A coverage is lost after 36 months of kidney transplant
    function isPartALossBenefitOffered() public view returns (bool) {
        return coverage.partALossBenefit;
    }

    // Function to get the monthly premium for the immunosuppressive drug benefit
    function getMonthlyPremium() public view returns (uint) {
        return coverage.monthlyPremium;
    }

    // Function to get the deductible for the immunosuppressive drug benefit
    function getDeductible() public view returns (uint) {
        return coverage.deductible;
    }

    // Function to get the coinsurance percentage for the immunosuppressive drug benefit
    function getCoinsurancePercentage() public view returns (uint) {
        return coverage.coinsurancePercentage;
    }
}

contract MedicareCoverageContractTest {
    MedicareCoverageContract coverageContract;

    function beforeAll() public {
        coverageContract = new MedicareCoverageContract();
    }

    function testTransplantDrugTherapyCoverage() public {
        coverageContract.setMedicareCoverage(true, false, false, false, false, false, 0, 0, 0);
        Assert.equal(coverageContract.isTransplantDrugTherapyCovered(), true, "Transplant drug therapy should be covered");
    }

    function testPartDCoversDrugs() public {
        coverageContract.setMedicareCoverage(false, false, true, false, false, false, 0, 0, 0);
        Assert.equal(coverageContract.isPartDCoveringDrugs(), true, "Part D should cover immunosuppressive drugs");
    }

    function testPartALossBenefitOffered() public {
        coverageContract.setMedicareCoverage(false, false, false, false, false, true, 0, 0, 0);
        Assert.equal(coverageContract.isPartALossBenefitOffered(), true, "Part A loss benefit should be offered");
    }

    function testMonthlyPremium() public {
        coverageContract.setMedicareCoverage(false, false, false, false, false, false, 9710, 0, 0);
        Assert.equal(coverageContract.getMonthlyPremium(), 9710, "Monthly premium should be 9710");
    }

    function testDeductible() public {
        coverageContract.setMedicareCoverage(false, false, false, false, false, false, 0, 226, 0);
        Assert.equal(coverageContract.getDeductible(), 226, "Deductible should be 226");
    }

    function testCoinsurancePercentage() public {
        coverageContract.setMedicareCoverage(false, false, false, false, false, false, 0, 0, 20);
        Assert.equal(coverageContract.getCoinsurancePercentage(), 20, "Coinsurance percentage should be 20");
    }
}