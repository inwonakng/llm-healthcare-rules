pragma solidity ^0.8.0;

contract InsuranceContract {
    struct Patient {
        string diagnosis;
        bool isInHome;
    }

    mapping(address => Patient) public patients;

    function isIVIGCovered(string memory _diagnosis) public pure returns (bool) {
        // Check if the diagnosis is primary immune deficiency disease
        return keccak256(bytes(_diagnosis)) == keccak256(bytes("primary immune deficiency disease"));
    }

    function isIVIGInHome(string memory _diagnosis) public pure returns (bool) {
        // Check if the diagnosis is primary immune deficiency disease
        return keccak256(bytes(_diagnosis)) == keccak256(bytes("primary immune deficiency disease"));
    }

    function isIVIGCostCovered() public pure returns (bool) {
        // IVIG cost is covered by Medicare Part B
        return true;
    }

    function isOtherServicesCovered() public pure returns (bool) {
        // Other items and services related to IVIG at home are not covered
        return false;
    }

    function addPatient(string memory _diagnosis, bool _isInHome) public {
        patients[msg.sender] = Patient(_diagnosis, _isInHome);
    }

    function getPatientDiagnosis() public view returns (string memory) {
        return patients[msg.sender].diagnosis;
    }

    function getPatientIsInHome() public view returns (bool) {
        return patients[msg.sender].isInHome;
    }
}