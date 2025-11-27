## 🧑‍💻 Background Story

![Raffle DApp](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+4.0+-+COVER.png)

Cobwebs of trivia and laughter fill Cubao’s famous “perya” games every weekend—kids shouting “Panalo!”, families crowding around booths, coins clinking in sari-sari stores down the street. Inspired by this Pinoy spirit, Odessa decided to build a decentralized raffle DApp that captures the same excitement on-chain.

She and Neri deployed a simple `Raffle` smart contract on Goerli testnet. Whenever someone calls `enterRaffle()`, their address goes into the pot, and at intervals a “WinnerPicked(address)” event fires with the lucky winner’s address. No page refresh needed—Odessa wanted the UI to light up the moment the smart contract emits the event.

On a humid afternoon in Brooklyn, Odessa brewed her favorite Kapeng Barako, opened her React project, and wrote an Ethers.js listener:

```js
contract.on("WinnerPicked", (winner) => {
  setLatestWinner(winner);
});
```

She styled a big confetti animation the moment `latestWinner` updates. Her co-workers cheered as she simulated a transaction, watched the event bubble up in seconds, and saw the screen pop with the winner’s address—all without clicking refresh.

From Cubao perya vibes to Brooklyn co-working buzz, Odessa’s live raffle DApp became a bridge between communities, demonstrating how smart contract events can power real-time web experiences.

![RaffleListener Component](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+4.1.png)

Next up: filtering events, historical logs, and multi-chain listeners. Pero for now, let’s focus on **Event Listeners in the Frontend**! 🇵🇭✨

---

## 📚 Theory & Web3 Lecture

### 1. What Are Smart Contract Events?

Events are one of the most powerful features for building responsive DApps. Let's understand them deeply.

#### **The Problem Events Solve**

Imagine a raffle DApp where multiple users are watching the same screen. When someone wins:

- **Without events**: Each user must manually refresh to see the winner
- **With events**: All users see the winner instantly, automatically!

#### **How Events Work Under the Hood**

When a smart contract executes, it can "emit" events—special log entries stored on the blockchain:

```solidity
// In your Solidity contract
event WinnerPicked(address indexed winner);

function pickWinner() external {
    // ... winner selection logic ...
    emit WinnerPicked(winnerAddress);  // This creates a log entry!
}
```

**Key points:**

- Events are **cheap** (much cheaper than storing data in contract storage)
- Events are **permanent** (stored in transaction logs forever)
- Events are **not accessible** by smart contracts (only by external apps)
- Events can have **indexed** parameters (up to 3) for efficient filtering

#### **What Gets Stored in an Event Log**

```
┌─────────────────────────────────────────────────────────────────┐
│                        Event Log Entry                          │
├─────────────────────────────────────────────────────────────────┤
│  Contract Address: 0x1234...                                    │
│  Block Number: 12345678                                         │
│  Transaction Hash: 0xabcd...                                    │
│  Event Name: "WinnerPicked"                                     │
│  Topics (indexed params): [0x..., winner_address]               │
│  Data (non-indexed params): [additional data if any]            │
└─────────────────────────────────────────────────────────────────┘
```

#### **Why "indexed" Matters**

```solidity
// With indexed: Can filter events by this parameter efficiently
event WinnerPicked(address indexed winner);

// Without indexed: Must download ALL events and filter locally
event WinnerPicked(address winner);
```

**Indexed parameters** create "topics" that blockchain nodes can search quickly:

```js
// Find only events where YOU won
const myWins = await contract.queryFilter(
  contract.filters.WinnerPicked(myAddress)
);
```

---

### 2. Ethers.js Event Subscription: Complete Guide

Ethers.js makes listening to events simple. Let's explore all the options.

#### **Basic Event Listener Setup**

```js
import { ethers } from "ethers";
import abi from "./abi/Raffle.json";

// Step 1: Create provider (connection to blockchain)
const provider = new ethers.providers.JsonRpcProvider(RPC_URL);

// Step 2: Create contract instance
const contract = new ethers.Contract(CONTRACT_ADDRESS, abi, provider);

// Step 3: Subscribe to the event
contract.on("WinnerPicked", (winner, event) => {
  console.log("🎉 Winner:", winner);
  console.log("Block number:", event.blockNumber);
  console.log("Transaction:", event.transactionHash);

  // Update your React state here!
});
```

#### **Understanding the Callback Arguments**

The callback receives event parameters in order, plus an `event` object at the end:

