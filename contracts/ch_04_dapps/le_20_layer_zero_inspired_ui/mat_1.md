## 🧑‍💻 Background Story

At a bustling LayerZero hackathon in New York City, Odessa ("Det") teamed up with Neri to demo a **cross-chain bridge**—but they only had one local Hardhat node. No problem. Over coffee, they spun up a **BridgeSimulator** contract and built a React UI that **felt** like real cross-chain magic.

Front and center: a **Network** dropdown ("PHChain" ↔ "NYChain"), an **Amount** input, and a big **Bridge Tokens** button. Click. A confirmation modal pops: "Lock 0.05 ETH on PHChain?" Confirm → MetaMask pops → tx is sent → a loading spinner → "Locked! Lock ID #3." Then the UI flips to **NYChain**, asks "Release 0.05 ETH on NYChain?" Confirm → MetaMask → spinner → "Success! Tokens bridged."

Under the hood, it's the same contract on one network, but the UX simulates two chains, network switching, relayer wait, confirmations, error handling, and loading states. By demo's end, judges thought it was real. Filipino ingenuity had turned a sandbox into a production-grade cross-chain flow—in under 30 minutes. Mabuhay BridgeSimulator! 🇵🇭🔗🌐

---

## 📚 Theory & Web3 Lecture

### 🎯 What You'll Learn

In this lesson, you'll build a **cross-chain bridge simulator UI** inspired by LayerZero. Users can lock tokens on one "chain" and release them on another—all simulated on a single network to teach bridge concepts without the complexity of real cross-chain infrastructure.

---

### 📐 Bridge Simulator Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                  BRIDGE SIMULATOR FLOW                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ┌──────────────────────┐         ┌──────────────────────┐    │
│   │      PHChain         │         │       NYChain        │    │
│   │    (Simulated)       │         │     (Simulated)      │    │
│   └──────────┬───────────┘         └───────────┬──────────┘    │
│              │                                 │               │
│              │    STEP 1: LOCK                 │               │
│              │    ┌───────────────────┐        │               │
│              └───▶│ lockTokens()      │        │               │
│                   │ ├── Store amount  │        │               │
│                   │ ├── Assign lockId │        │               │
│                   │ └── emit Locked() │        │               │
│                   └─────────┬─────────┘        │               │
│                             │                  │               │
│                             ▼                  │               │
│                   ┌───────────────────┐        │               │
│                   │ STEP 2: SIMULATE  │        │               │
│                   │ NETWORK SWITCH    │        │               │
│                   │ (UI state change) │        │               │
│                   └─────────┬─────────┘        │               │
│                             │                  │               │
│                             │    STEP 3: RELEASE               │
│                             │    ┌───────────────────┐         │
│                             └───▶│ releaseTokens(id) │◀────────┘
│                                  │ ├── Check owner  │         │
│                                  │ ├── Mark released│         │
│                                  │ ├── Transfer ETH │         │
│                                  │ └── emit Released│         │
│                                  └───────────────────┘         │
│                                                                │
│                              ✅ BRIDGED!                       │
│                                                                │
└─────────────────────────────────────────────────────────────────┘
```

---

### 🔑 Key Concepts

#### 1. How Real Bridges Work

| Component | Role | This Lesson |
|-----------|------|-------------|
| **Source Chain** | Lock original tokens | Simulated in UI |
| **Destination Chain** | Mint/release wrapped tokens | Same contract |
| **Relayer** | Observes locks, triggers releases | Manual trigger |
| **Validators** | Verify cross-chain messages | Skipped (trusted) |
| **Oracle** | Provide proof of lock | Simulated |

```
Real Bridge Flow:
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│ Lock on  │───▶│ Relayer  │───▶│ Validate │───▶│ Release  │
│ Chain A  │    │ Observes │    │  Proof   │    │ on Chain B│
└──────────┘    └──────────┘    └──────────┘    └──────────┘

Simulated Flow:
┌──────────┐    ┌──────────┐    ┌──────────┐
│ Lock     │───▶│ UI State │───▶│ Release  │
│ (tx)     │    │  Change  │    │   (tx)   │
└──────────┘    └──────────┘    └──────────┘
```

#### 2. Bridge Contract Implementation

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BridgeSimulator {
    struct Lock {
        address user;      // Who locked the funds
        uint256 amount;    // How much was locked
        bool released;     // Has it been released?
    }
    
    // Auto-incrementing lock ID
    uint256 public nextId;
    
    // All locks by ID
    mapping(uint256 => Lock) public locks;
    
    event Locked(
        address indexed user, 
        uint256 amount, 
        uint256 indexed id
    );
    
    event Released(
        address indexed user, 
        uint256 amount, 
        uint256 indexed id
    );
    
    // Lock ETH and get a lock ID
    function lockTokens() external payable returns (uint256 id) {
        require(msg.value > 0, "Must send ETH");
        
        id = nextId++;
        locks[id] = Lock({
            user: msg.sender,
            amount: msg.value,
            released: false
        });
        
        emit Locked(msg.sender, msg.value, id);
    }
    
    // Release locked ETH back to user
    function releaseTokens(uint256 id) external {
        Lock storage lock = locks[id];
        
        require(lock.user == msg.sender, "Not your lock");
        require(!lock.released, "Already released");
        require(lock.amount > 0, "Invalid lock");
        
        lock.released = true;
        
        payable(msg.sender).transfer(lock.amount);
        
        emit Released(msg.sender, lock.amount, id);
    }
    
    // View lock details
    function getLock(uint256 id) external view returns (
        address user,
        uint256 amount,
        bool released
    ) {
        Lock memory lock = locks[id];
        return (lock.user, lock.amount, lock.released);
    }
}
```

