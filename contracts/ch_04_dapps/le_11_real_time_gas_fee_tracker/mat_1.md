## 🧑‍💻 Background Story

In a sleek Silicon Valley pitch room, Odessa (“Det”) stood before investors with her laptop open on a slide: “GaslessPH: Philippine-style gas fee insights.” The room was quiet—until she clicked “Live Demo.” A clean dashboard appeared showing Low, Medium, and High gas estimates in gwei and peso equivalents. The investors leaned in.

Back in her SoMa apartment, Det had mocked data for speed—but the UI/UX felt real. Now they wanted the on-chain twist. She wrote a tiny Solidity helper that returns `block.basefee`, deployed it on Sepolia, and wired Ethers.js to fetch it. In minutes, the dashboard pulled live base fees, calculated premium tiers (low=base×0.9, med=base, high=base×1.1), and converted to PHP using a “mock” oracle rate.

By the end of the day, “GaslessPH” was more than a slide deck—it was a working MVP. Investors nodded at the clean UI, real-time updates, and Filipino flair (“₱0.50 per tx? Where do I sign?”). For Det, it was proof: Web3 experiences must feel as smooth as loading a TikTok feed. Next step—integrate real gas station APIs and layer-2 support. Mabuhay, GaslessPH! 🚀🇵🇭

---

## 📚 Theory & Web3 Lecture

1. EIP-1559 & block.basefee  
   • Since London hard fork, blocks include `basefee` (minimum gwei) for inclusion.  
   • In Solidity (`^0.8.7+`), you can read `block.basefee` in a view function.

2. Gas Price Tiers  
   • Low: basefee × 0.9 (cheapest fast inclusion)  
   • Medium: basefee (standard)  
   • High: basefee × 1.1 (priority)  
   • Use `ethers.BigNumber` math and `ethers.utils.formatUnits`.

3. Price Conversion  
   • Convert gwei to ETH: `formatUnits(gwei, "gwei")`  
   • Multiply by mock PHP/ETH rate (e.g., 80₱/ETH).  
   • Show real-time estimates in two columns.

4. React + Ethers Architecture  
   • Provider: `new ethers.providers.JsonRpcProvider(RPC_URL)`—read-only  
   • Contract: helper to fetch `basefee` on-chain  
   • Hooks:  
    – `useState` for `baseFee`, `tiers`, `error`  
    – `useEffect` for initial fetch and polling every _n_ seconds  
   • No Signer needed (read-only calls).

5. Best Practices & UX  
   • Polling interval: 10–15s to avoid rate limits  
   • Error handling: show fallback “—” on failure  
   • `.env` for RPC and contract address  
   • Clean up interval on unmount

🔗 Docs  
– Ethers.js: https://docs.ethers.org/v5/api/providers/  
– Solidity `block.basefee`: https://docs.soliditylang.org/en/latest/units-and-global-variables.html#block-and-transaction-properties  
– React Hooks: https://reactjs.org/docs/hooks-overview.html

---

## ✅ Test Cases

Create `__tests__/GasDashboard.test.js`:

```js
// __tests__/GasDashboard.test.js
import React from "react";
import { render, screen, waitFor } from "@testing-library/react";
import GasDashboard from "../GasDashboard";
import { ethers } from "ethers";

jest.mock("ethers");

describe("GasDashboard Component", () => {
  const mockBase = ethers.BigNumber.from("100"); // 100 gwei
  const mockProvider = {};
  const mockContract = { getBaseFee: jest.fn() };

  beforeAll(() => {
    global.process.env.REACT_APP_RPC_URL = "http://localhost";
    global.process.env.REACT_APP_GAS_TRACKER_ADDRESS = "0xGas";
    ethers.providers.JsonRpcProvider = jest.fn().mockReturnValue(mockProvider);
    ethers.Contract = jest.fn().mockReturnValue(mockContract);
    mockContract.getBaseFee.mockResolvedValue(mockBase);
  });

  it("calculates PHP estimates correctly", async () => {
    render(<GasDashboard />);
    // Low = 100*0.9=90 gwei → 90×1e-9 ETH = 9e-8 ETH → ₱80×9e-8 = ₱0.00
    await waitFor(() => screen.getByText(/Low:/i));
    expect(screen.getByText("Low: ₱0.00")).toBeInTheDocument();
    // Medium
    expect(screen.getByText("Med: ₱0.00")).toBeInTheDocument();
    // High = 110 gwei...
    expect(screen.getByText("High: ₱0.00")).toBeInTheDocument();
  });
});
```

In `jest.config.js`:

```js
module.exports = {
  testEnvironment: "jsdom",
  moduleNameMapper: { "\\.(css|scss)$": "identity-obj-proxy" },
};
```

---

## 🌟 Closing Story

Investors in SV tapped their phones at Odessa’s demo: real-time gas fees, clear PHP costs, and a path to “gasless” user experiences. Next up, she’ll wire in multiple networks (BSC, Polygon), fetch live Chainlink price feeds, and prototype fee subsidy wallets. GaslessPH is just warming up—mabuhay innovation, one gwei at a time! 🇵🇭🔥🚀