```solidity
// Solidity event
event Transfer(address indexed from, address indexed to, uint256 amount);
```

```js
// JavaScript listener
contract.on("Transfer", (from, to, amount, event) => {
  // from, to, amount = event parameters in order
  // event = extra metadata about the event

  console.log(`${from} sent ${amount} to ${to}`);
  console.log("Block:", event.blockNumber);
  console.log("Tx Hash:", event.transactionHash);
});
```

#### **Event Listener Methods**

| Method                               | Description                         |
| ------------------------------------ | ----------------------------------- |
| `contract.on(event, listener)`       | Subscribe to future events          |
| `contract.once(event, listener)`     | Listen for only the next occurrence |
| `contract.off(event, listener)`      | Unsubscribe a specific listener     |
| `contract.removeAllListeners(event)` | Remove all listeners for an event   |

```js
// Listen to all future WinnerPicked events
contract.on("WinnerPicked", handler);

// Listen to only the NEXT WinnerPicked event
contract.once("WinnerPicked", handler);

// Stop listening
contract.off("WinnerPicked", handler);

// Remove ALL WinnerPicked listeners
contract.removeAllListeners("WinnerPicked");
```

#### **Filtering Events by Parameter**

You can listen for events matching specific criteria:

```js
// Listen for events where YOU are the winner
const myAddress = "0x1234...";

// Create a filter
const filter = contract.filters.WinnerPicked(myAddress);

// Subscribe with the filter
contract.on(filter, (winner, event) => {
  console.log("🎊 YOU WON!");
});
```

#### **⚠️ Critical: Always Clean Up Listeners**

Forgetting to remove listeners causes:

- Memory leaks (listeners pile up)
- Duplicate event handling (same event processed multiple times)
- State update errors (updates to unmounted components)

```js
// ✅ Correct: Store handler reference and remove it
const handler = (winner) => setWinner(winner);
contract.on("WinnerPicked", handler);

// Later, when cleaning up:
contract.off("WinnerPicked", handler);

// ❌ Wrong: Anonymous function can't be removed
contract.on("WinnerPicked", (winner) => setWinner(winner));
// contract.off("WinnerPicked", ???); // Can't reference it!
```

---

### 3. React + Ethers.js Listener Pattern

Integrating event listeners with React requires careful attention to the component lifecycle. Here's the complete pattern.

#### **The Complete Component Pattern**

```js
import { useState, useEffect, useCallback } from "react";
import { ethers } from "ethers";
import abi from "../abi/Raffle.json";

export default function RaffleListener() {
  // ============================================
  // STATE
  // ============================================
  const [latestWinner, setLatestWinner] = useState(null);
  const [isConnected, setIsConnected] = useState(false);
  const [error, setError] = useState(null);

  // ============================================
  // EVENT LISTENER SETUP
  // ============================================
  useEffect(() => {
    let contract; // Store reference for cleanup
    let handler; // Store handler reference for cleanup

    async function setupListener() {
      try {
        // Create provider
        const provider = new ethers.providers.JsonRpcProvider(
          process.env.REACT_APP_RPC_URL
        );

        // Verify connection
        await provider.getNetwork();
        setIsConnected(true);

        // Create contract instance
        contract = new ethers.Contract(
          process.env.REACT_APP_CONTRACT_ADDRESS,
          abi,
          provider
        );

        // Define the event handler
        handler = (winner, event) => {
          console.log("🎉 New winner:", winner);
          console.log("Block:", event.blockNumber);

          // Update state with new winner
          setLatestWinner(winner);
        };

        // Subscribe to the event
        contract.on("WinnerPicked", handler);
        console.log("✅ Listening for WinnerPicked events...");
      } catch (err) {
        console.error("Failed to setup listener:", err);
        setError("Failed to connect to blockchain");
        setIsConnected(false);
      }
    }

    setupListener();

    // ============================================
    // CLEANUP FUNCTION (runs on unmount)
    // ============================================
    return () => {
      if (contract && handler) {
        contract.off("WinnerPicked", handler);
        console.log("🧹 Cleaned up event listener");
      }
    };
  }, []); // Empty array = run once on mount

  // ============================================
  // RENDER
  // ============================================
  if (error) {
    return <div className="error">❌ {error}</div>;
  }

  if (!isConnected) {
    return <div className="loading">Connecting to blockchain...</div>;
  }

  return (
    <div className="raffle-listener">
      <h2>🎰 Raffle Listener</h2>

      <div className="status">
        <span className="dot connected"></span>
        Live - Listening for winners
      </div>

      <div className="winner-display">
        <h3>🎉 Latest Winner</h3>
        {latestWinner ? (
          <p className="winner-address">
            {latestWinner.slice(0, 6)}...{latestWinner.slice(-4)}
          </p>
        ) : (
          <p className="waiting">Waiting for first winner...</p>
        )}
      </div>
    </div>
  );
}
```

