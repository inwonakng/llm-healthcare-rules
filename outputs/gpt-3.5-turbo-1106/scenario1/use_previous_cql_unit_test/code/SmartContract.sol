// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicareCoverage {
    struct Patient {
        string gender;
        string condition;
        bool qualifiesForMedicareHomeHealthBenefit;
        bool boneFractureCertified;
        bool unableToSelfAdminister;
    }

    function qualifiesForCoverage(
        string memory _gender,
        string memory _condition,
        bool _qualifiesForMedicareHomeHealthBenefit
    ) public pure returns (bool) {
        if (
            keccak256(abi.encodePacked(_gender)) == keccak256(abi.encodePacked("woman")) &&
            keccak256(abi.encodePacked(_condition)) == keccak256(abi.encodePacked("osteoporosis")) &&
            _qualifiesForMedicareHomeHealthBenefit
        ) {
            return true;
        }
        return false;
    }

    function boneFractureCertified(string memory _condition) public pure returns (bool) {
        if (keccak256(abi.encodePacked(_condition)) == keccak256(abi.encodePacked("post-menopausal osteoporosis"))) {
            return true;
        }
        return false;
    }

    function patientCanSelfAdminister(bool _unableToSelfAdminister) public pure returns (bool) {
        return !_unableToSelfAdminister;
    }

    function homeHealthAideCoverage(bool _coverHomeHealthNurseOrAide) public pure returns (bool) {
        return _coverHomeHealthNurseOrAide;
    }

    function MedicareCoversOsteoporosisDrug(
        string memory _gender,
        string memory _condition,
        bool _qualifiesForMedicareHomeHealthBenefit,
        bool _boneFractureCertified,
        bool _unableToSelfAdminister,
        bool _coverHomeHealthNurseOrAide
    ) public pure returns (bool) {
        if (
            qualifiesForCoverage(_gender, _condition, _qualifiesForMedicareHomeHealthBenefit) &&
            boneFractureCertified(_condition) &&
            patientCanSelfAdminister(_unableToSelfAdminister) &&
            (_unableToSelfAdminister || homeHealthAideCoverage(_coverHomeHealthNurseOrAide))
        ) {
            return true;
        }
        return false;
    }
}