## 🧑‍💻 Background Story

![Typhoon Relief](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+14.0+-+COVER.png)

A week after Typhoon Ulysses swept through Cagayan Valley, Odessa ("Det") sat in her BGC co-working nook, watching relief convoys slow to a crawl. "What if donations automatically release when a storm hits threshold?" she mused. Neri grinned: "Let's simulate an oracle feeding wind-speed data on-chain."

By midnight, they had `TyphoonReliefChain.sol` deployed on a local Hardhat network. It held a donation pool and a threshold wind speed. When the mocked oracle pushed a reading above that threshold, the contract would auto-release funds to the barangay relief fund. No messy back-ends—just a simulated oracle call via `updateWeather`.

Odessa scaffolded a React app with three widgets:

1. **Stats**: shows current wind speed, contract balance, and release status.
2. **Donate**: lets supporters send ETH to the relief pool.
3. **OracleFeed**: simulates an off-chain weather provider by sending a new wind speed on-chain.

As they clicked "Feed 120 km/h," an `Released` event fired and the UI lit up: donations dispatched! Over cups of taho, Odessa and Neri toasted to the future: real Chainlink integration next—but tonight, TyphoonReliefChain was alive.

![Typhoon Relief DApp](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+14.1.png)

---

## 📚 Theory & Web3 Lecture

### 🎯 What You'll Learn

In this lesson, you'll build a **simulated oracle DApp** that demonstrates how off-chain data (weather conditions) can trigger on-chain actions (releasing typhoon relief funds). This pattern is fundamental to understanding real-world Chainlink integrations.

---

### 📐 Oracle-Triggered Relief Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                  TYPHOON RELIEF CHAIN FLOW                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │                 OFF-CHAIN WORLD                          │   │
│   │  ┌─────────────┐        ┌─────────────┐                 │   │
│   │  │   Weather   │───────▶│   Oracle    │                 │   │
│   │  │   Station   │        │  (Simulated)│                 │   │
│   │  │  🌪️ 120km/h │        │  Frontend   │                 │   │
│   │  └─────────────┘        └──────┬──────┘                 │   │
│   └────────────────────────────────┼────────────────────────┘   │
│                                    │                            │
│                          updateWeather(120)                     │
│                                    │                            │
│   ┌────────────────────────────────▼────────────────────────┐   │
│   │                 ON-CHAIN CONTRACT                        │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │  TyphoonReliefChain.sol                          │    │   │
│   │  │  ├── windSpeed: 120 km/h                         │    │   │
│   │  │  ├── threshold: 100 km/h                         │    │   │
│   │  │  ├── pool: 5 ETH                                 │    │   │
│   │  │  └── beneficiary: 0xBarangay                     │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   │                         │                                │   │
│   │         if (windSpeed >= threshold)                     │   │
│   │                         │                                │   │
│   │                         ▼                                │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │  AUTO-RELEASE TO BARANGAY FUND 💰               │    │   │
│   │  │  emit Released(beneficiary, 5 ETH)               │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   └──────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

### 🔑 Key Concepts

#### 1. The Oracle Problem

Smart contracts **cannot** fetch external data on their own:

| Capability       | Smart Contract | Oracle |
| ---------------- | -------------- | ------ |
| Read blockchain  | ✅ Yes         | ✅ Yes |
| Write blockchain | ✅ Yes         | ✅ Yes |
| HTTP requests    | ❌ No          | ✅ Yes |
| Access APIs      | ❌ No          | ✅ Yes |
| Read sensors     | ❌ No          | ✅ Yes |

```
Solution: Oracle Pattern
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│ Real World  │────▶│   Oracle    │────▶│  Contract   │
│   Data      │     │  (Bridge)   │     │  (On-chain) │
└─────────────┘     └─────────────┘     └─────────────┘
```

In production, you'd use **Chainlink** oracles. Here, we **simulate** the oracle by calling `updateWeather()` from the frontend.

