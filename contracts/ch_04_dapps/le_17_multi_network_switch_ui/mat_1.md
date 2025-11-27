## 🧑‍💻 Background Story

![Multi-Network Switch UI](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+17.0+-+COVER.png)

Under the bright lights of DevCon Cebu, Neri and Odessa demoed their multi-network React UI to a packed room. Local devs clapped as the screen showed "Chain: Sepolia" then switched live to "Chain: Polygon" with a single click. A week later—jet-lagged but exhilarated—in Los Angeles's hackathon they faced judges who flipped their MetaMask to Goerli by mistake and got stuck. Odessa grinned: "No worries, our app will detect your chain and prompt you to switch!"

Back in Cebu, they'd sketched out a tiny contract, `NetworkDetector.sol`, that simply returns `block.chainid`. In React they used Ethers.js and `window.ethereum.request` calls to read the chain ID, map it to human-readable names, and, if it didn't match the expected network, fire off `wallet_switchEthereumChain` (or `wallet_addEthereumChain` for new testnets).

Now at LA hackathon, when judges tried to deploy their smart-wallet on a wrong chain, Odessa's UI popped up a modal: "Please switch to Sepolia (ID 11155111)." In 30 seconds flat, the judges approved the switch in MetaMask—and the build pipeline continued seamlessly. Filipino ingenuity had turned a common UX friction into a feature. By the end of the week, teams were forking their code—and Neri and Odessa were already plotting the next trick: cross-chain network detection with automatic RPC fallback. Mabuhay multi-network UX! 🇵🇭🔄🚀

---

## 📚 Theory & Web3 Lecture

### 🎯 What You'll Learn

In this lesson, you'll build a **multi-network switch UI** that detects the current chain, displays network information, and allows users to switch between networks seamlessly. This is essential for any production DApp supporting multiple chains.

---

### 📐 Network Switching Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                  MULTI-NETWORK FLOW                             │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │                     MetaMask                             │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │ Current Network: Ethereum Mainnet (Chain ID: 1)  │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   └────────────────────────────┬────────────────────────────┘   │
│                                │                                │
│               eth_chainId → "0x1"                               │
│                                │                                │
│   ┌────────────────────────────▼────────────────────────────┐   │
│   │                    React App                             │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │ Detected Chain ID: 1                             │    │   │
│   │  │ Network Name: Ethereum Mainnet                   │    │   │
│   │  │                                                  │    │   │
│   │  │ ⚠️ Expected: Sepolia (11155111)                  │    │   │
│   │  │ [Switch to Sepolia]                              │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   └────────────────────────────┬────────────────────────────┘   │
│                                │                                │
│            wallet_switchEthereumChain                           │
│                                │                                │
│   ┌────────────────────────────▼────────────────────────────┐   │
│   │                     MetaMask                             │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │ [Switch Network Request]                         │    │   │
│   │  │ This site wants you to switch to Sepolia         │    │   │
│   │  │ [Approve] [Reject]                               │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   └──────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

### 🔑 Key Concepts

#### 1. Chain IDs Reference

| Network           | Chain ID (Decimal) | Chain ID (Hex) | Type    |
| ----------------- | ------------------ | -------------- | ------- |
| Ethereum Mainnet  | 1                  | 0x1            | Mainnet |
| Sepolia           | 11155111           | 0xaa36a7       | Testnet |
| Polygon           | 137                | 0x89           | Mainnet |
| Mumbai            | 80001              | 0x13881        | Testnet |
| Arbitrum One      | 42161              | 0xa4b1         | L2      |
| Optimism          | 10                 | 0xa            | L2      |
| BSC               | 56                 | 0x38           | Mainnet |
| Avalanche C-Chain | 43114              | 0xa86a         | Mainnet |

#### 2. Reading Chain ID with Solidity

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NetworkDetector {
    // Returns current chain ID
    function getChainId() external view returns (uint256) {
        return block.chainid;
    }
}
```

#### 3. Reading Chain ID with Ethers.js

```javascript
// Method 1: Using provider.send()
const chainIdHex = await provider.send("eth_chainId", []);
const chainId = parseInt(chainIdHex, 16);

// Method 2: Using getNetwork()
const network = await provider.getNetwork();
console.log(network.chainId); // 1 for mainnet

// Method 3: Direct window.ethereum request
const chainIdHex = await window.ethereum.request({
  method: "eth_chainId",
});
```

#### 4. Network Switching (EIP-3326)

```javascript
// Switch to an existing network in MetaMask
async function switchNetwork(chainId) {
  const chainIdHex = "0x" + chainId.toString(16);

  try {
    await window.ethereum.request({
      method: "wallet_switchEthereumChain",
      params: [{ chainId: chainIdHex }],
    });
    console.log("Switched successfully!");
  } catch (error) {
    if (error.code === 4902) {
      // Network not found - need to add it first
      console.log("Network not in wallet");
    } else if (error.code === 4001) {
      // User rejected the request
      console.log("User rejected network switch");
    } else {
      throw error;
    }
  }
}
```

#### 5. Adding a New Network (EIP-3085)

```javascript
// Add a network that doesn't exist in MetaMask
async function addNetwork(chainParams) {
  try {
    await window.ethereum.request({
      method: "wallet_addEthereumChain",
      params: [chainParams],
    });
    console.log("Network added successfully!");
  } catch (error) {
    if (error.code === 4001) {
      console.log("User rejected adding network");
    }
  }
}

