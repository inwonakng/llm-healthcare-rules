// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
 // this import is automatically injected by Remix.


contract InjectableOsteoporosisDrugsCoverageTest {
    
    InjectableOsteoporosisDrugsCoverage coverageContract;

    // Define a struct to encapsulate patient information for cleaner tests
    struct PatientInfo {
        bool isFemale;
        bool hasOsteoporosis;
        bool qualifiesForMedicareHomeHealth;
        bool hasPostmenopausalFracture;
        bool unableToSelfAdminister;
        bool familyUnableToAdminister;
    }

    // Create a setup function to initialize the contract before tests
    function beforeEach() public {
        coverageContract = new InjectableOsteoporosisDrugsCoverage();
    }

    /// Test if a female patient with osteoporosis who meets all criteria is covered
    function testCoverageForEligibleFemalePatient() public {
        PatientInfo memory patient = PatientInfo(true, true, true, true, true, false);
        bool result = coverageContract.isCovered(patient);
        Assert.equal(result, true, "Eligible female patient should be covered.");
    }

    /// Test if a male patient is not covered
    function testCoverageForMalePatient() public {
        PatientInfo memory patient = PatientInfo(false, true, true, true, true, false);
        bool result = coverageContract.isCovered(patient);
        Assert.equal(result, false, "Male patient should not be covered.");
    }

    /// Test if a patient without osteoporosis is not covered
    function testCoverageForPatientWithoutOsteoporosis() public {
        PatientInfo memory patient = PatientInfo(true, false, true, true, true, false);
        bool result = coverageContract.isCovered(patient);
        Assert.equal(result, false, "Patient without osteoporosis should not be covered.");
    }

    /// Test if a patient who does not qualify for Medicare home health benefit is not covered
    function testCoverageForPatientWithoutMedicareHomeHealthBenefit() public {
        PatientInfo memory patient = PatientInfo(true, true, false, true, true, false);
        bool result = coverageContract.isCovered(patient);
        Assert.equal(result, false, "Patient without Medicare home health benefit should not be covered.");
    }

    /// Test if a patient without a postmenopausal fracture is not covered
    function testCoverageForPatientWithoutPostmenopausalFracture() public {
        PatientInfo memory patient = PatientInfo(true, true, true, false, true, false);
        bool result = coverageContract.isCovered(patient);
        Assert.equal(result, false, "Patient without postmenopausal fracture should not be covered.");
    }

    /// Test if a patient who can self-administer is not covered
    function testCoverageForPatientAbleToSelfAdminister() public {
        PatientInfo memory patient = PatientInfo(true, true, true, true, false, false);
        bool result = coverageContract.isCovered(patient);
        Assert.equal(result, false, "Patient able to self-administer should not be covered.");
    }

    /// Test if a patient is covered when family is unable to administer
    function testCoverageForPatientWithFamilyUnableToAdminister() public {
        PatientInfo memory patient = PatientInfo(true, true, true, true, true, true);
        bool result = coverageContract.isCovered(patient);
        Assert.equal(result, true, "Patient with family unable to administer should be covered.");
    }

    /// Test if a patient is not covered when family is able to administer
    function testCoverageForPatientWithFamilyAbleToAdminister() public {
        PatientInfo memory patient = PatientInfo(true, true, true, true, true, false);
        bool result = coverageContract.isCovered(patient);
        Assert.equal(result, true, "Patient with family able to administer should still be covered if all other conditions are met.");
    }
}