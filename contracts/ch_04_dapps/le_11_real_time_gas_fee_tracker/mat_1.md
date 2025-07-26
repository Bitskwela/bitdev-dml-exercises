## 🧑‍💻 Background Story

In a sleek Silicon Valley pitch room, Odessa (“Det”) stood before investors with her laptop open on a slide: “GaslessPH: Philippine-style gas fee insights.” The room was quiet—until she clicked “Live Demo.” A clean dashboard appeared showing Low, Medium, and High gas estimates in gwei and peso equivalents. The investors leaned in.

Back in her SoMa apartment, Det had mocked data for speed—but the UI/UX felt real. Now they wanted the on-chain twist. She wrote a tiny Solidity helper that returns `block.basefee`, deployed it on Sepolia, and wired Ethers.js to fetch it. In minutes, the dashboard pulled live base fees, calculated premium tiers (low=base×0.9, med=base, high=base×1.1), and converted to PHP using a “mock” oracle rate.

By the end of the day, “GaslessPH” was more than a slide deck—it was a working MVP. Investors nodded at the clean UI, real-time updates, and Filipino flair (“₱0.50 per tx? Where do I sign?”). For Det, it was proof: Web3 experiences must feel as smooth as loading a TikTok feed. Next step—integrate real gas station APIs and layer-2 support. Mabuhay, GaslessPH! 🚀🇵🇭

---

## 📚 Theory & Web3 Lecture

1. EIP-1559 & block.basefee  
   • Since London hard fork, blocks include `basefee` (minimum gwei) for inclusion.  
   • In Solidity (`^0.8.7+`), you can read `block.basefee` in a view function.

2. Gas Price Tiers  
   • Low: basefee × 0.9 (cheapest fast inclusion)  
   • Medium: basefee (standard)  
   • High: basefee × 1.1 (priority)  
   • Use `ethers.BigNumber` math and `ethers.utils.formatUnits`.

3. Price Conversion  
   • Convert gwei to ETH: `formatUnits(gwei, "gwei")`  
   • Multiply by mock PHP/ETH rate (e.g., 80₱/ETH).  
   • Show real-time estimates in two columns.

4. React + Ethers Architecture  
   • Provider: `new ethers.providers.JsonRpcProvider(RPC_URL)`—read-only  
   • Contract: helper to fetch `basefee` on-chain  
   • Hooks:  
    – `useState` for `baseFee`, `tiers`, `error`  
    – `useEffect` for initial fetch and polling every _n_ seconds  
   • No Signer needed (read-only calls).

5. Best Practices & UX  
   • Polling interval: 10–15s to avoid rate limits  
   • Error handling: show fallback “—” on failure  
   • `.env` for RPC and contract address  
   • Clean up interval on unmount

🔗 Docs  
– Ethers.js: https://docs.ethers.org/v5/api/providers/  
– Solidity `block.basefee`: https://docs.soliditylang.org/en/latest/units-and-global-variables.html#block-and-transaction-properties  
– React Hooks: https://reactjs.org/docs/hooks-overview.html

---

## 🧪 Exercises

### Exercise 1: Deploy & Fetch Base Fee

Problem Statement  
Write a Solidity contract that exposes `block.basefee` and build a React component to read it.

**Solidity Contract (`GasTracker.sol`)**

```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract GasTracker {
    function getBaseFee() external view returns (uint256) {
        return block.basefee;
    }
}
```

**Starter Code (`GasStats.js`)**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = ["function getBaseFee() view returns (uint256)"];

