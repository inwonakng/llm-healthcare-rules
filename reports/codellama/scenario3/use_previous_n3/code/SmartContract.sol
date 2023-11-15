pragma solidity ^0.8.0;

contract MedicareImmunosuppressiveDrugBenefit {
    struct Patient {
        bool hasPartA;
        bool hasPartB;
        bool getImmunosuppressiveDrugs;
        bool hasESRDMedicare;
        bool successfulKidneyTransplant;
        bool endMedicareCoverage;
        bool losePartACoverage;
        bool haveOtherHealthCoverage;
        bool offerBenefit;
        bool qualifyBenefit;
        bool signUpBenefit;
        bool callSocialSecurity;
        bool payMonthlyPremium;
        bool payDeductible;
        bool metDeductible;
        bool payMedicareApprovedAmount;
    }

    mapping(address => Patient) public patients;

    function setPatient(address patientAddress, bool hasPartA, bool hasPartB, bool getImmunosuppressiveDrugs, bool hasESRDMedicare, bool successfulKidneyTransplant, bool endMedicareCoverage, bool losePartACoverage, bool haveOtherHealthCoverage, bool offerBenefit, bool qualifyBenefit, bool signUpBenefit, bool callSocialSecurity, bool payMonthlyPremium, bool payDeductible, bool metDeductible, bool payMedicareApprovedAmount) public {
        patients[patientAddress] = Patient(hasPartA, hasPartB, getImmunosuppressiveDrugs, hasESRDMedicare, successfulKidneyTransplant, endMedicareCoverage, losePartACoverage, haveOtherHealthCoverage, offerBenefit, qualifyBenefit, signUpBenefit, callSocialSecurity, payMonthlyPremium, payDeductible, metDeductible, payMedicareApprovedAmount);
    }

    function getPatient(address patientAddress) public view returns (Patient) {
        return patients[patientAddress];
    }

    function hasPartA(address patientAddress) public view returns (bool) {
        return patients[patientAddress].hasPartA;
    }

    function hasPartB(address patientAddress) public view returns (bool) {
        return patients[patientAddress].hasPartB;
    }

    function getImmunosuppressiveDrugs(address patientAddress) public view returns (bool) {
        return patients[patientAddress].getImmunosuppressiveDrugs;
    }

    function hasESRDMedicare(address patientAddress) public view returns (bool) {
        return patients[patientAddress].hasESRDMedicare;
    }

    function successfulKidneyTransplant(address patientAddress) public view returns (bool) {
        return patients[patientAddress].successfulKidneyTransplant;
    }

    function endMedicareCoverage(address patientAddress) public view returns (bool) {
        return patients[patientAddress].endMedicareCoverage;
    }

    function losePartACoverage(address patientAddress) public view returns (bool) {
        return patients[patientAddress].losePartACoverage;
    }

    function haveOtherHealthCoverage(address patientAddress) public view returns (bool) {
        return patients[patientAddress].haveOtherHealthCoverage;
    }

    function offerBenefit(address patientAddress) public view returns (bool) {
        return patients[patientAddress].offerBenefit;
    }

    function qualifyBenefit(address patientAddress) public view returns (bool) {
        return patients[patientAddress].qualifyBenefit;
    }

    function signUpBenefit(address patientAddress) public view returns (bool) {
        return patients[patientAddress].signUpBenefit;
    }

    function callSocialSecurity(address patientAddress) public view returns (bool) {
        return patients[patientAddress].callSocialSecurity;
    }

    function payMonthlyPremium(address patientAddress) public view returns (bool) {
        return patients[patientAddress].payMonthlyPremium;
    }

    function payDeductible(address patientAddress) public view returns (bool) {
        return patients[patientAddress].payDeductible;
    }

    function metDeductible(address patientAddress) public view returns (bool) {
        return patients[patientAddress].metDeductible;
    }

    function payMedicareApprovedAmount(address patientAddress) public view returns (bool) {
        return patients[patientAddress].payMedicareApprovedAmount;
    }
}