pragma solidity ^0.8.0;

contract MedicareInsurance {
    struct Patient {
        bool hasPartA;
        bool hasPartB;
        bool hasPartD;
        bool hasOriginalMedicare;
        bool hasESRD;
        uint256 transplantDate;
        bool hasOtherHealthCoverage;
        bool signedUpForImmunosuppressiveBenefit;
    }

    mapping(address => Patient) public patients;
    uint256 public constant MONTHS_AFTER_TRANSPLANT = 36;
    uint256 public constant MONTH_IN_SECONDS = 30 days;
    uint256 public constant PREMIUM = 9710; // in wei
    uint256 public constant DEDUCTIBLE = 226 ether; // in wei

    function signUpForImmunosuppressiveBenefit(address patientAddress) public {
        Patient storage patient = patients[patientAddress];
        require(patient.hasPartA, "Must have Part A");
        require(patient.hasPartB, "Must have Part B");
        require(patient.transplantDate + MONTHS_AFTER_TRANSPLANT * MONTH_IN_SECONDS < block.timestamp, "Must be 36 months after transplant");
        require(!patient.hasOtherHealthCoverage, "Must not have other health coverage");
        patient.signedUpForImmunosuppressiveBenefit = true;
    }

    function payPremium(address patientAddress) public payable {
        Patient storage patient = patients[patientAddress];
        require(patient.signedUpForImmunosuppressiveBenefit, "Must sign up for immunosuppressive benefit first");
        require(msg.value == PREMIUM, "Must pay the exact premium amount");
    }

    function payDeductible(address patientAddress) public payable {
        Patient storage patient = patients[patientAddress];
        require(patient.signedUpForImmunosuppressiveBenefit, "Must sign up for immunosuppressive benefit first");
        require(msg.value == DEDUCTIBLE, "Must pay the exact deductible amount");
    }

    function payForDrugs(address patientAddress, uint256 amount) public payable {
        Patient storage patient = patients[patientAddress];
        require(patient.signedUpForImmunosuppressiveBenefit, "Must sign up for immunosuppressive benefit first");
        require(msg.value == amount / 5, "Must pay 20% of the drug cost");
    }
}