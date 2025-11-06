# Activity 1: Fetch LP Reserves & Total Supply

**Time**: 10 minutes  
**Goal**: Build a React component that connects to your local Hardhat network, reads `reserve0`, `reserve1`, and `totalSupply` from `MockLP`, and displays them.

## Solidity Contract Baseline

Deploy this `MockLP.sol` contract first:

```solidity
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

## Starter Code

Create `LPStats.js`:

```javascript
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

## To Do List

- [ ] Initialize provider with `process.env.REACT_APP_RPC_URL`
- [ ] Validate `LP_ADDRESS`
- [ ] Instantiate contract and call `getReserves()` and `getTotalSupply()`
- [ ] Update state with fetched values

## Environment Setup

`.env` file:

```
REACT_APP_RPC_URL=http://127.0.0.1:8545
REACT_APP_LP_ADDRESS=0xYourMockLPAddress
```

## Full Solution

```javascript
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
