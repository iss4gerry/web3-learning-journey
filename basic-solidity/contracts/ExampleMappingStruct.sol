// SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract MappingStruct {
    struct Transaction {
        uint amount;
        uint timestamp;
    }

    struct Balance {
        uint totalBalance;
        uint numDeposit;
        mapping(uint => Transaction) transactions;
        uint numWithdrawals;
        mapping(uint => Transaction) withdrawals;
    }

    mapping(address => Balance) public balance;

    function getTransaction(address _from, uint _index) public view returns(Transaction memory){
        return balance[_from].transactions[_index];
    }

    function getWithdrawal(address _from, uint _index) public view returns(Transaction memory) {
        return balance[_from].withdrawals[_index];
    }

    function deposit () public payable {
        balance[msg.sender].totalBalance += msg.value;
        balance[msg.sender].transactions[balance[msg.sender].numDeposit] = Transaction(msg.value, block.timestamp);
        balance[msg.sender].numDeposit++;
    }

    function withdraw (address payable _to, uint _amount) public {
        balance[msg.sender].totalBalance -= _amount;
        balance[msg.sender].withdrawals[balance[msg.sender].numWithdrawals] = Transaction(_amount, block.timestamp);
        balance[msg.sender].numWithdrawals++;
        _to.transfer(_amount);
    }
}
