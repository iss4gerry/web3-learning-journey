// SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract BlockchainMessenger {

    uint public balance;

    function deposit() public payable {
        balance += msg.value;        
    }

    function withdrawAll () public {
        payable(msg.sender).transfer(checkContractBalance());        
    }

    function withdrawToAnotherAddress (address receiverAddress) public {
        payable(receiverAddress).transfer(checkContractBalance());        
    }

    function checkContractBalance() public view returns (uint){
        return address(this).balance;
    }

}