pragma solidity ^0.8.0;

contract InsuranceContract {
    struct Patient {
        bool hasPrimaryImmuneDeficiencyDisease;
        bool isMedicallyAppropriate;
    }

    function checkCoverage(Patient memory patient) public pure returns (bool, bool) {
        bool coverIVIG = patient.hasPrimaryImmuneDeficiencyDisease && patient.isMedicallyAppropriate;
        bool coverRelatedItems = !coverIVIG;

        return (coverIVIG, coverRelatedItems);
    }
}