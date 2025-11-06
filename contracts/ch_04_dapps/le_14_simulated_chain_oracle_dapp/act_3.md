# Activity 3: Simulate Oracle Feed

**Time**: 10 minutes  
**Goal**: Create `OracleFeed.js` to push a new wind speed reading via `updateWeather(speed)`. On `DataUpdated` or `Released` events, refresh `ReliefStats`.

## Background

Oracles provide external data to smart contracts. In this simulation, you'll manually input wind speed readings that trigger automatic fund releases when the threshold is exceeded.

## Starter Code

Create `OracleFeed.js`:

```javascript
import React, { useState } from "react";
import { ethers } from "ethers";

const ABI = ["function updateWeather(uint256)"];

export default function OracleFeed({ onFeed }) {
  const [speed, setSpeed] = useState("");
  const [error, setError] = useState("");

  async function feed() {
    try {
      // TODO: validate speed > 0
      // TODO: request accounts, get signer
      // TODO: relief = new Contract(CONTRACT, ABI, signer)
      // TODO: tx = await relief.updateWeather(speed)
      // TODO: await tx.wait(), onFeed(), clear speed
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <div>
      <h4>Simulate Weather Oracle</h4>
      <input
        value={speed}
        placeholder="Wind km/h"
        onChange={(e) => setSpeed(e.target.value)}
      />
      <button onClick={feed}>Feed Data</button>
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

## To Do List

- [ ] Validate `speed` is numeric & > 0
- [ ] `eth_requestAccounts`, get signer & contract
- [ ] Call `updateWeather(speed)`, `await tx.wait()`
- [ ] `onFeed()` to reload stats, handle clear

## Key Concepts

- **Oracle Pattern**: External data feeds into smart contracts
- **Threshold Logic**: Automatic actions triggered by data conditions
- **Event Emission**: Smart contracts emit events for frontend monitoring
- **Emergency Response**: Real-time disaster response automation

## Full Solution

```javascript
// OracleFeed.js
import React, { useState } from "react";
import { ethers } from "ethers";

const ABI = ["function updateWeather(uint256)"];
const CONTRACT = process.env.REACT_APP_RELIEF_ADDRESS;

export default function OracleFeed({ onFeed }) {
  const [speed, setSpeed] = useState("");
  const [error, setError] = useState("");

  async function feed() {
    setError("");
    if (!speed || isNaN(speed) || Number(speed) <= 0) {
      setError("Enter a valid wind speed");
      return;
    }
    try {
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const relief = new ethers.Contract(CONTRACT, ABI, signer);
      const tx = await relief.updateWeather(Number(speed));
      await tx.wait();
      setSpeed("");
      onFeed();
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <div>
      <h4>Simulate Weather Oracle</h4>
      <input
        value={speed}
        placeholder="Wind km/h"
        onChange={(e) => setSpeed(e.target.value)}
      />
      <button onClick={feed}>Feed Data</button>
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```
