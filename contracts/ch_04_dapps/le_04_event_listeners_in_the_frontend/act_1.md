# Event Listeners in the Frontend Activity

Odessa's perya raffle needs a live board: the moment the contract picks a winner, the screen should show it, with no refresh. In this activity you build `RaffleListener`. It subscribes to the `WinnerPicked` event, shows the latest winner and the last five winners, and cleans up after itself.

**What you will learn:** how to listen for smart contract events with ethers v6 (`contract.on`), update React state from them, and unsubscribe (`contract.off`) in a `useEffect` cleanup so that listeners never stack.

## The Contract You Are Listening To

You do not write or deploy this contract. It is here so you know where the event comes from.

```solidity
// Raffle.sol - already deployed on Sepolia
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

## Initial Code

This is the starter that opens in your editor. The comment on line 1 says `.js`, but the file you are editing is `RaffleListener.jsx`.

```js
// RaffleListener.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/Raffle.json";

export default function RaffleListener() {
  const [winner, setWinner] = useState(null);
  const [history, setHistory] = useState([]);

  useEffect(() => {
    // TODO: Task 1 - Build a read-only provider and contract
    // TODO: Task 2 - Subscribe to the "WinnerPicked" event; on each one, store
    //                the winner and prepend it to a history capped at 5
    // TODO: Task 3 - Return a cleanup that unsubscribes, so remounting the
    //                component does not stack duplicate listeners
  }, []);

  return (
    <div>
      <h2>Raffle Listener</h2>
      {/* TODO: Task 4 - Show the latest winner and the history list */}
      <p>Placeholder</p>
    </div>
  );
}
```

The editor provides `process.env.REACT_APP_RPC_URL` (a Sepolia RPC URL), `process.env.REACT_APP_CONTRACT_ADDRESS` and the ABI file `../abi/Raffle.json`. In your own Vite project you would use `import.meta.env.VITE_RPC_URL` instead.

**Time Allotment: 30 minutes**

## Tasks for Learners

Topics Covered: smart contract events, `contract.on()`, `contract.off()`, `useEffect` cleanup, functional state updates, real-time UI

This lesson uses **ethers v6**: `new ethers.JsonRpcProvider(...)`, not `ethers.providers.JsonRpcProvider`. <!-- v5-ok -->

Tasks 1 to 3 all go inside the `useEffect`, in order, replacing the three `TODO` comments.

---

### Task 1: Build a Read-Only Provider and Contract

Listening needs no wallet, so a `JsonRpcProvider` is enough:

```js
const provider = new ethers.JsonRpcProvider(process.env.REACT_APP_RPC_URL);
const contract = new ethers.Contract(
  process.env.REACT_APP_CONTRACT_ADDRESS,
  abi,
  provider
);
```

Create them **inside** the `useEffect`, so the cleanup in Task 3 can reach this same `contract`.

---

### Task 2: Subscribe to `WinnerPicked`

Define a **named** handler, then subscribe it:

```js
const handleWinnerPicked = (winnerAddress) => {
  setWinner(winnerAddress);
  // Functional update: several events can land before React re-renders.
  setHistory((prev) => [winnerAddress, ...prev].slice(0, 5));
};