// Example: Add Polygon network
const polygonParams = {
  chainId: "0x89",
  chainName: "Polygon Mainnet",
  nativeCurrency: {
    name: "MATIC",
    symbol: "MATIC",
    decimals: 18,
  },
  rpcUrls: ["https://polygon-rpc.com"],
  blockExplorerUrls: ["https://polygonscan.com/"],
};

await addNetwork(polygonParams);
```

---

### 🏗️ React Component Pattern

```
┌─────────────────────────────────────────────────────────────────┐
│                    NETWORK UI COMPONENTS                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │                    NetworkApp                            │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │ State: chainId, chainName, error, loading       │    │   │
│   │  │ Effect: Listen for chainChanged event           │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   └───────────────────────┬─────────────────────────────────┘   │
│                           │                                     │
│       ┌───────────────────┼───────────────────┐                 │
│       ▼                   ▼                   ▼                 │
│   ┌─────────┐      ┌─────────────┐     ┌─────────────┐         │
│   │ Network │      │  Network    │     │   Add       │         │
│   │  Stats  │      │  Switcher   │     │  Network    │         │
│   │         │      │             │     │             │         │
│   │ 🔗 ID:1 │      │ [Sepolia]   │     │ [+ Polygon] │         │
│   │ Mainnet │      │ [Polygon]   │     │ [+ Avax]    │         │
│   │         │      │ [Mumbai]    │     │             │         │
│   └─────────┘      └─────────────┘     └─────────────┘         │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

#### Complete Implementation

```javascript
import { useState, useEffect } from "react";
import { ethers } from "ethers";

// Network configuration
const NETWORKS = {
  1: { name: "Ethereum Mainnet", symbol: "ETH" },
  11155111: { name: "Sepolia", symbol: "ETH" },
  137: { name: "Polygon", symbol: "MATIC" },
  80001: { name: "Mumbai", symbol: "MATIC" },
};

function NetworkApp() {
  const [chainId, setChainId] = useState(null);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(false);

  // Get current chain on mount
  useEffect(() => {
    const detectChain = async () => {
      if (!window.ethereum) {
        setError("MetaMask not detected");
        return;
      }

      try {
        const chainIdHex = await window.ethereum.request({
          method: "eth_chainId",
        });
        setChainId(parseInt(chainIdHex, 16));
      } catch (err) {
        setError("Failed to detect network");
      }
    };

    detectChain();

    // Listen for chain changes
    const handleChainChanged = (chainIdHex) => {
      const newChainId = parseInt(chainIdHex, 16);
      setChainId(newChainId);
      // Recommended: reload the page on chain change
      // window.location.reload();
    };

    window.ethereum?.on("chainChanged", handleChainChanged);

    return () => {
      window.ethereum?.removeListener("chainChanged", handleChainChanged);
    };
  }, []);

  const switchToNetwork = async (targetChainId) => {
    setLoading(true);
    setError(null);

    try {
      await window.ethereum.request({
        method: "wallet_switchEthereumChain",
        params: [{ chainId: "0x" + targetChainId.toString(16) }],
      });
    } catch (err) {
      if (err.code === 4902) {
        setError("Network not available in wallet");
      } else if (err.code === 4001) {
        setError("User rejected the switch request");
      } else {
        setError("Failed to switch network");
      }
    } finally {
      setLoading(false);
    }
  };

  const networkInfo = NETWORKS[chainId] || { name: "Unknown", symbol: "?" };

  return (
    <div>
      <h2>Current Network</h2>
      <p>Chain ID: {chainId}</p>
      <p>Name: {networkInfo.name}</p>
      <p>Currency: {networkInfo.symbol}</p>

      <h3>Switch Network</h3>
      {Object.entries(NETWORKS).map(([id, info]) => (
        <button
          key={id}
          onClick={() => switchToNetwork(parseInt(id))}
          disabled={loading || chainId === parseInt(id)}
        >
          {chainId === parseInt(id) ? "✓ " : ""}
          {info.name}
        </button>
      ))}

      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

---

### 📊 Error Codes Reference

| Code   | Meaning                 | User Action                    |
| ------ | ----------------------- | ------------------------------ |
| 4001   | User rejected request   | Show "Cancelled" message       |
| 4902   | Chain not in wallet     | Call `wallet_addEthereumChain` |
| -32002 | Request already pending | Wait for user to respond       |
| -32603 | Internal error          | Retry or show error            |

---

### ⚠️ Common Mistakes

| Mistake                   | Problem                    | Solution                           |
| ------------------------- | -------------------------- | ---------------------------------- |
| Not handling 4902         | Crash when network missing | Add network then switch            |
| Forgetting hex conversion | Invalid chain ID format    | Use `"0x" + id.toString(16)`       |
| No event cleanup          | Memory leaks               | Remove listener on unmount         |
| Ignoring user rejection   | Silent failure             | Check `error.code === 4001`        |
| Not checking MetaMask     | Crash without wallet       | Guard with `if (!window.ethereum)` |

---

### ✅ Testing Checklist

Before considering this lesson complete, verify:

- [ ] Current chain ID displays correctly
- [ ] Network name maps from chain ID
- [ ] Switch buttons trigger MetaMask prompt
- [ ] User rejection shows friendly message
- [ ] Unknown networks prompt "Add Network"
- [ ] chainChanged event updates UI
- [ ] Loading state prevents double-clicks
- [ ] Works without MetaMask (graceful error)
- [ ] Event listeners clean up on unmount

---

### 🔗 External Resources

| Resource                 | Link                                                        |
| ------------------------ | ----------------------------------------------------------- |
| EIP-3085 (Add Chain)     | https://eips.ethereum.org/EIPS/eip-3085                     |
| EIP-3326 (Switch Chain)  | https://eips.ethereum.org/EIPS/eip-3326                     |
| Chainlist (All Networks) | https://chainlist.org/                                      |
| MetaMask RPC Methods     | https://docs.metamask.io/wallet/reference/json-rpc-methods/ |

---

## ✅ Test Cases

Create `__tests__/NetworkSwitch.test.js`:

```js
// __tests__/NetworkSwitch.test.js
import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import NetworkStats from "../NetworkStats";
import NetworkSwitcher from "../NetworkSwitcher";
import AddChainButton from "../AddChainButton";
import { ethers } from "ethers";

