# Activity 1: Build ReliefStats Component

**Time**: 10 minutes  
**Goal**: Create `ReliefStats.js` that reads and displays on-chain wind speed, contract ETH balance, and release status from a typhoon relief smart contract.

## Solidity Contract Baseline

Deploy this `TyphoonReliefChain.sol` contract first:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TyphoonReliefChain {
    uint256 public threshold;      // km/h
    uint256 public windSpeed;      // latest reading
    address payable public beneficiary;
    bool public released;

    event DataUpdated(uint256 windSpeed);
    event Released(address beneficiary, uint256 amount);

    constructor(uint256 _threshold, address payable _beneficiary) {
        threshold = _threshold;
        beneficiary = _beneficiary;
    }

    // Donate ETH to pool
    function donate() external payable {}

    // Update weather reading (simulated oracle)
    function updateWeather(uint256 _speed) external {
        windSpeed = _speed;
        emit DataUpdated(_speed);
        if (!released && windSpeed >= threshold) {
            released = true;
            uint256 bal = address(this).balance;
            beneficiary.transfer(bal);
            emit Released(beneficiary, bal);
        }
    }
}
```

## Starter Code

Create `ReliefStats.js`:

```javascript
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function windSpeed() view returns (uint256)",
  "function released() view returns (bool)",
];

export default function ReliefStats() {
  const [wind, setWind] = useState(null);
  const [balance, setBalance] = useState(null);
  const [released, setReleased] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadStats() {
      try {
        // TODO: provider = new ethers.providers.Web3Provider(window.ethereum)
        // TODO: relief = new ethers.Contract(CONTRACT_ADDRESS, ABI, provider)
        // TODO: ws = await relief.windSpeed()
        // TODO: rel = await relief.released()
        // TODO: bal = await provider.getBalance(CONTRACT_ADDRESS)
        // TODO: setWind(ws.toNumber()), setReleased(rel), setBalance(ethers.utils.formatEther(bal))
      } catch (err) {
        setError(err.message);
      }
    }
    loadStats();
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (wind === null) return <p>Loading relief stats…</p>;
  return (
    <div>
      <h3>Typhoon Relief Chain Stats</h3>
      <p>Wind Speed: {wind} km/h</p>
      <p>Pool Balance: {balance} ETH</p>
      <p>Released: {released ? "✅ Funds Dispatched" : "❌ Pending"}</p>
    </div>
  );
}
```

## To Do List

- [ ] Instantiate `provider = new ethers.providers.Web3Provider(window.ethereum)`
- [ ] Relief contract: `new ethers.Contract(address, ABI, provider)`
- [ ] Call `windSpeed()` & `released()`
- [ ] `provider.getBalance(address)` for ETH balance
- [ ] Update state with parsed values

## Key Concepts

- **Oracle Pattern**: Smart contract receives external data (weather readings)
- **Conditional Logic**: Automatic fund release based on threshold conditions
- **Balance Queries**: Reading contract ETH balance vs. token balances
- **Emergency Relief**: Blockchain-based disaster response systems

## Full Solution

```javascript
// ReliefStats.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function windSpeed() view returns (uint256)",
  "function released() view returns (bool)",
];
const RPC = process.env.REACT_APP_RPC_URL;
const CONTRACT = process.env.REACT_APP_RELIEF_ADDRESS;

export default function ReliefStats() {
  const [wind, setWind] = useState(null);
  const [balance, setBalance] = useState(null);
  const [released, setReleased] = useState(false);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadStats() {
      try {
        await window.ethereum.request({ method: "eth_requestAccounts" });
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const relief = new ethers.Contract(CONTRACT, ABI, provider);
        const [ws, rel] = await Promise.all([
          relief.windSpeed(),
          relief.released(),
        ]);
        const bal = await provider.getBalance(CONTRACT);
        setWind(ws.toNumber());
        setReleased(rel);
        setBalance(ethers.utils.formatEther(bal));
      } catch (err) {
        setError(err.message);
      }
    }
    loadStats();
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  if (wind === null) return <p>Loading relief stats…</p>;
  return (
    <div>
      <h3>Typhoon Relief Chain Stats</h3>
      <p>
        Wind Speed: <strong>{wind}</strong> km/h
      </p>
      <p>
        Pool Balance: <strong>{balance}</strong> ETH
      </p>
      <p>
        Released: <strong>{released ? "✅" : "❌"}</strong>
      </p>
    </div>
  );
}
```