contract.on("WinnerPicked", handleWinnerPicked);
```

- The event's one parameter, the winner's address, arrives as the handler's first argument.
- `[winnerAddress, ...prev]` puts the **newest** winner first. `.slice(0, 5)` keeps only the five most recent.
- Use the functional form `setHistory((prev) => ...)`. The handler is created once, when the component mounts, so reading `history` directly would always see the empty starting list.
- Naming the handler lets you remove exactly this one in Task 3.

---

### Task 3: Unsubscribe in the Cleanup

Return a cleanup function from the `useEffect`. React runs it when the component unmounts:

```js
// Without this, every remount adds another listener and the UI
// double-counts each event.
return () => {
  contract.off("WinnerPicked", handleWinnerPicked);
};
```

`contract.off` must receive the **same** event name and the **same** function you passed to `contract.on`. Another accepted cleanup is `contract.removeAllListeners("WinnerPicked")`, or `contract.removeAllListeners()` with no argument, which removes every listener on that contract.

Your finished `useEffect` reads:

```js
useEffect(() => {
  const provider = new ethers.JsonRpcProvider(process.env.REACT_APP_RPC_URL);
  const contract = new ethers.Contract(
    process.env.REACT_APP_CONTRACT_ADDRESS,
    abi,
    provider
  );

  const handleWinnerPicked = (winnerAddress) => {
    setWinner(winnerAddress);
    // Functional update: several events can land before React re-renders.
    setHistory((prev) => [winnerAddress, ...prev].slice(0, 5));
  };

  contract.on("WinnerPicked", handleWinnerPicked);

  // Without this, every remount adds another listener and the UI
  // double-counts each event.
  return () => {
    contract.off("WinnerPicked", handleWinnerPicked);
  };
}, []);
```

---

### Task 4: Show the Latest Winner and the History

Replace the whole `return (...)` block (including `<p>Placeholder</p>`) with:

```js
return (
  <div>
    <h2>Raffle Listener</h2>
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
```

- `{winner || "Waiting for winner..."}` shows the waiting message until the first event arrives.
- Each history entry is its own `<li>`, inside a `<ul>`.

> **Graded details: markup and wording are checked.**
>
> - Before any event, the page must show text containing **Waiting** (any case). A different message such as "No winner yet" fails.
> - You must call `contract.on("WinnerPicked", handler)`, with exactly that event name, when the component mounts.
> - When an event arrives, the winner's address must appear on the page.
> - **Each history entry must be an `<li>` element**, and the grader counts them. Two events must give exactly two `<li>`s, with the newest one first. Seven events must give exactly five. Rendering the history as `<div>`s, or adding any other `<li>` to the page, breaks the count.
> - When the component unmounts, your cleanup must unsubscribe `WinnerPicked`, either with `contract.off("WinnerPicked", handler)` or with `contract.removeAllListeners(...)`.

---

## Common Mistakes

- **No cleanup.** The page works at first, then shows every winner twice after the component remounts. The grader checks for the unsubscribe.
- **Returning the cleanup from an inner `async` function** instead of from the `useEffect` itself. React never sees it.
- **`setHistory([winnerAddress, ...history])`.** This is a stale closure: the list keeps resetting to one entry. Use `setHistory((prev) => ...)`.
- **Appending instead of prepending** (`[...prev, winnerAddress]`). The newest winner ends up last, and the grader expects it first.
- **`ethers.providers.JsonRpcProvider`.** That is version 5 and fails here. <!-- v5-ok -->

---

## Breakdown of the Activity

**Variables Defined:**

- `winner`: The most recent winner's address, updated by each `WinnerPicked` event. It starts as `null`, which shows the waiting message.

- `history`: The last five winners, newest first. Each new winner is put at the front, and `.slice(0, 5)` drops the oldest.

- `provider`: A read-only `JsonRpcProvider`. Listening to events needs no wallet. With this provider, ethers polls the node every few seconds for new logs.

- `contract`: An `ethers.Contract` for the deployed `Raffle`. It provides `.on()` and `.off()`.

- `handleWinnerPicked`: The named event handler. Because it has a name, the cleanup can pass the exact same function to `.off()`.

**Key Functions:**

- `contract.on("WinnerPicked", handler)`:
  Subscribes to the event. Each time the contract emits it, ethers calls the handler with the winner's address as its first argument. The last argument is an event payload whose `log` holds the block number and transaction hash.

- `contract.off("WinnerPicked", handler)`:
  Unsubscribes that handler. You call it from the `useEffect` cleanup, so that remounting the component never leaves an old listener behind.

- `useEffect` Cleanup Pattern:
  React runs the function returned from `useEffect` when the component unmounts, or before the effect runs again. For listeners, this is what stops them from piling up.
