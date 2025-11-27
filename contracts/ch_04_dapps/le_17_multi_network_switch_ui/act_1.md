# Detect & Display Current Network Activity

## Initial Code

```js
// .env Configuration
// REACT_APP_RPC_URL=https://sepolia.infura.io/v3/YOUR_KEY
// REACT_APP_NETWORK_DETECTOR=0xYourNetworkDetectorAddress

// NetworkStats.js - Starter Code
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
        // TODO: Detect MetaMask and create appropriate provider
        // TODO: Create contract instance and fetch chain ID
        // TODO: Map chain ID to friendly name and update state
      } catch (err) {
        setError(err.message);
      }
    }

    // TODO: Define handleChange function for chainChanged event

    loadChain();

    // TODO: Subscribe to chainChanged event if MetaMask is available

    return () => {
      // TODO: Cleanup listener on unmount
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

**Time Allotment: 10 minutes**

## Tasks for Learners

Topics Covered: `Web3Provider`, `JsonRpcProvider`, `window.ethereum`, `chainChanged` event, Chain ID mapping, Event cleanup

---

### Task 1: Create Provider Based on Wallet Availability

Detect if `window.ethereum` exists (MetaMask installed). If yes, create a `Web3Provider` and request account access. Otherwise, fall back to `JsonRpcProvider` using the RPC URL from environment variables for read-only access.

```js
if (window.ethereum) {
  provider = new ethers.providers.Web3Provider(window.ethereum);
  await window.ethereum.request({ method: "eth_requestAccounts" });
} else {
  provider = new ethers.providers.JsonRpcProvider(RPC);
}
```

---

### Task 2: Fetch Chain ID and Map to Friendly Name

Create a contract instance using the ABI, contract address, and provider. Call `getChainId()` to get the current chain ID as a BigNumber, convert it to a regular number, and map it to a human-readable name using the `NAMES` lookup object.

```js
contract = new ethers.Contract(CONTRACT, ABI, provider);
const idBN = await contract.getChainId();
const id = idBN.toNumber();
setChainId(id);
setChainName(NAMES[id] || "Unknown");
```

---

### Task 3: Subscribe to Chain Changed Event and Cleanup

Define a handler function that parses the hex chain ID from MetaMask's `chainChanged` event. Subscribe to this event when MetaMask is available, and clean up the listener when the component unmounts to prevent memory leaks.

```js
function handleChange(chainHex) {
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
```

---

## Breakdown of the Activity

**Variables Defined:**

- `RPC`: The RPC URL from environment variables (`process.env.REACT_APP_RPC_URL`). Used as fallback when MetaMask is not installed.

- `CONTRACT`: The deployed NetworkDetector contract address from environment variables. Used to instantiate the contract object.

- `NAMES`: An object mapping numeric chain IDs to human-readable network names. Allows displaying "Sepolia" instead of "11155111".

- `chainId`: State variable storing the current network's chain ID as a number. Updated both on initial load and when the user switches networks.

- `chainName`: State variable storing the friendly network name. Falls back to "Unknown" for unrecognized chain IDs.

- `provider`: Either a `Web3Provider` (MetaMask) or `JsonRpcProvider` (direct RPC) depending on wallet availability.

**Key Functions:**

- `loadChain()`:
  The async initialization function that runs on component mount. First detects MetaMask availability to create the appropriate provider. Then creates a contract instance and calls `getChainId()` to fetch the current network. Converts the BigNumber result to a number and maps it to a friendly name.

- `handleChange(chainHex)`:
  Event handler for MetaMask's `chainChanged` event. Receives the new chain ID as a hex string (e.g., "0x1" for Ethereum Mainnet). Parses it to a decimal number using `parseInt(chainHex, 16)` and updates both state variables.

- `window.ethereum.on("chainChanged", handler)`:
  Subscribes to network change events from MetaMask. Essential for live updates when users switch networks in their wallet without refreshing the page.

- `window.ethereum.removeListener("chainChanged", handler)`:
  Cleanup function called on component unmount. Prevents memory leaks and ensures the handler doesn't run after the component is destroyed.
