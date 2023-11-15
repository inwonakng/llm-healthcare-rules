// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicareInsurancePolicy {
    enum Diagnosis { None, PrimaryImmuneDeficiencyDisease }
    enum IVIGCoverageDecision { NotSet, Covered, NotCovered }

    struct Patient {
        Diagnosis diagnosis;
    }

    struct Doctor {
        bool hasDeterminedIVIGInHomeMedicallyAppropriate;
    }

    struct MedicarePartB {
        bool coversIVIG;
        bool doesNotCoverOthers;
    }

    function isIVIGCovered(
        Patient memory patient,
        Doctor memory doctor,
        MedicarePartB memory medicarePartB
    ) public pure returns (IVIGCoverageDecision) {
        if (patient.diagnosis == Diagnosis.PrimaryImmuneDeficiencyDisease &&
            doctor.hasDeterminedIVIGInHomeMedicallyAppropriate &&
            medicarePartB.coversIVIG &&
            medicarePartB.doesNotCoverOthers) {
            return IVIGCoverageDecision.Covered;
        } else {
            return IVIGCoverageDecision.NotCovered;
        }
    }
}