# EscrowStats Component Activity

## Initial Code

```js
// .env Configuration
// REACT_APP_RPC_URL=http://127.0.0.1:8545
// REACT_APP_ESCROW_ADDRESS=0xYourEscrowAddress

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

export default function EscrowStats() {
  const [buyer, setBuyer] = useState("");
  const [seller, setSeller] = useState("");
  const [amt, setAmt] = useState(null);
  const [deposited, setDeposited] = useState(false);
  const [released, setReleased] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadStats() {
      try {
        // TODO: Create a JsonRpcProvider using the RPC URL from environment variables
        // TODO: Instantiate the escrow contract using the contract address and ABI
        // TODO: Fetch all escrow data using Promise.all for efficiency
        // TODO: Update all state variables with the fetched data
      } catch (err) {
        setError(err.message);
      }
    }
    loadStats();
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (amt === null) return <p>Loading escrow stats…</p>;
  return (
    <div>
      <h3>Escrow Status</h3>
      <p>Buyer: {buyer}</p>
      <p>Seller: {seller}</p>
      <p>Amount: {ethers.utils.formatEther(amt)} ETH</p>
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
}
```

**Time Allotment: 10 minutes**

## Tasks for Learners

Topics Covered: `JsonRpcProvider`, Read-only Contract Calls, `Promise.all`, `formatEther`, State Management in React

---

### Task 1: Initialize the Provider and Contract

Create a `JsonRpcProvider` using the RPC URL from environment variables. Then instantiate the escrow contract using the contract address and the provided ABI. The provider allows read-only access to the blockchain.

```js
const RPC = process.env.REACT_APP_RPC_URL;
const ADDR = process.env.REACT_APP_ESCROW_ADDRESS;

const provider = new ethers.providers.JsonRpcProvider(RPC);
const escrow = new ethers.Contract(ADDR, ABI, provider);
```

---

### Task 2: Fetch All Escrow Data Using Promise.all

Call all the contract's getter functions (`buyer()`, `seller()`, `amount()`, `deposited()`, `released()`) simultaneously using `Promise.all()` for better performance. This avoids making sequential calls and reduces loading time.

```js
const [b, s, a, dep, rel] = await Promise.all([
  escrow.buyer(),
  escrow.seller(),
  escrow.amount(),
  escrow.deposited(),
  escrow.released(),
]);
```

---

### Task 3: Update State with Fetched Data

After successfully fetching all the escrow data, update each state variable with the corresponding value. This will trigger a re-render and display the escrow information to the user.

```js
setBuyer(b);
setSeller(s);
setAmt(a);
setDeposited(dep);
setReleased(rel);
```

---

## Breakdown of the Activity

**Variables Defined:**

- `RPC`: The RPC URL from environment variables (`process.env.REACT_APP_RPC_URL`). Points to the Ethereum node (local Hardhat or testnet).

- `ADDR`: The deployed escrow contract address from environment variables. Used to instantiate the contract object.

- `provider`: A `JsonRpcProvider` instance that connects to the blockchain via the RPC URL. Used for read-only operations without requiring a wallet.

- `escrow`: The contract instance created with `ethers.Contract()`. Takes the address, ABI, and provider as arguments. Allows calling view functions.

- `buyer`, `seller`: State variables storing the buyer and seller addresses retrieved from the contract.

- `amt`: The deposited amount as a BigNumber. Displayed using `formatEther()` to convert from wei to ETH.

- `deposited`, `released`: Boolean state variables tracking the escrow status. Used to determine which status message to display.

**Key Functions:**

- `JsonRpcProvider(url)`:
  Creates a read-only connection to an Ethereum node. Unlike `Web3Provider` which connects to MetaMask, `JsonRpcProvider` connects directly to a node URL. Ideal for reading blockchain data without user interaction.

- `ethers.Contract(address, abi, provider)`:
  Creates a contract instance for interacting with a deployed contract. When passed a provider (not signer), it can only call view/pure functions. Each ABI entry becomes a callable method on the contract object.

- `Promise.all([...])`:
  Executes multiple async calls concurrently and waits for all to complete. Returns an array of results in the same order as the input promises. More efficient than sequential `await` calls.

- `formatEther(bigNumber)`:
  Converts a BigNumber in wei (10^18) to a human-readable ETH string. Essential for displaying token/ETH amounts since Solidity uses integers without decimals.
