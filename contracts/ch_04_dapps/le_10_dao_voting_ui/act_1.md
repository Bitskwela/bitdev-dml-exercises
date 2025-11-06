# Fetch & Render Proposals activity:

```js
// ProposalList.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/DAO.json";

export default function ProposalList() {
  const [proposals, setProposals] = useState([]);

  useEffect(() => {
    // TODO: fetch all proposals from DAO contract
  }, []);

  return (
    <div>
      <h3>DAO Proposals</h3>
      {proposals.map((proposal, idx) => (
        <div key={idx}>
          <h4>{proposal.title}</h4>
          <p>{proposal.description}</p>
          <p>
            Yes: {proposal.yesVotes} | No: {proposal.noVotes}
          </p>
        </div>
      ))}
    </div>
  );
}
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: DAO contract interaction, proposal enumeration, vote counting

- Update the `ProposalList` component to:
  - Connect to the DAO contract using provider and ABI.
  - Fetch proposal count and iterate through all proposals.
  - Parse proposal data structure (title, description, vote counts).
  - Display proposals in a user-friendly format.
