## 🧑‍💻 Background Story

A week after Typhoon Ulysses swept through Cagayan Valley, Odessa (“Det”) sat in her BGC co-working nook, watching relief convoys slow to a crawl. “What if donations automatically release when a storm hits threshold?” she mused. Neri grinned: “Let’s simulate an oracle feeding wind-speed data on-chain.”

By midnight, they had `TyphoonReliefChain.sol` deployed on a local Hardhat network. It held a donation pool and a threshold wind speed. When the mocked oracle pushed a reading above that threshold, the contract would auto-release funds to the barangay relief fund. No messy back-ends—just a simulated oracle call via `updateWeather`.

Odessa scaffolded a React app with three widgets:

1. **Stats**: shows current wind speed, contract balance, and release status.
2. **Donate**: lets supporters send ETH to the relief pool.
3. **OracleFeed**: simulates an off-chain weather provider by sending a new wind speed on-chain.

As they clicked “Feed 120 km/h,” an `Released` event fired and the UI lit up: donations dispatched! Over cups of taho, Odessa and Neri toasted to the future: real Chainlink integration next—but tonight, TyphoonReliefChain was alive. 🇵🇭🌪️🚀

---

## 📚 Theory & Web3 Lecture

1. Off-Chain Data & Oracles  
   • On-chain contracts can’t fetch HTTP. They rely on external “oracle” calls.  
   • Here we simulate by calling `updateWeather(uint256 speed)` from frontend.  
   • Events (`DataUpdated`, `Released`) let UI react to data pushes and fund releases.

2. Smart Contract Breakdown  
   • donate(): payable, adds ETH to pool.  
   • updateWeather(uint256): stores `windSpeed` and emits `DataUpdated`.  
   • If `windSpeed ≥ threshold` and not yet released, sends entire balance to `beneficiary` and emits `Released`.  
   • Public getters: `windSpeed()`, `released()`, contract `balance`, and `threshold`.

3. Ethers.js & React Integration  
   • Provider (read): `new ethers.providers.Web3Provider(window.ethereum)`  
   • Signer (write): `provider.getSigner()`  
   • Contract instance:

   ```js
   const relief = new ethers.Contract(
     CONTRACT_ADDRESS,
     RELIEF_ABI,
     signerOrProvider
   );
   ```

   • Read calls: view windSpeed and release status—no gas.  
   • Transactions: donate & updateWeather—gas required, use `await tx.wait()`.  
   • Listen to events:

   ```js
   relief.on("DataUpdated", (speed) => {
     /* refresh UI */
   });
   relief.on("Released", (to, amt) => {
     /* show success */
   });
   ```

4. React Hooks Pattern  
   • `useState` for `windSpeed`, `balance`, `released`, `error`.  
   • `useEffect` on mount to fetch initial data and subscribe to events.  
   • Cleanup listeners on unmount.  
   • Loading & error handling for tx calls.

5. Best Practices  
   • Store RPC & contract address in `.env` (never commit secrets).  
   • Validate inputs (e.g., positive wind speed).  
   • Show user feedback: disable buttons during tx, show spinners.  
   • Use `ethers.utils.formatEther`/`parseEther` for ETH conversions.

🔗 Further Reading  
– Ethers.js: https://docs.ethers.org/v5  
– Solidity Global Variables & Events: https://docs.soliditylang.org  
– React Hooks: https://reactjs.org/docs/hooks-intro.html

---

## 🧪 Exercises

### Exercise 1: Build ReliefStats Component

Problem Statement  
Create `ReliefStats.js` that reads and displays on-chain:

- Current wind speed (`windSpeed`)
- Contract ETH balance
- Release status (`released`)

**Solidity Contract (`TyphoonReliefChain.sol`)**

```sol
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

**Starter Code (`ReliefStats.js`)**

```js
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

To Do List

- [ ] Instantiate `provider = new ethers.providers.Web3Provider(window.ethereum)`.
- [ ] Relief contract: `new ethers.Contract(address, ABI, provider)`.
- [ ] Call `windSpeed()` & `released()`.
- [ ] `provider.getBalance(address)` for ETH balance.
- [ ] Update state with parsed values.

**Full Solution**

```js
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

.env Sample

```
REACT_APP_RPC_URL=http://127.0.0.1:8545
REACT_APP_RELIEF_ADDRESS=0xYourDeployedAddress
```

---

### Exercise 2: Build Donate Component

Problem Statement  
Create `Donate.js` allowing users to send ETH to the relief pool. After donation, refresh `ReliefStats`.

**Starter Code (`Donate.js`)**

```js
import React, { useState } from "react";
import { ethers } from "ethers";

const ABI = ["function donate() payable"];

