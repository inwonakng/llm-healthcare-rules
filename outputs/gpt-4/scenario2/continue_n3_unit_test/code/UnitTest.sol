```
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";

contract InsurancePolicyTest {
    InsurancePolicy insurance = InsurancePolicy(DeployedAddresses.InsurancePolicy());

    function testEligibleForCoverage() public {
        bool result = insurance.checkCoverage(
            InsurancePolicy.Patient({
                diagnosis: InsurancePolicy.Diagnosis.PrimaryImmuneDeficiencyDisease,
                treatment: InsurancePolicy.Treatment.IVIG,
                location: InsurancePolicy.Location.Home,
                doctorApproval: true,
                additionalServices: false
            })
        );
        Assert.equal(result, true, "Patient with primary immune deficiency disease, receiving IVIG at home with doctor's approval should be covered");
    }

    function testNotCoveredForAdditionalServices() public {
        bool result = insurance.checkCoverage(
            InsurancePolicy.Patient({
                diagnosis: InsurancePolicy.Diagnosis.PrimaryImmuneDeficiencyDisease,
                treatment: InsurancePolicy.Treatment.IVIG,
                location: InsurancePolicy.Location.Home,
                doctorApproval: true,
                additionalServices: true
            })
        );
        Assert.equal(result, false, "Additional services related to IVIG treatment at home are not covered");
    }
}