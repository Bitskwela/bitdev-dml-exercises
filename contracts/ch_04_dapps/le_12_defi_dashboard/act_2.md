# Activity 2: Compute Token0 Price

**Time**: 10 minutes  
**Goal**: Extend `LPStats` to compute Token0's price in Token1 as `reserve1 / reserve0`, using 18-decimal scaling, and display a human-readable price.

## Background

In DeFi liquidity pools, token prices are determined by the ratio of reserves:

- Price of Token0 (in Token1) = reserve1 / reserve0
- Use BigNumber arithmetic with 18-decimal precision for accuracy
- Format the result to human-readable decimal format

## Starter Code

Create `LPPrice.js`:

```javascript
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

## To Do List

- [ ] Fetch `reserve0` and `reserve1` as `BigNumber`
- [ ] Use a scale of `1e18` (`const ONE = ethers.constants.WeiPerEther`)
- [ ] Calculate `priceBn = reserve1.mul(ONE).div(reserve0)`
- [ ] Format with `formatUnits(priceBn, 18)` for display

## Key Concepts

- **BigNumber Math**: Prevents precision loss in JavaScript number operations
- **18-decimal scaling**: Standard for DeFi price calculations
- **Reserve ratio**: Core AMM (Automated Market Maker) pricing mechanism

## Full Solution

```javascript
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
