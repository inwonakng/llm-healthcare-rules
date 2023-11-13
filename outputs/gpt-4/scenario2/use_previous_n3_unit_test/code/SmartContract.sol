pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Patient {
        bool hasPrimaryImmuneDeficiency;
        bool receivesIVIGAtHome;
        bool doctorApproved;
        bool usesOtherItemsAndServices;
    }

    mapping(address => Patient) public patients;

    function setPatient(
        address _patientAddress,
        bool _hasPrimaryImmuneDeficiency,
        bool _receivesIVIGAtHome,
        bool _doctorApproved,
        bool _usesOtherItemsAndServices
    ) public {
        Patient storage patient = patients[_patientAddress];
        patient.hasPrimaryImmuneDeficiency = _hasPrimaryImmuneDeficiency;
        patient.receivesIVIGAtHome = _receivesIVIGAtHome;
        patient.doctorApproved = _doctorApproved;
        patient.usesOtherItemsAndServices = _usesOtherItemsAndServices;
    }

    function isCovered(address _patientAddress) public view returns (bool) {
        Patient storage patient = patients[_patientAddress];
        if (
            patient.hasPrimaryImmuneDeficiency &&
            patient.receivesIVIGAtHome &&
            patient.doctorApproved
        ) {
            return true;
        } else {
            return false;
        }
    }

    function getCoveredAmount(address _patientAddress, string memory _item)
        public
        view
        returns (uint256)
    {
        Patient storage patient = patients[_patientAddress];
        if (
            keccak256(abi.encodePacked(_item)) == keccak256(abi.encodePacked("IVIG")) &&
            patient.hasPrimaryImmuneDeficiency &&
            patient.receivesIVIGAtHome &&
            patient.doctorApproved
        ) {
            return 100;
        } else if (
            keccak256(abi.encodePacked(_item)) != keccak256(abi.encodePacked("IVIG")) &&
            patient.hasPrimaryImmuneDeficiency &&
            patient.receivesIVIGAtHome &&
            patient.doctorApproved &&
            patient.usesOtherItemsAndServices
        ) {
            return 0;
        } else {
            return 0;
        }
    }
}