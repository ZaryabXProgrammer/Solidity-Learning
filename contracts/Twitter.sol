// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract Twitter {

        


    mapping(address => string[]) public tweets;
   

    function createTweet(string memory _tweet) public {
        

        tweets[msg.sender].push(_tweet);
        
    }

    function getTweet(address _owner, uint _i) public view returns (string memory) {
        
        return tweets[_owner][_i];
        // Return the tweet at index `_i` from the array of tweets for the given address (`_owner`).
    }

    function getAllTweets(address _owner) public view returns (string[] memory) {
      

        return tweets[_owner];
        // Return the array of all tweets stored in the `tweets` mapping for the given address (`_owner`).
    }
}
