// SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract ExampleMapping {
    mapping(address => uint) public balance;

    function getBalance () public view returns (uint) { 
        return address(this).balance;
    }

    function deposit () public payable {
        balance[msg.sender] += msg.value;   
    } 

    function withdraw() public {
        uint amount = balance[msg.sender];
        balance[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
}
