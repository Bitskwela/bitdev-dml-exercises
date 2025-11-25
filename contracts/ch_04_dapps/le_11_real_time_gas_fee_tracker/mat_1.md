## 🧑‍💻 Background Story

In a sleek Silicon Valley pitch room, Odessa (“Det”) stood before investors with her laptop open on a slide: “GaslessPH: Philippine-style gas fee insights.” The room was quiet—until she clicked “Live Demo.” A clean dashboard appeared showing Low, Medium, and High gas estimates in gwei and peso equivalents. The investors leaned in.

Back in her SoMa apartment, Det had mocked data for speed—but the UI/UX felt real. Now they wanted the on-chain twist. She wrote a tiny Solidity helper that returns `block.basefee`, deployed it on Sepolia, and wired Ethers.js to fetch it. In minutes, the dashboard pulled live base fees, calculated premium tiers (low=base×0.9, med=base, high=base×1.1), and converted to PHP using a “mock” oracle rate.

By the end of the day, “GaslessPH” was more than a slide deck—it was a working MVP. Investors nodded at the clean UI, real-time updates, and Filipino flair (“₱0.50 per tx? Where do I sign?”). For Det, it was proof: Web3 experiences must feel as smooth as loading a TikTok feed. Next step—integrate real gas station APIs and layer-2 support. Mabuhay, GaslessPH! 🚀🇵🇭

---

## 📚 Theory & Web3 Lecture

### 🎯 What You'll Learn

In this lesson, you'll build a **real-time gas fee tracker** that fetches live `block.basefee` from the blockchain and displays tiered gas estimates with Philippine Peso conversions. This teaches you essential concepts for building responsive, data-driven DApps.

---

### 📐 Gas Fee Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    GAS FEE TRACKER FLOW                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ┌──────────────┐     ┌──────────────┐     ┌──────────────┐   │
│   │   Ethereum   │────▶│  GasTracker  │────▶│    React     │   │
│   │   Network    │     │   Contract   │     │      UI      │   │
│   └──────────────┘     └──────────────┘     └──────────────┘   │
│          │                    │                    │            │
│          ▼                    ▼                    ▼            │
│   ┌──────────────┐     ┌──────────────┐     ┌──────────────┐   │
│   │ block.basefee│     │ getBaseFee() │     │  Tier Cards  │   │
│   │  (in gwei)   │     │    view fn   │     │ Low/Med/High │   │
│   └──────────────┘     └──────────────┘     └──────────────┘   │
│                                                     │           │
│                              ┌──────────────────────┘           │
│                              ▼                                  │
│                       ┌──────────────┐                          │
│                       │ PHP Estimate │                          │
│                       │  (mock rate) │                          │
│                       └──────────────┘                          │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

### 🔑 Key Concepts

#### 1. EIP-1559 & `block.basefee`

Since the **London Hard Fork** (August 2021), Ethereum uses EIP-1559 for gas pricing:

| Component | Description |
|-----------|-------------|
| **Base Fee** | Minimum gwei required for block inclusion (burned) |
| **Priority Fee** | Tip to validators for faster inclusion |
| **Max Fee** | Maximum total fee user is willing to pay |

```
Total Gas Cost = (Base Fee + Priority Fee) × Gas Used
```

