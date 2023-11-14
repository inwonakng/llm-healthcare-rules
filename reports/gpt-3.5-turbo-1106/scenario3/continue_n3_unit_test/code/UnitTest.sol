// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract InsurancePolicyTest {
    YourContract yourContract;

    function beforeAll() public {
        yourContract = new YourContract();
    }

    // Test for Rule 1: Medicare covers transplant drug therapy if Medicare helped pay for the organ transplant.
    function testTransplantDrugTherapyCoverage() public {
        bool result = yourContract.checkTransplantDrugTherapyCoverage(true, true);
        Assert.equal(result, true, "Transplant drug therapy coverage should be true");
    }

    // Test for Rule 2: The patient must have Part A at the time of the covered transplant.
    function testPartARequirement() public {
        bool result = yourContract.checkPartARequirement(true);
        Assert.equal(result, true, "Patient must have Part A at the time of the covered transplant");
    }

    // Test for Rule 3: The patient must have Part B at the time of getting immunosuppressive drugs.
    function testPartBRequirement() public {
        bool result = yourContract.checkPartBRequirement(true);
        Assert.equal(result, true, "Patient must have Part B at the time of getting immunosuppressive drugs");
    }

    // Test for Rule 4: Medicare drug coverage (Part D) covers immunosuppressive drugs if Part B doesn’t cover them.
    function testImmunosuppressiveDrugCoverageWithPartD() public {
        bool result = yourContract.checkImmunosuppressiveDrugCoverageWithPartD(true, true);
        Assert.equal(result, true, "Medicare drug coverage should cover immunosuppressive drugs if Part B doesn’t cover them");
    }

    // Test for Rule 5: If the patient has Original Medicare, they may join a Medicare drug plan to get Medicare drug coverage.
    function testJoinMedicareDrugPlan() public {
        bool result = yourContract.checkJoinMedicareDrugPlan(true);
        Assert.equal(result, true, "Patient with Original Medicare may join a Medicare drug plan");
    }

    // Test for Rule 6: If the patient only has Medicare because of End-Stage Renal Disease (ESRD), their Medicare coverage, including immunosuppressive drug coverage, ends 36 months after a successful kidney transplant.
    function testMedicareCoverageEndsAfter36Months() public {
        bool result = yourContract.checkMedicareCoverageEndsAfter36Months(true);
        Assert.equal(result, true, "Medicare coverage, including immunosuppressive drug coverage, ends 36 months after a successful kidney transplant for ESRD patients");
    }

    // Test for Rule 7: Medicare offers a benefit if the patient loses Part A coverage 36 months after a kidney transplant and doesn’t have certain types of other health coverage.
    function testReceiveImmunosuppressiveDrugBenefit() public {
        bool result = yourContract.checkReceiveImmunosuppressiveDrugBenefit(true);
        Assert.equal(result, true, "Patient may receive the immunosuppressive drug benefit under certain conditions");
    }

    // Test for Rule 8: The monthly premium for the immunosuppressive drug benefit in 2023 is $97.10 and there is a $226 deductible.
    function testImmunosuppressiveDrugBenefitDetails() public {
        bool result = yourContract.checkImmunosuppressiveDrugBenefitDetails(97.10, 226, true);
        Assert.equal(result, true, "The monthly premium and deductible for the immunosuppressive drug benefit in 2023 are as expected");
    }

    // Test for Rule 9: Once the deductible is met, the patient will pay 20% of the Medicare-approved amount for immunosuppressive drugs.
    function testPay20PercentForImmunosuppressiveDrugs() public {
        bool result = yourContract.checkPay20PercentForImmunosuppressiveDrugs(true);
        Assert.equal(result, true, "Once the deductible is met, the patient will pay 20% for immunosuppressive drugs");
    }
}