## 🧑‍💻 Background Story

Cobwebs of trivia and laughter fill Cubao’s famous “perya” games every weekend—kids shouting “Panalo!”, families crowding around booths, coins clinking in sari-sari stores down the street. Inspired by this Pinoy spirit, Odessa decided to build a decentralized raffle DApp that captures the same excitement on-chain.

She and Neri deployed a simple `Raffle` smart contract on Goerli testnet. Whenever someone calls `enterRaffle()`, their address goes into the pot, and at intervals a “WinnerPicked(address)” event fires with the lucky winner’s address. No page refresh needed—Odessa wanted the UI to light up the moment the smart contract emits the event.

On a humid afternoon in Brooklyn, Odessa brewed her favorite Kapeng Barako, opened her React project, and wrote an Ethers.js listener:

```js
contract.on("WinnerPicked", (winner) => {
  setLatestWinner(winner);
});
```

She styled a big confetti animation the moment `latestWinner` updates. Her co-workers cheered as she simulated a transaction, watched the event bubble up in seconds, and saw the screen pop with the winner’s address—all without clicking refresh.

From Cubao perya vibes to Brooklyn co-working buzz, Odessa’s live raffle DApp became a bridge between communities, demonstrating how smart contract events can power real-time web experiences. Next up: filtering events, historical logs, and multi-chain listeners. Pero for now, let’s focus on **Event Listeners in the Frontend**! 🇵🇭✨

---

## 📚 Theory & Web3 Lecture

### 1. What Are Smart Contract Events?

- Events are Ethereum’s “logs” emitted during transactions.
- Indexed fields allow efficient filtering.
- Frontends listen to these logs for real-time UI updates.

### 2. Ethers.js Event Subscription

```js
// 1. Setup provider & contract
const provider = new ethers.providers.JsonRpcProvider(RPC_URL);
const contract = new ethers.Contract(CONTRACT_ADDRESS, abi, provider);

// 2. Listen to event
contract.on("WinnerPicked", (winner) => {
  console.log("Winner:", winner);
  // update React state here
});

// 3. Cleanup listener (important!)
contract.off("WinnerPicked", handler);
```

- `.on(eventName, listener)`: subscribes.
- `.off(eventName, listener)`: unsubscribes.
- The callback receives event-args in order.

### 3. React + Ethers.js Listener Pattern

Use `useEffect` to subscribe/unsubscribe:

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/Raffle.json";

export default function RaffleListener() {
  const [latestWinner, setLatestWinner] = useState(null);

  useEffect(() => {
    const provider = new ethers.providers.JsonRpcProvider(
      process.env.REACT_APP_RPC_URL
    );
    const contract = new ethers.Contract(
      process.env.REACT_APP_CONTRACT_ADDRESS,
      abi,
      provider
    );

    const handler = (winner) => {
      setLatestWinner(winner);
    };
    contract.on("WinnerPicked", handler);

    // Cleanup on unmount
    return () => {
      contract.off("WinnerPicked", handler);
    };
  }, []);

  return (
    <div>
      <h2>🎉 Latest Winner</h2>
      <p>{latestWinner || "Waiting for first winner..."}</p>
    </div>
  );
}
```

### 4. Historical Events with `queryFilter`

To fetch past winners:

```js
const pastEvents = await contract.queryFilter(
  "WinnerPicked",
  fromBlock,
  toBlock
);
```

Convert each log to `event.args.winner`.

### 5. Best Practices

- Always **cleanup** listeners to avoid memory leaks.
- Filter by indexed args when needed.
- Debounce UI updates if events fire rapidly.
- Handle network errors in `try/catch`.

External References

- Ethers.js Events: https://docs.ethers.org/v5/api/contract/contract/#Contract--events
- React Hooks: https://reactjs.org/docs/hooks-effect.html

---

## 🧪 Exercises

### Solidity Baseline (`contracts/Raffle.sol`)

```solidity
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

.env Sample

```
REACT_APP_RPC_URL=https://goerli.infura.io/v3/YOUR_INFURA
REACT_APP_CONTRACT_ADDRESS=0xYourRaffleAddress
```

---

### Exercise 1: Basic Event Listener

**Problem Statement**  
Create a React component that listens to the `WinnerPicked` event and displays the latest winner.

**Starter Code (`RaffleListener.js`)**

```js
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

**To Do List**

1. Instantiate `JsonRpcProvider` & `Contract`.
2. Define `handler(winner)` to call `setWinner(winner)`.
3. Call `contract.on('WinnerPicked', handler)`.
4. Return cleanup function to `off` the handler.

**Full Solution**

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

  const handler = (winner) => setWinner(winner);
  contract.on("WinnerPicked", handler);

  return () => {
    contract.off("WinnerPicked", handler);
  };
}, []);
```

