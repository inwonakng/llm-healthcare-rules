pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Patient {
        bool hasPrimaryImmuneDeficiency;
        bool doctorApprovalForHomeIVIG;
    }

    mapping(address => Patient) public patients;

    function setPatient(address _patient, bool _hasPrimaryImmuneDeficiency, bool _doctorApprovalForHomeIVIG) public {
        patients[_patient] = Patient(_hasPrimaryImmuneDeficiency, _doctorApprovalForHomeIVIG);
    }

    function isCovered(address _patient, string memory _treatment, bool _atHome) public view returns (bool) {
        if (keccak256(abi.encodePacked(_treatment)) == keccak256(abi.encodePacked("IVIG")) && _atHome) {
            Patient memory patient = patients[_patient];
            if (patient.hasPrimaryImmuneDeficiency && patient.doctorApprovalForHomeIVIG) {
                return true;
            }
        }
        return false;
    }

    function isCoveredUnderPartB(string memory _treatment, bool _atHome) public view returns (bool) {
        if (keccak256(abi.encodePacked(_treatment)) == keccak256(abi.encodePacked("IVIG")) && _atHome) {
            return true;
        }
        return false;
    }

    function isOtherItemsAndServicesCovered(string memory _treatment, bool _atHome) public view returns (bool) {
        if (keccak256(abi.encodePacked(_treatment)) == keccak256(abi.encodePacked("IVIG")) && _atHome) {
            return false;
        }
        return true;
    }
}