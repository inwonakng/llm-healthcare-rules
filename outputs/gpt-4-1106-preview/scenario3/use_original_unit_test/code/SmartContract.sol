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
        uint256 premiumPaid;
        uint256 deductiblePaid;
    }

    // Define constants for policy
    uint256 public constant MONTHLY_PREMIUM = 97.10 ether;
    uint256 public constant ANNUAL_DEDUCTIBLE = 226 ether;
    uint256 public constant COVERAGE_PERCENTAGE = 20;
    uint256 public constant ESRD_COVERAGE_DURATION = 36 * 30 days; // 36 months in days

    // State variables
    mapping(address => PolicyHolder) public policyHolders;

    // Events
    event PolicyUpdated(address policyHolder);
    event PremiumPaid(address policyHolder, uint256 amount);
    event DeductiblePaid(address policyHolder, uint256 amount);
    event ClaimProcessed(address policyHolder, uint256 claimAmount, uint256 amountPaid);

    // Modifier to check if the policy holder is eligible for immunosuppressive drug benefit
    modifier isEligibleForBenefit(address _policyHolder) {
        require(policyHolders[_policyHolder].isEligibleForImmunosuppressiveDrugBenefit, "Not eligible for benefit.");
        _;
    }

    // Function to update policy holder details
    function updatePolicyHolder(
        address _policyHolder,
        bool _hasPartA,
        bool _hasPartB,
        bool _hasPartD,
        bool _hasESRD,
        uint256 _transplantDate
    ) external {
        PolicyHolder storage holder = policyHolders[_policyHolder];
        holder.hasPartA = _hasPartA;
        holder.hasPartB = _hasPartB;
        holder.hasPartD = _hasPartD;
        holder.hasESRD = _hasESRD;
        holder.transplantDate = _transplantDate;

        // Check if the policy holder is eligible for the immunosuppressive drug benefit
        if (_hasESRD && block.timestamp > _transplantDate + ESRD_COVERAGE_DURATION) {
            holder.isEligibleForImmunosuppressiveDrugBenefit = true;
            holder.immunosuppressiveDrugBenefitStartDate = block.timestamp;
        } else {
            holder.isEligibleForImmunosuppressiveDrugBenefit = false;
        }

        emit PolicyUpdated(_policyHolder);
    }

    // Function to pay monthly premium
    function payPremium(address _policyHolder) external payable isEligibleForBenefit(_policyHolder) {
        require(msg.value == MONTHLY_PREMIUM, "Incorrect premium amount.");
        policyHolders[_policyHolder].premiumPaid += msg.value;
        emit PremiumPaid(_policyHolder, msg.value);
    }

    // Function to pay deductible
    function payDeductible(address _policyHolder) external payable isEligibleForBenefit(_policyHolder) {
        require(msg.value == ANNUAL_DEDUCTIBLE, "Incorrect deductible amount.");
        policyHolders[_policyHolder].deductiblePaid += msg.value;
        emit DeductiblePaid(_policyHolder, msg.value);
    }

    // Function to process a claim for immunosuppressive drugs
    function processDrugClaim(address _policyHolder, uint256 _medicareApprovedAmount) external isEligibleForBenefit(_policyHolder) {
        PolicyHolder storage holder = policyHolders[_policyHolder];
        require(holder.premiumPaid >= MONTHLY_PREMIUM, "Monthly premium not paid.");
        require(holder.deductiblePaid >= ANNUAL_DEDUCTIBLE, "Annual deductible not met.");

        uint256 amountToPay = (_medicareApprovedAmount * COVERAGE_PERCENTAGE) / 100;
        emit ClaimProcessed(_policyHolder, _medicareApprovedAmount, amountToPay);
    }
}