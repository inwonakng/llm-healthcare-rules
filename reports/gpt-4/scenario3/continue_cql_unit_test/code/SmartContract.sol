pragma solidity ^0.8.0;

contract TransplantDrugCoverage {
    struct Coverage {
        bool active;
        uint256 start;
        uint256 end;
        string typeOfCoverage;
    }

    mapping(address => Coverage) public coverages;
    mapping(address => bool) public medicareCoveredTransplants;

    function checkMedicareCoveredTransplant() public view returns (bool) {
        return medicareCoveredTransplants[msg.sender];
    }

    function checkHasPartAAtTransplant() public view returns (bool) {
        Coverage memory coverage = coverages[msg.sender];
        return coverage.active && coverage.typeOfCoverage == "Part A";
    }

    function checkHasPartBForDrugs() public view returns (bool) {
        Coverage memory coverage = coverages[msg.sender];
        return coverage.active && coverage.typeOfCoverage == "Part B";
    }

    function checkHasPartDForDrugs() public view returns (bool) {
        Coverage memory coverage = coverages[msg.sender];
        return coverage.active && coverage.typeOfCoverage == "Part D";
    }

    function checkHasESRDMedicareCoverage() public view returns (bool) {
        Coverage memory coverage = coverages[msg.sender];
        return coverage.active && coverage.typeOfCoverage == "ESRD";
    }

    function checkEndOfESRDCoverage() public view returns (bool) {
        Coverage memory coverage = coverages[msg.sender];
        return coverage.active && coverage.typeOfCoverage == "ESRD" && coverage.end <= block.timestamp + 36 * 30 days;
    }

    function checkHasOtherHealthCoverage() public view returns (bool) {
        Coverage memory coverage = coverages[msg.sender];
        return coverage.active && (coverage.typeOfCoverage == "group health plan" || coverage.typeOfCoverage == "TRICARE" || coverage.typeOfCoverage == "Medicaid");
    }

    function checkEligibleForImmunosuppressiveDrugBenefit() public view returns (bool) {
        return checkMedicareCoveredTransplant() && checkHasPartAAtTransplant() && checkHasPartBForDrugs() && !checkHasOtherHealthCoverage() && (checkHasPartDForDrugs() || checkEndOfESRDCoverage());
    }

    function checkImmunosuppressiveDrugBenefitCost() public view returns (uint256) {
        if (checkEligibleForImmunosuppressiveDrugBenefit()) {
            return 97.10 ether/month + 226 ether;
        } else {
            return 0;
        }
    }
}