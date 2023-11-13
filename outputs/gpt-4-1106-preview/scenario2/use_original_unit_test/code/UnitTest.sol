// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


// Define a struct to encapsulate IVIG insurance policy parameters
struct IVIGPolicy {
    bool hasPrimaryImmuneDeficiency;
    bool doctorApprovedHomeIVIG;
    bool partBCoverage;
    bool requiresRelatedServices;
}

// The IVIGInsuranceTest will contain all unit tests for the IVIGInsurance contract
contract IVIGInsuranceTest {
    
    IVIGInsurance ivigInsurance; // The instance of the IVIGInsurance contract to be tested

    // Run before every test function
    function beforeEach() public {
        ivigInsurance = new IVIGInsurance();
    }

    /// Test if IVIG is covered for a patient with primary immune deficiency and doctor's approval for home IVIG
    function testCoverageWithPrimaryImmuneDeficiencyAndDoctorApproval(IVIGInsuranceTest) public {
        IVIGPolicy memory policy = IVIGPolicy(true, true, true, false);
        bool isCovered = ivigInsurance.isIVIGCovered(policy.hasPrimaryImmuneDeficiency, policy.doctorApprovedHomeIVIG);
        Assert.equal(isCovered, true, "IVIG should be covered for patients with primary immune deficiency and doctor's approval for home IVIG.");
    }

    /// Test if IVIG is not covered without a primary immune deficiency diagnosis
    function testNoCoverageWithoutPrimaryImmuneDeficiency(IVIGInsuranceTest) public {
        IVIGPolicy memory policy = IVIGPolicy(false, true, true, false);
        bool isCovered = ivigInsurance.isIVIGCovered(policy.hasPrimaryImmuneDeficiency, policy.doctorApprovedHomeIVIG);
        Assert.equal(isCovered, false, "IVIG should not be covered without a primary immune deficiency diagnosis.");
    }

    /// Test if IVIG is not covered without doctor's approval for home IVIG
    function testNoCoverageWithoutDoctorApproval(IVIGInsuranceTest) public {
        IVIGPolicy memory policy = IVIGPolicy(true, false, true, false);
        bool isCovered = ivigInsurance.isIVIGCovered(policy.hasPrimaryImmuneDeficiency, policy.doctorApprovedHomeIVIG);
        Assert.equal(isCovered, false, "IVIG should not be covered without doctor's approval for home IVIG.");
    }

    /// Test if Part B covers the IVIG itself but not related services
    function testPartBCoverageExcludesRelatedServices(IVIGInsuranceTest) public {
        IVIGPolicy memory policy = IVIGPolicy(true, true, true, true);
        bool isIVIGCovered = ivigInsurance.isIVIGCovered(policy.hasPrimaryImmuneDeficiency, policy.doctorApprovedHomeIVIG);
        bool areRelatedServicesCovered = ivigInsurance.areRelatedServicesCovered(policy.requiresRelatedServices);
        Assert.equal(isIVIGCovered, true, "Part B should cover the IVIG itself for eligible patients.");
        Assert.equal(areRelatedServicesCovered, false, "Part B should not pay for other items and services related to getting the IVIG at home.");
    }
}