# Real-Time Gas Fee Tracker Activity

## Initial Code

```js
// # .env Configuration
// REACT_APP_RPC_URL=https://sepolia.infura.io/v3/YOUR_KEY
// REACT_APP_GAS_TRACKER_ADDRESS=0xYourDeployedGasTracker

// GasStats.js - Starter Code
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = ["function getBaseFee() view returns (uint256)"];

export default function GasStats() {
  const [base, setBase] = useState(null);
  const [error, setError] = useState("");

  useEffect(() => {
    async function fetchBaseFee() {
      try {
        // TODO: Task 1 - Create the provider instance
        // @note Use JsonRpcProvider with the RPC URL from environment variables
        // TODO: Task 2 - Create the contract instance
        // @note Use ethers.Contract with the deployed address, ABI, and provider
        // TODO: Task 3 - Fetch base fee and update state
        // @note Call getBaseFee() and store the BigNumber result in state
      } catch (err) {
        setError(err.message);
      }
    }
    fetchBaseFee();
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (base === null) return <p>Loading base fee…</p>;
  return <p>Current Base Fee: {base.toString()} wei</p>;
}
```

**Time Allotment: 15 minutes**

## Tasks for Learners

Topics Covered: `JsonRpcProvider`, contract instantiation, `BigNumber` handling, environment variables

---

### Task 1: Create the Provider Instance

Instantiate a `JsonRpcProvider` using the RPC URL from environment variables. This provider connects to the Ethereum network without requiring a wallet.

```js
const provider = new ethers.providers.JsonRpcProvider(
  process.env.REACT_APP_RPC_URL
);
```

---

### Task 2: Create the Contract Instance

Create a contract instance using `ethers.Contract` with the deployed contract address, ABI, and provider. This allows read-only calls to the smart contract.

```js
const contract = new ethers.Contract(
  process.env.REACT_APP_GAS_TRACKER_ADDRESS,
  ABI,
  provider
);
```

---

### Task 3: Fetch Base Fee and Update State

Call the `getBaseFee()` function from the contract and store the returned `BigNumber` in component state.

```js
const fee = await contract.getBaseFee();
setBase(fee);
```

---

## Breakdown of the Activity

**Variables Defined:**

- `base`: State variable that holds the `BigNumber` returned from the contract. Initially `null` to indicate loading state.

- `error`: Stores any error messages that occur during the fetch process.

- `provider`: An instance of `JsonRpcProvider` that connects to the Ethereum network via RPC URL. Unlike `Web3Provider`, it doesn't require a browser wallet.

- `contract`: An instance of `ethers.Contract` representing the deployed `GasTracker`. Uses the ABI to understand available functions.

**Key Functions:**

- `fetchBaseFee`:
  An async function that creates the provider and contract instances, then calls `getBaseFee()` on the contract. The returned `BigNumber` is stored in state. If any error occurs (network issues, invalid address), it's caught and displayed to the user.

- `base.toString()`:
  Converts the `BigNumber` to a string for display. `BigNumber` is used because JavaScript cannot safely handle the large integers common in Ethereum.
