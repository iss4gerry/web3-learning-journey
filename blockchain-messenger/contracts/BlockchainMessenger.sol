// SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract BlockchainMessenger {
    uint public changeCounter;

    address public owner;

    string public message;

    constructor(){
        owner = msg.sender;
    }

    function updateMessage (string memory _message) public {
        if(owner == msg.sender){
            changeCounter++;
            message = _message;
        }else {
            message = "You're not the owner";
        }        
    }
}