// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Patient {
        bool ivigAtHome;
        bool diagnosedWithPID;
        bool doctorApproval;
        bool partBCoverage;
        bool otherHomeIVIGServices;
    }

    mapping(address => Patient) public patients;

    function setPatientData(
        address _patient,
        bool _ivigAtHome,
        bool _diagnosedWithPID,
        bool _doctorApproval,
        bool _partBCoverage,
        bool _otherHomeIVIGServices
    ) public {
        Patient storage patient = patients[_patient];
        patient.ivigAtHome = _ivigAtHome;
        patient.diagnosedWithPID = _diagnosedWithPID;
        patient.doctorApproval = _doctorApproval;
        patient.partBCoverage = _partBCoverage;
        patient.otherHomeIVIGServices = _otherHomeIVIGServices;
    }

    function isIVIGCovered(address _patient) public view returns (bool) {
        return patients[_patient].ivigAtHome;
    }

    function isCoveredWithDisease(address _patient) public view returns (bool) {
        return patients[_patient].diagnosedWithPID;
    }

    function isCoveredWithDoctorApproval(address _patient) public view returns (bool) {
        return patients[_patient].doctorApproval;
    }

    function isCoveredUnderPartB(address _patient) public view returns (bool) {
        return patients[_patient].partBCoverage;
    }

    function isOtherItemsCovered(address _patient) public view returns (bool) {
        return !patients[_patient].otherHomeIVIGServices;
    }

    function isEligibleForCoverage(address _patient) public view returns (bool) {
        return isIVIGCovered(_patient) && isCoveredWithDisease(_patient) && isCoveredWithDoctorApproval(_patient) && isCoveredUnderPartB(_patient) && isOtherItemsCovered(_patient);
    }
}