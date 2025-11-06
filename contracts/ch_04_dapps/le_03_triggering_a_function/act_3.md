# Auto-Refresh on Voted Events activity:

```js
// VoteApp.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/CooperativeVote.json";
import VoteCounts from "./VoteCounts";
import CastVote from "./CastVote";

export default function VoteApp({ proposals }) {
  const [refreshKey, setRefreshKey] = useState(0);
  const refresh = () => setRefreshKey((k) => k + 1);

  useEffect(() => {
    // TODO: subscribe to Voted events
  }, []);

  return (
    <div>
      <VoteCounts key={refreshKey} proposals={proposals} />
      <CastVote proposals={proposals} onVoted={refresh} />
    </div>
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

Topics Covered: Event listeners, contract events, useEffect cleanup, real-time updates

- Update the `VoteApp` component to:

  - Instantiate `JsonRpcProvider` and `Contract` for event listening.
  - In `useEffect`, add `contract.on('Voted', handler)` where handler calls `refresh()` function.
  - Implement proper cleanup with `contract.off('Voted', handler)` in the return function.
  - Enable automatic UI updates when the `Voted` event is emitted from the smart contract.

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
    const handler = (voter, proposal) => {
      console.log(`Event: ${voter} voted ${proposal}`);
      refresh();
    };
    contract.on("Voted", handler);
    return () => {
      contract.off("Voted", handler);
    };
  }, []);
  ```