export default function GasStats() {
  const [base, setBase] = useState(null);
  const [error, setError] = useState("");

  useEffect(() => {
    async function fetchBaseFee() {
      try {
        // TODO: provider = new ethers.providers.JsonRpcProvider(...)
        // TODO: contract = new ethers.Contract(addr, ABI, provider)
        // TODO: const fee = await contract.getBaseFee()
        // TODO: setBase(fee)  (BigNumber)
      } catch (err) {
        setError(err.message);
      }
    }
    fetchBaseFee();
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (base === null) return <p>Loading base fee…</p>;
  return <p>Current Base Fee: {base.toString()} gwei</p>;
}
```

**To Do List**

- [ ] Instantiate `provider` with `REACT_APP_RPC_URL`
- [ ] Create `contract` using `REACT_APP_GAS_TRACKER_ADDRESS`
- [ ] Call `getBaseFee()` and store `BigNumber` in state
- [ ] Render `base.toString()`

**Full Solution**

```js
// GasStats.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = ["function getBaseFee() view returns (uint256)"];
const RPC = process.env.REACT_APP_RPC_URL;
const ADDR = process.env.REACT_APP_GAS_TRACKER_ADDRESS;

export default function GasStats() {
  const [base, setBase] = useState(null);
  const [error, setError] = useState("");

  useEffect(() => {
    async function fetchBaseFee() {
      try {
        const provider = new ethers.providers.JsonRpcProvider(RPC);
        const tracker = new ethers.Contract(ADDR, ABI, provider);
        const fee = await tracker.getBaseFee();
        setBase(fee);
      } catch (err) {
        setError(err.message);
      }
    }
    fetchBaseFee();
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (base === null) return <p>Loading base fee…</p>;
  return (
    <div>
      <h4>Base Fee</h4>
      <p>{ethers.utils.formatUnits(base, "gwei")} gwei</p>
    </div>
  );
}
```

.env Sample

```
REACT_APP_RPC_URL=https://sepolia.infura.io/v3/YOUR_KEY
REACT_APP_GAS_TRACKER_ADDRESS=0xYourDeployedGasTracker
```

---

### Exercise 2: Calculate Low/Medium/High Tiers

Problem Statement  
Extend `GasStats` to compute Low (0.9×), Med (1×), and High (1.1×) tiers. Display each in gwei.

**Starter Code (`GasTiers.js`)**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
import GasStats from "./GasStats";

export default function GasTiers() {
  const [tiers, setTiers] = useState(null);

  useEffect(() => {
    async function calcTiers() {
      // TODO: get base (call GasStats logic or inline)
      // TODO: low = base.mul(9).div(10)
      // TODO: med = base
      // TODO: high = base.mul(11).div(10)
      // TODO: setTiers({ low, med, high })
    }
    calcTiers();
  }, []);

  if (!tiers) return <p>Calculating tiers…</p>;
  return (
    <ul>
      <li>Low: {tiers.low.toString()} gwei</li>
      <li>Medium: {tiers.med.toString()} gwei</li>
      <li>High: {tiers.high.toString()} gwei</li>
    </ul>
  );
}
```

**To Do List**

- [ ] Import or fetch `base` as `BigNumber`
- [ ] Compute `low`, `med`, `high` with `BigNumber` math
- [ ] Save to state and render

**Full Solution**

```js
// GasTiers.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
import GasStats from "./GasStats"; // or inline fetch

export default function GasTiers() {
  const [tiers, setTiers] = useState(null);

  useEffect(() => {
    async function calcTiers() {
      // Inline fetch base fee
      const provider = new ethers.providers.JsonRpcProvider(
        process.env.REACT_APP_RPC_URL
      );
      const tracker = new ethers.Contract(
        process.env.REACT_APP_GAS_TRACKER_ADDRESS,
        ["function getBaseFee() view returns (uint256)"],
        provider
      );
      const base = await tracker.getBaseFee();
      const low = base.mul(9).div(10);
      const med = base;
      const high = base.mul(11).div(10);
      setTiers({ low, med, high });
    }
    calcTiers();
  }, []);

  if (!tiers) return <p>Calculating tiers…</p>;
  return (
    <div>
      <h4>Gas Price Tiers</h4>
      <ul>
        <li>Low: {ethers.utils.formatUnits(tiers.low, "gwei")} gwei</li>
        <li>Medium: {ethers.utils.formatUnits(tiers.med, "gwei")} gwei</li>
        <li>High: {ethers.utils.formatUnits(tiers.high, "gwei")} gwei</li>
      </ul>
    </div>
  );
}
```

---

### Exercise 3: Show PHP Estimates & Auto-Refresh

Problem Statement  
Convert each tier to PHP using a mock rate (₱80/ETH). Poll every 15 seconds.

**Starter Code (`GasDashboard.js`)**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
import GasTiers from "./GasTiers";

export default function GasDashboard() {
  const [phpRates, setPhpRates] = useState(null);

  useEffect(() => {
    const rate = 80; // mock ₱80 per ETH
    async function update() {
      // TODO: fetch tiers as BigNumbers
      // TODO: convert gwei→ETH: formatUnits(gwei, "gwei")
      // TODO: multiply by rate to get PHP
      // TODO: setPhpRates({ lowP:…, medP:…, highP:… })
    }
    update();
    const id = setInterval(update, 15000);
    return () => clearInterval(id);
  }, []);

  if (!phpRates) return <p>Loading PHP estimates…</p>;
  return (
    <div>
      <h3>Gas Fee in PHP</h3>
      <p>Low: ₱{phpRates.lowP}</p>
      <p>Med: ₱{phpRates.medP}</p>
      <p>High: ₱{phpRates.highP}</p>
    </div>
  );
}
```

**To Do List**

- [ ] Poll `getBaseFee()` + compute tiers
- [ ] `ethers.utils.formatUnits(tier, "gwei")` → string ETH
- [ ] Multiply by PHP rate, round to 2 decimals
- [ ] Update state; clear interval on unmount

**Full Solution**

```js
// GasDashboard.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = ["function getBaseFee() view returns (uint256)"];
const RPC = process.env.REACT_APP_RPC_URL;
const ADDR = process.env.REACT_APP_GAS_TRACKER_ADDRESS;
const PHP_RATE = 80; // mock

export default function GasDashboard() {
  const [phpRates, setPhpRates] = useState(null);
  const provider = new ethers.providers.JsonRpcProvider(RPC);
  const tracker = new ethers.Contract(ADDR, ABI, provider);

  async function update() {
    try {
      const base = await tracker.getBaseFee();
      const lowG = base.mul(9).div(10);
      const medG = base;
      const highG = base.mul(11).div(10);
      const lowEth = parseFloat(ethers.utils.formatUnits(lowG, "gwei")) * 1e-9;
      const medEth = parseFloat(ethers.utils.formatUnits(medG, "gwei")) * 1e-9;
      const highEth =
        parseFloat(ethers.utils.formatUnits(highG, "gwei")) * 1e-9;
      const lowP = (lowEth * PHP_RATE).toFixed(2);
      const medP = (medEth * PHP_RATE).toFixed(2);
      const highP = (highEth * PHP_RATE).toFixed(2);
      setPhpRates({ lowP, medP, highP });
    } catch (err) {
      console.error(err);
    }
  }

  useEffect(() => {
    update();
    const id = setInterval(update, 15000);
    return () => clearInterval(id);
  }, []);

  if (!phpRates) return <p>Loading PHP estimates…</p>;
  return (
    <div>
      <h3>Gas Fee in PHP</h3>
      <p>Low: ₱{phpRates.lowP}</p>
      <p>Med: ₱{phpRates.medP}</p>
      <p>High: ₱{phpRates.highP}</p>
    </div>
  );
}
```

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
