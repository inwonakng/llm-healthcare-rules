```
pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract InsurancePolicyTest {
    InsurancePolicy insurancePolicy;
    
    function beforeEach() public {
        insurancePolicy = new InsurancePolicy();
    }

    function checkEligibilityForInjectableOsteoporosisDrugCoverage() public {
        Beneficiary memory beneficiary = Beneficiary({
            isFemale: true,
            hasOsteoporosis: true,
            qualifiesForMedicareHomeHealthBenefit: true,
            hasCertifiedPostMenopausalOsteoporosisFracture: true,
            unableToSelfAdministerInjection: true,
            hasUnwillingOrUnableFamilyOrCaregiver: false
        });
        
        Assert.equal(insurancePolicy.checkEligibility(beneficiary), true, "Beneficiary should be eligible for injectable osteoporosis drug coverage");
    }

    function checkEligibilityForHomeHealthNurseOrAideCoverage() public {
        Beneficiary memory beneficiary = Beneficiary({
            isFemale: true,
            hasOsteoporosis: true,
            qualifiesForMedicareHomeHealthBenefit: true,
            hasCertifiedPostMenopausalOsteoporosisFracture: true,
            unableToSelfAdministerInjection: true,
            hasUnwillingOrUnableFamilyOrCaregiver: true
        });
        
        Assert.equal(insurancePolicy.checkEligibility(beneficiary), true, "Beneficiary should be eligible for home health nurse or aide coverage");
    }
}