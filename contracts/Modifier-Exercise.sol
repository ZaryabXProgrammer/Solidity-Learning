// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract PausableToken {

    address public owner;
    bool public paused;
    mapping(address => uint) public balances;

    constructor() {
        owner = msg.sender;
        paused = false;
        balances[owner] = 1000;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    modifier notPaused() {
        require(paused == false, "The Contract is paused");
        _;
    }

    function pause() public onlyOwner {
        paused = true;
    }

    function unpause() public onlyOwner {
        paused = false;
    }

    function transfer(address to, uint amount) public notPaused {
        require(balances[msg.sender] >= amount, "Insufficient Balance");

        balances[msg.sender] -= amount;
        balances[to] += amount;
    }
}
