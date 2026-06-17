## 🧑‍💻 Background Story

![DeFi Dashboard](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+12.0+-+COVER.png)

In a virtual workshop hosted by Ateneo's Blockchain Society, Neri was ready to impress. She'd sketched out a DeFi staking dashboard—"Simulated, pero feels real"—and turned to Odessa ("Det") to wire up the frontend. Their goal: show LP token data (reserves, total supply), compute token prices, and display a mocked APR, all without a production protocol.

![DeFi Sim Dashboard](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+12.1.png)

Using Hardhat, Neri deployed a tiny `MockLP` contract on a local network. It stored two token reserves (e.g., USDC and TKO), a total supply, and a fixed APR (in basis points). Now Det would build a clean React + Ethers.js dashboard:

1. Fetch `getReserves()` and `totalSupply()`
2. Compute Token0's price in Token1 (reserve1 / reserve0)
3. Read `getMockAPR()` (e.g. 1 200 = 12.00 %)
4. Display all with friendly formatting

In under 30 minutes, Det had a "DeFi Sim" UI: a card for reserves, a badge for price, and a progress bar for APR. Ateneo scholars clicked "Refresh," and the numbers updated in real time. No real staking, no live oracles—just smart design, Filipino grit, and a taste of what DeFi dashboards can be. Mabuhay simulations, next stop: on-chain rewards! 🇵🇭🪙🚀

---

## 📚 Theory & Web3 Lecture

### 🎯 What You'll Learn

In this lesson, you'll build a **DeFi simulation dashboard** that reads LP (Liquidity Pool) token data, calculates token prices from reserves, and displays a mock APR. This teaches you the fundamentals of DeFi analytics without requiring a production protocol.

---

### 📐 DeFi Dashboard Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    DeFi DASHBOARD FLOW                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ┌──────────────────────────────────────────────────────────┐  │
│   │                     MockLP Contract                       │  │
│   │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐       │  │
│   │  │  reserve0   │  │  reserve1   │  │ totalSupply │       │  │
│   │  │   (USDC)    │  │   (TKO)     │  │  (LP tokens)│       │  │
│   │  └─────────────┘  └─────────────┘  └─────────────┘       │  │
│   │                         │                                 │  │
│   │  ┌──────────────────────┴──────────────────────────────┐ │  │
│   │  │  getMockAPR() → returns APR in basis points (bps)   │ │  │
│   │  └─────────────────────────────────────────────────────┘ │  │
│   └──────────────────────────────────────────────────────────┘  │
│                              │                                  │
│                              ▼                                  │
│   ┌──────────────────────────────────────────────────────────┐  │
│   │                    React Dashboard                        │  │
│   │  ┌───────────┐  ┌───────────┐  ┌───────────┐             │  │
│   │  │ Reserves  │  │   Price   │  │    APR    │             │  │
│   │  │  Panel    │  │   Badge   │  │ Progress  │             │  │
│   │  │ R0: 1000  │  │  2.0 TKO  │  │  12.00%   │             │  │
│   │  │ R1: 2000  │  │  per USDC │  │  ████░░   │             │  │
│   │  └───────────┘  └───────────┘  └───────────┘             │  │
│   └──────────────────────────────────────────────────────────┘  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

### 🔑 Key Concepts

#### 1. Liquidity Pool Basics

A **Liquidity Pool** holds two tokens and enables decentralized trading:

| Component        | Description                   | Example                |
| ---------------- | ----------------------------- | ---------------------- |
| **Reserve0**     | Amount of Token A in pool     | 1,000 USDC             |
| **Reserve1**     | Amount of Token B in pool     | 2,000 TKO              |
| **Total Supply** | LP tokens issued to providers | 500 LP                 |
| **LP Token**     | Represents share of the pool  | Your ownership receipt |

```
Pool Value = Reserve0 + (Reserve1 × Price of Token1)
Your Share = (Your LP Tokens / Total Supply) × Pool Value
```

