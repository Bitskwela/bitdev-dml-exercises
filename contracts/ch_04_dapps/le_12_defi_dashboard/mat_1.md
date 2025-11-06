## 🧑‍💻 Background Story

In a virtual workshop hosted by Ateneo's Blockchain Society, Neri was ready to impress. She'd sketched out a DeFi staking dashboard—"Simulated, pero feels real"—and turned to Odessa ("Det") to wire up the frontend. Their goal: show LP token data (reserves, total supply), compute token prices, and display a mocked APR, all without a production protocol.

Using Hardhat, Neri deployed a tiny `MockLP` contract on a local network. It stored two token reserves (e.g., USDC and TKO), a total supply, and a fixed APR (in basis points). Now Det would build a clean React + Ethers.js dashboard:

1. Fetch `getReserves()` and `getTotalSupply()`
2. Compute Token0's price in Token1 (reserve1 / reserve0)
3. Read `getMockAPR()` (e.g. 1 200 = 12.00 %)
4. Display all with friendly formatting

In under 30 minutes, Det had a "DeFi Sim" UI: a card for reserves, a badge for price, and a progress bar for APR. Ateneo scholars clicked "Refresh," and the numbers updated in real time. No real staking, no live oracles—just smart design, Filipino grit, and a taste of what DeFi dashboards can be. Mabuhay simulations, next stop: on-chain rewards! 🇵🇭🪙🚀

---

## 📚 Theory & Web3 Lecture

1. Mock LP Token Pattern

   - `getReserves()` returns `(reserve0, reserve1)` as `uint112`.
   - `getTotalSupply()` returns total LP tokens minted (`uint256`).
   - `getMockAPR()` returns APR in basis points (bps): 100 bps = 1 %.

2. Ethers.js Basics

   - Provider: read-only via `new ethers.providers.JsonRpcProvider(RPC_URL)`
   - Contract: `new ethers.Contract(address, ABI, provider)`
   - BigNumber math:  
     • Division: `reserve1.mul(ONE).div(reserve0)`  
     • Formatting: `ethers.utils.formatUnits(bn, decimals)`

3. Price Calculation

   - Token0 price in Token1 = `reserve1 / reserve0`
   - Use a constant scale factor (e.g. 1e18) to preserve precision.

4. APR Conversion

   - APR in bps → percent: `aprBps / 100`
   - Format to two decimals in UI.

5. React Architecture

   - `useState` for `reserves`, `supply`, `price`, `apr`
   - `useEffect` to fetch on mount & on "Refresh" clicks
   - Error handling with `try/catch`

6. Best Practices
   - Store `RPC_URL` and `LP_ADDRESS` in `.env`
   - Validate contract address with `ethers.utils.isAddress()`
   - Clean up intervals if polling
   - Catch and display errors in UI

🔗 Resources  
– Ethers.js docs: https://docs.ethers.org/v5  
– BigNumber: https://docs.ethers.org/v5/api/utils/bignumber/  
– React Hooks: https://reactjs.org/docs/hooks-intro.html

---

## ✅ Test Cases

Create `__tests__/DeFiDashboard.test.js` with Jest & React Testing Library.

```js
// __tests__/DeFiDashboard.test.js
import React from "react";
import { render, screen, waitFor } from "@testing-library/react";
import DeFiDashboard from "../DeFiDashboard";
import { ethers } from "ethers";

jest.mock("ethers");

describe("DeFiDashboard Component", () => {
  const fakeReserves = [
    ethers.BigNumber.from("1000"),
    ethers.BigNumber.from("2000"),
  ];
  const fakeSupply = ethers.BigNumber.from("500");
  const fakeAPR = ethers.BigNumber.from("1200"); // 12.00%
  const fakeProvider = {};
  const fakeContract = {
    getReserves: jest.fn(),
    getTotalSupply: jest.fn(),
    getMockAPR: jest.fn(),
  };

  beforeAll(() => {
    process.env.REACT_APP_RPC_URL = "http://localhost";
    process.env.REACT_APP_LP_ADDRESS = "0xLP";
    ethers.providers.JsonRpcProvider = jest.fn().mockReturnValue(fakeProvider);
    ethers.Contract = jest.fn().mockReturnValue(fakeContract);
    fakeContract.getReserves.mockResolvedValue(fakeReserves);
    fakeContract.getTotalSupply.mockResolvedValue(fakeSupply);
    fakeContract.getMockAPR.mockResolvedValue(fakeAPR);
    ethers.constants.WeiPerEther = ethers.BigNumber.from("1000000000000000000");
    ethers.utils.formatUnits = jest.fn((bn, dec) => {
      // price = r1*1e18/r0 = 2000*1e18/1000 = 2e18 → "2.0"
      return bn.toString() === "2000000000000000000000" ? "2.0" : "0";
    });
  });

  it("renders all DeFi data correctly", async () => {
    render(<DeFiDashboard />);
    await waitFor(() => screen.getByText(/DeFi Sim Dashboard/));
    expect(screen.getByText("Reserve0: 1000")).toBeInTheDocument();
    expect(screen.getByText("Reserve1: 2000")).toBeInTheDocument();
    expect(screen.getByText("Total Supply: 500")).toBeInTheDocument();
    expect(screen.getByText("Token0 Price: 2.0 Token1")).toBeInTheDocument();
    expect(screen.getByText("Mock APR: 12.00%")).toBeInTheDocument();
  });
});
```

jest.config.js:

```js
module.exports = {
  testEnvironment: "jsdom",
  moduleNameMapping: {
    "\\.(css|scss)$": "identity-obj-proxy",
  },
};
```

---

## 🌟 Closing Story

After the online workshop, Ateneo scholars chatted excitedly: "Feels like real DeFi!" Odessa smiled as Neri raised a virtual toast. Their simulated dashboard had demystified LP analytics and APR mechanics. Next up: integrate a real price oracle, add a staking simulation, and spin up a Polygon testnet version. From simulation to mainnet—Filipino Web3 excellence marches on! 🇵🇭🪙🚀
