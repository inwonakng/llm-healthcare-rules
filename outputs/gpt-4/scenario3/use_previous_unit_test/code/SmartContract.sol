pragma solidity ^0.8.0;

contract MedicareContract {
    struct Patient {
        bool hasPartA;
        bool hasPartB;
        bool hasPartD;
        bool hasMedicare;
        bool hasESRD;
        bool hasTransplant;
        bool hasImmunosuppressiveDrugs;
        uint256 transplantTime;
        uint256 premium;
        uint256 deductible;
    }

    mapping(address => Patient) public patients;

    function coverTransplantDrugTherapy(bool hasTransplant) public view returns(bool) {
        return patients[msg.sender].hasMedicare && hasTransplant;
    }

    function checkPartAAtTimeOfTransplant(bool hasTransplant) public view returns(bool) {
        return patients[msg.sender].hasPartA && hasTransplant;
    }

    function checkPartBAtTimeOfImmunosuppressiveDrugs(bool hasImmunosuppressiveDrugs) public view returns(bool) {
        return patients[msg.sender].hasPartB && hasImmunosuppressiveDrugs;
    }

    function checkPartDCoversImmunosuppressiveDrugs(bool hasPartB) public view returns(bool) {
        return patients[msg.sender].hasPartD && !hasPartB;
    }

    function checkMedicareCoverageEndsAfter36Months(bool hasESRD) public view returns(bool) {
        return hasESRD && (block.timestamp - patients[msg.sender].transplantTime >= 36 * 30 days);
    }

    function checkBenefitAfterPartACoverageEnds(bool hasPartA, bool hasOtherCoverage) public view returns(bool) {
        return !hasPartA && !hasOtherCoverage && (block.timestamp - patients[msg.sender].transplantTime >= 36 * 30 days);
    }

    function checkBenefitCoversImmunosuppressiveDrugsOnly(bool hasOtherServices) public pure returns(bool) {
        return !hasOtherServices;
    }

    function checkSignupAfterPartACoverageEnds(bool hasPartA) public view returns(bool) {
        return !hasPartA && (block.timestamp - patients[msg.sender].transplantTime >= 36 * 30 days);
    }

    function checkMonthlyPremiumAndDeductible(uint256 premium, uint256 deductible) public view returns(bool) {
        return patients[msg.sender].premium == premium && patients[msg.sender].deductible == deductible;
    }

    function calculatePaymentAfterDeductible(uint256 approvedAmount) public view returns(uint256) {
        return (approvedAmount * 20) / 100;
    }
}