#### **Why This Pattern Works**

```
Component Mounts
       │
       ▼
┌─────────────────────┐
│  useEffect runs     │
│  - Setup provider   │
│  - Create contract  │
│  - Add listener     │
└──────────┬──────────┘
           │
           ▼
    Listening for events... ◀──────────┐
           │                           │
           ▼                           │
    Event received!                    │
           │                           │
           ▼                           │
    setLatestWinner(winner)            │
           │                           │
           ▼                           │
    Component re-renders               │
           │                           │
           └───────────────────────────┘

Component Unmounts
       │
       ▼
┌─────────────────────┐
│  Cleanup function   │
│  - contract.off()   │
│  - No memory leaks! │
└─────────────────────┘
```

#### **Common Mistake: Missing Cleanup**

```js
// ❌ BAD: No cleanup - causes memory leaks and bugs
useEffect(() => {
  const contract = new ethers.Contract(...);
  contract.on("WinnerPicked", (winner) => {
    setLatestWinner(winner);  // May update unmounted component!
  });
}, []);

// ✅ GOOD: Proper cleanup
useEffect(() => {
  const contract = new ethers.Contract(...);
  const handler = (winner) => setLatestWinner(winner);
  contract.on("WinnerPicked", handler);

  return () => {
    contract.off("WinnerPicked", handler);  // Clean up!
  };
}, []);
```

---

### 4. Historical Events with `queryFilter`

Sometimes you need to fetch past events—like showing a history of all winners.

#### **Basic Query**

```js
// Fetch all WinnerPicked events from block 0 to latest
const events = await contract.queryFilter(
  "WinnerPicked", // Event name
  0, // From block (0 = genesis)
  "latest" // To block ("latest" = most recent)
);

console.log(`Found ${events.length} past winners`);
```

#### **Understanding the Event Object**

Each event in the array contains:

```js
{
  // Event arguments (what you care about)
  args: {
    winner: "0x1234..."
  },

  // Metadata
  blockNumber: 12345678,
  blockHash: "0xabcd...",
  transactionHash: "0xefgh...",
  transactionIndex: 5,
  logIndex: 2,

  // Methods
  getBlock: async function() { ... },
  getTransaction: async function() { ... },
  getTransactionReceipt: async function() { ... }
}
```

#### **Processing Historical Events**

```js
useEffect(() => {
  async function loadPastWinners() {
    const provider = new ethers.providers.JsonRpcProvider(RPC_URL);
    const contract = new ethers.Contract(ADDRESS, abi, provider);

    // Fetch last 1000 blocks of events
    const currentBlock = await provider.getBlockNumber();
    const fromBlock = Math.max(0, currentBlock - 1000);

    const events = await contract.queryFilter(
      "WinnerPicked",
      fromBlock,
      "latest"
    );

    // Extract winner addresses from events
    const winners = events.map((event) => ({
      address: event.args.winner,
      block: event.blockNumber,
      txHash: event.transactionHash,
    }));

    setPastWinners(winners);
  }

  loadPastWinners();
}, []);
```

#### **Filtering Historical Events**

```js
// Find only events where a specific address won
const myAddress = "0x1234...";
const filter = contract.filters.WinnerPicked(myAddress);
const myWins = await contract.queryFilter(filter, 0, "latest");

console.log(`You won ${myWins.length} times!`);
```

#### **Combining Historical + Live Events**

```js
useEffect(() => {
  async function setup() {
    const contract = new ethers.Contract(ADDRESS, abi, provider);

    // 1. Load historical events first
    const pastEvents = await contract.queryFilter("WinnerPicked", 0, "latest");
    const pastWinners = pastEvents.map((e) => e.args.winner);
    setWinners(pastWinners);

    // 2. Then listen for new events
    const handler = (winner) => {
      setWinners((prev) => [...prev, winner]);
    };
    contract.on("WinnerPicked", handler);

    return () => contract.off("WinnerPicked", handler);
  }

  setup();
}, []);
```

