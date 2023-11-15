pragma solidity ^0.8.0;

contract MedicareInsurancePolicy {
    struct CoveragePeriod {
        uint256 start;
        uint256 end;
    }

    struct InsurancePolicy {
        bool partA;
        bool partB;
        bool partD;
        bool originalMedicare;
        bool medicareDrugPlan;
        bool otherHealthCoverage;
        uint256 premium;
        uint256 deductible;
        bool deductibleMet;
    }

    struct Procedure {
        bool organTransplant;
        bool kidneyTransplant;
        uint256 performedAt;
    }

    struct Medication {
        bool transplantDrugTherapy;
        bool immunosuppressiveDrugs;
        uint256 orderedAt;
    }

    struct Diagnosis {
        bool ESRD;
    }

    struct Patient {
        CoveragePeriod medicareCoveragePeriod;
        CoveragePeriod partACoveragePeriod;
        CoveragePeriod partBCoveragePeriod;
        CoveragePeriod partDCoveragePeriod;
        InsurancePolicy insurancePolicy;
        Procedure procedure;
        Medication medication;
        Diagnosis diagnosis;
    }

    mapping(address => Patient) public patients;

    function medicareCoversTransplantDrugTherapy(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return patient.medication.transplantDrugTherapy && (patient.procedure.organTransplant >= patient.medicareCoveragePeriod.start && patient.procedure.organTransplant <= patient.medicareCoveragePeriod.end);
    }

    function hasPartAAtTimeOfTransplant(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return patient.procedure.organTransplant >= patient.partACoveragePeriod.start && patient.procedure.organTransplant <= patient.partACoveragePeriod.end;
    }

    function hasPartBAtTimeOfImmunosuppressiveDrugs(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return patient.medication.immunosuppressiveDrugs >= patient.partBCoveragePeriod.start && patient.medication.immunosuppressiveDrugs <= patient.partBCoveragePeriod.end;
    }

    function partDCoversImmunosuppressiveDrugs(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return !hasPartBAtTimeOfImmunosuppressiveDrugs(_patient) && patient.medication.immunosuppressiveDrugs >= patient.partDCoveragePeriod.start && patient.medication.immunosuppressiveDrugs <= patient.partDCoveragePeriod.end;
    }

    function hasOriginalMedicareAndJoinsDrugPlan(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return patient.insurancePolicy.originalMedicare && patient.insurancePolicy.medicareDrugPlan;
    }

    function medicareCoverageEndsAfterKidneyTransplant(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return patient.diagnosis.ESRD && patient.procedure.kidneyTransplant + 36 months <= patient.medicareCoveragePeriod.end;
    }

    function partACoverageEndsAfterKidneyTransplant(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return patient.procedure.kidneyTransplant + 36 months <= patient.partACoveragePeriod.end;
    }

    function hasOtherHealthCoverage(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return patient.insurancePolicy.otherHealthCoverage;
    }

    function benefitCoversOnlyImmunosuppressiveDrugs(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return partACoverageEndsAfterKidneyTransplant(_patient) && !hasOtherHealthCoverage(_patient) && patient.medication.immunosuppressiveDrugs;
    }

    function signUpForBenefitAfterPartAEnds(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return partACoverageEndsAfterKidneyTransplant(_patient);
    }

    function monthlyPremiumAndDeductibleIn2023(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return patient.insurancePolicy.premium == 97.10 ether && patient.insurancePolicy.deductible == 226 ether;
    }

    function pay20PercentAfterDeductible(address _patient) public view returns (bool) {
        Patient memory patient = patients[_patient];
        return patient.insurancePolicy.deductibleMet && patient.medication.immunosuppressiveDrugs;
    }
}