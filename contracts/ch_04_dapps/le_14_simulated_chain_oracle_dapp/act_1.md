# Build ReliefStats Component Activity

## Initial Code

```js
// .env Configuration
// REACT_APP_RPC_URL=http://127.0.0.1:8545
// REACT_APP_RELIEF_ADDRESS=0xYourTyphoonReliefAddress

// ReliefStats.js - Starter Code
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function windSpeed() view returns (uint256)",
  "function released() view returns (bool)",
];

export default function ReliefStats() {
  const [wind, setWind] = useState(null);
  const [balance, setBalance] = useState(null);
  const [released, setReleased] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadStats() {
      try {
        // TODO: Implement loading relief stats
      } catch (err) {
        setError(err.message);
      }
    }
    loadStats();
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (wind === null) return <p>Loading relief stats…</p>;
  return (
    <div>
      <h3>Typhoon Relief Chain Stats</h3>
      <p>Wind Speed: {wind} km/h</p>
      <p>Pool Balance: {balance} ETH</p>
      <p>Released: {released ? "✅ Funds Dispatched" : "❌ Pending"}</p>
    </div>
  );
}
```

**Time Allotment: 10 minutes**

## Tasks for Learners

Topics Covered: `Web3Provider`, contract reads, `provider.getBalance()`, `Promise.all`, `formatEther`

---

### Task 1: Connect to MetaMask and Create Provider

Request MetaMask account access and create a `Web3Provider` instance to connect to the user's wallet.

```js
await window.ethereum.request({ method: "eth_requestAccounts" });
const provider = new ethers.providers.Web3Provider(window.ethereum);
```

---

### Task 2: Create Contract and Fetch Wind Speed & Release Status

Instantiate the relief contract and use `Promise.all` to fetch both `windSpeed()` and `released()` in parallel for better performance.

```js
const CONTRACT = process.env.REACT_APP_RELIEF_ADDRESS;
const relief = new ethers.Contract(CONTRACT, ABI, provider);

const [ws, rel] = await Promise.all([relief.windSpeed(), relief.released()]);
```

---

### Task 3: Fetch Contract Balance and Update State

Use `provider.getBalance()` to query the contract's ETH balance, then update all state variables with properly formatted values.

```js
const bal = await provider.getBalance(CONTRACT);

setWind(ws.toNumber());
setReleased(rel);
setBalance(ethers.utils.formatEther(bal));
```

---

## Breakdown of the Activity

**Variables Defined:**

- `wind`: The current wind speed reading from the oracle, stored as a number (km/h). Converted from `BigNumber` using `.toNumber()`.

- `balance`: The contract's ETH pool balance as a string. Converted from wei using `formatEther()` for human-readable display.

- `released`: Boolean indicating whether funds have been dispatched to the beneficiary when wind speed exceeded the threshold.

- `CONTRACT`: The deployed contract address from environment variables. Used for both contract instantiation and balance queries.

**Key Functions:**

- `provider.getBalance(address)`:
  Queries the ETH balance of any address (wallet or contract). Returns a `BigNumber` in wei. Unlike token balances which require contract calls, ETH balance is queried directly from the provider.

- `Promise.all([...])`:
  Executes multiple async calls in parallel and waits for all to complete. More efficient than sequential `await` calls. Returns an array of results in the same order as the input promises.

- `ws.toNumber()`:
  Converts a `BigNumber` to a JavaScript number. Safe for values that fit within JavaScript's safe integer range (wind speed values). For large values like token amounts, use `.toString()` instead.

- `ethers.utils.formatEther(bal)`:
  Converts wei (10^18) to ETH as a string. Essential for displaying ETH amounts in a human-readable format.
