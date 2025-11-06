## 🧑‍💻 Background Story

A week after Typhoon Ulysses swept through Cagayan Valley, Odessa ("Det") sat in her BGC co-working nook, watching relief convoys slow to a crawl. "What if donations automatically release when a storm hits threshold?" she mused. Neri grinned: "Let's simulate an oracle feeding wind-speed data on-chain."

By midnight, they had `TyphoonReliefChain.sol` deployed on a local Hardhat network. It held a donation pool and a threshold wind speed. When the mocked oracle pushed a reading above that threshold, the contract would auto-release funds to the barangay relief fund. No messy back-ends—just a simulated oracle call via `updateWeather`.

Odessa scaffolded a React app with three widgets:

1. **Stats**: shows current wind speed, contract balance, and release status.
2. **Donate**: lets supporters send ETH to the relief pool.
3. **OracleFeed**: simulates an off-chain weather provider by sending a new wind speed on-chain.

As they clicked "Feed 120 km/h," an `Released` event fired and the UI lit up: donations dispatched! Over cups of taho, Odessa and Neri toasted to the future: real Chainlink integration next—but tonight, TyphoonReliefChain was alive. 🇵🇭🌪️🚀

---

## 📚 Theory & Web3 Lecture

1. Off-Chain Data & Oracles  
   • On-chain contracts can't fetch HTTP. They rely on external "oracle" calls.  
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

With "TyphoonReliefChain" live locally, Odessa clicked "Feed Data → 130 km/h" and watched donations auto-dispatch in real time. Neri cheered: "Next stop, Chainlink integration and multi-region triggers!" From mock oracle to production-grade pipeline, Odessa's civic-tech DApp was storm-ready. Mabuhay Filipino Web3 innovation! 🇵🇭🌪️🚀