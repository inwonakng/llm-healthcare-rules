// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


// Define the smart contract
contract MedicareCoverage {
    
    // Struct to represent the IVIG coverage details
    struct IVIGCoverage {
        bool isCovered;
        bool isMedicallyAppropriate;
    }
    
    IVIGCoverage public ivigCoverage;

    // Function to check if IVIG is covered by Medicare
    function checkIVIGCoverage(bool _hasPrimaryImmuneDeficiency, bool _isMedicallyAppropriate) public {
        if (_hasPrimaryImmuneDeficiency && _isMedicallyAppropriate) {
            ivigCoverage.isCovered = true;
            ivigCoverage.isMedicallyAppropriate = true;
        } else {
            ivigCoverage.isCovered = false;
            ivigCoverage.isMedicallyAppropriate = false;
        }
    }
}

contract MedicareCoverageTest {
    MedicareCoverage medCoverage;
    
    function beforeAll() public {
        medCoverage = new MedicareCoverage();
    }
    
    function testIVIGCoverage() public {
        medCoverage.checkIVIGCoverage(true, true);
        Assert.equal(medCoverage.ivigCoverage.isCovered, true, "IVIG should be covered");
        Assert.equal(medCoverage.ivigCoverage.isMedicallyAppropriate, true, "IVIG should be medically appropriate");
    }
    
    function testIVIGNotCovered() public {
        medCoverage.checkIVIGCoverage(false, true);
        Assert.equal(medCoverage.ivigCoverage.isCovered, false, "IVIG should not be covered");
        Assert.equal(medCoverage.ivigCoverage.isMedicallyAppropriate, false, "IVIG should not be medically appropriate");
    }
}