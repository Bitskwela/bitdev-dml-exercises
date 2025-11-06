# Activity 3: Add New Chain to MetaMask ⏱️ 10 mins

Build `AddChainButton` that proposes adding a new chain (e.g., Avalanche Fuji) when MetaMask doesn't recognize it. Use `wallet_addEthereumChain` with full parameters.

## 📋 Contract Baseline

Uses MetaMask's `wallet_addEthereumChain` RPC method to propose adding a new network to the user's wallet.

## 🚀 Starter Code

**`AddChainButton.js`**

```js
import React, { useState } from "react";

export default function AddChainButton({ chainParams }) {
  const [message, setMessage] = useState("");

  async function addChain() {
    try {
      // TODO: await window.ethereum.request({
      //   method: "wallet_addEthereumChain",
      //   params: [chainParams]
      // });
      // setMessage("✅ Chain added!");
    } catch (err) {
      setMessage(err.message);
    }
  }

  return (
    <div>
      <button onClick={addChain}>Add {chainParams.chainName}</button>
      {message && <p>{message}</p>}
    </div>
  );
}
```

**Example Chain Params**

```js
const avalancheFuji = {
  chainId: "0xa869", // 43113
  chainName: "Avalanche Fuji C-Chain",
  nativeCurrency: { name: "AVAX", symbol: "AVAX", decimals: 18 },
  rpcUrls: ["https://api.avax-test.network/rpc"],
  blockExplorerUrls: ["https://testnet.snowtrace.io/"],
};
```

## ✅ To Do List

- [ ] Use `wallet_addEthereumChain` with given `chainParams`.
- [ ] Handle and display success or error messages.

## 🎯 Full Solution

```js
// AddChainButton.js
import React, { useState } from "react";

export default function AddChainButton({ chainParams }) {
  const [message, setMessage] = useState("");

  async function addChain() {
    setMessage("");
    if (!window.ethereum) {
      setMessage("MetaMask not detected");
      return;
    }
    try {
      await window.ethereum.request({
        method: "wallet_addEthereumChain",
        params: [chainParams],
      });
      setMessage(`✅ ${chainParams.chainName} added!`);
    } catch (err) {
      if (err.code === 4001) {
        setMessage("User rejected the request.");
      } else {
        setMessage(err.message);
      }
    }
  }

  return (
    <div>
      <button onClick={addChain}>Add {chainParams.chainName}</button>
      {message && <p>{message}</p>}
    </div>
  );
}
```

## 📄 Example Usage

```js
import AddChainButton from "./AddChainButton";

const avalancheFuji = {
  chainId: "0xa869", // 43113 in hex
  chainName: "Avalanche Fuji C-Chain",
  nativeCurrency: {
    name: "AVAX",
    symbol: "AVAX",
    decimals: 18,
  },
  rpcUrls: ["https://api.avax-test.network/ext/bc/C/rpc"],
  blockExplorerUrls: ["https://testnet.snowtrace.io/"],
};

function App() {
  return (
    <div>
      <h2>Network Management</h2>
      <AddChainButton chainParams={avalancheFuji} />
    </div>
  );
}
```