---

### Exercise 2: Maintain a Winner History

**Problem Statement**  
Modify the component to keep an array of winners, showing the last 5 winners.

**Starter Code (`WinnerHistory.js`)**

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/Raffle.json";

export default function WinnerHistory() {
  const [history, setHistory] = useState([]);

  useEffect(() => {
    // TODO
  }, []);

  return (
    <div>
      <h2>Winner History</h2>
      <ul>
        {history.map((w, i) => (
          <li key={i}>{w}</li>
        ))}
      </ul>
    </div>
  );
}
```

**To Do List**

1. Subscribe to `WinnerPicked` event.
2. In handler, prepend new winner:  
   `setHistory(h => [winner, ...h].slice(0,5))`.
3. Cleanup on unmount.

**Full Solution**

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

  const handler = (winner) => {
    setHistory((h) => [winner, ...h].slice(0, 5));
  };
  contract.on("WinnerPicked", handler);
  return () => {
    contract.off("WinnerPicked", handler);
  };
}, []);
```

---

### Exercise 3: Fetch Past Winners on Mount

**Problem Statement**  
On component mount, fetch historical `WinnerPicked` events from block 0 to `latest` and display them.

**Starter Code (`PastWinners.js`)**

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/Raffle.json";

export default function PastWinners() {
  const [past, setPast] = useState([]);

  useEffect(() => {
    // TODO
  }, []);

  return (
    <div>
      <h2>Past Winners</h2>
      <ul>
        {past.map((evt, i) => (
          <li key={i}>{evt.args.winner}</li>
        ))}
      </ul>
    </div>
  );
}
```

**To Do List**

1. Instantiate provider & contract.
2. Call `contract.queryFilter('WinnerPicked', 0, 'latest')`.
3. Update `past` with returned event objects.

**Full Solution**

```js
useEffect(() => {
  async function loadPast() {
    const provider = new ethers.providers.JsonRpcProvider(
      process.env.REACT_APP_RPC_URL
    );
    const contract = new ethers.Contract(
      process.env.REACT_APP_CONTRACT_ADDRESS,
      abi,
      provider
    );
    const events = await contract.queryFilter("WinnerPicked", 0, "latest");
    setPast(events);
  }
  loadPast();
}, []);
```

---

## ✅ Test Cases

```js
// __tests__/RaffleListener.test.js
import React from "react";
import { render, screen, act } from "@testing-library/react";
import RaffleListener from "../components/RaffleListener";
import { ethers } from "ethers";

jest.mock("ethers", () => {
  const original = jest.requireActual("ethers");
  let storedHandler;
  const fakeContract = {
    on: (_event, handler) => {
      storedHandler = handler;
    },
    off: () => {},
  };
  return {
    ...original,
    providers: { JsonRpcProvider: jest.fn(() => ({})) },
    Contract: jest.fn(() => fakeContract),
    // expose handler for test
    __triggerWinner: (address) => storedHandler(address),
  };
});

test("updates UI on WinnerPicked event", async () => {
  render(<RaffleListener />);
  expect(screen.getByText(/Waiting for first winner/i)).toBeInTheDocument();

  // simulate event
  act(() => {
    ethers.__triggerWinner("0xABC");
  });

  expect(screen.getByText("0xABC")).toBeInTheDocument();
});
```

```js
// __tests__/PastWinners.test.js
import React from "react";
import { render, screen, waitFor } from "@testing-library/react";
import PastWinners from "../components/PastWinners";
import { ethers } from "ethers";

jest.mock("ethers", () => {
  const original = jest.requireActual("ethers");
  const fakeEvents = [
    { args: { winner: "0x111" } },
    { args: { winner: "0x222" } },
  ];
  return {
    ...original,
    providers: { JsonRpcProvider: jest.fn() },
    Contract: jest.fn(() => ({
      queryFilter: jest.fn(() => Promise.resolve(fakeEvents)),
    })),
  };
});

test("renders past winners from queryFilter", async () => {
  render(<PastWinners />);
  await waitFor(() => {
    expect(screen.getByText("0x111")).toBeInTheDocument();
    expect(screen.getByText("0x222")).toBeInTheDocument();
  });
});
```

---

## 🌟 Closing Story

Back in Cubao, the raffle DApp lit up every time someone on-chain won, just like the live perya draws. Odessa watched remote entries trigger confetti animations on-screen—no refresh, pure magic.

Next up: advanced filtering (e.g. show only your wins), cross-chain listeners, and integrating Chainlink VRF for true randomness. Odessa’s journey from read-only views to live event subscriptions proves Pinoy Web3 builders can deliver world-class, real-time dApps! 🚀🇵🇭🎉
