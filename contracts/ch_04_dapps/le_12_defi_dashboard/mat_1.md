## 🧑‍💻 Background Story

In a virtual workshop hosted by Ateneo’s Blockchain Society, Neri was ready to impress. She’d sketched out a DeFi staking dashboard—“Simulated, pero feels real”—and turned to Odessa (“Det”) to wire up the frontend. Their goal: show LP token data (reserves, total supply), compute token prices, and display a mocked APR, all without a production protocol.

Using Hardhat, Neri deployed a tiny `MockLP` contract on a local network. It stored two token reserves (e.g., USDC and TKO), a total supply, and a fixed APR (in basis points). Now Det would build a clean React + Ethers.js dashboard:

1. Fetch `getReserves()` and `getTotalSupply()`
2. Compute Token0’s price in Token1 (reserve1 / reserve0)
3. Read `getMockAPR()` (e.g. 1 200 = 12.00 %)
4. Display all with friendly formatting

In under 30 minutes, Det had a “DeFi Sim” UI: a card for reserves, a badge for price, and a progress bar for APR. Ateneo scholars clicked “Refresh,” and the numbers updated in real time. No real staking, no live oracles—just smart design, Filipino grit, and a taste of what DeFi dashboards can be. Mabuhay simulations, next stop: on-chain rewards! 🇵🇭🪙🚀

---

## 📚 Theory & Web3 Lecture

1. Mock LP Token Pattern

   - `getReserves()` returns `(reserve0, reserve1)` as `uint112`.
   - `getTotalSupply()` returns total LP tokens minted (`uint256`).
   - `getMockAPR()` returns APR in basis points (bps): 100 bps = 1 %.

2. Ethers.js Basics

   - Provider: read-only via `new ethers.providers.JsonRpcProvider(RPC_URL)`
   - Contract: `new ethers.Contract(address, ABI, provider)`
   - BigNumber math:  
     • Division: `reserve1.mul(ONE).div(reserve0)`  
     • Formatting: `ethers.utils.formatUnits(bn, decimals)`

3. Price Calculation

   - Token0 price in Token1 = `reserve1 / reserve0`
   - Use a constant scale factor (e.g. 1e18) to preserve precision.

4. APR Conversion

   - APR in bps → percent: `aprBps / 100`
   - Format to two decimals in UI.

5. React Architecture

   - `useState` for `reserves`, `supply`, `price`, `apr`
   - `useEffect` to fetch on mount & on “Refresh” clicks
   - Error handling with `try/catch`

6. Best Practices
   - Store `RPC_URL` and `LP_ADDRESS` in `.env`
   - Validate contract address with `ethers.utils.isAddress()`
   - Clean up intervals if polling
   - Catch and display errors in UI

🔗 Resources  
– Ethers.js docs: https://docs.ethers.org/v5  
– BigNumber: https://docs.ethers.org/v5/api/utils/bignumber/  
– React Hooks: https://reactjs.org/docs/hooks-intro.html

---

## 🧪 Exercises

### Exercise 1: Fetch LP Reserves & Total Supply

Problem Statement  
Build a React component that connects to your local Hardhat network, reads `reserve0`, `reserve1`, and `totalSupply` from `MockLP`, and displays them.

**Solidity Contract (`MockLP.sol`)**

```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MockLP {
    uint112 private reserve0;
    uint112 private reserve1;
    uint256 public totalSupply;
    uint256 public mockAPR; // in basis points

    constructor(
        uint112 _r0,
        uint112 _r1,
        uint256 _aprBps,
        uint256 _totalSupply
    ) {
        reserve0 = _r0;
        reserve1 = _r1;
        mockAPR = _aprBps;
        totalSupply = _totalSupply;
    }

    function getReserves() external view returns (uint112, uint112) {
        return (reserve0, reserve1);
    }

    function getTotalSupply() external view returns (uint256) {
        return totalSupply;
    }

    function getMockAPR() external view returns (uint256) {
        return mockAPR;
    }
}
```

**Starter Code (`LPStats.js`)**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getReserves() view returns (uint112, uint112)",
  "function getTotalSupply() view returns (uint256)",
];

