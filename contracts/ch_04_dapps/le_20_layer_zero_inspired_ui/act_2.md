# Activity 2: ReleaseFlow Component ⏱️ 10 mins

Create `ReleaseFlow` that accepts `lockId` & `amount`, shows a confirm modal for release on **NYChain**, and calls `releaseTokens(lockId)`.

## 📋 Contract Baseline

Using the same `BridgeSimulator.sol` contract with:

- `function releaseTokens(uint256 id) external`
- `event Released(address indexed user, uint256 amount, uint256 id)`

## 🚀 Starter Code

**`ReleaseFlow.js`**

```js
import React, { useState } from "react";
import { ethers } from "ethers";
const ABI = [
  "function releaseTokens(uint256)",
  "event Released(address indexed user, uint256 amount, uint256 id)",
];

export default function ReleaseFlow({ lockId, amount, onDone }) {
  const [step, setStep] = useState("Idle"); // Idle|Confirm|Releasing
  const [error, setError] = useState("");

  async function doRelease() {
    try {
      setError("");
      setStep("Releasing");
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const bridge = new ethers.Contract(
        process.env.REACT_APP_BRIDGE_ADDR,
        ABI,
        signer
      );
      const tx = await bridge.releaseTokens(lockId);
      await tx.wait();
      onDone();
    } catch (err) {
      setError(err.message);
      setStep("Idle");
    }
  }

  return (
    <div>
      {step === "Idle" && (
        <button onClick={() => setStep("Confirm")}>
          Release {amount} ETH on NYChain
        </button>
      )}
      {step === "Confirm" && (
        <div className="modal">
          <p>Release {amount} ETH on NYChain?</p>
          <button onClick={doRelease}>Yes, release</button>
          <button onClick={() => setStep("Idle")}>Cancel</button>
        </div>
      )}
      {step === "Releasing" && <p>⏳ Releasing on chain…</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

## ✅ To Do List

- [ ] Show **Release** button when `step==="Idle"`.
- [ ] Confirm modal and `doRelease()` on confirm.
- [ ] Call `releaseTokens(lockId)` and await receipt.
- [ ] Invoke `onDone()` on success.
- [ ] Handle loading and errors.

## 🎯 Full Solution

The starter code above already represents the complete solution - the component is fully functional with proper modal confirmation, contract interaction, transaction handling, and error management.
