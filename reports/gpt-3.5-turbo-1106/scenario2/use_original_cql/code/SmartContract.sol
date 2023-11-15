// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IVIGInsurancePolicy {
    
    struct Patient {
        bool hasPrimaryImmuneDeficiency;
        bool isMedicallyApproved;
    }
    
    function isIVIGCovered(bool _hasPrimaryImmuneDeficiency, bool _isMedicallyApproved) public pure returns (bool) {
        if (_hasPrimaryImmuneDeficiency && _isMedicallyApproved) {
            return true;
        } else {
            return false;
        }
    }
}