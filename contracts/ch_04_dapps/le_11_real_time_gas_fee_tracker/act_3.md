# PHP Estimates & Auto-Refresh activity:

```js
// GasDashboard.js - Starter Code
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = ["function getBaseFee() view returns (uint256)"];

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

```bash
# .env Configuration
REACT_APP_RPC_URL=https://sepolia.infura.io/v3/YOUR_KEY
REACT_APP_GAS_TRACKER_ADDRESS=0xYourDeployedGasTracker
```

**Time Allotment: 10 minutes**

## Tasks for students

Topics Covered: Currency conversion, auto-refresh intervals, formatUnits usage, cleanup patterns

- Update the `GasDashboard` component to:

  - Fetch base fee and calculate gas tiers (low, medium, high).
  - Convert gwei to ETH using `ethers.utils.formatUnits(tier, "gwei")`.
  - Multiply ETH values by PHP exchange rate (₱80 per ETH).
  - Set up automatic refresh every 15 seconds using `setInterval`.
  - Implement proper cleanup to clear the interval on component unmount.

  ```js
  useEffect(() => {
    const rate = 80; // mock ₱80 per ETH

    async function update() {
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
        const low = base.mul(9).div(10);
        const med = base;
        const high = base.mul(11).div(10);

        // Convert to ETH and then to PHP
        const lowEth = parseFloat(ethers.utils.formatUnits(low, "gwei"));
        const medEth = parseFloat(ethers.utils.formatUnits(med, "gwei"));
        const highEth = parseFloat(ethers.utils.formatUnits(high, "gwei"));

        setPhpRates({
          lowP: (lowEth * rate).toFixed(6),
          medP: (medEth * rate).toFixed(6),
          highP: (highEth * rate).toFixed(6),
        });
      } catch (err) {
        console.error("Error updating rates:", err);
      }
    }

    update();
    const id = setInterval(update, 15000);
    return () => clearInterval(id);
  }, []);
  ```