#### 2. Threshold-Based Auto-Release

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TyphoonReliefChain {
    address public beneficiary;      // Barangay relief fund
    uint256 public windSpeed;        // Current reading (km/h)
    uint256 public threshold;        // Trigger point (e.g., 100 km/h)
    bool public released;            // Has fund been released?

    event Donated(address indexed donor, uint256 amount);
    event DataUpdated(uint256 speed);
    event Released(address indexed to, uint256 amount);

    constructor(address _beneficiary, uint256 _threshold) {
        beneficiary = _beneficiary;
        threshold = _threshold;
    }

    // Anyone can donate to the relief pool
    function donate() external payable {
        require(msg.value > 0, "Must send ETH");
        emit Donated(msg.sender, msg.value);
    }

    // Oracle calls this with weather data
    function updateWeather(uint256 _speed) external {
        windSpeed = _speed;
        emit DataUpdated(_speed);

        // Auto-release if threshold exceeded and not yet released
        if (_speed >= threshold && !released && address(this).balance > 0) {
            released = true;
            uint256 amount = address(this).balance;
            payable(beneficiary).transfer(amount);
            emit Released(beneficiary, amount);
        }
    }
}
```

#### 3. Read vs Write Operations

| Operation | Gas Cost | Signer Needed | Example                       |
| --------- | -------- | ------------- | ----------------------------- |
| **Read**  | Free     | No            | `windSpeed()`, `released()`   |
| **Write** | Paid     | Yes           | `donate()`, `updateWeather()` |

```javascript
// Reading (no gas, no signer)
const speed = await contract.windSpeed();
const isReleased = await contract.released();
const balance = await provider.getBalance(contractAddress);

// Writing (gas required, needs signer)
const tx = await contract.donate({ value: ethers.parseEther("0.1") });
await tx.wait();

const tx2 = await contract.updateWeather(120);
await tx2.wait();
```

---

### 🏗️ React Component Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    RELIEF APP COMPONENTS                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │                      ReliefApp                           │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │ State: windSpeed, balance, released, error      │    │   │
│   │  │ Effects: Fetch data, subscribe to events        │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   └───────────────────────┬─────────────────────────────────┘   │
│                           │                                     │
│       ┌───────────────────┼───────────────────┐                 │
│       ▼                   ▼                   ▼                 │
│   ┌─────────┐      ┌─────────────┐     ┌─────────────┐         │
│   │ Relief  │      │   Donate    │     │  Oracle     │         │
│   │ Stats   │      │    Form     │     │   Feed      │         │
│   │         │      │             │     │             │         │
│   │ 🌪️ 50   │      │ Amount: ___ │     │ Speed: ___  │         │
│   │ 💰 1.5  │      │ [Donate]    │     │ [Feed Data] │         │
│   │ ❌ No   │      │             │     │             │         │
│   └─────────┘      └─────────────┘     └─────────────┘         │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

#### Event-Driven UI Updates

```javascript
useEffect(() => {
  const setupContract = async () => {
    const provider = new ethers.BrowserProvider(window.ethereum);
    const signer = await provider.getSigner();
    const contract = new ethers.Contract(CONTRACT_ADDRESS, RELIEF_ABI, signer);

    // Initial data fetch
    await refreshStats();

    // Subscribe to events for real-time updates
    contract.on("Donated", (donor, amount) => {
      console.log(`Donation: ${ethers.formatEther(amount)} ETH`);
      refreshStats();
    });

    contract.on("DataUpdated", (speed) => {
      console.log(`Wind speed updated: ${speed} km/h`);
      setWindSpeed(Number(speed));
    });

    contract.on("Released", (to, amount) => {
      console.log(`Funds released to ${to}!`);
      setReleased(true);
      refreshStats();
      // Show success notification
    });

    // Cleanup
    return () => contract.removeAllListeners();
  };

  setupContract();
}, []);
```

---

### 📊 Simulated vs Production Oracle

| Aspect      | Simulated (This Lesson) | Production (Chainlink) |
| ----------- | ----------------------- | ---------------------- |
| Data Source | Frontend button click   | Real weather APIs      |
| Trust Model | Centralized (you)       | Decentralized nodes    |
| Cost        | Just gas                | LINK tokens + gas      |
| Reliability | Manual                  | Automated & redundant  |
| Use Case    | Learning, prototyping   | Live production apps   |

```
Production Chainlink Flow:
┌────────────┐   ┌────────────┐   ┌────────────┐   ┌────────────┐
│ Weather    │──▶│ Chainlink  │──▶│ Aggregator │──▶│   Your     │
│ APIs       │   │   Nodes    │   │  Contract  │   │  Contract  │
└────────────┘   └────────────┘   └────────────┘   └────────────┘
     Real           Multiple          Median           Triggered
     Data           Sources           Value            Action