export default function Donate({ onDonated }) {
  const [amount, setAmount] = useState("");
  const [error, setError] = useState("");

  async function donate() {
    try {
      // TODO: validate amount > 0
      // TODO: request accounts, get signer
      // TODO: relief = new Contract(CONTRACT, ABI, signer)
      // TODO: tx = await relief.donate({ value: parseEther(amount) })
      // TODO: await tx.wait(), onDonated(), clear amount
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <div>
      <h4>Donate to Relief Pool</h4>
      <input
        value={amount}
        onChange={(e) => setAmount(e.target.value)}
        placeholder="ETH amount"
      />
      <button onClick={donate}>Donate</button>
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

To Do List

- [ ] Ensure `amount` is positive and numeric.
- [ ] `window.ethereum.request({ method: "eth_requestAccounts" })`.
- [ ] Signer & contract: `new ethers.Contract(...)`.
- [ ] `parseEther(amount)` & `donate({ value })`.
- [ ] `await tx.wait()`, call `onDonated()` to reload stats.

**Full Solution**

```js
// Donate.js
import React, { useState } from "react";
import { ethers } from "ethers";

const ABI = ["function donate() payable"];
const CONTRACT = process.env.REACT_APP_RELIEF_ADDRESS;

export default function Donate({ onDonated }) {
  const [amount, setAmount] = useState("");
  const [error, setError] = useState("");

  async function donate() {
    setError("");
    if (!amount || isNaN(amount) || Number(amount) <= 0) {
      setError("Enter a valid amount");
      return;
    }
    try {
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const relief = new ethers.Contract(CONTRACT, ABI, signer);
      const value = ethers.utils.parseEther(amount);
      const tx = await relief.donate({ value });
      await tx.wait();
      setAmount("");
      onDonated();
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <div>
      <h4>Donate to Relief Pool</h4>
      <input
        value={amount}
        onChange={(e) => setAmount(e.target.value)}
        placeholder="ETH amount"
      />
      <button onClick={donate}>Donate</button>
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

---

### Exercise 3: Simulate Oracle Feed

Problem Statement  
Create `OracleFeed.js` to push a new wind speed reading via `updateWeather(speed)`. On `DataUpdated` or `Released` events, refresh `ReliefStats`.

**Starter Code (`OracleFeed.js`)**

```js
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

To Do List

- [ ] Validate `speed` is numeric & > 0.
- [ ] `eth_requestAccounts`, get signer & contract.
- [ ] Call `updateWeather(speed)`, `await tx.wait()`.
- [ ] `onFeed()` to reload stats, handle clear.

**Full Solution**

```js
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

---

## ✅ Test Cases

Create `__tests__/ReliefApp.test.js`:

```js
// __tests__/ReliefApp.test.js
import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import ReliefStats from "../ReliefStats";
import Donate from "../Donate";
import OracleFeed from "../OracleFeed";
import { ethers } from "ethers";

jest.mock("ethers");

describe("TyphoonReliefChain App", () => {
  const fakeProvider = {};
  const fakeSigner = {};
  const fakeContract = {
    windSpeed: jest.fn(),
    released: jest.fn(),
    donate: jest.fn(),
    updateWeather: jest.fn(),
  };

  beforeAll(() => {
    global.window.ethereum = {
      request: jest.fn().mockResolvedValue(["0xABC"]),
    };
    ethers.providers.Web3Provider = jest.fn().mockReturnValue(fakeProvider);
    fakeProvider.getSigner = () => fakeSigner;
    ethers.Contract = jest.fn().mockReturnValue(fakeContract);
    fakeContract.windSpeed.mockResolvedValue(ethers.BigNumber.from("50"));
    fakeContract.released.mockResolvedValue(false);
    ethers.providers.Web3Provider.prototype.getBalance = jest
      .fn()
      .mockResolvedValue(ethers.utils.parseEther("1.5"));
  });

  it("loads and shows stats", async () => {
    render(<ReliefStats />);
    expect(await screen.findByText(/Wind Speed:/)).toHaveTextContent("50");
    expect(screen.getByText(/Pool Balance:/)).toHaveTextContent("1.5");
    expect(screen.getByText(/Released:/)).toHaveTextContent("❌");
  });

  it("donates ETH and refreshes", async () => {
    fakeContract.donate.mockResolvedValue({ wait: () => Promise.resolve() });
    const onDonated = jest.fn();
    render(<Donate onDonated={onDonated} />);
    fireEvent.change(screen.getByPlaceholderText("ETH amount"), {
      target: { value: "0.2" },
    });
    fireEvent.click(screen.getByText("Donate"));
    await waitFor(() => expect(fakeContract.donate).toHaveBeenCalled());
    expect(onDonated).toHaveBeenCalled();
  });

  it("feeds weather data and refreshes", async () => {
    fakeContract.updateWeather.mockResolvedValue({
      wait: () => Promise.resolve(),
    });
    const onFeed = jest.fn();
    render(<OracleFeed onFeed={onFeed} />);
    fireEvent.change(screen.getByPlaceholderText("Wind km/h"), {
      target: { value: "120" },
    });
    fireEvent.click(screen.getByText("Feed Data"));
    await waitFor(() =>
      expect(fakeContract.updateWeather).toHaveBeenCalledWith(120)
    );
    expect(onFeed).toHaveBeenCalled();
  });
});
```

Add to `jest.config.js`:

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

With “TyphoonReliefChain” live locally, Odessa clicked “Feed Data → 130 km/h” and watched donations auto-dispatch in real time. Neri cheered: “Next stop, Chainlink integration and multi-region triggers!” From mock oracle to production-grade pipeline, Odessa’s civic-tech DApp was storm-ready. Mabuhay Filipino Web3 innovation! 🇵🇭🌪️🚀