#### 2. Mock LP Contract Structure

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MockLP {
    uint112 public reserve0;      // Token A reserves
    uint112 public reserve1;      // Token B reserves
    uint256 public totalSupply;   // Total LP tokens
    uint256 public mockAPR;       // APR in basis points (bps)

    // Returns both reserves in one call (gas efficient)
    function getReserves() external view returns (uint112, uint112) {
        return (reserve0, reserve1);
    }

    // Returns APR in basis points: 1200 = 12.00%
    function getMockAPR() external view returns (uint256) {
        return mockAPR;
    }
}
```

#### 3. Understanding Basis Points (BPS)

| Basis Points | Percentage | Use Case          |
| ------------ | ---------- | ----------------- |
| 100 bps      | 1.00%      | Low APR           |
| 500 bps      | 5.00%      | Moderate APR      |
| 1200 bps     | 12.00%     | High APR          |
| 10000 bps    | 100.00%    | Maximum reference |

```javascript
// Convert basis points to percentage
const aprPercent = aprBps / 100; // 1200 → 12.00

// Format for display
const formattedAPR = (aprBps / 100).toFixed(2) + "%"; // "12.00%"
```

#### 4. Price Calculation from Reserves

The **Constant Product Formula** (x × y = k) determines prices:

```
Token0 Price (in Token1) = Reserve1 / Reserve0
Token1 Price (in Token0) = Reserve0 / Reserve1
```

```javascript
// With bigint precision (using 1e18 scale factor)
const ONE = ethers.WeiPerEther; // 1e18 (bigint)

// Calculate Token0 price in Token1 terms
const priceScaled = (reserve1 * ONE) / reserve0;
const price = ethers.formatUnits(priceScaled, 18);

// Example: 2000 TKO / 1000 USDC = 2.0 TKO per USDC
```

---

### 🏗️ bigint Math Deep Dive

In ethers v6, contract calls return native JavaScript `bigint` values
(not the v5 `BigNumber` object). Use standard operators instead of methods.

```
┌─────────────────────────────────────────────────────────────────┐
│                     BIGINT OPERATIONS                           │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ❌ JavaScript Numbers (DANGEROUS)                            │
│   ─────────────────────────────────                             │
│   const price = Number(reserve1) / Number(reserve0); // loss!   │
│   // 2000000000000000000000 / 1000000000000000000000 = ???      │
│                                                                 │
│   ✅ Native bigint (SAFE)                                       │
│   ────────────────────────                                      │
│   const price = (reserve1 * ONE) / reserve0;                    │
│   // Maintains 18 decimal precision                             │
│                                                                 │
│   Common bigint Operators:                                      │
│   ┌─────────────┬─────────────────────────────────────────┐    │
│   │ a + b       │ Addition                                │    │
│   │ a - b       │ Subtraction                             │    │
│   │ a * b       │ Multiplication                          │    │
│   │ a / b       │ Division (rounds toward zero)           │    │
│   │ a % b       │ Modulo                                  │    │
│   │ a === b     │ Equals → boolean                        │    │
│   │ a > b       │ Greater than → boolean                  │    │
│   │ a < b       │ Less than → boolean                     │    │
│   │ Number(a)   │ Convert to JS number (if small enough)  │    │
│   │ a.toString()│ Convert to string                       │    │
│   └─────────────┴─────────────────────────────────────────┘    │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

### 🔄 React Data Fetching Pattern

```javascript
import { useState, useEffect } from "react";
import { ethers } from "ethers";

function DeFiDashboard() {
  const [reserves, setReserves] = useState({ r0: null, r1: null });
  const [supply, setSupply] = useState(null);
  const [price, setPrice] = useState(null);
  const [apr, setApr] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const provider = new ethers.JsonRpcProvider(
          process.env.REACT_APP_RPC_URL
        );
        const lp = new ethers.Contract(
          process.env.REACT_APP_LP_ADDRESS,
          LP_ABI,
          provider
        );

        // Fetch all data in parallel for efficiency
        const [reserveData, totalSupply, mockAPR] = await Promise.all([
          lp.getReserves(),
          lp.totalSupply(),
          lp.getMockAPR(),
        ]);

        // Update state
        setReserves({ r0: reserveData[0], r1: reserveData[1] });
        setSupply(totalSupply);
        setApr(Number(mockAPR) / 100);

        // Calculate price with precision (native bigint math)
        const ONE = ethers.WeiPerEther;
        const priceScaled = (reserveData[1] * ONE) / reserveData[0];
        setPrice(ethers.formatUnits(priceScaled, 18));
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  // ... render UI
}
```

---

### 📊 Comparison: Real vs Mock LP Contracts

| Feature      | Real LP (Uniswap V2) | Mock LP (This Lesson)  |
| ------------ | -------------------- | ---------------------- |
| Reserves     | Dynamic, from swaps  | Hardcoded or settable  |
| Total Supply | Minted on deposits   | Fixed value            |
| APR          | Calculated from fees | Mock value in bps      |
| Swapping     | Full AMM logic       | Not implemented        |
| Complexity   | High                 | Low (learning-focused) |

