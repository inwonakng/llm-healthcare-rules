```
pragma solidity ^0.8.0;

contract MedicareCoverage {
    struct Patient {
        bool transplantCovered;
        bool partA;
        bool partB;
        bool partD;
        uint256 transplantDate;
        uint256 drugDate;
        uint256 premium;
        uint256 deductible;
        uint256 drugPrice;
    }

    mapping(address => Patient) public patients;

    function setPatient(
        address _patientAddress,
        bool _transplantCovered,
        bool _partA,
        bool _partB,
        bool _partD,
        uint256 _transplantDate,
        uint256 _drugDate,
        uint256 _premium,
        uint256 _deductible,
        uint256 _drugPrice
    ) public {
        patients[_patientAddress] = Patient({
            transplantCovered: _transplantCovered,
            partA: _partA,
            partB: _partB,
            partD: _partD,
            transplantDate: _transplantDate,
            drugDate: _drugDate,
            premium: _premium,
            deductible: _deductible,
            drugPrice: _drugPrice
        });
    }

    function checkMedicareTransplantCoverage(address _patientAddress) public view returns (bool) {
        return patients[_patientAddress].transplantCovered;
    }

    function checkPartAAtTransplantTime(address _patientAddress, uint256 _transplantDate) public view returns (bool) {
        return patients[_patientAddress].partA && patients[_patientAddress].transplantDate == _transplantDate;
    }

    function checkPartBAtDrugTime(address _patientAddress, uint256 _drugDate) public view returns (bool) {
        return patients[_patientAddress].partB && patients[_patientAddress].drugDate == _drugDate;
    }

    function checkPartDCoverage(address _patientAddress) public view returns (bool) {
        return patients[_patientAddress].partD;
    }

    function checkESRDCoverageEnd(uint256 _transplantDate) public view returns (bool) {
        return block.timestamp >= _transplantDate + 3 years;
    }

    function checkImmunosuppressiveDrugBenefit(address _patientAddress, uint256 _transplantDate, uint256 _drugDate) public view returns (bool) {
        return checkMedicareTransplantCoverage(_patientAddress) && checkPartAAtTransplantTime(_patientAddress, _transplantDate) && checkPartBAtDrugTime(_patientAddress, _drugDate) && !checkESRDCoverageEnd(_transplantDate);
    }

    function checkPremiumAndDeductible(address _patientAddress, uint256 _premium, uint256 _deductible) public view returns (bool) {
        return patients[_patientAddress].premium == _premium && patients[_patientAddress].deductible == _deductible;
    }

    function checkMedicareApprovedAmount(address _patientAddress, uint256 _drugPrice) public view returns (bool) {
        return patients[_patientAddress].drugPrice == _drugPrice * 20 / 100;
    }
}