## 🧑‍💻 Background Story

![Raffle DApp](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+4.0+-+COVER.png)

Every weekend, the perya games in Cubao fill with noise: kids shouting “Panalo!”, families crowding around booths, coins clinking at the sari-sari stores down the street. Inspired by that Pinoy spirit, Odessa decided to build a raffle DApp that captures the same excitement on-chain.

She and Neri deployed a simple `Raffle` smart contract on the Sepolia testnet. Players call `enterRaffle()` to get into the pot. When someone calls `pickWinner()`, the contract emits a `WinnerPicked` event with the lucky address. Odessa wanted the screen to light up the moment that event fired, with no page refresh.

On a humid afternoon in Brooklyn, Odessa brewed her favorite Kapeng Barako, opened her React project, and wrote an Ethers.js listener:

```js
contract.on("WinnerPicked", (winner) => {
  setLatestWinner(winner);
});
```

She added a big confetti animation that played whenever `latestWinner` changed. Her co-workers cheered as she sent a test transaction. Seconds later the event arrived and the screen popped with the winner’s address, without anyone clicking refresh.

From Cubao perya vibes to Brooklyn co-working buzz, Odessa’s live raffle DApp showed how smart contract events can power real-time web experiences.

![RaffleListener Component](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+4.1.png)

Pero for now, let’s focus on **Event Listeners in the Frontend**! 🇵🇭✨

---

## 📚 Theory & Web3 Lecture

### 1. What Are Smart Contract Events?

In Lesson 3 you sent a transaction and waited for it. But what about transactions *other people* send? Events are how a contract tells the outside world that something happened.

#### **The Problem Events Solve**

Imagine a raffle DApp where many people watch the same screen. When someone wins:

- **Without events**: each viewer has to keep refreshing to see the winner
- **With events**: every viewer's screen updates as soon as the news reaches it

#### **How Events Work Under the Hood**

While a transaction runs, a contract can **emit** an event. The event becomes a log entry stored with that transaction's receipt:

```solidity
// In your Solidity contract
event WinnerPicked(address indexed winner);

function pickWinner() external {
    // ... winner selection logic ...
    emit WinnerPicked(winnerAddress);  // This creates a log entry!
}
```

**Key points:**

- Events are **cheap**, much cheaper than saving the same data in contract storage
- Events are **permanent**: they stay in the transaction's logs on the chain
- Contracts **cannot read** events; only apps outside the chain can
- Up to **3 parameters** can be marked `indexed`, which makes them searchable

#### **What Gets Stored in an Event Log**

```
┌─────────────────────────────────────────────────────────────────┐
│                        Event Log Entry                          │
├─────────────────────────────────────────────────────────────────┤
│  Contract Address: 0x1234...                                    │
│  Block Number: 6123456                                          │
│  Transaction Hash: 0xabcd...                                    │
│  Topics: [hash of "WinnerPicked(address)", winner_address]      │
│  Data (non-indexed params): [additional data if any]            │
└─────────────────────────────────────────────────────────────────┘
```

The first topic is a hash of the event's signature. That is how ethers knows a log is a `WinnerPicked` event. To decode it, ethers needs the event in your ABI.

#### **Why "indexed" Matters**

```solidity
// With indexed: nodes can find events by this parameter quickly
event WinnerPicked(address indexed winner);

// Without indexed: you must fetch every WinnerPicked event and filter yourself
event WinnerPicked(address winner);
```

Indexed parameters are stored as **topics**, which nodes can search:

```js
// Find only the events where myAddress won
const myWins = await contract.queryFilter(
  contract.filters.WinnerPicked(myAddress)
);
```

Your ABI must describe the event exactly as the contract declares it, `indexed` included. If they differ, ethers reads the values from the wrong place in the log.

---

### 2. Ethers.js v6 Event Subscription

#### **Basic Event Listener Setup**

Listening needs no wallet, so a read-only provider is enough:

