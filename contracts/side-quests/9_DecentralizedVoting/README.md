# Sidequest #9: Decentralized Voting System

## Backstory:

With Hackana’s minions wreaking havoc, trust in local governance has been severely impacted. Residents in San Juan and nearby cities demand a decentralized voting system for barangay leaders to ensure transparency, fairness, and tamper-proof elections.

Neri, equipped with her blockchain expertise, is tasked with designing a Solidity-based voting smart contract. This system must allow registered voters to cast their votes securely and transparently while preventing duplicate voting. The entire barangay is counting on Neri to restore their faith in governance.

## Problem Overview:

The voting system must:

- Allow voters to register before casting a vote.
- Restrict voting to registered voters only.
- Prevent voters from voting multiple times.
- Transparently display the vote count for all candidates.

## Time allotment: 20 minutes

## Code Activity:

Update the castVote function to:

- Ensure only registered voters can vote.
- Prevent duplicate voting.
- Increment the vote count for the chosen candidate.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedVoting {
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    mapping(address => bool) public registeredVoters;
    mapping(string => uint256) public votes;

    modifier onlyRegistered() {
        // TODO: Restrict to registered voters
        _;
    }

    function registerVoter() public {
        // 🚩 Register a voter
    }

    function castVote(string memory candidateName) public onlyRegistered {
        // TODO: Validate and record the vote
    }
}
```

## Hints

- Use a `mapping(address => bool)` to track registered voters.
- Create a `mapping(string => uint256)` to store votes for each candidate.
- Use a modifier to check if the caller is registered and hasn’t voted yet.
- Emit events to log every vote cast.

## Checklist for Learners:

- The `registerVoter` function correctly registers voters and prevents duplicate registration.
- The `castVote` function only allows registered voters to vote.
- Duplicate voting is prevented by tracking voting status with hasVoted.
- Events are emitted when a vote is cast for transparency.
- The vote count updates correctly for the chosen candidate.

## Expected answer (flagged)

```solidity
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
        require(registeredVoters[msg.sender], "You are not registered to vote!");
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
```