export default function LPStats() {
  const [reserves, setReserves] = useState({ r0: null, r1: null });
  const [supply, setSupply] = useState(null);
  const [error, setError] = useState("");

  useEffect(() => {
    async function fetchStats() {
      try {
        // TODO: provider = new ethers.providers.JsonRpcProvider(RPC_URL)
        // TODO: contract = new ethers.Contract(LP_ADDRESS, ABI, provider)
        // TODO: [r0, r1] = await contract.getReserves()
        // TODO: ts = await contract.getTotalSupply()
        // TODO: setReserves({ r0, r1 }); setSupply(ts)
      } catch (err) {
        setError(err.message);
      }
    }
    fetchStats();
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (reserves.r0 === null) return <p>Loading LP data…</p>;
  return (
    <div>
      <h3>LP Reserves & Supply</h3>
      <p>Reserve0: {reserves.r0.toString()}</p>
      <p>Reserve1: {reserves.r1.toString()}</p>
      <p>Total Supply: {supply.toString()}</p>
    </div>
  );
}
```

To Do List

- [ ] Initialize provider with `process.env.REACT_APP_RPC_URL`.
- [ ] Validate `LP_ADDRESS`.
- [ ] Instantiate contract and call `getReserves()` and `getTotalSupply()`.
- [ ] Update state.

**Full Solution**

```js
// LPStats.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getReserves() view returns (uint112, uint112)",
  "function getTotalSupply() view returns (uint256)",
];
const RPC = process.env.REACT_APP_RPC_URL;
const LP_ADDRESS = process.env.REACT_APP_LP_ADDRESS;

export default function LPStats() {
  const [reserves, setReserves] = useState({ r0: null, r1: null });
  const [supply, setSupply] = useState(null);
  const [error, setError] = useState("");

  useEffect(() => {
    async function fetchStats() {
      try {
        if (!ethers.utils.isAddress(LP_ADDRESS)) {
          throw new Error("Invalid LP contract address");
        }
        const provider = new ethers.providers.JsonRpcProvider(RPC);
        const lp = new ethers.Contract(LP_ADDRESS, ABI, provider);
        const [r0, r1] = await lp.getReserves();
        const ts = await lp.getTotalSupply();
        setReserves({ r0, r1 });
        setSupply(ts);
      } catch (err) {
        setError(err.message);
      }
    }
    fetchStats();
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (reserves.r0 === null) return <p>Loading LP data…</p>;
  return (
    <div>
      <h3>LP Reserves & Supply</h3>
      <p>Reserve0: {reserves.r0.toString()}</p>
      <p>Reserve1: {reserves.r1.toString()}</p>
      <p>Total Supply: {supply.toString()}</p>
    </div>
  );
}
```

.env Sample

```
REACT_APP_RPC_URL=http://127.0.0.1:8545
REACT_APP_LP_ADDRESS=0xYourMockLPAddress
```

---

### Exercise 2: Compute Token0 Price

Problem Statement  
Extend `LPStats` to compute Token0’s price in Token1 as `reserve1 / reserve0`, using 18-decimal scaling, and display a human-readable price.

**Starter Code (`LPPrice.js`)**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
import LPStats from "./LPStats";

export default function LPPrice() {
  const [price, setPrice] = useState(null);

  useEffect(() => {
    async function calcPrice() {
      // TODO: reuse fetch from LPStats or inline provider & contract
      // TODO: compute price = reserve1.mul(scale).div(reserve0)
      // TODO: formatted = ethers.utils.formatUnits(priceBn, 18)
      // TODO: setPrice(formatted)
    }
    calcPrice();
  }, []);

  if (price === null) return <p>Calculating price…</p>;
  return <p>Token0 Price: {price} Token1</p>;
}
```

To Do List

- [ ] Fetch `reserve0` and `reserve1` as `BigNumber`.
- [ ] Use a scale of `1e18` (`const ONE = ethers.constants.WeiPerEther`).
- [ ] `priceBn = reserve1.mul(ONE).div(reserve0)`.
- [ ] Format with `formatUnits(priceBn, 18)`.

**Full Solution**

```js
// LPPrice.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = ["function getReserves() view returns (uint112, uint112)"];
const RPC = process.env.REACT_APP_RPC_URL;
const LP_ADDRESS = process.env.REACT_APP_LP_ADDRESS;

export default function LPPrice() {
  const [price, setPrice] = useState(null);

  useEffect(() => {
    async function calcPrice() {
      const provider = new ethers.providers.JsonRpcProvider(RPC);
      const lp = new ethers.Contract(LP_ADDRESS, ABI, provider);
      const [r0, r1] = await lp.getReserves();
      const ONE = ethers.constants.WeiPerEther; // 1e18
      const priceBn = r1.mul(ONE).div(r0);
      const formatted = ethers.utils.formatUnits(priceBn, 18);
      setPrice(formatted);
    }
    calcPrice();
  }, []);

  if (price === null) return <p>Calculating price…</p>;
  return (
    <div>
      <h3>Token0 Price</h3>
      <p>{price} Token1</p>
    </div>
  );
}
```

---

### Exercise 3: Display Mock APR & Full Dashboard

Problem Statement  
Build a `DeFiDashboard` component that fetches reserves, price, total supply, and `mockAPR` (bps). Show a combined card:

- Reserves (r0, r1)
- Price (Token0 in Token1)
- Total Supply
- APR: (bps / 100).toFixed(2) + “%”

**Starter Code (`DeFiDashboard.js`)**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getReserves() view returns (uint112, uint112)",
  "function getTotalSupply() view returns (uint256)",
  "function getMockAPR() view returns (uint256)",
];

export default function DeFiDashboard() {
  const [data, setData] = useState(null);

  useEffect(() => {
    async function loadAll() {
      // TODO: provider & contract
      // TODO: [r0,r1] = await contract.getReserves()
      // TODO: ts = await contract.getTotalSupply()
      // TODO: aprBps = await contract.getMockAPR()
      // TODO: price calc (as prior)
      // TODO: setData({ r0, r1, ts, price, aprBps })
    }
    loadAll();
  }, []);

  if (!data) return <p>Loading dashboard…</p>;
  return (
    <div>
      <h2>DeFi Sim Dashboard</h2>
      {/* display data.r0, data.r1, data.ts, data.price, data.apr */}
    </div>
  );
}
```

To Do List

- [ ] Fetch `getReserves`, `getTotalSupply`, `getMockAPR`.
- [ ] Compute `priceBn = r1.mul(1e18).div(r0)`, format to string.
- [ ] Convert `aprBps` to percent: `(aprBps.toNumber()/100).toFixed(2)`.
- [ ] Render in a styled card.

**Full Solution**

```js
// DeFiDashboard.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getReserves() view returns (uint112, uint112)",
  "function getTotalSupply() view returns (uint256)",
  "function getMockAPR() view returns (uint256)",
];
const RPC = process.env.REACT_APP_RPC_URL;
const LP_ADDRESS = process.env.REACT_APP_LP_ADDRESS;

export default function DeFiDashboard() {
  const [data, setData] = useState(null);

  useEffect(() => {
    async function loadAll() {
      const provider = new ethers.providers.JsonRpcProvider(RPC);
      const lp = new ethers.Contract(LP_ADDRESS, ABI, provider);
      const [[r0, r1], ts, aprBps] = await Promise.all([
        lp.getReserves(),
        lp.getTotalSupply(),
        lp.getMockAPR(),
      ]);
      const ONE = ethers.constants.WeiPerEther;
      const priceBn = r1.mul(ONE).div(r0);
      const price = ethers.utils.formatUnits(priceBn, 18);
      const apr = (aprBps.toNumber() / 100).toFixed(2);
      setData({
        reserve0: r0.toString(),
        reserve1: r1.toString(),
        totalSupply: ts.toString(),
        price,
        apr,
      });
    }
    loadAll();
  }, []);

  if (!data) return <p>Loading dashboard…</p>;
  return (
    <div style={{ border: "1px solid #ccc", padding: 16, maxWidth: 400 }}>
      <h2>DeFi Sim Dashboard</h2>
      <p>Reserve0: {data.reserve0}</p>
      <p>Reserve1: {data.reserve1}</p>
      <p>Total Supply: {data.totalSupply}</p>
      <p>Token0 Price: {data.price} Token1</p>
      <p>Mock APR: {data.apr}%</p>
      <button onClick={() => window.location.reload()}>Refresh</button>
    </div>
  );
}
```

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
  const fakeReserves = [
    ethers.BigNumber.from("1000"),
    ethers.BigNumber.from("2000"),
  ];
  const fakeSupply = ethers.BigNumber.from("500");
  const fakeAPR = ethers.BigNumber.from("1200"); // 12.00%
  const fakeProvider = {};
  const fakeContract = {
    getReserves: jest.fn(),
    getTotalSupply: jest.fn(),
    getMockAPR: jest.fn(),
  };

  beforeAll(() => {
    process.env.REACT_APP_RPC_URL = "http://localhost";
    process.env.REACT_APP_LP_ADDRESS = "0xLP";
    ethers.providers.JsonRpcProvider = jest.fn().mockReturnValue(fakeProvider);
    ethers.Contract = jest.fn().mockReturnValue(fakeContract);
    fakeContract.getReserves.mockResolvedValue(fakeReserves);
    fakeContract.getTotalSupply.mockResolvedValue(fakeSupply);
    fakeContract.getMockAPR.mockResolvedValue(fakeAPR);
    ethers.constants.WeiPerEther = ethers.BigNumber.from("1000000000000000000");
    ethers.utils.formatUnits = jest.fn((bn, dec) => {
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

After the online workshop, Ateneo scholars chatted excitedly: “Feels like real DeFi!” Odessa smiled as Neri raised a virtual toast. Their simulated dashboard had demystified LP analytics and APR mechanics. Next up: integrate a real price oracle, add a staking simulation, and spin up a Polygon testnet version. From simulation to mainnet—Filipino Web3 excellence marches on! 🇵🇭🪙🚀