In Solidity (`^0.8.7+`), you can access the base fee directly:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract GasTracker {
    // Returns the current block's base fee in wei
    function getBaseFee() external view returns (uint256) {
        return block.basefee;
    }
}
```

#### 2. Gas Price Tiers

Different urgency levels require different fee multipliers:

| Tier | Multiplier | Use Case |
|------|------------|----------|
| 🐢 **Low** | basefee × 0.9 | Not urgent, can wait 5-10 blocks |
| 🚗 **Medium** | basefee × 1.0 | Standard, next 1-3 blocks |
| 🚀 **High** | basefee × 1.1 | Urgent, next block priority |

```javascript
// Calculate tier prices from base fee
const baseFeeGwei = ethers.utils.formatUnits(baseFee, "gwei");
const low = parseFloat(baseFeeGwei) * 0.9;
const medium = parseFloat(baseFeeGwei);
const high = parseFloat(baseFeeGwei) * 1.1;
```

#### 3. Unit Conversions

Ethereum uses multiple denomination scales:

| Unit | Wei Value | Common Use |
|------|-----------|------------|
| **Wei** | 1 | Smallest unit, internal math |
| **Gwei** | 10⁹ wei | Gas prices |
| **Ether** | 10¹⁸ wei | Token amounts |

```javascript
// Converting between units with ethers.js
const gweiValue = ethers.utils.formatUnits(weiValue, "gwei");     // wei → gwei
const etherValue = ethers.utils.formatUnits(weiValue, "ether");   // wei → ether
const weiFromGwei = ethers.utils.parseUnits("50", "gwei");        // gwei → wei
```

#### 4. Price Conversion to PHP

To show costs in Philippine Peso:

```javascript
// Mock exchange rate (in production, use Chainlink or CoinGecko API)
const PHP_PER_ETH = 180000; // ₱180,000 per ETH

// Convert gwei to PHP
function gweiToPhp(gwei, gasLimit = 21000) {
    const ethCost = (gwei * gasLimit) / 1e9;  // gwei to ETH
    return ethCost * PHP_PER_ETH;
}

// Example: 50 gwei × 21000 gas = 0.00105 ETH ≈ ₱189
```

---

### 🏗️ React + Ethers.js Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    COMPONENT STRUCTURE                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │                    GasDashboard                         │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │ useState: baseFee, tiers, phpRate, error        │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   │                         │                               │   │
│   │  ┌──────────────────────┼──────────────────────────┐    │   │
│   │  │                      ▼                          │    │   │
│   │  │  useEffect (mount + interval)                   │    │   │
│   │  │  ├── Create Provider (JsonRpcProvider)          │    │   │
│   │  │  ├── Create Contract instance                   │    │   │
│   │  │  ├── Fetch baseFee every 15s                    │    │   │
│   │  │  └── Calculate tiers                            │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   │                                                         │   │
│   │  ┌───────────┐  ┌───────────┐  ┌───────────┐           │   │
│   │  │ TierCard  │  │ TierCard  │  │ TierCard  │           │   │
│   │  │   Low 🐢  │  │  Med 🚗   │  │  High 🚀  │           │   │
│   │  │  90 gwei  │  │ 100 gwei  │  │ 110 gwei  │           │   │
│   │  │  ₱171.00  │  │  ₱190.00  │  │  ₱209.00  │           │   │
│   │  └───────────┘  └───────────┘  └───────────┘           │   │
│   └─────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

#### Provider Setup (Read-Only)

```javascript
import { ethers } from "ethers";

// No wallet needed - just reading data
const provider = new ethers.providers.JsonRpcProvider(
    process.env.REACT_APP_RPC_URL
);

