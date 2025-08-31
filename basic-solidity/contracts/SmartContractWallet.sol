// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract SmartContractWallet {
    address public owner;
    mapping(address => uint) public allowedToSend;
    

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}

    function transfer(address _to, uint amount) public {
        require(
            msg.sender == owner || allowedToSend[msg.sender] >= amount,
            "Not allowed"
        );

        if (msg.sender != owner) {
            allowedToSend[msg.sender] -= amount; 
        }

        (bool success,) = _to.call{value: amount}("");
        require(success, "Operation Failed");
    }

    function setAllowance(address _address, uint _amount) public {
        require(msg.sender == owner, "Not owner");
        allowedToSend[_address] = _amount; 
    }
}

