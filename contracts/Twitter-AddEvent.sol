// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract Twitter {

    uint16 public MAX_TWEET_LENGTH = 280;

    struct Tweet {
        uint256 id;
        address author;        
        string content;       
        uint256 timestamps;    
        uint256 likes;        
    }

    mapping(address => Tweet[]) public tweets;

    address public owner;


    event TweetCreated(uint256 id, address author, string content, uint256 timestamps);

    event TweetLiked(address liker, address tweetAuthor, uint256 id, uint256 newLikeCount);

    event TweetUnliked(address unliker, address tweetAuthor, uint256 id, uint256 newLikeCount);

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "YOU ARE NOT THE OWNER");
        _;
    }

    function changeTweetLength(uint16 newTweetLength ) public onlyOwner {
        MAX_TWEET_LENGTH = newTweetLength;
    }

   
    function createTweet(string memory _tweet) public {

        require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "Tweet is too long bro: " );

        
        Tweet memory newTweet = Tweet({
            id: tweets[msg.sender].length,
            author: msg.sender,      
            content: _tweet,           
            timestamps: block.timestamp, 
            likes: 0                   
        });

        // Add the new tweet to the list of tweets for the sender's address in the 'tweets' mapping.
        tweets[msg.sender].push(newTweet);

        emit TweetCreated(newTweet.id, newTweet.author, newTweet.content,
         newTweet.timestamps);
    }

    function likeTweet(address author, uint256 id) external {

        require(tweets[author][id].id == id, "Tweet Does Not Exist");

        tweets[author][id].likes++;

        emit TweetLiked( msg.sender, author, id, tweets[author][id].likes);
    }

    function unlikeTweet(address author, uint256 id) external {

  
        require(tweets[author][id].id == id, "Tweet Does Not Exist");
        require(tweets[author][id].likes > 0, "Tweets has no likes");
        tweets[author][id].likes--;

        emit TweetUnliked(msg.sender, author, id, tweets[author][id].likes);
    }

  
    function getTweet( uint256 _i) public view returns (Tweet memory) {

       
        return tweets[msg.sender][_i];
    }

  
    function getAllTweets(address _owner) public view returns (Tweet[] memory) {

        return tweets[_owner];
    }
}