#### 3. UI State Machine

```
┌─────────┐     ┌─────────────┐     ┌──────────┐
│  IDLE   │────▶│CONFIRM_LOCK │────▶│ LOCKING  │
│         │     │   (modal)   │     │(pending) │
└─────────┘     └─────────────┘     └────┬─────┘
                                         │
     ┌───────────────────────────────────┘
     │
     ▼
┌──────────┐     ┌───────────────┐     ┌────────────┐
│  LOCKED  │────▶│ SWITCH_CHAIN  │────▶│CONFIRM_REL │
│ ID: #7   │     │   (UI only)   │     │  (modal)   │
└──────────┘     └───────────────┘     └─────┬──────┘
                                             │
     ┌───────────────────────────────────────┘
     │
     ▼
┌───────────┐     ┌──────────┐
│ RELEASING │────▶│   DONE   │
│ (pending) │     │    ✅    │
└───────────┘     └──────────┘
```

---

### 🏗️ React Component Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    BRIDGE APP COMPONENTS                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │                      BridgeApp                           │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │ State: step, amount, lockId, sourceChain,       │    │   │
│   │  │        destChain, loading, error                │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   └───────────────────────┬─────────────────────────────────┘   │
│                           │                                     │
│       ┌───────────────────┼───────────────────┐                 │
│       ▼                   ▼                   ▼                 │
│   ┌─────────┐      ┌─────────────┐     ┌─────────────┐         │
│   │ Chain   │      │    Lock     │     │   Release   │         │
│   │Selector │      │    Panel    │     │    Panel    │         │
│   │         │      │             │     │             │         │
│   │ PHChain │      │ Amount: ___ │     │ Lock ID: 7  │         │
│   │    ↓    │      │ [Lock]      │     │ [Release]   │         │
│   │ NYChain │      │             │     │             │         │
│   └─────────┘      └─────────────┘     └─────────────┘         │
│                                                                 │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │                   Confirmation Modal                     │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │ Lock 0.1 ETH on PHChain?                         │    │   │
│   │  │ [Yes, lock] [Cancel]                             │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   └─────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

#### Complete Bridge Flow

```javascript
import { useState } from "react";
import { ethers } from "ethers";

const CHAINS = {
    PH: { name: "PHChain", color: "#0066CC" },
    NY: { name: "NYChain", color: "#FF6600" }
};

function BridgeApp() {
    const [step, setStep] = useState("IDLE");
    const [amount, setAmount] = useState("");
    const [lockId, setLockId] = useState(null);
    const [sourceChain, setSourceChain] = useState("PH");
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(null);

    const handleLock = async () => {
        if (!amount || parseFloat(amount) <= 0) {
            setError("Enter a valid amount");
            return;
        }

        setStep("CONFIRM_LOCK");
    };

    const confirmLock = async () => {
        setLoading(true);
        setError(null);
        setStep("LOCKING");

        try {
            const provider = new ethers.providers.Web3Provider(window.ethereum);
            const signer = provider.getSigner();
            const contract = new ethers.Contract(
                process.env.REACT_APP_BRIDGE_ADDRESS,
                BRIDGE_ABI,
                signer
            );

            const tx = await contract.lockTokens({
                value: ethers.utils.parseEther(amount)
            });
            
            const receipt = await tx.wait();
            
            // Extract lock ID from event
            const lockEvent = receipt.events.find(e => e.event === "Locked");
            const id = lockEvent.args.id.toNumber();
            
            setLockId(id);
            setStep("LOCKED");

        } catch (err) {
            setError(err.message);
            setStep("IDLE");
        } finally {
            setLoading(false);
        }
    };

    const handleSwitchChain = () => {
        // Simulated chain switch (just UI state)
        setSourceChain(sourceChain === "PH" ? "NY" : "PH");
        setStep("CONFIRM_RELEASE");
    };

    const confirmRelease = async () => {
        setLoading(true);
        setError(null);
        setStep("RELEASING");

        try {
            const provider = new ethers.providers.Web3Provider(window.ethereum);
            const signer = provider.getSigner();
            const contract = new ethers.Contract(
                process.env.REACT_APP_BRIDGE_ADDRESS,
                BRIDGE_ABI,
                signer
            );

            const tx = await contract.releaseTokens(lockId);
            await tx.wait();
            
            setStep("DONE");

        } catch (err) {
            setError(err.message);
            setStep("LOCKED");
        } finally {
            setLoading(false);
        }
    };

    // Render based on current step...
}
```

