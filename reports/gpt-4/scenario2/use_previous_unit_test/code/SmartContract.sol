// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InsurancePolicy {
    struct Insured {
        bool hasPrimaryImmuneDeficiency;
        bool isMedicallyAppropriateForIVIG;
    }

    mapping(address => Insured) public insureds;

    function setInsured(address _insured, bool _hasPrimaryImmuneDeficiency, bool _isMedicallyAppropriateForIVIG) public {
        insureds[_insured] = Insured(_hasPrimaryImmuneDeficiency, _isMedicallyAppropriateForIVIG);
    }

    function isIVIGCoveredAtHome(address _insured) public view returns (bool) {
        return insureds[_insured].hasPrimaryImmuneDeficiency && insureds[_insured].isMedicallyAppropriateForIVIG;
    }

    function isCoveredForPrimaryImmuneDeficiency(address _insured) public view returns (bool) {
        return insureds[_insured].hasPrimaryImmuneDeficiency;
    }

    function isMedicallyAppropriate(address _insured) public view returns (bool) {
        return insureds[_insured].isMedicallyAppropriateForIVIG;
    }

    function isPartBCoveringIVIG(address _insured) public view returns (bool) {
        return insureds[_insured].hasPrimaryImmuneDeficiency && insureds[_insured].isMedicallyAppropriateForIVIG;
    }

    function isPartBNotCoveringOtherItems(address _insured) public view returns (bool) {
        return insureds[_insured].hasPrimaryImmuneDeficiency && insureds[_insured].isMedicallyAppropriateForIVIG;
    }
}