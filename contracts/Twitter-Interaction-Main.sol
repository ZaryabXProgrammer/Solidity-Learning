// SPDX-License-Identifier: MIT


import "@openzeppelin/contracts/access/Ownable.sol";

pragma solidity ^0.8.26;

interface IProfile{
    struct UserProfile{
        string displayName;
        string bio;
    }

 function getProfile(address _user) external view returns(UserProfile memory);

}

contract Twitter is Ownable {

    uint16 public MAX_TWEET_LENGTH = 280;

    struct Tweet {
        uint256 id;
        address author;        
        string content;       
        uint256 timestamps;    
        uint256 likes;        
    }

    mapping(address => Tweet[]) public tweets;

    IProfile profileContract;

    event TweetCreated(uint256 id, address author, string content, uint256 timestamps);
    event TweetLiked(address liker, address tweetAuthor, uint256 id, uint256 newLikeCount);
    event TweetUnliked(address unliker, address tweetAuthor, uint256 id, uint256 newLikeCount);

    modifier onlyRegistered(){
        
        IProfile.UserProfile memory userProfileTemp = profileContract.getProfile(msg.sender);

        require(bytes(userProfileTemp.displayName).length > 0,"User not Registered" );


        _;
    }

    // Constructor to pass the initial owner to the Ownable contract
    constructor(address _profileContract) Ownable(msg.sender) {
        // You can add any additional initialization logic here if needed
        profileContract = IProfile(_profileContract);
    }

    function changeTweetLength(uint16 newTweetLength) public onlyOwner {
        MAX_TWEET_LENGTH = newTweetLength;
    }

    function createTweet(string memory _tweet) public onlyRegistered{
        require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "Tweet is too long bro: ");
        
        Tweet memory newTweet = Tweet({
            id: tweets[msg.sender].length,
            author: msg.sender,
            content: _tweet,
            timestamps: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTweet);
        emit TweetCreated(newTweet.id, newTweet.author, newTweet.content, newTweet.timestamps);
    }

    function likeTweet(address author, uint256 id) external onlyRegistered {
        require(id < tweets[author].length && tweets[author][id].id == id, "Tweet Does Not Exist");
        
        tweets[author][id].likes++;
        emit TweetLiked(msg.sender, author, id, tweets[author][id].likes);
    }

    function unlikeTweet(address author, uint256 id) external onlyRegistered {
        require(id < tweets[author].length && tweets[author][id].id == id, "Tweet Does Not Exist");
        require(tweets[author][id].likes > 0, "Tweets has no likes");
        
        tweets[author][id].likes--;
        emit TweetUnliked(msg.sender, author, id, tweets[author][id].likes);
    }

    function getTweet(uint256 _i) public view returns (Tweet memory) {
        return tweets[msg.sender][_i];
    }

    function getAllTweets(address _owner) public view returns (Tweet[] memory) {
        return tweets[_owner];
    }
}