---

### 5. Best Practices for Event Listeners

#### **1. Always Clean Up Listeners**

Memory leaks are the #1 problem with event listeners:

```js
// ✅ Store handler reference and clean up
const handler = (winner) => { ... };
contract.on("WinnerPicked", handler);
return () => contract.off("WinnerPicked", handler);
```

#### **2. Debounce Rapid Events**

If events fire quickly, debounce to avoid UI jank:

```js
import { debounce } from "lodash";

// Only update UI once per 500ms, even if many events fire
const debouncedUpdate = debounce((winner) => {
  setLatestWinner(winner);
}, 500);

contract.on("WinnerPicked", debouncedUpdate);
```

#### **3. Handle Network Errors Gracefully**

```js
useEffect(() => {
  let contract;

  async function setup() {
    try {
      const provider = new ethers.providers.JsonRpcProvider(RPC_URL);

      // Test connection
      await provider.getNetwork();

      contract = new ethers.Contract(ADDRESS, abi, provider);
      // ... setup listeners
    } catch (error) {
      if (error.code === "NETWORK_ERROR") {
        setError("Cannot connect to blockchain. Check RPC URL.");
      } else {
        setError("An error occurred: " + error.message);
      }
    }
  }

  setup();
}, []);
```

#### **4. Show Connection Status**

```js
const [connectionStatus, setConnectionStatus] = useState("connecting");

// In your UI
<div className="status-indicator">
  {connectionStatus === "connected" && (
    <span className="dot green">● Live</span>
  )}
  {connectionStatus === "connecting" && (
    <span className="dot yellow">● Connecting...</span>
  )}
  {connectionStatus === "error" && (
    <span className="dot red">● Disconnected</span>
  )}
</div>;
```

#### **5. Limit Historical Query Range**

```js
// ❌ BAD: Querying entire blockchain history (millions of blocks!)
const events = await contract.queryFilter("WinnerPicked", 0, "latest");

// ✅ GOOD: Limit to recent blocks
const currentBlock = await provider.getBlockNumber();
const fromBlock = Math.max(0, currentBlock - 10000); // Last ~10000 blocks
const events = await contract.queryFilter("WinnerPicked", fromBlock, "latest");
```

---

### 6. Common Mistakes to Avoid

1. **Using anonymous functions (can't clean up)**

   ```js
   // ❌ Can't remove this listener
   contract.on("Event", (data) => setState(data));

   // ✅ Can be removed
   const handler = (data) => setState(data);
   contract.on("Event", handler);
   return () => contract.off("Event", handler);
   ```

2. **Not checking if component is still mounted**

   ```js
   useEffect(() => {
     let isMounted = true;

     const handler = (winner) => {
       if (isMounted) {
         // Only update if still mounted
         setWinner(winner);
       }
     };

     contract.on("WinnerPicked", handler);

     return () => {
       isMounted = false;
       contract.off("WinnerPicked", handler);
     };
   }, []);
   ```

3. **Creating new contract instance on every render**

   ```js
   // ❌ New contract (and new listeners) every render!
   function Component() {
     const contract = new ethers.Contract(...);
     contract.on("Event", handler);
   }

   // ✅ Create once in useEffect
   function Component() {
     useEffect(() => {
       const contract = new ethers.Contract(...);
       contract.on("Event", handler);
       return () => contract.off("Event", handler);
     }, []);
   }
   ```

---

### 7. Testing Your Event Listeners

Verify these scenarios work:

1. ✅ **Initial state**: Shows "Waiting for winner..." or similar
2. ✅ **Event received**: UI updates immediately when event fires
3. ✅ **Multiple events**: Each event updates the UI correctly
4. ✅ **Component unmount**: No errors, no memory leaks
5. ✅ **Network error**: Graceful error message displayed
6. ✅ **Historical events**: Past events load correctly on mount

---

### External References & Further Learning

- **Ethers.js Events**: https://docs.ethers.org/v5/api/contract/contract/#Contract--events - Complete events API
- **Event Filtering**: https://docs.ethers.org/v5/api/contract/contract/#Contract--filters - Create event filters
- **React useEffect**: https://reactjs.org/docs/hooks-effect.html - Effect hook documentation
- **React Cleanup**: https://reactjs.org/docs/hooks-effect.html#effects-with-cleanup - Cleanup pattern
- **Etherscan Events**: https://etherscan.io - View event logs on-chain

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
