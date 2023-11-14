```
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract InsurancePolicyTest {
    InsurancePolicy insurancePolicy;
    
    function beforeEach() public {
        insurancePolicy = new InsurancePolicy();
    }

    function checkIVIGCoverageEligibility() public {
        address patient = address(0x123);
        address doctor = address(0x456);
        bool hasPrimaryImmuneDeficiency = true;
        bool medicallyAppropriateForIVIGAtHome = true;
        bool IVIGProvidedAtHome = true;
        
        insurancePolicy.setPatientDetails(patient, hasPrimaryImmuneDeficiency, medicallyAppropriateForIVIGAtHome, IVIGProvidedAtHome);
        insurancePolicy.setDoctorDetails(doctor);
        
        Assert.equal(insurancePolicy.checkEligibility(patient), true, "Patient should be eligible for IVIG coverage under Part B");
    }

    function checkNonCoverageOfOtherItemsAndServices() public {
        address patient = address(0x123);
        bool receivesIVIGAtHome = true;
        bool associatedWithOtherItemsAndServices = true;
        
        insurancePolicy.setPatientDetails(patient, receivesIVIGAtHome, associatedWithOtherItemsAndServices);
        
        Assert.equal(insurancePolicy.checkEligibilityForOtherItemsAndServices(patient), false, "Patient should not be eligible for coverage of other items and services related to IVIG at home");
    }
}