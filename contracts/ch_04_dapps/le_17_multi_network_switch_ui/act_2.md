# Activity 2: Prompt & Switch Network ⏱️ 10 mins

Create `NetworkSwitcher` that, given a `targetChainId` prop, checks the current chain and, if it doesn't match, prompts MetaMask to switch to it. Handle user rejection gracefully.

## 📋 Contract Baseline

Using the same `NetworkDetector.sol` from Activity 1 and MetaMask's `wallet_switchEthereumChain` RPC method.

## 🚀 Starter Code

**`NetworkSwitcher.js`**

```js
import React, { useState, useEffect } from "react";

export default function NetworkSwitcher({ targetChainId }) {
  const [currentChain, setCurrentChain] = useState(null);
  const [status, setStatus] = useState("");

  useEffect(() => {
    // TODO: get current chain via window.ethereum.request or ethers
    // TODO: setCurrentChain(parsed)
  }, []);

  async function switchNetwork() {
    try {
      // TODO: const hexId = ethers.utils.hexValue(targetChainId)
      // TODO: await window.ethereum.request({ method: "wallet_switchEthereumChain", params: [{ chainId: hexId }] })
      // TODO: setStatus("✅ Switched")
    } catch (err) {
      // TODO: if error.code === 4902 then show "chain not added"
      // TODO: else handle user rejection
      setStatus(err.message);
    }
  }

  return (
    <div>
      <p>Current Chain: {currentChain}</p>
      {currentChain !== targetChainId && (
        <button onClick={switchNetwork}>Switch to {targetChainId}</button>
      )}
      {status && <p>{status}</p>}
    </div>
  );
}
```

## ✅ To Do List

- [ ] Read current chain on mount.
- [ ] Compare to `targetChainId`.
- [ ] On click, call `wallet_switchEthereumChain` with hex `chainId`.
- [ ] Handle error codes:  
       • `4902` → need to add chain first.  
       • `4001` → user rejected.
- [ ] Display status messages.

## 🎯 Full Solution

```js
// NetworkSwitcher.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

export default function NetworkSwitcher({ targetChainId }) {
  const [currentChain, setCurrentChain] = useState(null);
  const [status, setStatus] = useState("");

  useEffect(() => {
    async function fetchChain() {
      if (window.ethereum) {
        const hex = await window.ethereum.request({ method: "eth_chainId" });
        setCurrentChain(parseInt(hex, 16));
      }
    }
    fetchChain();
  }, []);

  async function switchNetwork() {
    setStatus("");
    const hexId = ethers.utils.hexValue(targetChainId);
    try {
      await window.ethereum.request({
        method: "wallet_switchEthereumChain",
        params: [{ chainId: hexId }],
      });
      setStatus("✅ Switched!");
      setCurrentChain(targetChainId);
    } catch (err) {
      if (err.code === 4902) {
        setStatus("Network not found in MetaMask – please add it first.");
      } else if (err.code === 4001) {
        setStatus("User rejected the request.");
      } else {
        setStatus(err.message);
      }
    }
  }

  return (
    <div>
      <p>
        Current Chain ID: <strong>{currentChain}</strong>
      </p>
      {currentChain !== targetChainId && (
        <button onClick={switchNetwork}>Switch to {targetChainId}</button>
      )}
      {status && <p>{status}</p>}
    </div>
  );
}
```