---

### 📊 Real Bridge vs Simulator Comparison

| Aspect | Real Bridge (LayerZero) | This Simulator |
|--------|------------------------|----------------|
| **Networks** | 2+ real chains | 1 network, UI simulates 2 |
| **Relayers** | Decentralized nodes | Manual button click |
| **Validation** | Oracle consensus | None (trusted) |
| **Token Wrap** | wETH, wBTC, etc. | Native ETH only |
| **Fees** | Protocol + gas | Gas only |
| **Finality** | Minutes to hours | Instant |
| **Complexity** | High | Low (learning-focused) |

---

### ⚠️ Common Mistakes

| Mistake | Problem | Solution |
|---------|---------|----------|
| Double release | Funds sent twice | Check `released` flag |
| Wrong lock owner | Unauthorized release | Verify `msg.sender == user` |
| Missing loading states | Double-clicks | Disable buttons while pending |
| Not saving lock ID | Can't release | Store in state after lock |
| Forgetting confirmation modals | Accidental transactions | Always confirm with user |

---

### ✅ Testing Checklist

Before considering this lesson complete, verify:

- [ ] Amount input validates positive numbers
- [ ] Lock confirmation modal appears
- [ ] Lock transaction succeeds and returns ID
- [ ] Lock ID displays after locking
- [ ] Chain "switch" updates UI state
- [ ] Release confirmation modal appears
- [ ] Release transaction succeeds
- [ ] Cannot release twice (guard works)
- [ ] Error handling for rejections
- [ ] Loading states prevent double-clicks

---

### 🔗 External Resources

| Resource | Link |
|----------|------|
| LayerZero Docs | https://layerzero.gitbook.io/ |
| Cross-Chain Messaging | https://ethereum.org/en/developers/docs/bridges/ |
| Ethers Transactions | https://docs.ethers.org/v5/api/contract/contract/#contract-functionsSend |
| Bridge Security | https://blog.chain.link/cross-chain-security/ |



---

## ✅ Test Cases

Create `__tests__/BridgeApp.test.js`:

```js
// __tests__/BridgeApp.test.js
import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import BridgeApp from "../BridgeApp";
import { ethers } from "ethers";

jest.mock("ethers");

describe("BridgeApp Flow", () => {
  const fakeProvider = {};
  const fakeSigner = {};
  const fakeBridge = {
    lockTokens: jest.fn(),
    releaseTokens: jest.fn(),
  };
  beforeAll(() => {
    global.window.ethereum = {
      request: jest
        .fn()
        // detect chainId
        .mockResolvedValueOnce("0x1")
        // eth_requestAccounts
        .mockResolvedValueOnce(["0xABC"])
        // wallet_switchEthereumChain
        .mockResolvedValueOnce(null),
    };
    ethers.providers.Web3Provider = jest.fn().mockReturnValue(fakeProvider);
    fakeProvider.getSigner = () => fakeSigner;
    ethers.Contract = jest.fn().mockReturnValue(fakeBridge);
    // mock lock tx
    fakeBridge.lockTokens.mockResolvedValue({
      wait: () =>
        Promise.resolve({
          events: [
            { event: "Locked", args: { id: ethers.BigNumber.from("7") } },
          ],
        }),
    });
    // mock release tx
    fakeBridge.releaseTokens.mockResolvedValue({
      wait: () => Promise.resolve(),
    });
  });

  it("completes bridge flow", async () => {
    render(<BridgeApp />);
    // Lock step
    fireEvent.change(screen.getByPlaceholderText("ETH"), {
      target: { value: "0.1" },
    });
    fireEvent.click(screen.getByText("Bridge"));
    // Confirm modal
    fireEvent.click(screen.getByText("Yes, lock"));
    await waitFor(() => expect(fakeBridge.lockTokens).toHaveBeenCalled());
    // Switch step
    fireEvent.click(screen.getByText("Switch Chain"));
    await waitFor(() => screen.getByText(/Release 0.1 ETH/));
    // Release step
    fireEvent.click(screen.getByText("Release 0.1 ETH on NYChain"));
    fireEvent.click(screen.getByText("Yes, release"));
    await waitFor(() =>
      expect(fakeBridge.releaseTokens).toHaveBeenCalledWith(7)
    );
    // Done
    expect(await screen.findByText(/✅ Bridged/)).toBeInTheDocument();
  });
});
```

In `jest.config.js`:

```js
module.exports = {
  testEnvironment: "jsdom",
  moduleNameMapping: { "\\.(css|scss)$": "identity-obj-proxy" },
};
```

---

## 🌟 Closing Story

At hackathon's demo stage, the crowd watched Odessa's UI lock—and then "release"—0.2 ETH across **simulated** PHChain & NYChain. Judges applauded the slick UX: "Feels like the real LayerZero!" Back in Cebu, Neri and Odessa sketched the next leap—integrating a mock relayer backend and real cross-chain testnets. Filipino dev power: bridging chains, building futures! 🇵🇭🌐🔥