```solidity
pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Patient {
        bool hasPrimaryImmuneDeficiency;
        bool doctorApprovedIVIG;
    }

    mapping(address => Patient) public patients;

    function setPatient(address _patient, bool _hasPrimaryImmuneDeficiency, bool _doctorApprovedIVIG) public {
        patients[_patient] = Patient(_hasPrimaryImmuneDeficiency, _doctorApprovedIVIG);
    }

    function isIVIGCovered(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        if(patient.hasPrimaryImmuneDeficiency && patient.doctorApprovedIVIG) {
            return true;
        } else {
            return false;
        }
    }

    function getIVIGCoverageAmount(string memory _part, uint _IVIGCost, uint _otherCosts) public view returns (uint) {
        if(keccak256(abi.encodePacked(_part)) == keccak256(abi.encodePacked("PartB"))) {
            return _IVIGCost;
        } else {
            return 0;
        }
    }
}