---

### ⚠️ Common Mistakes

| Mistake                        | Problem                     | Solution                  |
| ------------------------------ | --------------------------- | ------------------------- |
| Using `Number()` on bigint    | `Number(r1) / Number(r0)` loses precision | Use bigint `*` and `/` |
| Forgetting scale factor        | Loss of decimal precision   | Multiply by 1e18 first    |
| Not handling loading state     | Flash of empty content      | Show spinner until ready  |
| Ignoring error handling        | Silent failures             | Wrap in try/catch         |
| Hardcoding addresses           | Hard to maintain            | Use `.env` variables      |

---

### ✅ Testing Checklist

Before considering this lesson complete, verify:

- [ ] Reserves display correctly (Reserve0, Reserve1)
- [ ] Total Supply shows the LP token count
- [ ] Price calculation is accurate (R1/R0)
- [ ] APR converts from bps to percentage (1200 → 12.00%)
- [ ] Loading state shows while fetching
- [ ] Error state displays on fetch failure
- [ ] All addresses come from `.env`
- [ ] bigint math uses proper operators

---

### 🔗 External Resources

| Resource              | Link                                                                               |
| --------------------- | ---------------------------------------------------------------------------------- |
| Uniswap V2 Whitepaper | https://uniswap.org/whitepaper.pdf                                                 |
| Ethers BigInt         | https://docs.ethers.org/v6/api/utils/maths/                                        |
| Constant Product AMM  | https://docs.uniswap.org/contracts/v2/concepts/protocol-overview/how-uniswap-works |
| React Hooks           | https://react.dev/reference/react                                                  |

---

## ✅ Test Cases

Create `__tests__/DeFiDashboard.test.js` with Jest & React Testing Library.

```js
// __tests__/DeFiDashboard.test.js
import React from "react";
import { render, screen, waitFor } from "@testing-library/react";
import DeFiDashboard from "../DeFiDashboard";
import { ethers } from "ethers";

jest.mock("ethers");

describe("DeFiDashboard Component", () => {
  const fakeReserves = [1000n, 2000n];
  const fakeSupply = 500n;
  const fakeAPR = 1200n; // 12.00%
  const fakeProvider = {};
  const fakeContract = {
    getReserves: jest.fn(),
    totalSupply: jest.fn(),
    getMockAPR: jest.fn(),
  };

  beforeAll(() => {
    process.env.REACT_APP_RPC_URL = "http://localhost";
    process.env.REACT_APP_LP_ADDRESS = "0xLP";
    ethers.JsonRpcProvider = jest.fn().mockReturnValue(fakeProvider);
    ethers.Contract = jest.fn().mockReturnValue(fakeContract);
    fakeContract.getReserves.mockResolvedValue(fakeReserves);
    fakeContract.totalSupply.mockResolvedValue(fakeSupply);
    fakeContract.getMockAPR.mockResolvedValue(fakeAPR);
    ethers.WeiPerEther = 1000000000000000000n;
    ethers.formatUnits = jest.fn((bn, dec) => {
      // price = r1*1e18/r0 = 2000*1e18/1000 = 2e18 → "2.0"
      return bn.toString() === "2000000000000000000000" ? "2.0" : "0";
    });
  });

  it("renders all DeFi data correctly", async () => {
    render(<DeFiDashboard />);
    await waitFor(() => screen.getByText(/DeFi Sim Dashboard/));
    expect(screen.getByText("Reserve0: 1000")).toBeInTheDocument();
    expect(screen.getByText("Reserve1: 2000")).toBeInTheDocument();
    expect(screen.getByText("Total Supply: 500")).toBeInTheDocument();
    expect(screen.getByText("Token0 Price: 2.0 Token1")).toBeInTheDocument();
    expect(screen.getByText("Mock APR: 12.00%")).toBeInTheDocument();
  });
});
```

jest.config.js:

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

After the online workshop, Ateneo scholars chatted excitedly: "Feels like real DeFi!" Odessa smiled as Neri raised a virtual toast. Their simulated dashboard had demystified LP analytics and APR mechanics. Next up: integrate a real price oracle, add a staking simulation, and spin up a Polygon testnet version. From simulation to mainnet—Filipino Web3 excellence marches on! 🇵🇭🪙🚀
