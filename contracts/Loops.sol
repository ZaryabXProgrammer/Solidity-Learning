// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract ExpenseTracker{

    struct Expense{
        address user;
        string description;
        uint256 amount;
    }

    Expense[] public expenses;

    constructor(){
        expenses.push(Expense(msg.sender, "Groceries", 50));
        expenses.push(Expense(msg.sender, "Transportation", 30));
        expenses.push(Expense(msg.sender, "Dining Out", 25));
    }


    function addExpense(string memory _description, uint256 _amount) public {

        expenses.push(Expense(msg.sender, _description, _amount));

    }

    function getTotalExpense(address _user) public view returns(uint256){
        
        uint256 totalExpenses;

        for (uint i; i < expenses.length; i++) 
        {
            if(expenses[i].user == _user){
                totalExpenses += expenses[i].amount;
            }
        }

        return totalExpenses;







    }

}