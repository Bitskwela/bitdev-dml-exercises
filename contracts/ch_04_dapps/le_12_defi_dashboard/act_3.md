# Activity 3: Display Mock APR & Full Dashboard

**Time**: 10 minutes  
**Goal**: Build a `DeFiDashboard` component that fetches reserves, price, total supply, and `mockAPR` (bps). Show a combined card with all DeFi metrics.

## Background

A comprehensive DeFi dashboard should display:

- **Reserves**: Available liquidity for each token
- **Price**: Current exchange rate between tokens
- **Total Supply**: Total LP tokens in circulation
- **APR**: Annual Percentage Rate for yield farming (basis points → percentage)

## Starter Code

Create `DeFiDashboard.js`:

```javascript
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

## To Do List

- [ ] Fetch `getReserves`, `getTotalSupply`, `getMockAPR` in parallel
- [ ] Compute `priceBn = r1.mul(1e18).div(r0)`, format to string
- [ ] Convert `aprBps` to percent: `(aprBps.toNumber()/100).toFixed(2)`
- [ ] Render in a styled card with all metrics

## Key Concepts

- **Basis Points**: 1 bps = 0.01%, so 500 bps = 5.00%
- **Promise.all()**: Fetch multiple contract calls efficiently
- **Dashboard Design**: Clean, scannable layout for financial data

## Full Solution

```javascript
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
