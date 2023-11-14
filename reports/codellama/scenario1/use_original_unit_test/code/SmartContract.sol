pragma solidity ^0.8.0;

contract InjectableOsteoporosisDrugs {
    struct Patient {
        address patientAddress;
        string patientName;
        uint256 patientAge;
        bool isFemale;
        bool hasOsteoporosis;
        bool hasBoneFracture;
        bool canGiveInjection;
        bool hasFamilyOrCaregivers;
    }

    mapping(address => Patient) public patients;

    function addPatient(
        address patientAddress,
        string memory patientName,
        uint256 patientAge,
        bool isFemale,
        bool hasOsteoporosis,
        bool hasBoneFracture,
        bool canGiveInjection,
        bool hasFamilyOrCaregivers
    ) public {
        patients[patientAddress] = Patient(
            patientAddress,
            patientName,
            patientAge,
            isFemale,
            hasOsteoporosis,
            hasBoneFracture,
            canGiveInjection,
            hasFamilyOrCaregivers
        );
    }

    function isEligibleForMedicareCoverage(address patientAddress) public view returns (bool) {
        Patient memory patient = patients[patientAddress];

        if (patient.isFemale && patient.hasOsteoporosis && patient.hasBoneFracture && !patient.canGiveInjection) {
            if (patient.hasFamilyOrCaregivers) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }
}