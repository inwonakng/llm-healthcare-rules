pragma solidity ^0.8.0;

contract MedicareInsurance {
    struct Patient {
        bool hasPartA;
        bool hasPartB;
        bool hasPartD;
        bool hasOriginalMedicare;
        bool hasESRD;
        bool hasTransplant;
        uint256 transplantTime;
        bool hasOtherHealthCoverage;
        bool hasImmunosuppressiveDrugBenefit;
        uint256 deductible;
        uint256 premium;
    }

    mapping(address => Patient) public patients;

    function registerPatient(
        address _patient,
        bool _hasPartA,
        bool _hasPartB,
        bool _hasPartD,
        bool _hasOriginalMedicare,
        bool _hasESRD,
        bool _hasTransplant,
        uint256 _transplantTime,
        bool _hasOtherHealthCoverage
    ) public {
        patients[_patient] = Patient({
            hasPartA: _hasPartA,
            hasPartB: _hasPartB,
            hasPartD: _hasPartD,
            hasOriginalMedicare: _hasOriginalMedicare,
            hasESRD: _hasESRD,
            hasTransplant: _hasTransplant,
            transplantTime: _transplantTime,
            hasOtherHealthCoverage: _hasOtherHealthCoverage,
            hasImmunosuppressiveDrugBenefit: false,
            deductible: 0,
            premium: 0
        });
    }

    function applyForImmunosuppressiveDrugBenefit(address _patient) public {
        Patient storage patient = patients[_patient];
        require(patient.hasPartA, "Must have Part A at the time of the covered transplant");
        require(patient.hasPartB, "Must have Part B at the time you get immunosuppressive drugs");
        require(patient.hasTransplant, "Must have a transplant");
        require(patient.transplantTime + 36 months <= block.timestamp, "Must be 36 months after a successful kidney transplant");
        require(!patient.hasOtherHealthCoverage, "Must not have certain types of other health coverage");

        patient.hasImmunosuppressiveDrugBenefit = true;
        patient.deductible = 226;
        patient.premium = 97.10;
    }

    function getImmunosuppressiveDrugCost(address _patient, uint256 _medicareApprovedAmount) public view returns (uint256) {
        Patient storage patient = patients[_patient];
        require(patient.hasImmunosuppressiveDrugBenefit, "Must have immunosuppressive drug benefit");
        require(patient.deductible <= 0, "Must have met the deductible");

        return _medicareApprovedAmount * 20 / 100;
    }
}