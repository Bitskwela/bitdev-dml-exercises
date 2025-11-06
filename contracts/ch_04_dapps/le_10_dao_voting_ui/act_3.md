# Live Results Panel activity:

```js
// LiveResults.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/DAO.json";

export default function LiveResults({ proposalId }) {
  const [results, setResults] = useState({ yes: 0, no: 0 });

  useEffect(() => {
    // TODO: fetch initial results and listen for vote events
  }, [proposalId]);

  const totalVotes = results.yes + results.no;
  const yesPercentage = totalVotes > 0 ? (results.yes / totalVotes) * 100 : 0;

  return (
    <div>
      <h4>Live Results - Proposal #{proposalId}</h4>
      <div>
        <p>
          Yes: {results.yes} ({yesPercentage.toFixed(1)}%)
        </p>
        <p>
          No: {results.no} ({(100 - yesPercentage).toFixed(1)}%)
        </p>
        <p>Total Votes: {totalVotes}</p>
      </div>
    </div>
  );
}
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: Real-time vote tracking, event listening, percentage calculations

- Update the `LiveResults` component to:
  - Fetch initial vote counts for the specific proposal.
  - Subscribe to `VoteCast` events to update results in real-time.
  - Calculate and display vote percentages dynamically.
  - Update the UI immediately when new votes are cast.
