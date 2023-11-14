// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract YourContractTest {
    YourContract yourContract;

    function beforeAll() public {
        yourContract = new YourContract();
    }

    function testIVIGCoverage() public {
        // Rule 1: Medicare covers IVIG if the patient has a diagnosis of primary immune deficiency disease.
        bool result = yourContract.isCoveredForIVIG(true, true);
        Assert.equal(result, true, "IVIG should be covered for a patient with primary immune deficiency disease");
    }

    function testIVIGAtHomeCoverage() public {
        // Rule 2: The patient's doctor must determine that it is medically appropriate for the patient to receive IVIG at home.
        bool result = yourContract.isCoveredForIVIGAtHome(true, true);
        Assert.equal(result, true, "IVIG at home should be covered if determined medically appropriate by the doctor");
    }

    function testMedicarePartBCoverage() public {
        // Rule 3: Medicare Part B covers the cost of the IVIG itself.
        bool result = yourContract.isCoveredByMedicarePartB(true);
        Assert.equal(result, true, "Medicare Part B should cover the cost of IVIG itself");
    }

    function testOtherServicesCoverage() public {
        // Rule 4: Medicare Part B does not cover other items and services related to the patient receiving IVIG at home.
        bool result = yourContract.isCoveredByMedicarePartB(false);
        Assert.equal(result, true, "Medicare Part B should not cover other items and services related to IVIG at home");
    }
}