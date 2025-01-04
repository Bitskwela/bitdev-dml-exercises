// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedVoting {
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    mapping(address => bool) public registeredVoters;
    mapping(address => bool) public hasVoted;
    mapping(string => uint256) public votes;

    event VoteCast(address voter, string candidate);

    modifier onlyRegistered() {
        // 🏁 ANSWER: Restrict to registered voters
        require(
            registeredVoters[msg.sender],
            "You are not registered to vote!"
        );
        _;
    }

    function registerVoter() public {
        // 🏁 ANSWER: Register a voter
        require(!registeredVoters[msg.sender], "Already registered!");
        registeredVoters[msg.sender] = true;
    }

    function castVote(string memory candidateName) public onlyRegistered {
        // 🏁 ANSWER: Prevent duplicate voting
        require(!hasVoted[msg.sender], "You have already voted!");

        // 🏁 ANSWER: Record the vote
        votes[candidateName]++;
        hasVoted[msg.sender] = true;

        // 🏁 ANSWER: Emit voting event
        emit VoteCast(msg.sender, candidateName);
    }
}