jest.mock("ethers");

describe("Multi-Network Components", () => {
  const fakeProvider = {};
  const fakeContract = { getChainId: jest.fn() };

  beforeAll(() => {
    // Mock window.ethereum
    global.window.ethereum = {
      request: jest.fn(),
    };
    ethers.providers.Web3Provider = jest.fn().mockReturnValue(fakeProvider);
    ethers.Contract = jest.fn().mockReturnValue(fakeContract);
  });

  it("loads and displays current network", async () => {
    fakeContract.getChainId.mockResolvedValue({ toNumber: () => 11155111 });
    window.ethereum.request.mockResolvedValue("0xaa36a7"); // Sepolia hex
    render(<NetworkStats />);
    expect(await screen.findByText("Chain ID:")).toHaveTextContent("11155111");
    expect(screen.getByText("Chain Name:")).toHaveTextContent("Sepolia");
  });

  it("prompts switch and handles success", async () => {
    window.ethereum.request
      .mockResolvedValueOnce("0x1") // eth_chainId initial
      .mockResolvedValueOnce(); // wallet_switch
    render(<NetworkSwitcher targetChainId={5} />);
    expect(await screen.findByText(/Current Chain ID:/)).toHaveTextContent("1");
    fireEvent.click(screen.getByText("Switch to 5"));
    await waitFor(() => screen.getByText("✅ Switched!"));
  });

  it("handles user rejection on switch", async () => {
    window.ethereum.request
      .mockResolvedValueOnce("0x1") // initial
      .mockRejectedValueOnce({ code: 4001 }); // user rejected
    render(<NetworkSwitcher targetChainId={5} />);
    await screen.findByText("Switch to 5");
    fireEvent.click(screen.getByText("Switch to 5"));
    await waitFor(() => screen.getByText("User rejected the request."));
  });

  it("adds a new chain successfully", async () => {
    const params = {
      chainId: "0xa869",
      chainName: "Avalanche Fuji",
      nativeCurrency: { name: "AVAX", symbol: "AVAX", decimals: 18 },
      rpcUrls: ["https://api.avax-test.network/rpc"],
      blockExplorerUrls: ["https://testnet.snowtrace.io/"],
    };
    window.ethereum.request.mockResolvedValueOnce();
    render(<AddChainButton chainParams={params} />);
    fireEvent.click(screen.getByText("Add Avalanche Fuji"));
    await waitFor(() => screen.getByText(/added!/));
  });
});
```

Add to `jest.config.js`:

```js
module.exports = {
  testEnvironment: "jsdom",
  moduleNameMapping: { "\\.(css|scss)$": "identity-obj-proxy" },
};
```

---

## 🌟 Closing Story

At the LA hackathon finals, a judge accidentally switched MetaMask to Fantom; Odessa's UI caught it, prompted a switch back to Sepolia, and the live demo stayed flawless. Judges congratulated the duo: "This UX is rock solid." Back in Cebu, over halo-halo, Neri and Odessa plotted automatic RPC fallback and cross-chain asset checks. From Cebu to LA, Filipino Web3 devs just raised the bar for seamless multi-network dApps. Mabuhay network-agnostic builds! 🇵🇭🔄🌐
