pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract MedicareTest {
    // Test that the Medicare contract has the correct name
    function testMedicareName() public {
        Medicare medicare = new Medicare();
        Assert.equal(medicare.name(), "Medicare", "Medicare contract should have the correct name");
    }

    // Test that the Medicare contract has the correct number of Part A and Part B plans
    function testMedicarePlans() public {
        Medicare medicare = new Medicare();
        Assert.equal(medicare.partAPlans.length, 10, "Medicare contract should have 10 Part A plans");
        Assert.equal(medicare.partBPlans.length, 10, "Medicare contract should have 10 Part B plans");
    }

    // Test that the Medicare contract has the correct number of immunosuppressive drug plans
    function testImmunosuppressiveDrugPlans() public {
        Medicare medicare = new Medicare();
        Assert.equal(medicare.immunosuppressiveDrugPlans.length, 10, "Medicare contract should have 10 immunosuppressive drug plans");
    }

    // Test that the Medicare contract has the correct number of Part A and Part B plans for a specific state
    function testMedicarePlansForState() public {
        Medicare medicare = new Medicare();
        Assert.equal(medicare.partAPlansForState("CA").length, 2, "Medicare contract should have 2 Part A plans for California");
        Assert.equal(medicare.partBPlansForState("CA").length, 2, "Medicare contract should have 2 Part B plans for California");
    }

    // Test that the Medicare contract has the correct number of immunosuppressive drug plans for a specific state
    function testImmunosuppressiveDrugPlansForState() public {
        Medicare medicare = new Medicare();
        Assert.equal(medicare.immunosuppressiveDrugPlansForState("CA").length, 2, "Medicare contract should have 2 immunosuppressive drug plans for California");
    }

    // Test that the Medicare contract has the correct number of Part A and Part B plans for a specific zip code
    function testMedicarePlansForZipCode() public {
        Medicare medicare = new Medicare();
        Assert.equal(medicare.partAPlansForZipCode("90210").length, 2, "Medicare contract should have 2 Part A plans for zip code 90210");
        Assert.equal(medicare.partBPlansForZipCode("90210").length, 2, "Medicare contract should have 2 Part B plans for zip code 90210");
    }

    // Test that the Medicare contract has the correct number of immunosuppressive drug plans for a specific zip code
    function testImmunosuppressiveDrugPlansForZipCode() public {
        Medicare medicare = new Medicare();
        Assert.equal(medicare.immunosuppressiveDrugPlansForZipCode("90210").length, 2, "Medicare contract should have 2 immunosuppressive drug plans for zip code 90210");
    }
}