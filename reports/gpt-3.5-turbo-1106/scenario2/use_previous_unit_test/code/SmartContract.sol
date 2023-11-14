// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "remix_tests.sol";

// Smart contract for testing insurance coverage for IVIG
contract InsuranceCoverage {
    
    struct Patient {
        bool hasPrimaryImmuneDeficiency; // Whether the patient has a diagnosis of primary immune deficiency disease
        bool isMedicallyAppropriate; // Whether it is medically appropriate for the patient to receive IVIG in their home
    }
    
    // Function to check if Medicare covers IVIG for a patient
    function checkMedicareCoverageForIVIG(bool _hasPrimaryImmuneDeficiency, bool _isMedicallyAppropriate) public pure returns (string memory) {
        Patient memory patient = Patient(_hasPrimaryImmuneDeficiency, _isMedicallyAppropriate);
        
        if (patient.hasPrimaryImmuneDeficiency && patient.isMedicallyAppropriate) {
            return "Medicare covers IVIG for the patient.";
        } else {
            return "Medicare does not cover IVIG for the patient.";
        }
    }
    
    // Function to check if Medicare Part B covers the cost of IVIG
    function checkMedicarePartBCoverage(bool _hasPrimaryImmuneDeficiency, bool _isMedicallyAppropriate) public pure returns (string memory) {
        Patient memory patient = Patient(_hasPrimaryImmuneDeficiency, _isMedicallyAppropriate);
        
        if (patient.hasPrimaryImmuneDeficiency && patient.isMedicallyAppropriate) {
            return "Medicare Part B covers the cost of IVIG.";
        } else {
            return "Medicare Part B does not cover the cost of IVIG.";
        }
    }
    
    // Function to check if Medicare Part B covers other items and services related to IVIG at home
    function checkMedicarePartBCoverageForOtherItems(bool _hasPrimaryImmuneDeficiency, bool _isMedicallyAppropriate) public pure returns (string memory) {
        Patient memory patient = Patient(_hasPrimaryImmuneDeficiency, _isMedicallyAppropriate);
        
        if (patient.hasPrimaryImmuneDeficiency && patient.isMedicallyAppropriate) {
            return "Medicare Part B does not cover other items and services related to IVIG at home.";
        } else {
            return "Medicare Part B may cover other items and services related to IVIG at home.";
        }
    }
}

contract InsuranceCoverageTest is InsuranceCoverage {
    function testMedicareCoverageForIVIG() public {
        Assert.equal(checkMedicareCoverageForIVIG(true, true), "Medicare covers IVIG for the patient.", "Medicare should cover IVIG for the patient with primary immune deficiency disease and medical appropriateness.");
        Assert.equal(checkMedicareCoverageForIVIG(false, true), "Medicare does not cover IVIG for the patient.", "Medicare should not cover IVIG for the patient without primary immune deficiency disease.");
    }
    
    function testMedicarePartBCoverage() public {
        Assert.equal(checkMedicarePartBCoverage(true, true), "Medicare Part B covers the cost of IVIG.", "Medicare Part B should cover the cost of IVIG for the patient with primary immune deficiency disease and medical appropriateness.");
        Assert.equal(checkMedicarePartBCoverage(false, true), "Medicare Part B does not cover the cost of IVIG.", "Medicare Part B should not cover the cost of IVIG for the patient without primary immune deficiency disease.");
    }
    
    function testMedicarePartBCoverageForOtherItems() public {
        Assert.equal(checkMedicarePartBCoverageForOtherItems(true, true), "Medicare Part B does not cover other items and services related to IVIG at home.", "Medicare Part B should not cover other items and services related to IVIG at home for the patient with primary immune deficiency disease and medical appropriateness.");
        Assert.equal(checkMedicarePartBCoverageForOtherItems(false, true), "Medicare Part B may cover other items and services related to IVIG at home.", "Medicare Part B may cover other items and services related to IVIG at home for the patient without primary immune deficiency disease.");
    }
}