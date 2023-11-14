pragma solidity ^0.8.0;

contract IVIGCoverage {
    struct Patient {
        address patient;
        bytes32 diagnosis;
        bytes32 medicalJudgment;
    }

    mapping(address => Patient) public patients;

    function isCovered(address patient, bytes32 diagnosis, bytes32 medicalJudgment, bytes32 item) public view returns (bool) {
        // Check if patient has primary immune deficiency disease
        if (diagnosis == "Primary immune deficiency disease") {
            // Check if patient's doctor determines IVIG is medically appropriate
            if (medicalJudgment == "IVIG is medically appropriate for patient") {
                // Check if item is IVIG
                if (item == "IVIG") {
                    return true;
                }
            }
        }
        return false;
    }

    function addPatient(address patient, bytes32 diagnosis, bytes32 medicalJudgment) public {
        patients[patient] = Patient(patient, diagnosis, medicalJudgment);
    }

    function removePatient(address patient) public {
        delete patients[patient];
    }
}