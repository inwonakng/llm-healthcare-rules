pragma solidity ^0.8.0;

contract InsurancePolicyContract {
    struct Procedure {
        string code;
        uint256 birthDate;
        uint256 encounterStart;
        uint256 encounterEnd;
        string providerSpecialty;
    }

    struct Coverage {
        string code;
        address beneficiary;
    }

    function coverageForPrimaryImmuneDeficiency(string memory conditionCode) public pure returns (bool) {
        // Check if the condition code matches primary immune deficiency disease
        return keccak256(bytes(conditionCode)) == keccak256(bytes("Primary Immune Deficiency Disease"));
    }

    function ivigInHomeMedicallyAppropriate(
        string memory procedureCode,
        uint256 birthDate,
        uint256 encounterStart,
        uint256 encounterEnd,
        string memory providerSpecialty
    ) public pure returns (bool) {
        // Check if the procedure code matches IVIG and other conditions are met
        return
            keccak256(bytes(procedureCode)) == keccak256(bytes("Intravenous Immune Globulin (IVIG)")) &&
            birthDate <= block.timestamp - 18 years &&
            encounterStart <= block.timestamp &&
            encounterEnd >= block.timestamp &&
            keccak256(bytes(providerSpecialty)) == keccak256(bytes("General Practice"));
    }

    function ivigCoverageByMedicarePartB(string memory coverageCode) public pure returns (bool) {
        // Check if the coverage code matches Medicare Part B
        return keccak256(bytes(coverageCode)) == keccak256(bytes("Medicare Part B"));
    }

    function nonCoveredItemsAndServices(
        string memory procedureCode,
        uint256 birthDate,
        uint256 encounterStart,
        uint256 encounterEnd,
        string memory providerSpecialty
    ) public pure returns (bool) {
        // Check if the procedure code matches other items and services and other conditions are met
        return
            keccak256(bytes(procedureCode)) == keccak256(bytes("Other Items and Services")) &&
            birthDate <= block.timestamp - 18 years &&
            encounterStart <= block.timestamp &&
            encounterEnd >= block.timestamp &&
            keccak256(bytes(providerSpecialty)) == keccak256(bytes("General Practice"));
    }

    function finalDecision(
        string memory conditionCode,
        string memory procedureCode,
        uint256 birthDate,
        uint256 encounterStart,
        uint256 encounterEnd,
        string memory providerSpecialty,
        string memory coverageCode,
        string memory nonCoveredCode
    ) public pure returns (bool) {
        // Check all the conditions for the final decision
        return
            coverageForPrimaryImmuneDeficiency(conditionCode) &&
            ivigInHomeMedicallyAppropriate(procedureCode, birthDate, encounterStart, encounterEnd, providerSpecialty) &&
            ivigCoverageByMedicarePartB(coverageCode) &&
            !nonCoveredItemsAndServices(procedureCode, birthDate, encounterStart, encounterEnd, providerSpecialty);
    }
}