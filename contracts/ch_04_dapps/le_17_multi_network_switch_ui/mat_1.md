## 🧑‍💻 Background Story

Under the bright lights of DevCon Cebu, Neri and Odessa demoed their multi-network React UI to a packed room. Local devs clapped as the screen showed “Chain: Sepolia” then switched live to “Chain: Polygon” with a single click. A week later—jet-lagged but exhilarated—in Los Angeles’s hackathon they faced judges who flipped their MetaMask to Goerli by mistake and got stuck. Odessa grinned: “No worries, our app will detect your chain and prompt you to switch!”

Back in Cebu, they’d sketched out a tiny contract, `NetworkDetector.sol`, that simply returns `block.chainid`. In React they used Ethers.js and `window.ethereum.request` calls to read the chain ID, map it to human-readable names, and, if it didn’t match the expected network, fire off `wallet_switchEthereumChain` (or `wallet_addEthereumChain` for new testnets).

Now at LA hackathon, when judges tried to deploy their smart-wallet on a wrong chain, Odessa’s UI popped up a modal: “Please switch to Sepolia (ID 11155111).” In 30 seconds flat, the judges approved the switch in MetaMask—and the build pipeline continued seamlessly. Filipino ingenuity had turned a common UX friction into a feature. By the end of the week, teams were forking their code—and Neri and Odessa were already plotting the next trick: cross-chain network detection with automatic RPC fallback. Mabuhay multi-network UX! 🇵🇭🔄🚀

---

## 📚 Theory & Web3 Lecture

1. block.chainid in Solidity  
   • Global variable: `block.chainid` returns the current chain ID.  
   • Useful for on-chain verification or basic network checks.

2. window.ethereum and EIP-1193  
   • `window.ethereum.request({ method: "eth_chainId" })` → returns current chain hex ID.  
   • `provider.send("eth_chainId", [])` via Ethers.js provider.

3. Chain Switching (EIP-3085 & EIP-3326)  
   • `wallet_switchEthereumChain`: switch MetaMask to an existing chain.

   ```js
   await provider.send("wallet_switchEthereumChain", [{ chainId: targetHex }]);
   ```

   • `wallet_addEthereumChain`: propose adding a new chain to MetaMask.

   ```js
   await provider.send("wallet_addEthereumChain", [chainParams]);
   ```

4. React + Ethers.js Pattern  
   • useState for `chainId`, `chainName`, `error`, `loading`.  
   • useEffect to fetch on-mount and subscribe to `chainChanged`.

   ```js
   window.ethereum.on("chainChanged", handleChainChanged);
   ```

   • Cleanup in return of useEffect to remove listener.

5. UX Best Practices  
   • Map known chain IDs to names & RPC logos.  
   • Friendly modals when switching: explain why.  
   • Gracefully handle user rejection (`error.code === 4001`).  
   • Fallback to JSON-RPC provider read-only if MetaMask unavailable.

🔗 References  
– Ethers.js: https://docs.ethers.org/v5  
– EIP-3085: https://eips.ethereum.org/EIPS/eip-3085  
– EIP-3326: https://eips.ethereum.org/EIPS/eip-3326  
– React Hooks: https://reactjs.org/docs/hooks-intro.html

---

## 🧪 Exercises

### Exercise 1: Detect & Display Current Network

Problem Statement  
Build `NetworkStats` that connects to MetaMask (or JSON-RPC), calls a small on-chain contract to read `block.chainid`, and displays both the raw ID and a friendly name (e.g., “Sepolia”, “Polygon”). Subscribe to `chainChanged` so it updates live.

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

**Starter Code (`NetworkStats.js`)**

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

To Do List

- [ ] Request accounts or fallback to JSON-RPC.
- [ ] Instantiate provider & `NetworkDetector` contract (address in `.env`).
- [ ] Call `getChainId()`, parse number.
- [ ] Map common IDs to names (`{1: "Mainnet", 5:"Goerli", 11155111:"Sepolia", 137:"Polygon"}`).
- [ ] Subscribe to `chainChanged` and re-run logic.
- [ ] Clean up listener on unmount.

**Full Solution**

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

.env Sample

```
REACT_APP_RPC_URL=https://sepolia.infura.io/v3/YOUR_KEY
REACT_APP_NETWORK_DETECTOR=0xYourNetworkDetectorAddress
```

---

### Exercise 2: Prompt & Switch Network

Problem Statement  
Create `NetworkSwitcher` that, given a `targetChainId` prop, checks the current chain and, if it doesn’t match, prompts MetaMask to switch to it. Handle user rejection gracefully.

**Starter Code (`NetworkSwitcher.js`)**

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

To Do List

- [ ] Read current chain on mount.
- [ ] Compare to `targetChainId`.
- [ ] On click, call `wallet_switchEthereumChain` with hex `chainId`.
- [ ] Handle error codes:  
      • `4902` → need to add chain first.  
      • `4001` → user rejected.
- [ ] Display status messages.

**Full Solution**

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

---

### Exercise 3: Add New Chain to MetaMask

Problem Statement  
Build `AddChainButton` that proposes adding a new chain (e.g., Avalanche Fuji) when MetaMask doesn’t recognize it. Use `wallet_addEthereumChain` with full parameters.

**Starter Code (`AddChainButton.js`)**

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

To Do List

- [ ] Use `wallet_addEthereumChain` with given `chainParams`.
- [ ] Handle and display success or error messages.

**Full Solution**

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
  moduleNameMapper: { "\\.(css|scss)$": "identity-obj-proxy" },
};
```

---

## 🌟 Closing Story

At the LA hackathon finals, a judge accidentally switched MetaMask to Fantom; Odessa’s UI caught it, prompted a switch back to Sepolia, and the live demo stayed flawless. Judges congratulated the duo: “This UX is rock solid.” Back in Cebu, over halo-halo, Neri and Odessa plotted automatic RPC fallback and cross-chain asset checks. From Cebu to LA, Filipino Web3 devs just raised the bar for seamless multi-network dApps. Mabuhay network-agnostic builds! 🇵🇭🔄🌐
