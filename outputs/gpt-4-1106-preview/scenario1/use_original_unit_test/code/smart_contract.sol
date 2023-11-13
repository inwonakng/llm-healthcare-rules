// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InjectableOsteoporosisDrugCoverage {

    struct Patient {
        bool isWoman;
        bool hasOsteoporosis;
        bool hasBoneFracture;
        bool canSelfInject;
        bool hasMedicare;
        bool hasHomeHealthBenefit;
    }

    struct DoctorCertification {
        bool fractureRelatedToOsteoporosis;
        bool patientCannotSelfInject;
    }

    struct HomeHealthService {
        bool nurseAvailable;
        bool aideAvailable;
        bool familyUnableToInject;
    }

    mapping(address => Patient) public patients;
    mapping(address => DoctorCertification) public doctorCertifications;
    mapping(address => HomeHealthService) public homeHealthServices;

    // Event to log the coverage decision
    event CoverageDecision(address patient, bool isCovered);

    // Modifier to check if the caller is a registered patient
    modifier onlyRegisteredPatient(address _patientAddress) {
        require(patients[_patientAddress].hasMedicare, "Patient is not registered or does not have Medicare.");
        _;
    }

    // Function to register a patient
    function registerPatient(
        address _patientAddress,
        bool _isWoman,
        bool _hasOsteoporosis,
        bool _hasBoneFracture,
        bool _canSelfInject,
        bool _hasHomeHealthBenefit
    ) external {
        patients[_patientAddress] = Patient({
            isWoman: _isWoman,
            hasOsteoporosis: _hasOsteoporosis,
            hasBoneFracture: _hasBoneFracture,
            canSelfInject: _canSelfInject,
            hasMedicare: true,
            hasHomeHealthBenefit: _hasHomeHealthBenefit
        });
    }

    // Function to record doctor's certification
    function certifyPatient(
        address _patientAddress,
        bool _fractureRelatedToOsteoporosis,
        bool _patientCannotSelfInject
    ) external onlyRegisteredPatient(_patientAddress) {
        doctorCertifications[_patientAddress] = DoctorCertification({
            fractureRelatedToOsteoporosis: _fractureRelatedToOsteoporosis,
            patientCannotSelfInject: _patientCannotSelfInject
        });
    }

    // Function to record home health service availability
    function recordHomeHealthService(
        address _patientAddress,
        bool _nurseAvailable,
        bool _aideAvailable,
        bool _familyUnableToInject
    ) external onlyRegisteredPatient(_patientAddress) {
        homeHealthServices[_patientAddress] = HomeHealthService({
            nurseAvailable: _nurseAvailable,
            aideAvailable: _aideAvailable,
            familyUnableToInject: _familyUnableToInject
        });
    }

    // Function to check coverage eligibility
    function checkCoverageEligibility(address _patientAddress) external onlyRegisteredPatient(_patientAddress) returns (bool) {
        Patient memory patient = patients[_patientAddress];
        DoctorCertification memory certification = doctorCertifications[_patientAddress];
        HomeHealthService memory service = homeHealthServices[_patientAddress];

        bool isEligible = patient.isWoman &&
                          patient.hasOsteoporosis &&
                          patient.hasBoneFracture &&
                          !patient.canSelfInject &&
                          patient.hasHomeHealthBenefit &&
                          certification.fractureRelatedToOsteoporosis &&
                          certification.patientCannotSelfInject &&
                          (service.nurseAvailable || service.aideAvailable || service.familyUnableToInject);

        emit CoverageDecision(_patientAddress, isEligible);
        return isEligible;
    }
}