pragma solidity ^0.8.0;

import "./SmartContract.sol";
import "./remix_tests.sol";


contract MyContract {
    function myFunction() public {
        // ...
    }
}

contract TestMyContract {
    function testMyFunction() public {
        MyContract myContract = new MyContract();
        myContract.myFunction();
        // ...
    }
}