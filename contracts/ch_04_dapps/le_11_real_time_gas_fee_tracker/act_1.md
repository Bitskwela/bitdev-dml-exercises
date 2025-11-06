# Deploy & Fetch Base Fee activity:

```solidity
// GasTracker.sol - Contract Baseline
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract GasTracker {
    function getBaseFee() external view returns (uint256) {
        return block.basefee;
    }
}
```

```js
// GasStats.js - Starter Code
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

```bash
# .env Configuration
REACT_APP_RPC_URL=https://sepolia.infura.io/v3/YOUR_KEY
REACT_APP_GAS_TRACKER_ADDRESS=0xYourDeployedGasTracker
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: block.basefee access, contract deployment, BigNumber handling, error management

- Update the `GasStats` component to:

  - Instantiate `provider` with `REACT_APP_RPC_URL` from environment variables.
  - Create `contract` instance using `REACT_APP_GAS_TRACKER_ADDRESS` and ABI.
  - Call `getBaseFee()` and store the returned `BigNumber` in component state.
  - Handle loading states and error scenarios properly.
  - Render the base fee using `base.toString()` for display.

  ```js
  useEffect(() => {
    async function fetchBaseFee() {
      try {
        const provider = new ethers.providers.JsonRpcProvider(
          process.env.REACT_APP_RPC_URL
        );
        const contract = new ethers.Contract(
          process.env.REACT_APP_GAS_TRACKER_ADDRESS,
          ABI,
          provider
        );
        const fee = await contract.getBaseFee();
        setBase(fee);
      } catch (err) {
        setError(err.message);
      }
    }
    fetchBaseFee();
  }, []);
  ```
