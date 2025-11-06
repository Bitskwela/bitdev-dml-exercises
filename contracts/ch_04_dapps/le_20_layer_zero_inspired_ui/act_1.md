# Activity 1: LockForm Component ⏱️ 10 mins

Build `LockForm` that: 1) Lets user enter an ETH amount, 2) On **Bridge** click, shows a confirm modal, 3) Calls `lockTokens()` on `BridgeSimulator` when confirmed, 4) Emits `onLocked(id, amount)` callback.

## 📋 Contract Baseline

**Solidity Contract (`BridgeSimulator.sol`)**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract BridgeSimulator {
  struct Lock { address user; uint256 amount; bool released; }
  mapping(uint256 => Lock) public locks;
  uint256 public nextId;
  event Locked(address indexed user, uint256 amount, uint256 id);
  event Released(address indexed user, uint256 amount, uint256 id);

  function lockTokens() external payable returns (uint256 id) {
    require(msg.value > 0, "Zero amount");
    id = ++nextId;
    locks[id] = Lock(msg.sender, msg.value, false);
    emit Locked(msg.sender, msg.value, id);
  }

  function releaseTokens(uint256 id) external {
    Lock storage l = locks[id];
    require(l.user == msg.sender, "Not owner");
    require(!l.released, "Already released");
    l.released = true;
    payable(l.user).transfer(l.amount);
    emit Released(msg.sender, l.amount, id);
  }

  function getLock(uint256 id)
    external view returns (address user, uint256 amount, bool released)
  {
    Lock memory l = locks[id];
    return (l.user, l.amount, l.released);
  }
}
```

## 🚀 Starter Code

**`LockForm.js`**

```js
import React, { useState } from "react";
import { ethers } from "ethers";
const ABI = [
  "function lockTokens() payable returns (uint256)",
  "event Locked(address indexed user, uint256 amount, uint256 id)",
];

export default function LockForm({ onLocked }) {
  const [amt, setAmt] = useState("");
  const [step, setStep] = useState("Idle"); // Idle|Confirm|Locking
  const [error, setError] = useState("");

  async function doLock() {
    try {
      setError("");
      setStep("Locking");
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const bridge = new ethers.Contract(
        process.env.REACT_APP_BRIDGE_ADDR,
        ABI,
        signer
      );
      const tx = await bridge.lockTokens({
        value: ethers.utils.parseEther(amt),
      });
      const receipt = await tx.wait();
      const evt = receipt.events.find((e) => e.event === "Locked");
      const id = evt.args.id.toNumber();
      onLocked(id, amt);
      setStep("Idle");
    } catch (err) {
      setError(err.message);
      setStep("Idle");
    }
  }

  return (
    <div>
      <h4>Amount to Bridge</h4>
      <input
        placeholder="ETH"
        value={amt}
        onChange={(e) => setAmt(e.target.value)}
        disabled={step !== "Idle"}
      />
      <button
        onClick={() => setStep("Confirm")}
        disabled={!amt || isNaN(amt) || Number(amt) <= 0 || step !== "Idle"}
      >
        Bridge
      </button>
      {step === "Confirm" && (
        <div className="modal">
          <p>Lock {amt} ETH on PHChain?</p>
          <button onClick={doLock}>Yes, lock</button>
          <button onClick={() => setStep("Idle")}>Cancel</button>
        </div>
      )}
      {step === "Locking" && <p>⏳ Locking on chain…</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

## ✅ To Do List

- [ ] Validate input (`>0`, numeric).
- [ ] Modal for confirm step (`step==="Confirm"`).
- [ ] Call `lockTokens` with `{ value: parseEther(amt) }`.
- [ ] Extract `id` from `Locked` event and call `onLocked(id, amt)`.
- [ ] Handle loading and errors.

## 🎯 Full Solution

The starter code above already represents the complete solution - the component is fully functional with proper validation, modal confirmation, contract interaction, event handling, and error management.
