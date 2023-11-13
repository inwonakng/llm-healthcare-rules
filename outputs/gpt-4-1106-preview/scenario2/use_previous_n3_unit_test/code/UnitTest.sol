// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


// Define a struct to encapsulate the parameters for cleaner code
struct IVIGCoverageParams {
    bool providedInHome;
    bool hasPrimaryImmuneDeficiency;
    bool medicallyAppropriate;
    bool partBCoversIVIG;
    bool partBCoversOtherServices;
}

contract IVIGCoverageContractTest {
    IVIGCoverageContract ivigCoverageContract;

    // Run before every test function
    function beforeEach() public {
        ivigCoverageContract = new IVIGCoverageContract();
    }

    /// Test if IVIG is provided in the patient's home
    function testProvidedInHomeIVIGCoverageContractTest() public {
        IVIGCoverageParams memory params = IVIGCoverageParams({
            providedInHome: true,
            hasPrimaryImmuneDeficiency: true,
            medicallyAppropriate: true,
            partBCoversIVIG: true,
            partBCoversOtherServices: false
        });

        bool isCovered = ivigCoverageContract.isIVIGCovered(params.providedInHome, params.hasPrimaryImmuneDeficiency, params.medicallyAppropriate);
        Assert.equal(isCovered, true, "IVIG should be covered when provided in home.");
    }

    /// Test if patient has a diagnosis of primary immune deficiency disease
    function testHasPrimaryImmuneDeficiencyIVIGCoverageContractTest() public {
        IVIGCoverageParams memory params = IVIGCoverageParams({
            providedInHome: true,
            hasPrimaryImmuneDeficiency: false,
            medicallyAppropriate: true,
            partBCoversIVIG: true,
            partBCoversOtherServices: false
        });

        bool isCovered = ivigCoverageContract.isIVIGCovered(params.providedInHome, params.hasPrimaryImmuneDeficiency, params.medicallyAppropriate);
        Assert.equal(isCovered, false, "IVIG should not be covered without a primary immune deficiency diagnosis.");
    }

    /// Test if doctor determines receiving IVIG at home is medically appropriate
    function testMedicallyAppropriateIVIGCoverageContractTest() public {
        IVIGCoverageParams memory params = IVIGCoverageParams({
            providedInHome: true,
            hasPrimaryImmuneDeficiency: true,
            medicallyAppropriate: false,
            partBCoversIVIG: true,
            partBCoversOtherServices: false
        });

        bool isCovered = ivigCoverageContract.isIVIGCovered(params.providedInHome, params.hasPrimaryImmuneDeficiency, params.medicallyAppropriate);
        Assert.equal(isCovered, false, "IVIG should not be covered if not medically appropriate to receive at home.");
    }

    /// Test if Medicare Part B covers the cost of IVIG
    function testPartBCoversIVIGIVIGCoverageContractTest() public {
        IVIGCoverageParams memory params = IVIGCoverageParams({
            providedInHome: true,
            hasPrimaryImmuneDeficiency: true,
            medicallyAppropriate: true,
            partBCoversIVIG: false,
            partBCoversOtherServices: false
        });

        bool isCovered = ivigCoverageContract.isIVIGCovered(params.providedInHome, params.hasPrimaryImmuneDeficiency, params.medicallyAppropriate);
        Assert.equal(isCovered, false, "IVIG should not be covered if Part B does not cover IVIG.");
    }

    /// Test if Medicare Part B does not cover the cost of other items and services
    function testPartBDoesNotCoverOtherServicesIVIGCoverageContractTest() public {
        IVIGCoverageParams memory params = IVIGCoverageParams({
            providedInHome: true,
            hasPrimaryImmuneDeficiency: true,
            medicallyAppropriate: true,
            partBCoversIVIG: true,
            partBCoversOtherServices: true
        });

        bool isCovered = ivigCoverageContract.isIVIGCovered(params.providedInHome, params.hasPrimaryImmuneDeficiency, params.medicallyAppropriate);
        Assert.equal(isCovered, true, "IVIG should be covered even if Part B does not cover other services.");
    }
}