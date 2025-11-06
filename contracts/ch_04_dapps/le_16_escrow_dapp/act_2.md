# Activity 2: DepositFunds Component ⏱️ 10 mins

Create `DepositFunds` that lets the **Buyer** deposit ETH into escrow. After success, call a callback to refresh stats.

## 📋 Contract Baseline

Using the same `SimulatedEscrow.sol` contract from Activity 1 with:

- `function deposit() external payable onlyBuyer`
- `event Deposited(uint256 amount)`

## 🚀 Starter Code

**`DepositFunds.js`**

```js
import React, { useState } from "react";
import { ethers } from "ethers";

const ABI = ["function deposit() payable"];

export default function DepositFunds({ onDeposited }) {
  const [amount, setAmount] = useState("");
  const [error, setError] = useState("");

  async function deposit() {
    try {
      // TODO: ensure amount > 0
      // TODO: await window.ethereum.request({ method: "eth_requestAccounts" })
      // TODO: provider = new Web3Provider(window.ethereum)
      // TODO: signer = provider.getSigner()
      // TODO: escrow = new Contract(ESCROW_ADDR, ABI, signer)
      // TODO: tx = await escrow.deposit({ value: parseEther(amount) })
      // TODO: await tx.wait(), onDeposited(), clear amount
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <div>
      <h4>Deposit Funds</h4>
      <input
        placeholder="ETH amount"
        value={amount}
        onChange={(e) => setAmount(e.target.value)}
      />
      <button onClick={deposit}>Deposit</button>
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

## ✅ To Do List

- [ ] Validate `amount` is numeric & > 0.
- [ ] Request accounts and get signer.
- [ ] Call `deposit()` with `{ value: parseEther(amount) }`.
- [ ] Wait for tx, then `onDeposited()`.

## 🎯 Full Solution

```js
// DepositFunds.js
import React, { useState } from "react";
import { ethers } from "ethers";

const ABI = ["function deposit() payable"];
const ADDR = process.env.REACT_APP_ESCROW_ADDRESS;

export default function DepositFunds({ onDeposited }) {
  const [amount, setAmount] = useState("");
  const [error, setError] = useState("");

  async function deposit() {
    setError("");
    if (!amount || isNaN(amount) || Number(amount) <= 0) {
      setError("Enter a valid amount");
      return;
    }
    try {
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const escrow = new ethers.Contract(ADDR, ABI, signer);
      const tx = await escrow.deposit({
        value: ethers.utils.parseEther(amount),
      });
      await tx.wait();
      setAmount("");
      onDeposited();
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <div>
      <h4>Deposit Funds</h4>
      <input
        placeholder="ETH amount"
        value={amount}
        onChange={(e) => setAmount(e.target.value)}
      />
      <button onClick={deposit}>Deposit</button>
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```
