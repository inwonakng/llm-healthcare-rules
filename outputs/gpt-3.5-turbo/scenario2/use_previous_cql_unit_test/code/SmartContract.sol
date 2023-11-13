pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Patient {
        string diagnosis;
        string location;
    }
    
    Patient public patient;
    
    constructor(string memory _diagnosis, string memory _location) {
        patient.diagnosis = _diagnosis;
        patient.location = _location;
    }
    
    function hasDiagnosisOfPrimaryImmuneDeficiency() public view returns (bool) {
        return (keccak256(bytes(patient.diagnosis)) == keccak256(bytes("primary immune deficiency disease")));
    }
    
    function isMedicallyAppropriateForHomeIVIG() public view returns (bool) {
        return (hasDiagnosisOfPrimaryImmuneDeficiency() && keccak256(bytes(patient.location)) == keccak256(bytes("home")));
    }
    
    function isCoveredByMedicarePartB() public view returns (bool) {
        return hasDiagnosisOfPrimaryImmuneDeficiency();
    }
    
    function isNotCoveredByMedicarePartB() public view returns (bool) {
        return !isCoveredByMedicarePartB();
    }
    
    function MedicareCoversIVIG() public view returns (bool) {
        return isCoveredByMedicarePartB();
    }
    
    function MedicareCoversIVIGInHome() public view returns (bool) {
        return MedicareCoversIVIG() && isMedicallyAppropriateForHomeIVIG();
    }
    
    function MedicareDoesNotCoverOtherItemsAndServices() public view returns (bool) {
        return !isCoveredByMedicarePartB();
    }
    
    function MedicareCoversIVIGInHomeWithConditions() public view returns (bool) {
        return MedicareCoversIVIG() && hasDiagnosisOfPrimaryImmuneDeficiency() && isMedicallyAppropriateForHomeIVIG();
    }
    
    function MedicareCoversIVIGInHomeWithoutConditions() public view returns (bool) {
        return MedicareCoversIVIG() && !hasDiagnosisOfPrimaryImmuneDeficiency() && isMedicallyAppropriateForHomeIVIG();
    }
    
    function MedicareDoesNotCoverIVIGInHome() public view returns (bool) {
        return MedicareCoversIVIG() && !isMedicallyAppropriateForHomeIVIG();
    }
    
    function MedicareDoesNotCoverIVIG() public view returns (bool) {
        return !isCoveredByMedicarePartB();
    }
    
    function MedicareCoversIVIGInHomeWithConditionsAndDoesNotCoverOtherItemsAndServices() public view returns (bool) {
        return MedicareCoversIVIGInHomeWithConditions() && MedicareDoesNotCoverOtherItemsAndServices();
    }
    
    function MedicareCoversIVIGInHomeWithoutConditionsAndDoesNotCoverOtherItemsAndServices() public view returns (bool) {
        return MedicareCoversIVIGInHomeWithoutConditions() && MedicareDoesNotCoverOtherItemsAndServices();
    }
    
    function MedicareDoesNotCoverIVIGInHomeAndDoesNotCoverOtherItemsAndServices() public view returns (bool) {
        return MedicareDoesNotCoverIVIGInHome() && MedicareDoesNotCoverOtherItemsAndServices();
    }
}