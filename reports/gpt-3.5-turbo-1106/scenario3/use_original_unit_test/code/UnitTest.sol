// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


// Define a struct to represent the Medicare coverage details
struct MedicareCoverage {
    bool hasPartA;
    bool hasPartB;
    bool hasPartD;
    bool hasOriginalMedicare;
    bool hasESRD;
    bool hasOtherHealthCoverage;
    bool hasLostPartAAfter36Months;
    bool hasSignedUpForBenefit;
    uint monthlyPremium;
    uint deductible;
    uint coinsurancePercentage;
}

// Define the contract that will implement the Medicare coverage logic
contract MedicareCoverageContract {
    // Function to check if the patient is eligible for immunosuppressive drug coverage
    function isEligibleForImmunosuppressiveDrugCoverage(MedicareCoverage memory coverage) public pure returns (bool) {
        if (coverage.hasPartA && coverage.hasPartB) {
            if (coverage.hasOriginalMedicare) {
                if (coverage.hasESRD) {
                    if (coverage.hasLostPartAAfter36Months && !coverage.hasOtherHealthCoverage) {
                        return true;
                    }
                } else {
                    return true;
                }
            } else if (coverage.hasPartD) {
                return true;
            }
        }
        return false;
    }

    // Function to calculate the cost of immunosuppressive drugs
    function calculateDrugCost(MedicareCoverage memory coverage, uint drugCost) public pure returns (uint) {
        if (isEligibleForImmunosuppressiveDrugCoverage(coverage)) {
            if (drugCost > coverage.deductible) {
                return coverage.deductible + ((drugCost - coverage.deductible) * coverage.coinsurancePercentage / 100);
            } else {
                return drugCost;
            }
        } else {
            return drugCost;
        }
    }
}

// Test the MedicareCoverageContract
contract MedicareCoverageContractTest {
    MedicareCoverageContract coverageContract;

    function beforeAll() public {
        coverageContract = new MedicareCoverageContract();
    }

    function testEligibleForImmunosuppressiveDrugCoverage() public {
        MedicareCoverage memory coverage1 = MedicareCoverage(true, true, true, true, false, false, false, false, 97, 226, 20);
        MedicareCoverage memory coverage2 = MedicareCoverage(true, true, false, true, true, false, true, true, 97, 226, 20);
        MedicareCoverage memory coverage3 = MedicareCoverage(true, true, false, false, true, true, false, false, 97, 226, 20);

        Assert.equal(coverageContract.isEligibleForImmunosuppressiveDrugCoverage(coverage1), true, "Coverage1 should be eligible");
        Assert.equal(coverageContract.isEligibleForImmunosuppressiveDrugCoverage(coverage2), true, "Coverage2 should be eligible");
        Assert.equal(coverageContract.isEligibleForImmunosuppressiveDrugCoverage(coverage3), true, "Coverage3 should be eligible");
    }

    function testNotEligibleForImmunosuppressiveDrugCoverage() public {
        MedicareCoverage memory coverage1 = MedicareCoverage(false, true, true, true, false, false, false, false, 97, 226, 20);
        MedicareCoverage memory coverage2 = MedicareCoverage(true, false, false, false, true, true, false, false, 97, 226, 20);

        Assert.equal(coverageContract.isEligibleForImmunosuppressiveDrugCoverage(coverage1), false, "Coverage1 should not be eligible");
        Assert.equal(coverageContract.isEligibleForImmunosuppressiveDrugCoverage(coverage2), false, "Coverage2 should not be eligible");
    }

    function testCalculateDrugCost() public {
        MedicareCoverage memory coverage1 = MedicareCoverage(true, true, true, true, false, false, false, false, 97, 226, 20);
        uint drugCost1 = 500;
        uint expectedCost1 = 226 + ((500 - 226) * 20 / 100);

        MedicareCoverage memory coverage2 = MedicareCoverage(true, true, false, true, true, false, true, true, 97, 226, 20);
        uint drugCost2 = 150;
        uint expectedCost2 = 150;

        Assert.equal(coverageContract.calculateDrugCost(coverage1, drugCost1), expectedCost1, "Cost calculation for coverage1 is incorrect");
        Assert.equal(coverageContract.calculateDrugCost(coverage2, drugCost2), expectedCost2, "Cost calculation for coverage2 is incorrect");
    }
}