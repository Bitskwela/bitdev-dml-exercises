# Fetch LP Reserves & Total Supply Activity

**Goal:** check that a liquidity-pool address is valid, then read two kinds of on-chain data, a **tuple** (`getReserves()` returns two numbers at once) and a single value (`getTotalSupply()`), and show all three numbers with loading and error states.

Neri's workshop audience at Ateneo wants to see the pool's real numbers. Det's first card is the honest foundation: Reserve0, Reserve1 and Total Supply, read straight from the `MockLP` contract on Sepolia.

## Initial Code

This is the starter file you will edit (`LPStats.jsx`):

```jsx
// LPStats.js - Starter Code
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getReserves() view returns (uint112, uint112)",
  "function getTotalSupply() view returns (uint256)",
];

export default function LPStats() {
  const [reserves, setReserves] = useState({ r0: null, r1: null });
  const [supply, setSupply] = useState(null);
  const [error, setError] = useState("");

  useEffect(() => {
    async function fetchStats() {
      // TODO: Task 1 - Reject an invalid LP address before doing any work
      // TODO: Task 2 - Build a read-only provider and contract
      // TODO: Task 3 - Read getReserves() (a tuple) and getTotalSupply()
    }
    fetchStats();
  }, []);

  // TODO: Task 4 - Render the error, the loading state, and the three numbers
  return <p>Placeholder</p>;
}
```

Two values are provided for you as environment variables:

- `process.env.REACT_APP_RPC_URL`: the Sepolia RPC endpoint.
- `process.env.REACT_APP_LP_ADDRESS`: the deployed `MockLP` contract.

**Time Allotment: 25 minutes**

## Tasks for Learners

Topics Covered: `ethers.isAddress`, `ethers.JsonRpcProvider` (ethers v6), destructuring a tuple return, `bigint` values, loading and error states.

Tasks 1, 2 and 3 all go **inside** `fetchStats()`, in place of its three TODO lines, inside one `try`/`catch`. Task 4 replaces the `return <p>Placeholder</p>;` line. This builds directly on the previous lesson (Gas Fee Checker); the new ideas are the address check and the tuple.

---

### Task 1: Reject an invalid LP address before doing any work

Environment variables are typed by humans, and humans make typos. Check the address **first**, before you build anything. If it is not a valid address, `throw` an error; the `catch` you add in Task 3 turns it into a message on screen.

Open a `try` block (you close it in Task 3) and start it like this:

```jsx
try {
  const LP_ADDRESS = process.env.REACT_APP_LP_ADDRESS;

  if (!ethers.isAddress(LP_ADDRESS)) {
    throw new Error("Invalid LP contract address");
  }
```

`ethers.isAddress("not-an-address")` returns `false`, and `ethers.isAddress("0x4444…4444")` returns `true`. Because you `throw` before the contract exists, a bad address never reaches the chain.

---

### Task 2: Build a read-only provider and contract

Pool stats are public, so no wallet is needed. Still inside the `try`:

```jsx
  const provider = new ethers.JsonRpcProvider(
    process.env.REACT_APP_RPC_URL
  );
  const lp = new ethers.Contract(LP_ADDRESS, ABI, provider);
```

---

### Task 3: Read `getReserves()` (a tuple) and `getTotalSupply()`

`getReserves()` returns **two** numbers at once. In ethers v6 the result behaves like an array, so you can unpack it with array destructuring: `[r0, r1]`. Then read the total supply, save everything to state, and close the `try` with a `catch`:

```jsx
  const [r0, r1] = await lp.getReserves();
  const ts = await lp.getTotalSupply();
  setReserves({ r0, r1 });
  setSupply(ts);
} catch (err) {
  setError(err.message);
}
```

After Tasks 1 to 3, your whole `fetchStats()` should look exactly like this:

```jsx
async function fetchStats() {
  try {
    const LP_ADDRESS = process.env.REACT_APP_LP_ADDRESS;

    if (!ethers.isAddress(LP_ADDRESS)) {
      throw new Error("Invalid LP contract address");
    }

    const provider = new ethers.JsonRpcProvider(
      process.env.REACT_APP_RPC_URL
    );
    const lp = new ethers.Contract(LP_ADDRESS, ABI, provider);

    const [r0, r1] = await lp.getReserves();
    const ts = await lp.getTotalSupply();
    setReserves({ r0, r1 });
    setSupply(ts);
  } catch (err) {
    setError(err.message);
  }
}
```

`r0`, `r1` and `ts` are all `bigint` values (for example `120000000000000000000n`).

---

### Task 4: Render the error, the loading state, and the three numbers

Replace `return <p>Placeholder</p>;` with this. Error first, then loading, then the data:

```jsx
if (error) return <p style={{ color: "red" }}>{error}</p>;
if (reserves.r0 === null) return <p>Loading LP data…</p>;
return (
  <div>
    <h3>LP Reserves & Supply</h3>
    <p>Reserve0: {reserves.r0.toString()}</p>
    <p>Reserve1: {reserves.r1.toString()}</p>
    <p>Total Supply: {supply.toString()}</p>
  </div>
);
```

`.toString()` shows the raw on-chain units (for example `120000000000000000000`). Formatted values are accepted too, as long as they are exact: `ethers.formatUnits(reserves.r0, 18)` renders `120.0`, and `ethers.formatEther(supply)` renders `7.35`.

---

> **Graded details: labels and wording are checked.** The hidden test checks these exact things:
>
> - **Invalid address:** when `REACT_APP_LP_ADDRESS` is `"not-an-address"`, your component must **not** call `getReserves()`, and the page must **not** still say `Loading`. Checking with `ethers.isAddress` and throwing (Task 1) does both.
> - You create the provider with `new ethers.JsonRpcProvider(...)`, not a wallet provider.
> - You call both `getReserves()` and `getTotalSupply()`.
> - The page shows **both** reserves and the total supply as exact numbers: either the raw units (`120000000000000000000`, `45000000000`, `7350000000000000000`) or the same values formatted with 6, 8 or 18 decimals (for example `120.0` and `7.35` with 18). Rounded values fail.
> - Once the data has arrived, the word `Loading` must be gone.

## Common Mistakes

- **Checking the address after building the contract.** The check must come first. A bad address should stop the function before any network call.
- **Keeping only one reserve.** `const r0 = await lp.getReserves()` stores the whole pair in `r0`. Destructure both: `const [r0, r1] = ...`.
- **Doing math with `Number`.** A JavaScript `Number` is only guaranteed exact up to about 9 quadrillion (`Number.MAX_SAFE_INTEGER`), and token amounts in base units pass that easily. Keep `bigint` math, or use `ethers.formatUnits` for display.
- **Using ethers v5 syntax.** This course runs ethers v6: `ethers.isAddress` and `ethers.JsonRpcProvider` sit directly on `ethers`.

## Breakdown of the Activity

**Variables Defined:**

- `reserves`: state object `{ r0, r1 }` holding the two pool reserves. `r0` starts as `null`, which signals loading.
- `supply`: state holding the total number of LP tokens.
- `error`: state holding an error message, empty when everything is fine.
- `LP_ADDRESS`: the pool address from the environment, checked before use.
- `provider` / `lp`: a read-only `JsonRpcProvider` and the `MockLP` contract built on it.

**Key Functions:**

- `ethers.isAddress(value)`: returns `true` only for a well-formed `0x` address. Used as a guard before any network work.
- `fetchStats`: runs once on mount. Validates, connects, reads the tuple and the supply, and stores either the values or the error.
- Array destructuring `const [r0, r1] = await lp.getReserves()`: unpacks a multi-value Solidity return into two variables in one line.
