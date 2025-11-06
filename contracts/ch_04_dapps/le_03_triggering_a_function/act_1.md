# Display Vote Counts activity:

```solidity
// CooperativeVote.sol - Contract Baseline
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CooperativeVote {
    mapping(string => uint256) public votes;
    mapping(address => bool)    public hasVoted;
    string[] public proposals;

    event Voted(address indexed voter, string proposal);

    constructor(string[] memory _proposals) {
        proposals = _proposals;
    }

    function vote(string calldata proposal) external {
        require(!hasVoted[msg.sender], "Already voted");
        bool valid = false;
        for (uint i; i < proposals.length; i++) {
            if (keccak256(bytes(proposals[i])) == keccak256(bytes(proposal))) {
                valid = true;
                break;
            }
        }
        require(valid, "Invalid proposal");
        votes[proposal] += 1;
        hasVoted[msg.sender] = true;
        emit Voted(msg.sender, proposal);
    }

    function getVoteCount(string calldata proposal) external view returns (uint256) {
        return votes[proposal];
    }
}
```

```js
// VoteCounts.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/CooperativeVote.json";

export default function VoteCounts({ proposals }) {
  const [counts, setCounts] = useState({});

  useEffect(() => {
    // TODO: implement loadCounts()
  }, [proposals]);

  return (
    <ul>
      {proposals.map((p) => (
        <li key={p}>
          {p}: {counts[p] ?? "..."}
        </li>
      ))}
    </ul>
  );
}
```

```bash
# .env Configuration
REACT_APP_RPC_URL=http://localhost:8545
REACT_APP_CONTRACT_ADDRESS=0xYourDeployedAddress
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: Contract view functions, async data fetching, BigNumber conversion, array mapping

- Update the `VoteCounts` component to:

  - Instantiate `JsonRpcProvider` with `REACT_APP_RPC_URL` from environment variables.
  - Create `Contract` instance with ABI and provider for read-only operations.
  - Loop through `proposals` array and call `contract.getVoteCount(p)` for each proposal.
  - Convert BigNumber results to regular numbers and update `counts` state object.

  ```js
  useEffect(() => {
    const provider = new ethers.providers.JsonRpcProvider(
      process.env.REACT_APP_RPC_URL
    );
    const contract = new ethers.Contract(
      process.env.REACT_APP_CONTRACT_ADDRESS,
      abi,
      provider
    );
    async function loadCounts() {
      const result = {};
      for (const p of proposals) {
        const bn = await contract.getVoteCount(p);
        result[p] = bn.toNumber();
      }
      setCounts(result);
    }
    loadCounts();
  }, [proposals]);
  ```
