# Activity 3: Confirm a Proposal

**Time**: 10 minutes  
**Goal**: Build a `ConfirmButton` component that shows "Confirm" or "Confirmed" for a given `txId`. Clicking it calls `confirmTransaction(txId)`, awaits confirmation, and triggers a reload.

## Background

Multisig wallets require multiple owner confirmations before execution. This component handles the confirmation interface, checking if the current user has already confirmed and allowing them to add their signature.

## Starter Code

Create `ConfirmButton.js`:

```javascript
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = [
  "function isOwner(address) view returns (bool)",
  "function confirmations(uint256,address) view returns (bool)",
  "function confirmTransaction(uint256)",
];

export default function ConfirmButton({ contractAddress, txId, onConfirmed }) {
  const [confirmed, setConfirmed] = useState(false);

  useEffect(() => {
    async function check() {
      // TODO: provider & contract
      // TODO: get signer account
      // TODO: call confirmations(txId, account) and setConfirmed
    }
    check();
  }, [txId]);

  async function confirmTx() {
    try {
      // TODO: request accounts, get signer, call confirmTransaction(txId), await tx.wait()
      // TODO: setConfirmed(true) and onConfirmed()
    } catch (err) {
      console.error(err);
    }
  }

  return (
    <button onClick={confirmTx} disabled={confirmed}>
      {confirmed ? "✅ Confirmed" : "Confirm"}
    </button>
  );
}
```

## To Do List

- [ ] Get current account with `eth_requestAccounts`
- [ ] Provider & contract with ABI & signer
- [ ] Call `confirmations(txId, account)` in `useEffect`
- [ ] In `confirmTx()`, call `confirmTransaction(txId)`, `await tx.wait()`, `setConfirmed(true)`, `onConfirmed()`

## Key Concepts

- **State Checking**: Query blockchain to see if user already confirmed
- **Dynamic UI**: Button text and disabled state reflect confirmation status
- **Owner Permissions**: Only multisig owners can confirm transactions
- **Real-time Updates**: Component reflects latest blockchain state

## Full Solution

```javascript
// ConfirmButton.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = [
  "function confirmations(uint256,address) view returns (bool)",
  "function confirmTransaction(uint256)",
];

export default function ConfirmButton({ contractAddress, txId, onConfirmed }) {
  const [confirmed, setConfirmed] = useState(false);

  useEffect(() => {
    async function check() {
      const [account] = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const wallet = new ethers.Contract(contractAddress, ABI, provider);
      const did = await wallet.confirmations(txId, account);
      setConfirmed(did);
    }
    check();
  }, [txId, contractAddress]);

  async function confirmTx() {
    try {
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const wallet = new ethers.Contract(contractAddress, ABI, signer);
      const tx = await wallet.confirmTransaction(txId);
      await tx.wait();
      setConfirmed(true);
      onConfirmed();
    } catch (err) {
      console.error(err);
    }
  }

  return (
    <button onClick={confirmTx} disabled={confirmed}>
      {confirmed ? "✅ Confirmed" : "Confirm"}
    </button>
  );
}
```
