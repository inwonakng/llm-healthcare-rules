pragma solidity ^0.8.0;

contract InsuranceCoverage {
    // Define the struct for the patient
    struct Patient {
        string name;
        uint age;
        bool gender;
        bool hasBoneFracture;
        bool isPostMenopausal;
        bool isHomeHealthBenefit;
    }

    // Define the struct for the coverage
    struct Coverage {
        string name;
        uint cost;
        bool isCovered;
    }

    // Define the mapping for the patients
    mapping(address => Patient) public patients;

    // Define the mapping for the coverages
    mapping(string => Coverage) public coverages;

    // Define the function to add a patient
    function addPatient(string memory _name, uint _age, bool _gender, bool _hasBoneFracture, bool _isPostMenopausal, bool _isHomeHealthBenefit) public {
        patients[msg.sender] = Patient(_name, _age, _gender, _hasBoneFracture, _isPostMenopausal, _isHomeHealthBenefit);
    }

    // Define the function to add a coverage
    function addCoverage(string memory _name, uint _cost, bool _isCovered) public {
        coverages[_name] = Coverage(_name, _cost, _isCovered);
    }

    // Define the function to check if a patient is covered
    function isCovered(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        if (patient.isHomeHealthBenefit && patient.hasBoneFracture && patient.isPostMenopausal) {
            return true;
        }
        return false;
    }

    // Define the function to get the cost of a coverage
    function getCost(string memory _name) public view returns (uint) {
        Coverage memory coverage = coverages[_name];
        return coverage.cost;
    }
}