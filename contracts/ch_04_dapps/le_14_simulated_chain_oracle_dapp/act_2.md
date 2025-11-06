# Activity 2: Build Donate Component

**Time**: 10 minutes  
**Goal**: Create `Donate.js` allowing users to send ETH to the relief pool. After donation, refresh `ReliefStats`.

## Background

The typhoon relief system needs funding before it can distribute aid. This component creates a simple donation interface that sends ETH directly to the smart contract's balance.

## Starter Code

Create `Donate.js`:

```javascript
import React, { useState } from "react";
import { ethers } from "ethers";

const ABI = ["function donate() payable"];

export default function Donate({ onDonated }) {
  const [amount, setAmount] = useState("");
  const [error, setError] = useState("");

  async function donate() {
    try {
      // TODO: validate amount > 0
      // TODO: request accounts, get signer
      // TODO: relief = new Contract(CONTRACT, ABI, signer)
      // TODO: tx = await relief.donate({ value: parseEther(amount) })
      // TODO: await tx.wait(), onDonated(), clear amount
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <div>
      <h4>Donate to Relief Pool</h4>
      <input
        value={amount}
        onChange={(e) => setAmount(e.target.value)}
        placeholder="ETH amount"
      />
      <button onClick={donate}>Donate</button>
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

## To Do List

- [ ] Ensure `amount` is positive and numeric
- [ ] `window.ethereum.request({ method: "eth_requestAccounts" })`
- [ ] Signer & contract: `new ethers.Contract(...)`
- [ ] `parseEther(amount)` & `donate({ value })`
- [ ] `await tx.wait()`, call `onDonated()` to reload stats

## Key Concepts

- **Payable Functions**: Sending ETH with smart contract calls
- **Input Validation**: Ensuring positive donation amounts
- **Parent Callbacks**: Notifying parent components to refresh data
- **Transaction Waiting**: Confirming blockchain inclusion before UI updates

## Full Solution

```javascript
// Donate.js
import React, { useState } from "react";
import { ethers } from "ethers";

const ABI = ["function donate() payable"];
const CONTRACT = process.env.REACT_APP_RELIEF_ADDRESS;

export default function Donate({ onDonated }) {
  const [amount, setAmount] = useState("");
  const [error, setError] = useState("");

  async function donate() {
    setError("");
    if (!amount || isNaN(amount) || Number(amount) <= 0) {
      setError("Enter a valid amount");
      return;
    }
    try {
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const relief = new ethers.Contract(CONTRACT, ABI, signer);
      const value = ethers.utils.parseEther(amount);
      const tx = await relief.donate({ value });
      await tx.wait();
      setAmount("");
      onDonated();
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <div>
      <h4>Donate to Relief Pool</h4>
      <input
        value={amount}
        onChange={(e) => setAmount(e.target.value)}
        placeholder="ETH amount"
      />
      <button onClick={donate}>Donate</button>
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```
