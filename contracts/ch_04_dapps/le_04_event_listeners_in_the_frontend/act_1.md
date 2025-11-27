# Event Listeners in the Frontend Activity

## Initial Code

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
  const [history, setHistory] = useState([]);

  useEffect(() => {
    // TODO: Subscribe to WinnerPicked event
    // TODO: Implement cleanup
  }, []);

  return (
    <div>
      <h2>🎰 Raffle Listener</h2>
      <div>
        <h3>Latest Winner:</h3>
        <p>{winner || "Waiting for winner..."}</p>
      </div>
      <div>
        <h3>Winner History (Last 5):</h3>
        <ul>
          {history.map((w, i) => (
            <li key={i}>{w}</li>
          ))}
        </ul>
      </div>
    </div>
  );
}
```

```bash
# .env Configuration
REACT_APP_RPC_URL=https://goerli.infura.io/v3/YOUR_INFURA
REACT_APP_CONTRACT_ADDRESS=0xYourRaffleAddress
```

**Time Allotment: 15 minutes**

## Tasks for Learners

Topics Covered: Smart contract events, event listeners, `contract.on()`, `contract.off()`, useEffect cleanup, real-time UI updates

---

### Task 1: Create Provider and Contract Instance

Inside the `useEffect`, create a `JsonRpcProvider` and contract instance to listen for events. Store references for later cleanup.

```js
const provider = new ethers.providers.JsonRpcProvider(
  process.env.REACT_APP_RPC_URL
);

const contract = new ethers.Contract(
  process.env.REACT_APP_CONTRACT_ADDRESS,
  abi,
  provider
);
```

---

### Task 2: Subscribe to the WinnerPicked Event

Define a named handler function that updates both the `winner` state (latest winner) and the `history` state (keeping only the last 5 winners). Subscribe to the event using `contract.on()`.

```js
const handleWinnerPicked = (winnerAddress) => {
  setWinner(winnerAddress);
  setHistory((prev) => [winnerAddress, ...prev].slice(0, 5));
};

contract.on("WinnerPicked", handleWinnerPicked);
```

---

### Task 3: Implement Cleanup Function

Return a cleanup function from the `useEffect` that removes the event listener using `contract.off()`. This prevents memory leaks and errors when the component unmounts.

```js
return () => {
  contract.off("WinnerPicked", handleWinnerPicked);
};
```

---

## Complete Solution

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/Raffle.json";

export default function RaffleListener() {
  const [winner, setWinner] = useState(null);
  const [history, setHistory] = useState([]);

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
      setHistory((prev) => [winnerAddress, ...prev].slice(0, 5));
    };

    contract.on("WinnerPicked", handleWinnerPicked);

    return () => {
      contract.off("WinnerPicked", handleWinnerPicked);
    };
  }, []);

  return (
    <div>
      <h2>🎰 Raffle Listener</h2>
      <div>
        <h3>Latest Winner:</h3>
        <p>{winner || "Waiting for winner..."}</p>
      </div>
      <div>
        <h3>Winner History (Last 5):</h3>
        <ul>
          {history.map((w, i) => (
            <li key={i}>{w}</li>
          ))}
        </ul>
      </div>
    </div>
  );
}
```

---

## Breakdown of the Activity

**Variables Defined:**

- `winner`: A React state variable that stores the most recent winner's address. Updated in real-time whenever the `WinnerPicked` event is emitted from the smart contract. Initially `null` to show a "Waiting for winner..." message.

- `history`: An array state variable that maintains a list of the last 5 winners. New winners are prepended to the array, and `.slice(0, 5)` ensures only the 5 most recent are kept. This provides users with context about recent raffle results.

- `provider`: A `JsonRpcProvider` instance that connects to the Ethereum network via an RPC URL. For event listening, we only need read access, so a provider (not signer) is sufficient.

- `contract`: An Ethers.js contract instance that represents the deployed Raffle contract. This object provides the `.on()` and `.off()` methods for subscribing to and unsubscribing from events.

- `handleWinnerPicked`: A named function reference for the event handler. Using a named function (instead of an anonymous arrow function) is crucial because we need the same reference to remove the listener during cleanup.

**Key Functions:**

- `contract.on("WinnerPicked", handler)`:
  Subscribes to the `WinnerPicked` event emitted by the smart contract. Whenever the contract emits this event (when `pickWinner()` is called), the handler function is automatically invoked with the event parameters. The handler receives the `winner` address as its first argument (matching the event's indexed parameter). This creates a real-time connection between blockchain events and your UI.

- `contract.off("WinnerPicked", handler)`:
  Unsubscribes the handler from the event. This is called in the useEffect cleanup function (the returned function) when the component unmounts. Failing to clean up listeners causes memory leaks, duplicate event handling, and React errors about updating unmounted components. The handler reference must be the exact same function object passed to `.on()`.

- `useEffect` Cleanup Pattern:
  The cleanup function returned from `useEffect` runs when the component unmounts or before the effect re-runs. For event listeners, this pattern ensures we don't accumulate multiple listeners over time, which would cause each event to trigger multiple state updates.
