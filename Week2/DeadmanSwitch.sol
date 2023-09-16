// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract DeadmanSwitch {
    address public owner;
    address payable public backup;
    uint public latestBlock;

    constructor(address payable _backupAddress) {
        owner = msg.sender;
        backup = _backupAddress;
        latestBlock = block.number;
    }

    modifier ownerOnly() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function still_alive() ownerOnly public returns (string memory) {
        latestBlock = block.number;
        return "I am alive";
    }

    function deposit() ownerOnly public payable {
        
    }

    function sendBalance() external  {
        require(block.number - latestBlock >= 10, "Owner still alive");
        uint accountBalance = address(this).balance;
        require(accountBalance > 0, "Balance is nil!");
        backup.transfer(accountBalance);
    }

    receive() external payable {

    }
}