```js
import { ethers } from "ethers";
import abi from "./abi/Raffle.json";

// Step 1: Create a read-only provider
const provider = new ethers.JsonRpcProvider(RPC_URL);

// Step 2: Create the contract instance
const contract = new ethers.Contract(CONTRACT_ADDRESS, abi, provider);

// Step 3: Subscribe to the event
contract.on("WinnerPicked", (winner, event) => {
  console.log("🎉 Winner:", winner);
  console.log("Block number:", event.log.blockNumber);
  console.log("Transaction:", event.log.transactionHash);
});
```

With a `JsonRpcProvider`, ethers **polls** the node, by default every 4 seconds, and calls your listener for each new matching log. So "real-time" means within a few seconds of the block being mined.

> In ethers **version 5** the last argument had `event.blockNumber` directly, and the provider was `ethers.providers.JsonRpcProvider`. In v6 the block data lives on `event.log`. <!-- v5-ok -->

#### **Understanding the Callback Arguments**

The listener receives the event's parameters in order, then one extra **payload** object at the end:

```solidity
// Solidity event
event Transfer(address indexed from, address indexed to, uint256 amount);
```

```js
contract.on("Transfer", (from, to, amount, event) => {
  // from, to, amount = the event's parameters, in order
  // amount is a bigint (it is a uint256)
  // event = the payload; event.log holds the block and transaction details

  console.log(`${from} sent ${amount} to ${to}`);
  console.log("Block:", event.log.blockNumber);
  console.log("Tx Hash:", event.log.transactionHash);
});
```

#### **Event Listener Methods**

| Method                               | Description                         |
| ------------------------------------ | ----------------------------------- |
| `contract.on(event, listener)`       | Subscribe to future events          |
| `contract.once(event, listener)`     | Listen for only the next occurrence |
| `contract.off(event, listener)`      | Unsubscribe one specific listener   |
| `contract.removeAllListeners(event)` | Remove every listener for an event (or for all events, with no argument) |

```js
// Listen to all future WinnerPicked events
contract.on("WinnerPicked", handler);

// Listen to only the NEXT WinnerPicked event
contract.once("WinnerPicked", handler);

// Stop listening with this one handler
contract.off("WinnerPicked", handler);

// Remove ALL WinnerPicked listeners on this contract
contract.removeAllListeners("WinnerPicked");
```

These methods return Promises in v6. You usually don't need to `await` them inside a `useEffect`.

#### **Filtering Events by Parameter**

You can listen only for events that match an indexed parameter:

```js
// Listen for events where myAddress is the winner
const filter = contract.filters.WinnerPicked(myAddress);

contract.on(filter, (winner, event) => {
  console.log("🎊 YOU WON!");
});
```

#### **⚠️ Critical: Always Clean Up Listeners**

Forgetting to remove listeners causes:

- **Duplicate handling**: every time the component mounts again, another listener is added, so one event updates the screen twice, three times, and so on
- **Wasted work**: listeners keep polling the node after the component is gone
- **State updates on a component that no longer exists**

```js
// ✅ Correct: keep a reference to the handler so you can remove it
const handler = (winner) => setWinner(winner);
contract.on("WinnerPicked", handler);

// Later, when cleaning up:
contract.off("WinnerPicked", handler);

// ❌ Wrong: an anonymous function has no name to pass to off()
contract.on("WinnerPicked", (winner) => setWinner(winner));
// contract.off("WinnerPicked", ???);
```

If you really did use an anonymous function, `contract.removeAllListeners("WinnerPicked")` can still remove it. Keeping a named handler is clearer.

---

### 3. React + Ethers.js Listener Pattern

The listener has to be added when the component appears and removed when it disappears. That is exactly what `useEffect` with a cleanup function is for.

#### **A Quick `useEffect` Cleanup Refresher**

```js
useEffect(() => {
  // runs after the component first renders (mount)
  return () => {
    // runs when the component is removed (unmount),
    // or before the effect runs again
  };
}, []); // [] = run the effect once, on mount
```

#### **The Complete Component Pattern**

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/Raffle.json";

