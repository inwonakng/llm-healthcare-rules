```
pragma solidity ^0.8.0;

contract InsurancePolicy {
    enum Diagnosis { PrimaryImmuneDeficiencyDisease }
    enum Treatment { IVIG }
    enum Location { Home }

    struct Patient {
        Diagnosis diagnosis;
        Treatment treatment;
        Location location;
        bool doctorApproval;
        bool additionalServices;
    }

    function checkCoverage(Patient memory patient) public pure returns (bool) {
        if (patient.diagnosis == Diagnosis.PrimaryImmuneDeficiencyDisease &&
            patient.treatment == Treatment.IVIG &&
            patient.location == Location.Home &&
            patient.doctorApproval == true &&
            patient.additionalServices == false) {
            return true;
        } else {
            return false;
        }
    }
}