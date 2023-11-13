pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Patient {
        bool isIVIGProvidedAtHome;
        bool isDiagnosedWithPrimaryImmuneDeficiencyDisease;
        bool isDoctorApprovedIVIGAtHome;
    }

    struct PartB {
        bool isIVIGCovered;
        bool isOtherIVIGRelatedItemsCovered;
    }

    mapping(address => Patient) public patients;
    mapping(address => PartB) public partB;

    function setPatient(address _patient, bool _isIVIGProvidedAtHome, bool _isDiagnosedWithPrimaryImmuneDeficiencyDisease, bool _isDoctorApprovedIVIGAtHome) public {
        patients[_patient] = Patient(_isIVIGProvidedAtHome, _isDiagnosedWithPrimaryImmuneDeficiencyDisease, _isDoctorApprovedIVIGAtHome);
    }

    function setPartB(address _patient, bool _isIVIGCovered, bool _isOtherIVIGRelatedItemsCovered) public {
        partB[_patient] = PartB(_isIVIGCovered, _isOtherIVIGRelatedItemsCovered);
    }

    function isEligibleForIVIGCoverage(address _patient) public view returns (bool) {
        return patients[_patient].isIVIGProvidedAtHome && patients[_patient].isDiagnosedWithPrimaryImmuneDeficiencyDisease && patients[_patient].isDoctorApprovedIVIGAtHome && partB[_patient].isIVIGCovered && !partB[_patient].isOtherIVIGRelatedItemsCovered;
    }
}