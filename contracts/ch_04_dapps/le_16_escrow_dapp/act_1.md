# Escrow Status Viewer Activity

**Goal:** read an escrow contract's public state with a read-only provider and show who the parties are, how much is locked, and whether the money is still waiting.

Det's client in New York wants proof before work starts: "Show me the money is really in escrow." You will build `EscrowStats`, the panel both sides open to check the deal. It only reads, so it needs no wallet and no gas.

## Initial Code

```js
// EscrowStats.js - Starter Code
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function buyer() view returns (address)",
  "function seller() view returns (address)",
  "function amount() view returns (uint256)",
  "function deposited() view returns (bool)",
  "function released() view returns (bool)",
];
const RPC = process.env.REACT_APP_RPC_URL;
const ADDR = process.env.REACT_APP_ESCROW_ADDRESS;

export default function EscrowStats() {
  const [buyer, setBuyer] = useState("");
  const [seller, setSeller] = useState("");
  const [amt, setAmt] = useState(null);
  const [deposited, setDeposited] = useState(false);
  const [released, setReleased] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadStats() {
      // TODO: Task 1 - Build a read-only provider and the escrow contract
      // TODO: Task 2 - Read buyer, seller, amount, deposited and released together
      // TODO: Task 3 - Store them
    }
    loadStats();
  }, []);

  // TODO: Task 4 - Render the error, the loading state, the parties, the amount
  //                in ether, and a status of Released / Pending / Not Deposited
  return <p>Placeholder</p>;
}
```

**Time Allotment: 25 minutes**

> **Where do `RPC` and `ADDR` come from?** The grader fills in `process.env.REACT_APP_RPC_URL` (a Sepolia RPC) and `process.env.REACT_APP_ESCROW_ADDRESS` for you, so leave those two lines exactly as they are. In your own Vite project you would put the values in `.env` as `VITE_RPC_URL=...` and read them with `import.meta.env.VITE_RPC_URL`.

## Tasks for Learners

Topics Covered: `ethers.JsonRpcProvider`, read-only contract calls, `Promise.all`, `ethers.formatEther`, conditional rendering

The numbered tasks match the `TODO` comments in the starter. Follow them in order.

---

### Task 1: Build a read-only provider and the escrow contract

Escrow state is public, so anyone can read it without connecting a wallet. A `JsonRpcProvider` talks straight to a blockchain node by URL. Hand it to `ethers.Contract` together with the address and ABI, and you get an object whose methods are the contract's view functions.

Replace the three `TODO` lines inside `loadStats()` with this `try`/`catch`. The `catch` makes sure a bad RPC URL or a wrong address shows up as a message on screen instead of failing silently:

```js
async function loadStats() {
  try {
    // Task 1: Initialize provider and contract
    const provider = new ethers.JsonRpcProvider(RPC);
    const escrow = new ethers.Contract(ADDR, ABI, provider);

    // Task 2 goes here

    // Task 3 goes here
  } catch (err) {
    setError(err.message);
  }
}
```

**Required:** use `new ethers.JsonRpcProvider(RPC)`. Do not use `BrowserProvider` here, because this panel must work for someone with no wallet installed.

---

### Task 2: Read all five fields together with `Promise.all`

Each getter is a separate network request. If you `await` them one by one, you wait five times in a row. `Promise.all` sends all five at once and waits for every answer, then gives them back **in the same order you listed them**.

Put this where it says `// Task 2 goes here`:

```js
// Task 2: Fetch all escrow data using Promise.all
const [b, s, a, dep, rel] = await Promise.all([
  escrow.buyer(),
  escrow.seller(),
  escrow.amount(),
  escrow.deposited(),
  escrow.released(),
]);
```

`a` is the amount in **wei** as a JavaScript `bigint` (in ethers v6, every `uint256` comes back as a `bigint`). `dep` and `rel` are plain booleans.

**Required:** call all five getters: `buyer()`, `seller()`, `amount()`, `deposited()` and `released()`.

---

### Task 3: Store the values in state

Put this where it says `// Task 3 goes here`. Each setter triggers a re-render with the new data:

```js
// Task 3: Update state with fetched data
setBuyer(b);
setSeller(s);
setAmt(a);
setDeposited(dep);
setReleased(rel);
```

---

### Task 4: Render the error, the loading state, and the escrow status

Replace the starter's `return <p>Placeholder</p>;` with the code below. It renders in three stages. First comes the error if there is one, then a loading line while `amt` is still `null`, and finally the panel itself:

```js
if (error) return <p style={{ color: "red" }}>{error}</p>;
if (amt === null) return <p>Loading escrow stats…</p>;
return (
  <div>
    <h3>Escrow Status</h3>
    <p>Buyer: {buyer}</p>
    <p>Seller: {seller}</p>
    <p>Amount: {ethers.formatEther(amt)} ETH</p>
    <p>
      Status:{" "}
      {released
        ? "Released ✅"
        : deposited
        ? "Pending ⏳"
        : "Not Deposited ❌"}
    </p>
  </div>
);
```

The status line reads the escrow's life cycle, and its two flags give you three cases:

| `deposited` | `released` | Status shown |
| ----------- | ---------- | ------------ |
| `false`     | `false`    | Not Deposited ❌ |
| `true`      | `false`    | **Pending ⏳** (money locked, waiting for the buyer) |
| `true`      | `true`     | Released ✅ |

`ethers.formatEther(amt)` turns wei into an ether string, so `750000000000000000n` becomes `"0.75"`.

---

> **Graded details: labels and wording are checked.** The grader reads the escrow fixture (deposited `true`, released `false`, amount 0.75 ETH) and checks all of these:
>
> - It creates the provider with `new ethers.JsonRpcProvider(...)`.
> - It calls all five getters: `buyer()`, `seller()`, `amount()`, `deposited()` and `released()`.
> - The rendered text contains the full buyer address and the full seller address. Do not shorten them to `0xaAaA…AaAa`.
> - The amount appears as `0.75`, and the raw wei value `750000000000000000` must **not** appear anywhere on screen.
> - The status text contains the word **`Pending`** (any capitalisation) when the money is deposited but not released. Other wording such as "Awaiting release" or "Locked" fails, even though it means the same thing.

## Common mistakes

| Mistake | What happens | Fix |
| ------- | ------------ | --- |
| `ethers.providers.JsonRpcProvider` <!-- v5-ok --> | `TypeError`: that is the ethers v5 path <!-- v5-ok --> | ethers v6 uses `ethers.JsonRpcProvider` |
| `ethers.utils.formatEther(amt)` <!-- v5-ok --> | `TypeError` in v6 <!-- v5-ok --> | `ethers.formatEther(amt)` |
| Showing `{amt.toString()}` | Shows `750000000000000000`, which fails the "not wei" check | Always format wei with `formatEther` |
| Status reads "Waiting" or "Locked" | The Pending check fails | Use the exact word `Pending` |
| Forgetting the `amt === null` check | `formatEther(null)` throws on the first render, before the data arrives | Keep the loading line before the panel |

## Breakdown of the Activity

- **`JsonRpcProvider(url)`** is a read-only connection to a node. It cannot sign anything, which is exactly right for a page that only reads.
- **`new ethers.Contract(address, abi, provider)`** turns each ABI line into a method. With a provider (not a signer), only `view`/`pure` functions can be called.
- **`Promise.all([...])`** runs the reads in parallel and keeps their order.
- **`ethers.formatEther(bigint)`** converts wei (10^18 per ether) to a readable decimal string.
- **Status logic:** check `released` first. A released escrow is also deposited, so if you checked `deposited` first, a finished deal would be stuck showing "Pending".
