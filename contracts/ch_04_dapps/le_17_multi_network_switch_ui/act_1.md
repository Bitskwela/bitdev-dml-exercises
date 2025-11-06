# Activity 1: Detect & Display Current Network ⏱️ 10 mins

Build `NetworkStats` that connects to MetaMask (or JSON-RPC), calls a small on-chain contract to read `block.chainid`, and displays both the raw ID and a friendly name (e.g., "Sepolia", "Polygon"). Subscribe to `chainChanged` so it updates live.

## 📋 Contract Baseline

**Solidity Contract (`NetworkDetector.sol`)**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NetworkDetector {
    function getChainId() external view returns (uint256) {
        return block.chainid;
    }
}
```

## 🚀 Starter Code

**`NetworkStats.js`**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = ["function getChainId() view returns (uint256)"];

export default function NetworkStats() {
  const [chainId, setChainId] = useState(null);
  const [chainName, setChainName] = useState("");
  const [error, setError] = useState("");

  useEffect(() => {
    let provider, contract;

    async function loadChain() {
      try {
        // TODO: detect if window.ethereum exists
        // TODO: init provider = new ethers.providers.Web3Provider(window.ethereum) or JsonRpcProvider
        // TODO: contract = new ethers.Contract(address, ABI, provider)
        // TODO: idBN = await contract.getChainId()
        // TODO: id = idBN.toNumber(); setChainId(id)
        // TODO: map id to chainName (e.g., 11155111 → "Sepolia")
      } catch (err) {
        setError(err.message);
      }
    }

    loadChain();

    // TODO: subscribe to window.ethereum.on("chainChanged", ...) to reload

    return () => {
      // TODO: remove listener
    };
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (chainId === null) return <p>Detecting network…</p>;

  return (
    <div>
      <h3>Current Network</h3>
      <p>Chain ID: {chainId}</p>
      <p>Chain Name: {chainName}</p>
    </div>
  );
}
```

## ✅ To Do List

- [ ] Request accounts or fallback to JSON-RPC.
- [ ] Instantiate provider & `NetworkDetector` contract (address in `.env`).
- [ ] Call `getChainId()`, parse number.
- [ ] Map common IDs to names (`{1: "Mainnet", 5:"Goerli", 11155111:"Sepolia", 137:"Polygon"}`).
- [ ] Subscribe to `chainChanged` and re-run logic.
- [ ] Clean up listener on unmount.

## 🎯 Full Solution

```js
// NetworkStats.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = ["function getChainId() view returns (uint256)"];
const RPC = process.env.REACT_APP_RPC_URL;
const CONTRACT = process.env.REACT_APP_NETWORK_DETECTOR;

const NAMES = {
  1: "Ethereum Mainnet",
  5: "Goerli",
  11155111: "Sepolia",
  137: "Polygon",
  80001: "Mumbai",
};

export default function NetworkStats() {
  const [chainId, setChainId] = useState(null);
  const [chainName, setChainName] = useState("");
  const [error, setError] = useState("");

  useEffect(() => {
    let provider, contract;

    async function loadChain() {
      try {
        if (window.ethereum) {
          provider = new ethers.providers.Web3Provider(window.ethereum);
          await window.ethereum.request({ method: "eth_requestAccounts" });
        } else {
          provider = new ethers.providers.JsonRpcProvider(RPC);
        }
        contract = new ethers.Contract(CONTRACT, ABI, provider);
        const idBN = await contract.getChainId();
        const id = idBN.toNumber();
        setChainId(id);
        setChainName(NAMES[id] || "Unknown");
      } catch (err) {
        setError(err.message);
      }
    }

    loadChain();

    function handleChange(chainHex) {
      // chainHex e.g. "0xaa36a7"
      const id = parseInt(chainHex, 16);
      setChainId(id);
      setChainName(NAMES[id] || "Unknown");
    }

    if (window.ethereum) {
      window.ethereum.on("chainChanged", handleChange);
    }

    return () => {
      if (window.ethereum) {
        window.ethereum.removeListener("chainChanged", handleChange);
      }
    };
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (chainId === null) return <p>Detecting network…</p>;

  return (
    <div>
      <h3>Current Network</h3>
      <p>
        Chain ID: <strong>{chainId}</strong>
      </p>
      <p>
        Chain Name: <strong>{chainName}</strong>
      </p>
    </div>
  );
}
```

## 📄 .env Sample

```
REACT_APP_RPC_URL=https://sepolia.infura.io/v3/YOUR_KEY
REACT_APP_NETWORK_DETECTOR=0xYourNetworkDetectorAddress
```