const contract = new ethers.Contract(
    process.env.REACT_APP_GAS_TRACKER_ADDRESS,
    GAS_TRACKER_ABI,
    provider  // Read-only, no signer
);
```

#### Polling Pattern with useEffect

```javascript
useEffect(() => {
    const fetchGasData = async () => {
        try {
            const baseFee = await contract.getBaseFee();
            setBaseFee(baseFee);
            calculateTiers(baseFee);
        } catch (err) {
            setError("Failed to fetch gas data");
        }
    };

    // Initial fetch
    fetchGasData();

    // Poll every 15 seconds
    const interval = setInterval(fetchGasData, 15000);

    // Cleanup on unmount
    return () => clearInterval(interval);
}, []);
```

---

### 📊 Comparison: Polling vs Event-Driven

| Approach | Pros | Cons | Best For |
|----------|------|------|----------|
| **Polling** | Simple, predictable | Wastes calls if no change | Gas prices, balances |
| **Events** | Real-time, efficient | More complex setup | User transactions |
| **Hybrid** | Best of both | More code | Production DApps |

For gas tracking, **polling every 10-15 seconds** is ideal since base fee changes every block (~12s).

---

### ⚠️ Common Mistakes

| Mistake | Problem | Solution |
|---------|---------|----------|
| Polling too fast | Rate limiting, wasted calls | Use 10-15s intervals |
| Not cleaning up intervals | Memory leaks | Return cleanup fn in useEffect |
| Hardcoding RPC URL | Security risk | Use `.env` file |
| Ignoring errors | Silent failures | Show fallback UI ("—") |
| Wrong unit conversion | Incorrect prices | Always use `formatUnits` |

---

### ✅ Testing Checklist

Before considering this lesson complete, verify:

- [ ] Base fee displays in gwei format
- [ ] All three tiers calculate correctly (×0.9, ×1.0, ×1.1)
- [ ] PHP estimates update when base fee changes
- [ ] Polling updates every 15 seconds
- [ ] Error state shows "—" or fallback message
- [ ] Interval cleans up on component unmount
- [ ] RPC URL is in `.env`, not hardcoded

---

### 🔗 External Resources

| Resource | Link |
|----------|------|
| EIP-1559 Specification | https://eips.ethereum.org/EIPS/eip-1559 |
| Ethers.js Providers | https://docs.ethers.org/v5/api/providers/ |
| Solidity Global Variables | https://docs.soliditylang.org/en/latest/units-and-global-variables.html |
| React useEffect Cleanup | https://react.dev/learn/synchronizing-with-effects#how-to-handle-the-effect-firing-twice-in-development |



---

## ✅ Test Cases

Create `__tests__/GasDashboard.test.js`:

```js
// __tests__/GasDashboard.test.js
import React from "react";
import { render, screen, waitFor } from "@testing-library/react";
import GasDashboard from "../GasDashboard";
import { ethers } from "ethers";

jest.mock("ethers");

describe("GasDashboard Component", () => {
  const mockBase = ethers.BigNumber.from("100"); // 100 gwei
  const mockProvider = {};
  const mockContract = { getBaseFee: jest.fn() };

  beforeAll(() => {
    global.process.env.REACT_APP_RPC_URL = "http://localhost";
    global.process.env.REACT_APP_GAS_TRACKER_ADDRESS = "0xGas";
    ethers.providers.JsonRpcProvider = jest.fn().mockReturnValue(mockProvider);
    ethers.Contract = jest.fn().mockReturnValue(mockContract);
    mockContract.getBaseFee.mockResolvedValue(mockBase);
  });

  it("calculates PHP estimates correctly", async () => {
    render(<GasDashboard />);
    // Low = 100*0.9=90 gwei → 90×1e-9 ETH = 9e-8 ETH → ₱80×9e-8 = ₱0.00
    await waitFor(() => screen.getByText(/Low:/i));
    expect(screen.getByText("Low: ₱0.00")).toBeInTheDocument();
    // Medium
    expect(screen.getByText("Med: ₱0.00")).toBeInTheDocument();
    // High = 110 gwei...
    expect(screen.getByText("High: ₱0.00")).toBeInTheDocument();
  });
});
```

In `jest.config.js`:

```js
module.exports = {
  testEnvironment: "jsdom",
  moduleNameMapper: { "\\.(css|scss)$": "identity-obj-proxy" },
};
```

---

## 🌟 Closing Story

Investors in SV tapped their phones at Odessa’s demo: real-time gas fees, clear PHP costs, and a path to “gasless” user experiences. Next up, she’ll wire in multiple networks (BSC, Polygon), fetch live Chainlink price feeds, and prototype fee subsidy wallets. GaslessPH is just warming up—mabuhay innovation, one gwei at a time! 🇵🇭🔥🚀
