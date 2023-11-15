pragma solidity ^0.8.0;

contract IVIGInsurancePolicy {
    struct Patient {
        bool IVIGProvidedAtHome;
        bool diagnosedWithPID;
        bool medicallyAppropriateForIVIGAtHome;
        bool IVIGCoveredUnderPartB;
        bool noCoverageForOtherItemsAndServices;
    }

    mapping(address => Patient) public patients;

    function setPatientStatus(
        address _patientAddress,
        bool _IVIGProvidedAtHome,
        bool _diagnosedWithPID,
        bool _medicallyAppropriateForIVIGAtHome,
        bool _IVIGCoveredUnderPartB,
        bool _noCoverageForOtherItemsAndServices
    ) public {
        Patient storage patient = patients[_patientAddress];
        patient.IVIGProvidedAtHome = _IVIGProvidedAtHome;
        patient.diagnosedWithPID = _diagnosedWithPID;
        patient.medicallyAppropriateForIVIGAtHome = _medicallyAppropriateForIVIGAtHome;
        patient.IVIGCoveredUnderPartB = _IVIGCoveredUnderPartB;
        patient.noCoverageForOtherItemsAndServices = _noCoverageForOtherItemsAndServices;
    }

    function isEligibleForIVIGCoverage(address _patientAddress) public view returns (bool) {
        Patient storage patient = patients[_patientAddress];
        return (
            patient.IVIGProvidedAtHome &&
            patient.diagnosedWithPID &&
            patient.medicallyAppropriateForIVIGAtHome &&
            patient.IVIGCoveredUnderPartB &&
            patient.noCoverageForOtherItemsAndServices
        );
    }
}