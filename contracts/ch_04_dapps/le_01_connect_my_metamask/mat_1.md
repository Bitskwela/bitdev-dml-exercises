## 🧑‍💻 Background Story

In a cozy café in BGC, Neri leaned forward, latte foam dusting her laptop keyboard. Across from her, Odessa’s eyes sparkled with excitement—and jitters. “Next week, you pitch our decentralized street-food market app in NYC,” Neri reminded her. “But kung walang **Connect** button, it ain’t a DApp!”

Odessa took a deep breath. She imagined balikbayans craving sisig tacos, taho vendors tokenizing orders, and OFWs trading food vouchers—all powered by Ethereum. First step: MetaMask. With a sly grin, Neri typed `npx create-react-app dapp-foundation`. “We’ll inject Ethers.js, detect MetaMask, and call `eth_requestAccounts`.”

In fifteen minutes, Odessa saw “Install MetaMask” if no wallet was found. Ten more lines of React Hooks later, her screen displayed “Connected: 0xAbC…123”. She laughed—the same way she felt when she first tasted halo-halo in Manila. In that moment, bustling BGC felt like Ethereum’s mainnet: full of promise, a little wild, and utterly addictive.

As she sipped her iced matcha, Odessa realized this small widget held enormous power. It was her gateway for every future contract call: sari-sari store tokens, barangay voting DAOs, even rice subsidy NFTs. Next stop: smart contracts! But tonight, she’d celebrate her “Connect Me, MetaMask!” triumph with extra ube rolls.

Welcome to DApp Integration Foundations. Let’s elevate Filipino flavors to the global Web3 stage! 🇵🇭🍢🚀

---

## 📚 Theory & Web3 Lecture

### 1. DApp Architecture

- **React Frontend** for UI & user interactions
- **Ethers.js** to communicate with Ethereum via `window.ethereum` injected by MetaMask
- **MetaMask** handles key management, network switching, and transaction signing

### 2. Key Concepts

1. **Detect** `window.ethereum` → prompt user to install MetaMask.
2. **Request Accounts** (`eth_requestAccounts`) → user approval popup.
3. **Listen** to `accountsChanged` & `chainChanged` events → keep UI in sync.
4. **Optional**: Switch networks (`wallet_switchEthereumChain`).

### 3. Code Walkthrough

Install Ethers.js:

```bash
npm install ethers
```

Hook up wallet logic in a functional component:

```js
// src/components/WalletConnector.js
import { useState, useEffect } from "react";
import { ethers } from "ethers";

export default function WalletConnector() {
  const [account, setAccount] = useState(null);
  const [chainId, setChainId] = useState(null);

  // Detect account & chain changes
  useEffect(() => {
    if (!window.ethereum) return;
    // Account change handler
    const onAccountsChanged = (accounts) => {
      setAccount(accounts[0] || null);
    };
    // Chain change handler
    const onChainChanged = (chainHex) => {
      setChainId(chainHex);
    };
    window.ethereum.on("accountsChanged", onAccountsChanged);
    window.ethereum.on("chainChanged", onChainChanged);

    // Cleanup
    return () => {
      window.ethereum.removeListener("accountsChanged", onAccountsChanged);
      window.ethereum.removeListener("chainChanged", onChainChanged);
    };
  }, []);

  // Connect wallet
  const connectWallet = async () => {
    if (!window.ethereum) return alert("Please install MetaMask!");
    try {
      const [selected] = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      setAccount(selected);
      const hex = await window.ethereum.request({ method: "eth_chainId" });
      setChainId(hex);
    } catch (error) {
      console.error("User rejected wallet connection", error);
    }
  };

  return (
    <div style={{ padding: 20 }}>
      {window.ethereum ? (
        account ? (
          <div>
            <p>Connected: {account}</p>
            <p>Network: {chainId}</p>
          </div>
        ) : (
          <button onClick={connectWallet}>Connect MetaMask 🦊</button>
        )
      ) : (
        <p>Please install MetaMask to continue.</p>
      )}
    </div>
  );
}
```

### 4. Security Best Practices

- Always **verify** `window.ethereum` existence before calls.
- **Handle** rejections gracefully (user denies request).
- **Don’t** hardcode private keys or expose RPC URLs publicly.
- **Listen** to chain changes to prevent transactions on the wrong network.

External References:

- Ethers.js Docs: https://docs.ethers.org
- MetaMask API: https://docs.metamask.io
- React Hooks: https://reactjs.org/docs/hooks-intro.html

---

## ✅ Test Cases

```js
// __tests__/WalletConnector.test.js
import React from "react";
import { render, fireEvent, screen, act } from "@testing-library/react";
import WalletConnector from "../components/WalletConnector";

beforeEach(() => {
  jest.resetAllMocks();
  global.window.ethereum = undefined;
});

test("prompts to install when no MetaMask", () => {
  render(<WalletConnector />);
  expect(screen.getByText(/Please install MetaMask/i)).toBeInTheDocument();
});

test("connects and displays account & chain", async () => {
  const fakeAcct = "0xABC";
  const fakeChain = "0x5";
  global.window.ethereum = {
    request: jest
      .fn()
      .mockResolvedValueOnce([fakeAcct]) // eth_requestAccounts
      .mockResolvedValueOnce(fakeChain), // eth_chainId
    on: jest.fn(),
    removeListener: jest.fn(),
  };
  render(<WalletConnector />);
  fireEvent.click(screen.getByText(/Connect MetaMask/i));

  // wait for account & chain to render
  expect(await screen.findByText(new RegExp(fakeAcct))).toBeInTheDocument();
  expect(screen.getByText(new RegExp(fakeChain))).toBeInTheDocument();
  expect(window.ethereum.request).toHaveBeenCalledWith({
    method: "eth_requestAccounts",
  });
  expect(window.ethereum.request).toHaveBeenCalledWith({
    method: "eth_chainId",
  });
});

test("listens to events", () => {
  const mockOn = jest.fn();
  window.ethereum = {
    request: jest.fn(),
    on: mockOn,
    removeListener: jest.fn(),
  };
  render(<WalletConnector />);
  expect(mockOn).toHaveBeenCalledWith("accountsChanged", expect.any(Function));
  expect(mockOn).toHaveBeenCalledWith("chainChanged", expect.any(Function));
});
```

---

## 🌟 Closing Story

As Odessa closed her laptop, she grinned at Neri: “Check this out—my React app just talks to MetaMask!” In a few clicks, she’d turned a blank page into the gateway for all future contract calls. The aroma of ube pandesal from the café suddenly tasted sweeter.

Next, they’d wire this connector to a local Hardhat contract: reading and writing on-chain state. From wallet integration to full DApp—Odessa was one step closer to powering Filipino street-food vendors on Ethereum. Onward to smart contracts! 🚀🌮🪙
