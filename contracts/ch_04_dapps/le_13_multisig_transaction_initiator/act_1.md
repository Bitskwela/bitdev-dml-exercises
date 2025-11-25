# List All Multisig Proposals Activity

## Initial Code

```js
// ProposalList.js - Starter Code
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getTransactionCount() view returns (uint256)",
  "function transactions(uint256) view returns (address to, uint256 value, bytes data, bool executed, uint256 numConfirmations)",
];

export default function ProposalList({ contractAddress }) {
  const [proposals, setProposals] = useState([]);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadProposals() {
      try {
        // TODO: Implement fetching proposals
      } catch (err) {
        setError(err.message);
      }
    }
    loadProposals();
  }, [contractAddress]);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  return (
    <div>
      <h3>Multisig Proposals</h3>
      {proposals.map((p) => (
        <div
          key={p.id}
          style={{ borderBottom: "1px solid #ccc", padding: "8px 0" }}
        >
          <p>
            <strong>ID #{p.id}</strong>
          </p>
          <p>To: {p.to}</p>
          <p>Value: {p.value} ETH</p>
          <p>Data: {p.data}</p>
          <p>Confirmations: {p.numConfirmations}</p>
          <p>Executed: {p.executed ? "✅" : "❌"}</p>
        </div>
      ))}
    </div>
  );
}
```

**Time Allotment: 15 minutes**

## Tasks for Learners

Topics Covered: MetaMask integration, `Web3Provider`, contract loops, `formatEther`, data formatting

---

### Task 1: Connect to MetaMask

Request account access from MetaMask and create a `Web3Provider` instance. Unlike `JsonRpcProvider`, this wraps the browser's injected wallet.

```js
await window.ethereum.request({ method: "eth_requestAccounts" });
const provider = new ethers.providers.Web3Provider(window.ethereum);
```

---

### Task 2: Create Contract Instance and Get Transaction Count

Instantiate the contract with the provider and call `getTransactionCount()` to know how many proposals exist. Convert the `BigNumber` to a regular number for looping.

```js
const wallet = new ethers.Contract(contractAddress, ABI, provider);
const count = (await wallet.getTransactionCount()).toNumber();
```

---

### Task 3: Loop Through and Format Proposals

Iterate through each transaction index, fetch the proposal data, format the ETH value using `formatEther`, truncate the hex data for display, and store in state.

```js
const items = [];
for (let i = 0; i < count; i++) {
  const [to, value, data, executed, numConfirmations] =
    await wallet.transactions(i);
  items.push({
    id: i,
    to,
    value: ethers.utils.formatEther(value),
    data: data.slice(0, 10) + "…",
    executed,
    numConfirmations: numConfirmations.toNumber(),
  });
}
setProposals(items);
```

---

## Breakdown of the Activity

**Variables Defined:**

- `proposals`: Array state holding all fetched transaction proposals. Each proposal contains `id`, `to`, `value`, `data`, `executed`, and `numConfirmations`.

- `provider`: A `Web3Provider` instance that wraps MetaMask. Required for dApps that need wallet context for transactions.

- `wallet`: The contract instance connected to the multisig wallet. Named `wallet` to reflect it represents the multisig wallet contract.

**Key Functions:**

- `eth_requestAccounts`:
  A JSON-RPC method that prompts MetaMask to show the connection popup. Returns an array of connected account addresses. Must be called before interacting with contracts through MetaMask.

- `getTransactionCount()`:
  Returns the total number of proposals in the multisig. We convert to a regular number using `.toNumber()` for use in the loop condition.

- `wallet.transactions(i)`:
  The public `transactions` array auto-generates a getter function. Calling it with an index returns all fields of the `Transaction` struct as a tuple.

- `ethers.utils.formatEther(value)`:
  Converts wei (smallest ETH unit, 10^18) to a human-readable ETH string. Essential for displaying transaction values.

- `data.slice(0, 10)`:
  Extracts the first 10 characters of the hex data (function selector). The full calldata can be very long, so we truncate for display.
