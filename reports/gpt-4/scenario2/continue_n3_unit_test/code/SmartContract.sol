pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Patient {
        bool hasPrimaryImmuneDeficiency;
        bool medicallyAppropriateForIVIGAtHome;
        bool IVIGProvidedAtHome;
        bool receivesIVIGAtHome;
        bool associatedWithOtherItemsAndServices;
    }

    mapping(address => Patient) public patients;
    mapping(address => bool) public doctors;

    function setPatientDetails(address _patient, bool _hasPrimaryImmuneDeficiency, bool _medicallyAppropriateForIVIGAtHome, bool _IVIGProvidedAtHome, bool _receivesIVIGAtHome, bool _associatedWithOtherItemsAndServices) public {
        patients[_patient] = Patient(_hasPrimaryImmuneDeficiency, _medicallyAppropriateForIVIGAtHome, _IVIGProvidedAtHome, _receivesIVIGAtHome, _associatedWithOtherItemsAndServices);
    }

    function setDoctorDetails(address _doctor) public {
        doctors[_doctor] = true;
    }

    function checkEligibility(address _patient) public view returns(bool) {
        return patients[_patient].hasPrimaryImmuneDeficiency && patients[_patient].medicallyAppropriateForIVIGAtHome && patients[_patient].IVIGProvidedAtHome;
    }

    function checkEligibilityForOtherItemsAndServices(address _patient) public view returns(bool) {
        return !(patients[_patient].receivesIVIGAtHome && patients[_patient].associatedWithOtherItemsAndServices);
    }
}