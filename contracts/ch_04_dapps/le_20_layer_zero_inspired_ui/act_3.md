# Activity 3: BridgeApp Integration ⏱️ 10 mins

Build `BridgeApp` that: 1) Renders `LockForm`, 2) After lock, auto-asks user to switch to NYChain (simulate via chain ID check), 3) Renders `ReleaseFlow`, 4) Shows final success message.

## 📋 Contract Baseline

Using the same `BridgeSimulator.sol` contract with integrated cross-chain flow simulation.

## 🚀 Starter Code

**`BridgeApp.js`**

```js
import React, { useState, useEffect } from "react";
import LockForm from "./LockForm";
import ReleaseFlow from "./ReleaseFlow";

export default function BridgeApp() {
  const [lockId, setLockId] = useState(null);
  const [amount, setAmount] = useState("");
  const [step, setStep] = useState("Lock"); // Lock|Switch|Release|Done
  const [currentChain, setCid] = useState(null);

  // detect chain
  useEffect(() => {
    async function detect() {
      const hex = await window.ethereum.request({ method: "eth_chainId" });
      setCid(parseInt(hex, 16));
    }
    detect();
    window.ethereum.on("chainChanged", detect);
    return () => window.ethereum.removeListener("chainChanged", detect);
  }, []);

  function handleLocked(id, amt) {
    setLockId(id);
    setAmount(amt);
    setStep("Switch");
  }

  function handleReleased() {
    setStep("Done");
  }

  async function doSwitch() {
    // TODO: call wallet_switchEthereumChain to targetChainId (e.g. 0x4 for Rinkeby)
  }

  return (
    <div>
      {step === "Lock" && <LockForm onLocked={handleLocked} />}
      {step === "Switch" && (
        <div>
          <p>
            Please switch from chain {currentChain} to chain{" "}
            {process.env.REACT_APP_TARGET_CHAIN_ID}
          </p>
          <button onClick={doSwitch}>Switch Chain</button>
        </div>
      )}
      {step === "Release" && (
        <ReleaseFlow lockId={lockId} amount={amount} onDone={handleReleased} />
      )}
      {step === "Done" && (
        <p>
          ✅ Bridged {amount} ETH! Your lock ID: {lockId}
        </p>
      )}
    </div>
  );
}
```

## ✅ To Do List

- [ ] On lock, move `step` to "Switch".
- [ ] In **Switch** UI, call `wallet_switchEthereumChain` with `REACT_APP_TARGET_CHAIN_ID`.
- [ ] On success, set `step="Release"`.
- [ ] Wire `ReleaseFlow` and final success.

## 🎯 Full Solution

```js
// BridgeApp.js
import React, { useState, useEffect } from "react";
import LockForm from "./LockForm";
import ReleaseFlow from "./ReleaseFlow";
import { ethers } from "ethers";

export default function BridgeApp() {
  const [lockId, setLockId] = useState(null);
  const [amount, setAmount] = useState("");
  const [step, setStep] = useState("Lock"); // Lock|Switch|Release|Done
  const [currentChain, setCid] = useState(null);

  const targetHex = ethers.utils.hexValue(
    Number(process.env.REACT_APP_TARGET_CHAIN_ID)
  );

  useEffect(() => {
    async function detect() {
      const hex = await window.ethereum.request({ method: "eth_chainId" });
      setCid(parseInt(hex, 16));
    }
    detect();
    window.ethereum.on("chainChanged", detect);
    return () => window.ethereum.removeListener("chainChanged", detect);
  }, []);

  function handleLocked(id, amt) {
    setLockId(id);
    setAmount(amt);
    setStep("Switch");
  }

  async function doSwitch() {
    try {
      await window.ethereum.request({
        method: "wallet_switchEthereumChain",
        params: [{ chainId: targetHex }],
      });
      setStep("Release");
    } catch (err) {
      console.error(err);
      // handle 4902, 4001 if needed
    }
  }

  function handleReleased() {
    setStep("Done");
  }

  return (
    <div style={{ padding: 24, fontFamily: "sans-serif" }}>
      <h2>🌉 Bridge Simulator</h2>
      {step === "Lock" && <LockForm onLocked={handleLocked} />}
      {step === "Switch" && (
        <div>
          <p>
            🔄 Current Chain: {currentChain}. Please switch to{" "}
            {process.env.REACT_APP_TARGET_CHAIN_ID}.
          </p>
          <button onClick={doSwitch}>Switch Chain</button>
        </div>
      )}
      {step === "Release" && (
        <ReleaseFlow lockId={lockId} amount={amount} onDone={handleReleased} />
      )}
      {step === "Done" && (
        <p>
          ✅ Bridged {amount} ETH! Your lock ID: {lockId}
        </p>
      )}
    </div>
  );
}
```

## 📄 .env Sample

```
REACT_APP_RPC_URL=http://127.0.0.1:8545
REACT_APP_BRIDGE_ADDR=0xYourBridgeSimulatorAddress
REACT_APP_TARGET_CHAIN_ID=1337
```
