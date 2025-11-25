# Fetch LP Reserves & Total Supply Activity

## Initial Code

```js
// LPStats.js - Starter Code

// .env Configurations
// REACT_APP_RPC_URL=http://127.0.0.1:8545
// REACT_APP_LP_ADDRESS=0xYourMockLPAddress

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
      try {
        // TODO: Implement fetching LP stats
      } catch (err) {
        setError(err.message);
      }
    }
    fetchStats();
  }, []);

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
}
```

**Time Allotment: 10 minutes**

## Tasks for Learners

Topics Covered: Address validation, `JsonRpcProvider`, tuple destructuring, multiple contract calls

---

### Task 1: Validate the Contract Address

Before interacting with the contract, validate that the LP address from environment variables is a valid Ethereum address using `ethers.utils.isAddress()`.

```js
const LP_ADDRESS = process.env.REACT_APP_LP_ADDRESS;

if (!ethers.utils.isAddress(LP_ADDRESS)) {
  throw new Error("Invalid LP contract address");
}
```

---

### Task 2: Create Provider and Contract Instance

Instantiate a `JsonRpcProvider` with the RPC URL and create a contract instance for read-only calls to the MockLP contract.

```js
const provider = new ethers.providers.JsonRpcProvider(
  process.env.REACT_APP_RPC_URL
);
const lp = new ethers.Contract(LP_ADDRESS, ABI, provider);
```

---

### Task 3: Fetch Reserves and Total Supply

Call `getReserves()` and `getTotalSupply()` from the contract. Destructure the tuple returned by `getReserves()` and update component state with the fetched values.

```js
const [r0, r1] = await lp.getReserves();
const ts = await lp.getTotalSupply();
setReserves({ r0, r1 });
setSupply(ts);
```

---

## Breakdown of the Activity

**Variables Defined:**

- `reserves`: State object containing `r0` and `r1` representing the token balances in the liquidity pool. Initially both are `null` to indicate loading.

- `supply`: The total number of LP tokens minted, representing total liquidity provided to the pool.

- `LP_ADDRESS`: The deployed contract address read from environment variables. Must be validated before use.

**Key Functions:**

- `ethers.utils.isAddress()`:
  A utility function that validates whether a string is a valid Ethereum address (40 hex characters with 0x prefix). Returns `true` or `false`. Essential for preventing errors when interacting with invalid addresses.

- `getReserves()`:
  Returns a tuple of two `uint112` values. In JavaScript, we destructure this as `const [r0, r1] = await lp.getReserves()`. Each value is a `BigNumber` representing the token balance.

- `fetchStats`:
  The main async function that validates the address, creates the provider and contract, fetches both reserves and total supply, and updates state. Errors are caught and displayed to the user.