export default function RaffleListener() {
  const [latestWinner, setLatestWinner] = useState(null);
  const [history, setHistory] = useState([]);

  useEffect(() => {
    // Build the provider and contract inside the effect, so the cleanup
    // below can reach the same contract object.
    const provider = new ethers.JsonRpcProvider(import.meta.env.VITE_RPC_URL);
    const contract = new ethers.Contract(
      import.meta.env.VITE_CONTRACT_ADDRESS,
      abi,
      provider
    );

    const handleWinnerPicked = (winner) => {
      setLatestWinner(winner);
      // Functional update: always builds on the newest list, even if
      // several events arrive before React re-renders.
      setHistory((prev) => [winner, ...prev].slice(0, 5));
    };

    contract.on("WinnerPicked", handleWinnerPicked);

    // Cleanup: runs on unmount
    return () => {
      contract.off("WinnerPicked", handleWinnerPicked);
    };
  }, []); // Empty array = run once on mount

  return (
    <div>
      <h2>🎰 Raffle Listener</h2>
      <h3>🎉 Latest Winner</h3>
      <p>{latestWinner || "Waiting for winner..."}</p>

      <h3>Last 5 Winners</h3>
      <ul>
        {history.map((w, i) => (
          <li key={i}>{w}</li>
        ))}
      </ul>
    </div>
  );
}
```

#### **Why `setHistory((prev) => ...)` and Not `setHistory([winner, ...history])`?**

The handler is created once, on mount, when `history` was `[]`. If it read `history` directly, it would always see that empty array, and every new event would wipe the list. This is called a **stale closure**. The functional form `setHistory((prev) => ...)` asks React for the current list each time.

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
│  - No stacked       │
│    listeners!       │
└─────────────────────┘
```

#### **Common Mistake: Missing Cleanup**

```js
// ❌ BAD: no cleanup — each remount adds another listener
useEffect(() => {
  const contract = new ethers.Contract(address, abi, provider);
  contract.on("WinnerPicked", (winner) => {
    setLatestWinner(winner);
  });
}, []);

// ✅ GOOD: proper cleanup
useEffect(() => {
  const contract = new ethers.Contract(address, abi, provider);
  const handler = (winner) => setLatestWinner(winner);
  contract.on("WinnerPicked", handler);

  return () => {
    contract.off("WinnerPicked", handler);
  };
}, []);
```

In development, React's Strict Mode mounts each component, unmounts it, and mounts it again, precisely to catch missing cleanups like this one. A missing cleanup shows up as every event appearing twice.

---

### 4. Historical Events with `queryFilter`

`contract.on` only hears events from now on. To show winners from *before* the page loaded, ask for past logs.

#### **Basic Query**

```js
// Fetch WinnerPicked events from a recent range of blocks
const currentBlock = await provider.getBlockNumber();
const events = await contract.queryFilter(
  "WinnerPicked", // Event name
  currentBlock - 1000, // From block
  "latest" // To block ("latest" = most recent)
);

console.log(`Found ${events.length} past winners`);
```

#### **Understanding the Event Object**

Each item in the array is an `EventLog`:

```js
{
  // The decoded event arguments
  args: ["0x1234..."], // also readable by name: event.args.winner

  // Where it happened
  blockNumber: 6123456,
  blockHash: "0xabcd...",
  transactionHash: "0xefgh...",
  index: 2, // position of this log in its block

  // Helpers (each returns a Promise)
  // event.getBlock(), event.getTransaction(), event.getTransactionReceipt()
}
```

Reading `event.args.winner` by name works because the ABI names the parameter `winner`.

#### **Combining Historical + Live Events**

When the setup needs `await`, the cleanup must still be returned from the effect itself, not from the async function:

```js
useEffect(() => {
  const provider = new ethers.JsonRpcProvider(import.meta.env.VITE_RPC_URL);
  const contract = new ethers.Contract(ADDRESS, abi, provider);

  const handler = (winner) => {
    setWinners((prev) => [winner, ...prev]);
  };

  async function loadPast() {
    const currentBlock = await provider.getBlockNumber();
    const past = await contract.queryFilter(
      "WinnerPicked",
      currentBlock - 1000,
      "latest"
    );
    // Newest first, to match the live list
    setWinners(past.map((e) => e.args.winner).reverse());
  }

  loadPast();
  contract.on("WinnerPicked", handler);

  // Returned synchronously, so React always gets the cleanup
  return () => {
    contract.off("WinnerPicked", handler);
  };
}, []);
```

