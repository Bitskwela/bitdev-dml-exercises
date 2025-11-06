# Cast Vote activity:

```js
// VotingInterface.js - Starter Code
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/DAO.json";

export default function VotingInterface({ proposalId }) {
  const [voteChoice, setVoteChoice] = useState("");
  const [status, setStatus] = useState("");

  const castVote = async () => {
    // TODO: submit vote to contract
  };

  return (
    <div>
      <h4>Vote on Proposal #{proposalId}</h4>
      <div>
        <label>
          <input
            type="radio"
            name="vote"
            value="yes"
            onChange={(e) => setVoteChoice(e.target.value)}
          />
          Yes
        </label>
        <label>
          <input
            type="radio"
            name="vote"
            value="no"
            onChange={(e) => setVoteChoice(e.target.value)}
          />
          No
        </label>
      </div>
      <button onClick={castVote} disabled={!voteChoice}>
        Cast Vote
      </button>
      {status && <p>{status}</p>}
    </div>
  );
}
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: DAO voting, boolean parameters, vote submission

- Update the `VotingInterface` component to:
  - Connect to MetaMask and get signer for vote submission.
  - Call the `vote()` function with proposalId and vote choice (true/false).
  - Handle transaction confirmation and status updates.
  - Prevent multiple votes and handle voting restrictions properly.
