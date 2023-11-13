// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


// Define a struct to encapsulate the parameters for cleaner code
struct IVIGPolicyParameters {
    bool providedInHome;
    bool hasPrimaryImmuneDeficiency;
    bool medicallyAppropriate;
    bool partBCoversIVIG;
    bool partBCoversOtherServices;
}

// Define the test contract
contract IVIGCoverageContractTest {

    IVIGCoverageContract public ivigCoverageContract;

    // Run before every test function
    function beforeEach() public {
        ivigCoverageContract = new IVIGCoverageContract();
    }

    /// Test if IVIG is provided in the patient's home
    function testIVIGProvidedInHome() public {
        IVIGPolicyParameters memory params = IVIGPolicyParameters({
            providedInHome: true,
            hasPrimaryImmuneDeficiency: true,
            medicallyAppropriate: true,
            partBCoversIVIG: true,
            partBCoversOtherServices: false
        });

        bool result = ivigCoverageContract.isCovered(params.providedInHome, params.hasPrimaryImmuneDeficiency, params.medicallyAppropriate);
        Assert.equal(result, true, "IVIG should be covered when provided in home.");
    }

    /// Test if the patient has a diagnosis of primary immune deficiency disease
    function testHasPrimaryImmuneDeficiency() public {
        IVIGPolicyParameters memory params = IVIGPolicyParameters({
            providedInHome: true,
            hasPrimaryImmuneDeficiency: false,
            medicallyAppropriate: true,
            partBCoversIVIG: true,
            partBCoversOtherServices: false
        });

        bool result = ivigCoverageContract.isCovered(params.providedInHome, params.hasPrimaryImmuneDeficiency, params.medicallyAppropriate);
        Assert.equal(result, false, "IVIG should not be covered if the patient does not have primary immune deficiency.");
    }

    /// Test if the patient's doctor determines it is medically appropriate for the patient to receive IVIG at home
    function testMedicallyAppropriateIVIGAtHome() public {
        IVIGPolicyParameters memory params = IVIGPolicyParameters({
            providedInHome: true,
            hasPrimaryImmuneDeficiency: true,
            medicallyAppropriate: false,
            partBCoversIVIG: true,
            partBCoversOtherServices: false
        });

        bool result = ivigCoverageContract.isCovered(params.providedInHome, params.hasPrimaryImmuneDeficiency, params.medicallyAppropriate);
        Assert.equal(result, false, "IVIG should not be covered if it is not medically appropriate to receive it at home.");
    }

    /// Test if Medicare Part B covers the cost of IVIG
    function testPartBCoversIVIG() public {
        IVIGPolicyParameters memory params = IVIGPolicyParameters({
            providedInHome: true,
            hasPrimaryImmuneDeficiency: true,
            medicallyAppropriate: true,
            partBCoversIVIG: false,
            partBCoversOtherServices: false
        });

        bool result = ivigCoverageContract.isCovered(params.providedInHome, params.hasPrimaryImmuneDeficiency, params.medicallyAppropriate);
        Assert.equal(result, false, "IVIG should not be covered if Medicare Part B does not cover IVIG.");
    }

    /// Test if Medicare Part B does not cover the cost of other items and services related to the administration of IVIG at home
    function testPartBDoesNotCoverOtherServices() public {
        IVIGPolicyParameters memory params = IVIGPolicyParameters({
            providedInHome: true,
            hasPrimaryImmuneDeficiency: true,
            medicallyAppropriate: true,
            partBCoversIVIG: true,
            partBCoversOtherServices: true
        });

        bool result = ivigCoverageContract.doesPartBCoverOtherServices();
        Assert.equal(result, false, "Medicare Part B should not cover other items and services related to IVIG administration at home.");
    }
}