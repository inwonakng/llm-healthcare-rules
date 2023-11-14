pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract IVIGTest {
    function testIVIGCoverage() public {
        // Test if Medicare covers IVIG for primary immune deficiency disease
        assertTrue(IVIG.isCovered("primary immune deficiency disease"));
    }

    function testIVIGNotCovered() public {
        // Test if Medicare doesn't cover IVIG for other conditions
        assertFalse(IVIG.isCovered("other condition"));
    }

    function testIVIGHomeCoverage() public {
        // Test if Medicare covers IVIG if administered in home
        assertTrue(IVIG.isCovered("primary immune deficiency disease", "home"));
    }

    function testIVIGNotHomeCoverage() public {
        // Test if Medicare doesn't cover IVIG if administered in other locations
        assertFalse(IVIG.isCovered("primary immune deficiency disease", "other location"));
    }
}