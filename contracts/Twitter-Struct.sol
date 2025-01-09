// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract Twitter {

    uint16 constant MAX_TWEET_LENGTH = 280;

    // Define a struct called 'Tweet' to store information about each tweet.
    struct Tweet {
        address author;        
        string content;       
        uint256 timestamps;    // The timestamp when the tweet was created (block time).
        uint256 likes;        
    }

    // Create a mapping that links each address (user) to an array of tweets.
    // The 'tweets' mapping stores multiple tweets for each address.
    mapping(address => Tweet[]) public tweets;

    // Function to create a new tweet.
    function createTweet(string memory _tweet) public {

        require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "Tweet is too long bro: " );

        // Create a new Tweet struct with the user's address, tweet content, current timestamp, and initial like count of 0.
        Tweet memory newTweet = Tweet({
            author: msg.sender,      
            content: _tweet,           
            timestamps: block.timestamp, 
            likes: 0                   
        });

        // Add the new tweet to the list of tweets for the sender's address in the 'tweets' mapping.
        tweets[msg.sender].push(newTweet);
    }

    // Function to get a specific tweet by index from a user's list of tweets.
    // The function takes the address of the user and the index of the tweet.
    function getTweet( uint256 _i) public view returns (Tweet memory) {

        // Return the tweet at the specified index from the list of tweets for the given address (_owner).
        return tweets[msg.sender][_i];
    }

    // Function to get all tweets from a specific user.
    // The function takes the user's address and returns an array of all tweets.
    
    function getAllTweets(address _owner) public view returns (Tweet[] memory) {

        // Return the entire array of tweets for the specified user (_owner).
        return tweets[_owner];
    }
}
