# Basic Event Listener activity:

```solidity
// Raffle.sol - Contract Baseline
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Raffle {
    address[] public players;
    address public latestWinner;
    event WinnerPicked(address indexed winner);

    function enterRaffle() external payable {
        require(msg.value == 0.01 ether, "Send 0.01 ETH");
        players.push(msg.sender);
    }

    // Only for testing: pick first player as winner
    function pickWinner() external {
        require(players.length > 0, "No players");
        latestWinner = players[0];
        delete players;
        emit WinnerPicked(latestWinner);
    }
}
```

```js
// RaffleListener.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/Raffle.json";

export default function RaffleListener() {
  const [winner, setWinner] = useState(null);

  useEffect(() => {
    // TODO: subscribe to WinnerPicked and update state
    // Don't forget cleanup!
  }, []);

  return (
    <div>
      <h2>Latest Winner:</h2>
      <p>{winner || "..."}</p>
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

Topics Covered: Smart contract events, event listeners, useEffect cleanup, real-time updates

- Update the `RaffleListener` component to:

  - Create provider and contract instance for event listening.
  - Subscribe to the `WinnerPicked` event using `contract.on()` in useEffect.
  - Update the winner state when event is triggered.
  - Implement proper cleanup by removing event listener on component unmount.

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
      setWinner(winnerAddress);
    };

    contract.on("WinnerPicked", handleWinnerPicked);

    return () => {
      contract.off("WinnerPicked", handleWinnerPicked);
    };
  }, []);
  ```
