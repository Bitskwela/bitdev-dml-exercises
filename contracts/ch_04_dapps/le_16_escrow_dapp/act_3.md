# Activity 3: ReleaseControls Component ⏱️ 10 mins

Build `ReleaseControls` showing **Release** (for Buyer) and **Refund** (for Seller) buttons. Each calls the respective contract method and triggers a refresh.

## 📋 Contract Baseline

Using the same `SimulatedEscrow.sol` contract with:

- `function release() external onlyBuyer onlyDeposited onlyNotReleased`
- `function refund() external onlySeller onlyDeposited onlyNotReleased`
- `event Released(address to, uint256 amount)`

## 🚀 Starter Code

**`ReleaseControls.js`**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function buyer() view returns (address)",
  "function seller() view returns (address)",
  "function deposited() view returns (bool)",
  "function released() view returns (bool)",
  "function release()",
  "function refund()",
];

export default function ReleaseControls({ onAction }) {
  const [account, setAccount] = useState("");
  const [buyer, setBuyer] = useState("");
  const [seller, setSeller] = useState("");
  const [deposited, setDeposited] = useState(false);
  const [released, setReleased] = useState(false);

  useEffect(() => {
    async function load() {
      // TODO: request accounts, get provider, contract
      // TODO: set account, buyer, seller, deposited, released
    }
    load();
  }, []);

  async function doRelease() {
    // TODO: get signer & call release(), await tx.wait(), onAction()
  }

  async function doRefund() {
    // TODO: get signer & call refund(), await tx.wait(), onAction()
  }

  return (
    <div>
      {deposited && !released && (
        <div>
          {account.toLowerCase() === buyer.toLowerCase() && (
            <button onClick={doRelease}>Release Funds</button>
          )}
          {account.toLowerCase() === seller.toLowerCase() && (
            <button onClick={doRefund}>Refund Buyer</button>
          )}
        </div>
      )}
    </div>
  );
}
```

## ✅ To Do List

- [ ] On mount, fetch current `account`, `buyer`, `seller`, `deposited`, `released`.
- [ ] Implement `doRelease()` and `doRefund()` with signer, contract call, `await tx.wait()`, then `onAction()`.

## 🎯 Full Solution

```js
// ReleaseControls.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function buyer() view returns (address)",
  "function seller() view returns (address)",
  "function deposited() view returns (bool)",
  "function released() view returns (bool)",
  "function release()",
  "function refund()",
];
const ADDR = process.env.REACT_APP_ESCROW_ADDRESS;

export default function ReleaseControls({ onAction }) {
  const [account, setAccount] = useState("");
  const [buyer, setBuyer] = useState("");
  const [seller, setSeller] = useState("");
  const [deposited, setDeposited] = useState(false);
  const [released, setReleased] = useState(false);

  useEffect(() => {
    async function load() {
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const [acct] = await window.ethereum.request({ method: "eth_accounts" });
      setAccount(acct);
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const escrow = new ethers.Contract(ADDR, ABI, provider);
      const [b, s, dep, rel] = await Promise.all([
        escrow.buyer(),
        escrow.seller(),
        escrow.deposited(),
        escrow.released(),
      ]);
      setBuyer(b);
      setSeller(s);
      setDeposited(dep);
      setReleased(rel);
    }
    load();
  }, []);

  async function doRelease() {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const escrow = new ethers.Contract(ADDR, ABI, signer);
    const tx = await escrow.release();
    await tx.wait();
    onAction();
  }

  async function doRefund() {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const escrow = new ethers.Contract(ADDR, ABI, signer);
    const tx = await escrow.refund();
    await tx.wait();
    onAction();
  }

  if (!deposited || released) return null;
  return (
    <div>
      {account.toLowerCase() === buyer.toLowerCase() && (
        <button onClick={doRelease}>Release Funds</button>
      )}
      {account.toLowerCase() === seller.toLowerCase() && (
        <button onClick={doRefund}>Refund Buyer</button>
      )}
    </div>
  );
}
```
