// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InjectableOsteoporosisDrugsCoverageContract {
    
    // Define a struct to encapsulate patient information for cleaner code
    struct PatientInfo {
        bool isFemale;
        bool hasOsteoporosis;
        bool qualifiesForMedicareHomeHealth;
        bool hasPostmenopausalFracture;
        bool unableToSelfAdminister;
        bool familyUnableToAdminister;
    }

    // Function to check if the patient is covered for injectable osteoporosis drugs
    function isCovered(
        bool isFemale,
        bool hasOsteoporosis,
        bool qualifiesForMedicareHomeHealth,
        bool hasPostmenopausalFracture,
        bool unableToSelfAdminister
    ) public pure returns (bool) {
        return (
            isFemale &&
            hasOsteoporosis &&
            qualifiesForMedicareHomeHealth &&
            hasPostmenopausalFracture &&
            unableToSelfAdminister
        );
    }

    // Function to check if the patient is covered for a home health nurse or aide to provide the injection
    function isCoveredWithFamily(
        bool isFemale,
        bool hasOsteoporosis,
        bool qualifiesForMedicareHomeHealth,
        bool hasPostmenopausalFracture,
        bool unableToSelfAdminister,
        bool familyUnableToAdminister
    ) public pure returns (bool) {
        return (
            isCovered(isFemale, hasOsteoporosis, qualifiesForMedicareHomeHealth, hasPostmenopausalFracture, unableToSelfAdminister) &&
            familyUnableToAdminister
        );
    }
}