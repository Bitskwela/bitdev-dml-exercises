# Winner History Tracker activity:

```js
// WinnerHistory.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/Raffle.json";

export default function WinnerHistory() {
  const [winners, setWinners] = useState([]);

  useEffect(() => {
    // TODO: maintain array of all winners
  }, []);

  return (
    <div>
      <h2>Winner History:</h2>
      <ul>
        {winners.map((winner, idx) => (
          <li key={idx}>
            #{idx + 1}: {winner}
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

Topics Covered: State array management, event accumulation, functional state updates

- Update the `WinnerHistory` component to:

  - Create provider and contract instance for event listening.
  - Subscribe to the `WinnerPicked` event to accumulate winners in an array.
  - Use functional state updates to append new winners to the existing array.
  - Display the complete history of winners with numbering.

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

    const handleWinnerPicked = (winnerAddress) => {
      setWinners((prev) => [...prev, winnerAddress]);
    };

    contract.on("WinnerPicked", handleWinnerPicked);

    return () => {
      contract.off("WinnerPicked", handleWinnerPicked);
    };
  }, []);
  ```
