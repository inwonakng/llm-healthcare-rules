// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicareInsurancePolicy {
    // Define a struct to encapsulate policy holder details
    struct PolicyHolder {
        bool hasPartA;
        bool hasPartB;
        bool hasPartD;
        bool hasESRD;
        uint256 transplantDate;
        bool isEligibleForImmunosuppressiveDrugBenefit;
        uint256 immunosuppressiveDrugBenefitStartDate;
        uint256 paidDeductible;
    }

    // Define constants for the policy
    uint256 public constant IMMUNOSUPPRESSIVE_DRUG_BENEFIT_PERIOD = 36 * 30 days; // 36 months
    uint256 public constant MONTHLY_PREMIUM = 97.10 ether;
    uint256 public constant ANNUAL_DEDUCTIBLE = 226 ether;
    uint256 public constant COINSURANCE_PERCENTAGE = 20;

    // State variables
    mapping(address => PolicyHolder) public policyHolders;
    uint256 public medicareApprovedAmount;

    // Events
    event SignedUpForBenefit(address indexed policyHolder, uint256 startDate);
    event PremiumPaid(address indexed policyHolder, uint256 amount);
    event DeductiblePaid(address indexed policyHolder, uint256 amount);
    event CoinsurancePaid(address indexed policyHolder, uint256 amount);

    // Modifier to check eligibility for immunosuppressive drug benefit
    modifier onlyEligibleForImmunosuppressiveDrugBenefit(address _policyHolder) {
        require(
            policyHolders[_policyHolder].isEligibleForImmunosuppressiveDrugBenefit,
            "Not eligible for immunosuppressive drug benefit"
        );
        _;
    }

    // Function to sign up for the immunosuppressive drug benefit
    function signUpForImmunosuppressiveDrugBenefit(address _policyHolder) external {
        PolicyHolder storage holder = policyHolders[_policyHolder];
        require(holder.hasPartA, "Must have Part A for coverage");
        require(!holder.hasESRD || (holder.hasESRD && block.timestamp > holder.transplantDate + IMMUNOSUPPRESSIVE_DRUG_BENEFIT_PERIOD), "ESRD coverage period has not ended");
        holder.isEligibleForImmunosuppressiveDrugBenefit = true;
        holder.immunosuppressiveDrugBenefitStartDate = block.timestamp;
        emit SignedUpForBenefit(_policyHolder, block.timestamp);
    }

    // Function to pay monthly premium
    function payMonthlyPremium(address _policyHolder) external payable onlyEligibleForImmunosuppressiveDrugBenefit(_policyHolder) {
        require(msg.value == MONTHLY_PREMIUM, "Incorrect premium amount");
        emit PremiumPaid(_policyHolder, msg.value);
    }

    // Function to pay deductible
    function payDeductible(address _policyHolder) external payable onlyEligibleForImmunosuppressiveDrugBenefit(_policyHolder) {
        PolicyHolder storage holder = policyHolders[_policyHolder];
        uint256 remainingDeductible = ANNUAL_DEDUCTIBLE - holder.paidDeductible;
        require(msg.value <= remainingDeductible, "Excess payment over deductible");
        holder.paidDeductible += msg.value;
        emit DeductiblePaid(_policyHolder, msg.value);
    }

    // Function to pay coinsurance for immunosuppressive drugs
    function payCoinsurance(address _policyHolder) external payable onlyEligibleForImmunosuppressiveDrugBenefit(_policyHolder) {
        PolicyHolder storage holder = policyHolders[_policyHolder];
        require(holder.paidDeductible == ANNUAL_DEDUCTIBLE, "Deductible not met");
        uint256 coinsuranceAmount = (medicareApprovedAmount * COINSURANCE_PERCENTAGE) / 100;
        require(msg.value == coinsuranceAmount, "Incorrect coinsurance amount");
        emit CoinsurancePaid(_policyHolder, msg.value);
    }

    // Function to set the Medicare-approved amount for immunosuppressive drugs
    function setMedicareApprovedAmount(uint256 _amount) external {
        medicareApprovedAmount = _amount;
    }

    // Function to check if a policy holder is eligible for immunosuppressive drug benefit
    function checkEligibility(address _policyHolder) external view returns (bool) {
        PolicyHolder storage holder = policyHolders[_policyHolder];
        return holder.isEligibleForImmunosuppressiveDrugBenefit;
    }
}