A `return` inside `async function loadPast()` would hand the cleanup to a Promise that React never looks at. The listener would never be removed.

#### **Limit the Query Range**

```js
// ❌ BAD: asking for the whole chain's history
const events = await contract.queryFilter("WinnerPicked", 0, "latest");

// ✅ GOOD: only recent blocks (or start at the block the contract was deployed)
const currentBlock = await provider.getBlockNumber();
const fromBlock = Math.max(0, currentBlock - 10000);
const recent = await contract.queryFilter("WinnerPicked", fromBlock, "latest");
```

Many RPC providers refuse log queries that span too many blocks, or limit them on free plans. Small ranges are faster and less likely to be rejected.

---

### 5. Best Practices for Event Listeners

1. **Always clean up.** Use a named handler with `off`, or `removeAllListeners`, in the `useEffect` cleanup.
2. **Use functional state updates** inside handlers, to avoid stale closures.
3. **Show a waiting state.** Before the first event arrives, tell the user the app is listening, for example "Waiting for winner...". A blank box looks broken.
4. **Handle connection errors.** A wrong RPC URL should produce a message, not silence. Ethers v6 marks these errors with the code `NETWORK_ERROR`, which `ethers.isError(error, "NETWORK_ERROR")` detects.
5. **Bound your history.** Keep only what you show, like the last 5 winners, so the list does not grow forever.

---

### 6. Common Mistakes to Avoid

1. **Using an anonymous handler and then trying to `off` it.** Name the handler, or use `removeAllListeners`.

2. **Creating the contract (and a listener) during every render**

   ```js
   // ❌ A new listener on every render!
   function Component() {
     const contract = new ethers.Contract(address, abi, provider);
     contract.on("WinnerPicked", handler);
   }

   // ✅ Subscribe once, inside useEffect, and clean up
   function Component() {
     useEffect(() => {
       const contract = new ethers.Contract(address, abi, provider);
       contract.on("WinnerPicked", handler);
       return () => contract.off("WinnerPicked", handler);
     }, []);
   }
   ```

3. **Reading state directly inside the handler** (`[winner, ...history]`) instead of the functional update. The list keeps resetting.

---

### 7. Testing Your Event Listeners

On Sepolia, call `pickWinner()` from another tab or from Remix and watch your UI:

1. ✅ **Initial state**: shows "Waiting for winner..."
2. ✅ **Event received**: the winner appears within a few seconds of the block
3. ✅ **Multiple events**: the newest winner is on top, and the list stops at 5
4. ✅ **Component unmount**: no errors, and no doubled events after remounting

**How this is graded:** the platform mounts your component against a pretend `Raffle` contract and fires `WinnerPicked` events at it. It checks the waiting message, that you subscribed with `contract.on("WinnerPicked", ...)`, and that winners appear newest first in a list capped at 5. It also unmounts the component to check that your cleanup unsubscribes. The activity page lists the exact markup it counts.

---

### External References & Further Learning

- **Ethers v6 Contract Events**: https://docs.ethers.org/v6/api/contract/ - `on`, `off`, `queryFilter` and filters
- **Ethers v6 Migration Notes**: https://docs.ethers.org/v6/migrating/ - What changed from v5
- **React `useEffect`**: https://react.dev/reference/react/useEffect - Effects and cleanup functions
- **Solidity Events**: https://docs.soliditylang.org/en/latest/contracts.html#events - How events and `indexed` work
- **Sepolia Etherscan**: https://sepolia.etherscan.io - The "Logs" tab of a transaction shows its events

---

## 🌟 Closing Story

Back in Cubao, the raffle DApp lit up every time someone on-chain won, just like the live perya draws. Odessa watched remote entries trigger confetti on screen, no refresh needed.

Her `pickWinner()` still chose the first player, which is fine for testing and nowhere near fair. True randomness (for example Chainlink VRF) can wait for another day. Next up: proving who you are with your wallet. Odessa’s journey from read-only views to live event subscriptions proves Pinoy Web3 builders can deliver world-class, real-time dApps! 🚀🇵🇭🎉
