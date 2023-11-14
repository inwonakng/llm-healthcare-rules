```solidity
pragma solidity ^0.8.0;

contract MedicareContract {
    struct Patient {
        bool hasPartA;
        bool hasPartB;
        bool hasPartD;
        bool hasOriginalMedicare;
        bool hasESRD;
        bool hasTransplant;
        uint transplantTime;
        uint partAEndTime;
        uint premium;
        uint deductible;
    }

    mapping(address => Patient) public patients;

    function checkTransplantCoverage(address _patient) public view returns(bool) {
        return patients[_patient].hasTransplant;
    }

    function checkPartACoverageAtTransplantTime(address _patient) public view returns(bool) {
        return patients[_patient].hasPartA && patients[_patient].transplantTime > 0;
    }

    function checkPartBCoverageAtDrugTime(address _patient) public view returns(bool) {
        return patients[_patient].hasPartB;
    }

    function checkPartDCoverage(address _patient) public view returns(bool) {
        return patients[_patient].hasPartD;
    }

    function checkMedicareDrugPlanEnrollment(address _patient) public view returns(bool) {
        return patients[_patient].hasOriginalMedicare;
    }

    function checkCoverageEndAfterKidneyTransplant(address _patient) public view returns(bool) {
        return patients[_patient].hasESRD && (block.timestamp - patients[_patient].transplantTime >= 36 months);
    }

    function checkBenefitAfterPartAEnds(address _patient) public view returns(bool) {
        return !patients[_patient].hasPartA && (block.timestamp - patients[_patient].partAEndTime >= 36 months);
    }

    function checkBenefitCoverage(address _patient) public view returns(bool) {
        return checkBenefitAfterPartAEnds(_patient);
    }

    function checkBenefitSignupAfterPartAEnds(address _patient) public view returns(bool) {
        return !patients[_patient].hasPartA;
    }

    function checkPremiumAndDeductible(address _patient) public view returns(uint, uint) {
        return (patients[_patient].premium, patients[_patient].deductible);
    }

    function checkPaymentAfterDeductible(address _patient) public view returns(uint) {
        return patients[_patient].deductible > 0 ? 20 : 100;
    }
}