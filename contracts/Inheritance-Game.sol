// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;


interface IUser {
     function createUser(address userAddress, string memory username) external;
}

contract Game{
    uint256 public gameCount;
    IUser public userContract;

    constructor(address _userContractAddress){

        userContract = IUser(_userContractAddress);
    }

    function startGame(string memory username) external {

        gameCount++;

        userContract.createUser(msg.sender, username);
    }
}