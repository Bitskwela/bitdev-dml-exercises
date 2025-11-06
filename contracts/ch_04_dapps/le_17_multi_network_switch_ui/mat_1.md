## 🧑‍💻 Background Story

Under the bright lights of DevCon Cebu, Neri and Odessa demoed their multi-network React UI to a packed room. Local devs clapped as the screen showed "Chain: Sepolia" then switched live to "Chain: Polygon" with a single click. A week later—jet-lagged but exhilarated—in Los Angeles's hackathon they faced judges who flipped their MetaMask to Goerli by mistake and got stuck. Odessa grinned: "No worries, our app will detect your chain and prompt you to switch!"

Back in Cebu, they'd sketched out a tiny contract, `NetworkDetector.sol`, that simply returns `block.chainid`. In React they used Ethers.js and `window.ethereum.request` calls to read the chain ID, map it to human-readable names, and, if it didn't match the expected network, fire off `wallet_switchEthereumChain` (or `wallet_addEthereumChain` for new testnets).

Now at LA hackathon, when judges tried to deploy their smart-wallet on a wrong chain, Odessa's UI popped up a modal: "Please switch to Sepolia (ID 11155111)." In 30 seconds flat, the judges approved the switch in MetaMask—and the build pipeline continued seamlessly. Filipino ingenuity had turned a common UX friction into a feature. By the end of the week, teams were forking their code—and Neri and Odessa were already plotting the next trick: cross-chain network detection with automatic RPC fallback. Mabuhay multi-network UX! 🇵🇭🔄🚀

---

## 📚 Theory & Web3 Lecture

1. block.chainid in Solidity  
   • Global variable: `block.chainid` returns the current chain ID.  
   • Useful for on-chain verification or basic network checks.

2. window.ethereum and EIP-1193  
   • `window.ethereum.request({ method: "eth_chainId" })` → returns current chain hex ID.  
   • `provider.send("eth_chainId", [])` via Ethers.js provider.

3. Chain Switching (EIP-3085 & EIP-3326)  
   • `wallet_switchEthereumChain`: switch MetaMask to an existing chain.

   ```js
   await provider.send("wallet_switchEthereumChain", [{ chainId: targetHex }]);
   ```

   • `wallet_addEthereumChain`: propose adding a new chain to MetaMask.

   ```js
   await provider.send("wallet_addEthereumChain", [chainParams]);
   ```

4. React + Ethers.js Pattern  
   • useState for `chainId`, `chainName`, `error`, `loading`.  
   • useEffect to fetch on-mount and subscribe to `chainChanged`.

   ```js
   window.ethereum.on("chainChanged", handleChainChanged);
   ```

   • Cleanup in return of useEffect to remove listener.

5. UX Best Practices  
   • Map known chain IDs to names & RPC logos.  
   • Friendly modals when switching: explain why.  
   • Gracefully handle user rejection (`error.code === 4001`).  
   • Fallback to JSON-RPC provider read-only if MetaMask unavailable.

🔗 References  
– Ethers.js: https://docs.ethers.org/v5  
– EIP-3085: https://eips.ethereum.org/EIPS/eip-3085  
– EIP-3326: https://eips.ethereum.org/EIPS/eip-3326  
– React Hooks: https://reactjs.org/docs/hooks-intro.html

---

## ✅ Test Cases

Create `__tests__/NetworkSwitch.test.js`:

```js
// __tests__/NetworkSwitch.test.js
import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import NetworkStats from "../NetworkStats";
import NetworkSwitcher from "../NetworkSwitcher";
import AddChainButton from "../AddChainButton";
import { ethers } from "ethers";

jest.mock("ethers");

describe("Multi-Network Components", () => {
  const fakeProvider = {};
  const fakeContract = { getChainId: jest.fn() };

  beforeAll(() => {
    // Mock window.ethereum
    global.window.ethereum = {
      request: jest.fn(),
    };
    ethers.providers.Web3Provider = jest.fn().mockReturnValue(fakeProvider);
    ethers.Contract = jest.fn().mockReturnValue(fakeContract);
  });

  it("loads and displays current network", async () => {
    fakeContract.getChainId.mockResolvedValue({ toNumber: () => 11155111 });
    window.ethereum.request.mockResolvedValue("0xaa36a7"); // Sepolia hex
    render(<NetworkStats />);
    expect(await screen.findByText("Chain ID:")).toHaveTextContent("11155111");
    expect(screen.getByText("Chain Name:")).toHaveTextContent("Sepolia");
  });

  it("prompts switch and handles success", async () => {
    window.ethereum.request
      .mockResolvedValueOnce("0x1") // eth_chainId initial
      .mockResolvedValueOnce(); // wallet_switch
    render(<NetworkSwitcher targetChainId={5} />);
    expect(await screen.findByText(/Current Chain ID:/)).toHaveTextContent("1");
    fireEvent.click(screen.getByText("Switch to 5"));
    await waitFor(() => screen.getByText("✅ Switched!"));
  });

  it("handles user rejection on switch", async () => {
    window.ethereum.request
      .mockResolvedValueOnce("0x1") // initial
      .mockRejectedValueOnce({ code: 4001 }); // user rejected
    render(<NetworkSwitcher targetChainId={5} />);
    await screen.findByText("Switch to 5");
    fireEvent.click(screen.getByText("Switch to 5"));
    await waitFor(() => screen.getByText("User rejected the request."));
  });

  it("adds a new chain successfully", async () => {
    const params = {
      chainId: "0xa869",
      chainName: "Avalanche Fuji",
      nativeCurrency: { name: "AVAX", symbol: "AVAX", decimals: 18 },
      rpcUrls: ["https://api.avax-test.network/rpc"],
      blockExplorerUrls: ["https://testnet.snowtrace.io/"],
    };
    window.ethereum.request.mockResolvedValueOnce();
    render(<AddChainButton chainParams={params} />);
    fireEvent.click(screen.getByText("Add Avalanche Fuji"));
    await waitFor(() => screen.getByText(/added!/));
  });
});
```

Add to `jest.config.js`:

```js
module.exports = {
  testEnvironment: "jsdom",
  moduleNameMapping: { "\\.(css|scss)$": "identity-obj-proxy" },
};
```

---

## 🌟 Closing Story

At the LA hackathon finals, a judge accidentally switched MetaMask to Fantom; Odessa's UI caught it, prompted a switch back to Sepolia, and the live demo stayed flawless. Judges congratulated the duo: "This UX is rock solid." Back in Cebu, over halo-halo, Neri and Odessa plotted automatic RPC fallback and cross-chain asset checks. From Cebu to LA, Filipino Web3 devs just raised the bar for seamless multi-network dApps. Mabuhay network-agnostic builds! 🇵🇭🔄🌐