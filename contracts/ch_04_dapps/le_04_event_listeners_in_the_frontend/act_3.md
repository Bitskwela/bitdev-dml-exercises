# Fetch Past Winners activity:

```js
// PastWinners.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/Raffle.json";

export default function PastWinners() {
  const [pastWinners, setPastWinners] = useState([]);
  const [newWinners, setNewWinners] = useState([]);

  useEffect(() => {
    // TODO: fetch historical events on mount
    // TODO: listen for new events
  }, []);

  const allWinners = [...pastWinners, ...newWinners];

  return (
    <div>
      <h2>All Winners (Past + Live):</h2>
      <ul>
        {allWinners.map((winner, idx) => (
          <li key={idx}>
            #{idx + 1}: {winner} {idx >= pastWinners.length ? "🔴 LIVE" : ""}
          </li>
        ))}
      </ul>
    </div>
  );
}
```

```bash
# .env Configuration
REACT_APP_RPC_URL=https://goerli.infura.io/v3/YOUR_INFURA
REACT_APP_CONTRACT_ADDRESS=0xYourRaffleAddress
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: Historical event queries, contract.queryFilter(), combining past and live data

- Update the `PastWinners` component to:

  - Fetch historical `WinnerPicked` events using `contract.queryFilter()` on component mount.
  - Set up live event listener for new `WinnerPicked` events.
  - Combine past winners and new live winners in the display.
  - Handle both historical data loading and real-time updates properly.

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

    // Fetch past events
    const loadPastWinners = async () => {
      const filter = contract.filters.WinnerPicked();
      const events = await contract.queryFilter(filter);
      const winners = events.map((event) => event.args.winner);
      setPastWinners(winners);
    };

    // Listen for new events
    const handleNewWinner = (winnerAddress) => {
      setNewWinners((prev) => [...prev, winnerAddress]);
    };

    loadPastWinners();
    contract.on("WinnerPicked", handleNewWinner);

    return () => {
      contract.off("WinnerPicked", handleNewWinner);
    };
  }, []);
  ```
