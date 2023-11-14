// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract MedicareCoverageTest {
    YourContract contractInstance;

    function beforeAll() public {
        contractInstance = new YourContract();
    }

    function checkQualifiesForCoverage() public {
        bool result = contractInstance.qualifiesForCoverage("woman", "osteoporosis", true);
        Assert.equal(result, true, "Patient should qualify for coverage");
    }

    function checkBoneFractureCertification() public {
        bool result = contractInstance.boneFractureCertified("post-menopausal osteoporosis");
        Assert.equal(result, true, "Bone fracture should be certified");
    }

    function checkPatientAbilityToSelfAdminister() public {
        bool result = contractInstance.patientCanSelfAdminister(false);
        Assert.equal(result, true, "Patient should be unable to self-administer");
    }

    function checkHomeHealthAideCoverage() public {
        bool result = contractInstance.homeHealthAideCoverage(true);
        Assert.equal(result, true, "Home health nurse or aide should be covered");
    }
}