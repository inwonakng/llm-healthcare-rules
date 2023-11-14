// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Patient {
        bool isCoveredForIVIG;
        bool isCoveredForIVIGAtHome;
        bool isCoveredByMedicarePartB;
    }

    function isCoveredForIVIG(bool hasPrimaryImmuneDeficiencyDisease) public pure returns (bool) {
        return hasPrimaryImmuneDeficiencyDisease;
    }

    function isCoveredForIVIGAtHome(bool isMedicallyAppropriate) public pure returns (bool) {
        return isMedicallyAppropriate;
    }

    function isCoveredByMedicarePartB(bool isCoveredForIVIG) public pure returns (bool) {
        return isCoveredForIVIG;
    }
}