```

---

### ⚠️ Common Mistakes

| Mistake                  | Problem                        | Solution                          |
| ------------------------ | ------------------------------ | --------------------------------- |
| Not checking `released`  | Double release                 | Add `!released` guard             |
| Forgetting `tx.wait()`   | UI updates before confirmation | Always await receipt              |
| No balance check         | Transfer fails on empty pool   | Check `address(this).balance > 0` |
| Hardcoding threshold     | Inflexible                     | Make it constructor parameter     |
| Missing reentrancy guard | Security vulnerability         | Use OpenZeppelin ReentrancyGuard  |

---

### ✅ Testing Checklist

Before considering this lesson complete, verify:

- [ ] Stats panel shows current wind speed
- [ ] Pool balance updates after donations
- [ ] Release status shows ❌ before threshold
- [ ] Oracle feed updates wind speed on-chain
- [ ] Auto-release triggers at threshold
- [ ] Released event fires and UI updates
- [ ] Cannot release twice (guard works)
- [ ] Error handling for failed transactions
- [ ] Events refresh UI in real-time

---

### 🔗 External Resources

| Resource             | Link                                                                 |
| -------------------- | -------------------------------------------------------------------- |
| Chainlink Data Feeds | https://docs.chain.link/data-feeds                                   |
| The Oracle Problem   | https://blog.chain.link/what-is-the-blockchain-oracle-problem/       |
| Ethers.js Events     | https://docs.ethers.org/v6/api/contract/#ContractEvent               |
| Solidity Security    | https://docs.soliditylang.org/en/latest/security-considerations.html |

---

## ✅ Test Cases

Create `__tests__/ReliefApp.test.js`:

```js
// __tests__/ReliefApp.test.js
import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import ReliefStats from "../ReliefStats";
import Donate from "../Donate";
import OracleFeed from "../OracleFeed";
import { ethers } from "ethers";

jest.mock("ethers");

describe("TyphoonReliefChain App", () => {
  const fakeProvider = {};
  const fakeSigner = {};
  const fakeContract = {
    windSpeed: jest.fn(),
    released: jest.fn(),
    donate: jest.fn(),
    updateWeather: jest.fn(),
  };

  beforeAll(() => {
    global.window.ethereum = {
      request: jest.fn().mockResolvedValue(["0xABC"]),
    };
    ethers.BrowserProvider = jest.fn().mockReturnValue(fakeProvider);
    fakeProvider.getSigner = async () => fakeSigner;
    ethers.Contract = jest.fn().mockReturnValue(fakeContract);
    fakeContract.windSpeed.mockResolvedValue(50n);
    fakeContract.released.mockResolvedValue(false);
    // ethers v6 returns native bigint for parseEther / getBalance
    ethers.parseEther = jest.fn((v) => BigInt(Math.round(Number(v) * 1e18)));
    ethers.formatEther = jest.fn((wei) => (Number(wei) / 1e18).toString());
    fakeProvider.getBalance = jest
      .fn()
      .mockResolvedValue(ethers.parseEther("1.5"));
  });

  it("loads and shows stats", async () => {
    render(<ReliefStats />);
    expect(await screen.findByText(/Wind Speed:/)).toHaveTextContent("50");
    expect(screen.getByText(/Pool Balance:/)).toHaveTextContent("1.5");
    expect(screen.getByText(/Released:/)).toHaveTextContent("❌");
  });

  it("donates ETH and refreshes", async () => {
    fakeContract.donate.mockResolvedValue({ wait: () => Promise.resolve() });
    const onDonated = jest.fn();
    render(<Donate onDonated={onDonated} />);
    fireEvent.change(screen.getByPlaceholderText("ETH amount"), {
      target: { value: "0.2" },
    });
    fireEvent.click(screen.getByText("Donate"));
    await waitFor(() => expect(fakeContract.donate).toHaveBeenCalled());
    expect(onDonated).toHaveBeenCalled();
  });

  it("feeds weather data and refreshes", async () => {
    fakeContract.updateWeather.mockResolvedValue({
      wait: () => Promise.resolve(),
    });
    const onFeed = jest.fn();
    render(<OracleFeed onFeed={onFeed} />);
    fireEvent.change(screen.getByPlaceholderText("Wind km/h"), {
      target: { value: "120" },
    });
    fireEvent.click(screen.getByText("Feed Data"));
    await waitFor(() =>
      expect(fakeContract.updateWeather).toHaveBeenCalledWith(120)
    );
    expect(onFeed).toHaveBeenCalled();
  });
});
```

Add to `jest.config.js`:

```js
module.exports = {
  testEnvironment: "jsdom",
  moduleNameMapper: {
    "\\.(css|scss)$": "identity-obj-proxy",
  },
};
```

---

## 🌟 Closing Story

With "TyphoonReliefChain" live locally, Odessa clicked "Feed Data → 130 km/h" and watched donations auto-dispatch in real time. Neri cheered: "Next stop, Chainlink integration and multi-region triggers!" From mock oracle to production-grade pipeline, Odessa's civic-tech DApp was storm-ready. Mabuhay Filipino Web3 innovation! 🇵🇭🌪️🚀
