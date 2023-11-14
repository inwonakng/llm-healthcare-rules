// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicareContract {
    // Define a struct to encapsulate the insured's information for cleaner code
    struct InsuredInfo {
        bool isWoman;
        bool diagnosedWithOsteoporosis;
        bool meetsHomeHealthCriteria;
        bool hasCertifiedFracture;
        bool unableToSelfAdminister;
        bool familyUnableToAdminister;
        bool familyUnwillingToAdminister;
    }

    // Function to check if the insured is covered for injectable osteoporosis drugs
    function isCovered(
        bool isWoman,
        bool diagnosedWithOsteoporosis,
        bool meetsHomeHealthCriteria,
        bool hasCertifiedFracture,
        bool unableToSelfAdminister
    ) public pure returns (bool) {
        return isWoman &&
               diagnosedWithOsteoporosis &&
               meetsHomeHealthCriteria &&
               hasCertifiedFracture &&
               unableToSelfAdminister;
    }

    // Function to check if the insured is covered for a home health nurse or aide
    function isCoveredForNurse(
        bool familyUnableToAdminister,
        bool familyUnwillingToAdminister
    ) public pure returns (bool) {
        return familyUnableToAdminister || familyUnwillingToAdminister;
    }
}