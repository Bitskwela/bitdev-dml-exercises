# Calculate Gas Tiers activity:

```js
// GasTiers.js - Starter Code
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = ["function getBaseFee() view returns (uint256)"];

export default function GasTiers() {
  const [tiers, setTiers] = useState(null);

  useEffect(() => {
    async function calcTiers() {
      // TODO: get base (call contract or inline)
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

```bash
# .env Configuration
REACT_APP_RPC_URL=https://sepolia.infura.io/v3/YOUR_KEY
REACT_APP_GAS_TRACKER_ADDRESS=0xYourDeployedGasTracker
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: BigNumber arithmetic, gas tier calculations, multipliers and division

- Update the `GasTiers` component to:

  - Fetch the base fee from the GasTracker contract.
  - Compute Low tier as 90% of base fee using `base.mul(9).div(10)`.
  - Set Medium tier as the base fee itself.
  - Compute High tier as 110% of base fee using `base.mul(11).div(10)`.
  - Store all tiers in component state and display them properly.

  ```js
  useEffect(() => {
    async function calcTiers() {
      try {
        const provider = new ethers.providers.JsonRpcProvider(
          process.env.REACT_APP_RPC_URL
        );
        const contract = new ethers.Contract(
          process.env.REACT_APP_GAS_TRACKER_ADDRESS,
          ABI,
          provider
        );

        const base = await contract.getBaseFee();
        const low = base.mul(9).div(10); // 90%
        const med = base; // 100%
        const high = base.mul(11).div(10); // 110%

        setTiers({ low, med, high });
      } catch (err) {
        console.error("Error calculating tiers:", err);
      }
    }
    calcTiers();
  }, []);
  ```
