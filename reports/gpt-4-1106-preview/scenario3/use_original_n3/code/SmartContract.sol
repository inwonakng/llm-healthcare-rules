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

    // Define constants for the policy
    uint256 public constant MONTHLY_PREMIUM = 97.10 ether;
    uint256 public constant ANNUAL_DEDUCTIBLE = 226 ether;
    uint256 public constant COVERAGE_PERCENTAGE = 20;
    uint256 public constant ESRD_COVERAGE_DURATION = 36 months;

    // State variables
    mapping(address => PolicyHolder) public policyHolders;

    // Events
    event PolicyUpdated(address policyHolder);
    event PremiumPaid(address policyHolder, uint256 amount);
    event DeductiblePaid(address policyHolder, uint256 amount);
    event BenefitClaimed(address policyHolder, uint256 amount);

    // Modifier to check eligibility for immunosuppressive drug benefit
    modifier isEligibleForBenefit(address _policyHolder) {
        require(policyHolders[_policyHolder].isEligibleForImmunosuppressiveDrugBenefit, "Not eligible for benefit.");
        _;
    }

    // Function to enroll a policy holder
    function enrollPolicyHolder(
        address _policyHolder,
        bool _hasPartA,
        bool _hasPartB,
        bool _hasPartD,
        bool _hasESRD,
        uint256 _transplantDate
    ) external {
        policyHolders[_policyHolder] = PolicyHolder({
            hasPartA: _hasPartA,
            hasPartB: _hasPartB,
            hasPartD: _hasPartD,
            hasESRD: _hasESRD,
            transplantDate: _transplantDate,
            isEligibleForImmunosuppressiveDrugBenefit: false,
            immunosuppressiveDrugBenefitStartDate: 0,
            premiumPaid: 0,
            deductiblePaid: 0
        });
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

    // Function to claim immunosuppressive drug benefit
    function claimImmunosuppressiveDrugBenefit(address _policyHolder, uint256 _medicareApprovedAmount) external isEligibleForBenefit(_policyHolder) {
        require(policyHolders[_policyHolder].deductiblePaid >= ANNUAL_DEDUCTIBLE, "Deductible not met.");
        uint256 benefitAmount = (_medicareApprovedAmount * COVERAGE_PERCENTAGE) / 100;
        emit BenefitClaimed(_policyHolder, benefitAmount);
    }

    // Function to check eligibility for immunosuppressive drug benefit
    function checkEligibility(address _policyHolder) external {
        PolicyHolder storage holder = policyHolders[_policyHolder];
        if (holder.hasESRD && (block.timestamp - holder.transplantDate) > ESRD_COVERAGE_DURATION) {
            holder.isEligibleForImmunosuppressiveDrugBenefit = false;
        } else if (holder.hasPartA && holder.hasPartB && !holder.hasPartD) {
            holder.isEligibleForImmunosuppressiveDrugBenefit = true;
            holder.immunosuppressiveDrugBenefitStartDate = block.timestamp;
        }
        emit PolicyUpdated(_policyHolder);
    }
}