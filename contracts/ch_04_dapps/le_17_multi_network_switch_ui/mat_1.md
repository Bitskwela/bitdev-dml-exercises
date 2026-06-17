# Multi-Network Switch UI — Detecting and Switching Chains the Right Way

![Multi-Network Switch UI](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+17.0+-+COVER.png)

## Scene

Under the bright lights of DevCon Cebu, Neri and Odessa demoed their multi-network React UI to a packed room. Local devs clapped as the screen showed "Chain: Sepolia" then switched live to "Chain: Polygon" with a single click. A week later — jet-lagged but exhilarated — at a Los Angeles hackathon they faced judges who flipped their MetaMask to the wrong network by mistake and got stuck. Odessa grinned: "No worries, our app detects your chain and prompts you to switch."

Back in Cebu they'd sketched a tiny contract, `NetworkDetector.sol`, that returns `block.chainid`. In React they read the chain ID, mapped it to a human-readable name, and — if it didn't match the chain the dApp expected — fired off `wallet_switchEthereumChain`, falling back to `wallet_addEthereumChain` when the wallet had never heard of the target chain.

When a judge's wallet sat on the wrong network, Odessa's UI popped a modal: "Please switch to Sepolia (chain ID 11155111)." In thirty seconds the judge approved the switch in MetaMask and the build pipeline rolled on. Filipino ingenuity had turned a common UX friction into a feature.

This lesson is about doing that switch *correctly*: the two EIPs that power it, the one error code you must handle, the bigint/hex conversions that trip everyone up, and why a chain change should usually reload your whole app. Everything here is **ethers v6**.

---

## Why network handling is non-negotiable

Every read and every transaction your dApp sends is scoped to **one chain**. A contract deployed at `0xabc…` on Sepolia does not exist at that address on Polygon. If your UI thinks it's on Sepolia but the user's wallet is on Polygon, every call either reverts, hits the wrong contract, or — worst case — sends real funds to an address that means something completely different.

So a multi-chain dApp has exactly three jobs:

1. **Detect** which chain the wallet is currently on.
2. **React** when the user switches chains underneath you.
3. **Request** a switch (or an add-then-switch) when the user is on the wrong chain.

The wallet — not your web page — is the source of truth for the active chain. Your job is to stay in sync with it.

---

## 1. Chain IDs: decimal, hex, and bigint

A chain ID is just an integer that uniquely identifies a network (defined by EIP-155 to prevent replay attacks across chains). The friction is that it shows up in **three different representations**, and mixing them is the single most common bug in this lesson.

| Network          | Decimal    | Hex (`eth_chainId`) | Type    |
| ---------------- | ---------- | ------------------- | ------- |
| Ethereum Mainnet | 1          | `0x1`               | Mainnet |
| Sepolia          | 11155111   | `0xaa36a7`          | Testnet |
| Polygon          | 137        | `0x89`              | Mainnet |
| Polygon Amoy     | 80002      | `0x13882`           | Testnet |
| Arbitrum One     | 42161      | `0xa4b1`            | L2      |
| Optimism         | 10         | `0xa`               | L2      |
| Base             | 8453       | `0x2105`            | L2      |

> **Goerli (5) and Mumbai (80001) are dead.** Both testnets were deprecated and their faucets and RPCs shut down. The live Ethereum testnet is **Sepolia (11155111)** and the live Polygon testnet is **Polygon Amoy (80002)**. Any tutorial still pointing you at Goerli or Mumbai is out of date — do not configure them.

The rules that keep you sane:

- The JSON-RPC method `eth_chainId` always returns a **hex string** like `"0xaa36a7"`. Convert it with `parseInt(hex, 16)`.
- `wallet_switchEthereumChain` and `wallet_addEthereumChain` always expect a **hex string** `chainId`. Build it with `"0x" + id.toString(16)`.
- In **ethers v6**, anything that reads a chain on-chain or via the provider gives you a **`bigint`**, not a JavaScript `number` and not a v5 `BigNumber`. `provider.getNetwork()` returns `network.chainId` as a `bigint`; a Solidity `uint256` return value comes back as a `bigint`. Convert with `Number(...)` before using it as an object key or comparing against a number literal.

```javascript
// hex string  -> number
const id = parseInt("0xaa36a7", 16); // 11155111

// number -> hex string (for wallet_* params)
const hex = "0x" + (11155111).toString(16); // "0xaa36a7"

// bigint (ethers v6) -> number
const net = await provider.getNetwork();
const chainId = Number(net.chainId); // 11155111  (net.chainId is 11155111n)
```

A `bigint` compared with `===` against a `number` is **always false** (`11155111n === 11155111` is `false`). Convert before you compare, or your "are we on the right chain?" check will silently always say no.

---

## 2. Reading the current chain (ethers v6)

There are three ways to read the active chain. Pick based on what you already have.

```javascript
import { ethers } from "ethers";

// (a) Straight from the wallet — no provider object needed.
const chainIdHex = await window.ethereum.request({ method: "eth_chainId" });
const chainId = parseInt(chainIdHex, 16);

// (b) Through an ethers v6 BrowserProvider (wraps window.ethereum).
const provider = new ethers.BrowserProvider(window.ethereum);
const network = await provider.getNetwork();
const chainId = Number(network.chainId); // bigint -> number

// (c) From your own NetworkDetector contract returning block.chainid.
const contract = new ethers.Contract(CONTRACT, ABI, provider);
const chainId = Number(await contract.getChainId()); // uint256 -> bigint -> number
```

In ethers v6, `new ethers.providers.Web3Provider(window.ethereum)` is gone — the wallet-backed provider is now `new ethers.BrowserProvider(window.ethereum)`. For read-only RPC access without a wallet, `new ethers.JsonRpcProvider(url)` replaces the old `ethers.providers.JsonRpcProvider`.

The matching `NetworkDetector` contract is trivial:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NetworkDetector {
    /// @notice Returns the chain ID of the network this contract is running on.
    function getChainId() external view returns (uint256) {
        return block.chainid;
    }
}
```

---

## 3. Reacting to chain changes — and why you should reload

The wallet emits a `chainChanged` event whenever the user switches networks. You **must** subscribe to it, because the user can switch at any time from inside MetaMask without touching your UI.

```javascript
useEffect(() => {
  if (!window.ethereum) return;

  const handleChainChanged = (chainIdHex) => {
    // MetaMask hands you a hex string, e.g. "0xaa36a7"
    const id = parseInt(chainIdHex, 16);
    setChainId(id);
    // Recommended by MetaMask: just reload.
    window.location.reload();
  };

  window.ethereum.on("chainChanged", handleChainChanged);
  return () => window.ethereum.removeListener("chainChanged", handleChainChanged);
}, []);
```

**Why reload instead of patching state?** MetaMask's own documentation recommends reloading the page on `chainChanged`. The reason is correctness, not laziness: when the chain changes, *everything chain-scoped is now stale* — your `BrowserProvider`, every `Contract` instance bound to it, cached balances, the deployed contract address you looked up, token decimals, event subscriptions. Surgically invalidating all of that by hand is error-prone and a rich source of "it shows the wrong balance after I switch" bugs. A reload rebuilds the provider and re-runs your detection logic against the new chain from a clean slate. If a full reload is too heavy for your UX, the disciplined alternative is to tear down and rebuild the provider + every contract instance inside the handler — but reload is the safe default.

Two things people forget:

- **Always remove the listener on unmount.** `window.ethereum` outlives your React component; a leaked listener keeps firing `setState` on an unmounted component (and stacks up every time the component remounts).
- **`accountsChanged` is a separate event.** Switching the *account* is not the same as switching the *chain*. If your dApp cares about both, subscribe to both.

---

## 4. Switching to a network the wallet already has (EIP-3326)

`wallet_switchEthereumChain` (standardized as **EIP-3326**) asks the wallet to make a chain the active one. The wallet shows the user a confirmation; your code cannot switch silently.

```javascript
async function switchNetwork(chainId) {
  const chainIdHex = "0x" + chainId.toString(16);
  await window.ethereum.request({
    method: "wallet_switchEthereumChain",
    params: [{ chainId: chainIdHex }],
  });
}
```

That call resolves if the user approves, and **rejects** otherwise. The two rejection codes you must handle:

| Code   | Meaning                       | What to do                                   |
| ------ | ----------------------------- | -------------------------------------------- |
| 4001   | User rejected the request     | Show a calm "Switch cancelled" message       |
| 4902   | Chain is **unrecognized**     | Add it with `wallet_addEthereumChain`, then retry the switch |
| -32002 | A request is already pending  | Tell the user to check their wallet; don't re-fire |

`4902` is the one that matters most: it means the wallet has never been configured with that network, so there is nothing to switch *to* yet. The correct flow is **add-then-switch** (next section).

---

## 5. Adding an unrecognized network (EIP-3085) — the 4902 flow

`wallet_addEthereumChain` (**EIP-3085**) registers a new network in the wallet. You hand it the full chain definition; the wallet asks the user to approve adding it. Many wallets switch to the chain as part of adding it, but you should not rely on that — re-issue the switch afterward to be safe.

```javascript
// Full chain definitions. rpcUrls and blockExplorerUrls must be REAL and live.
const CHAIN_PARAMS = {
  11155111: {
    chainId: "0xaa36a7",
    chainName: "Sepolia",
    nativeCurrency: { name: "Sepolia Ether", symbol: "ETH", decimals: 18 },
    rpcUrls: ["https://rpc.sepolia.org"],
    blockExplorerUrls: ["https://sepolia.etherscan.io"],
  },
  80002: {
    chainId: "0x13882",
    chainName: "Polygon Amoy",
    nativeCurrency: { name: "POL", symbol: "POL", decimals: 18 },
    rpcUrls: ["https://rpc-amoy.polygon.technology"],
    blockExplorerUrls: ["https://amoy.polygonscan.com"],
  },
};

async function switchOrAddNetwork(chainId) {
  const chainIdHex = "0x" + chainId.toString(16);
  try {
    // First, try a plain switch — works if the wallet already knows the chain.
    await window.ethereum.request({
      method: "wallet_switchEthereumChain",
      params: [{ chainId: chainIdHex }],
    });
  } catch (err) {
    if (err.code === 4902) {
      // Unrecognized chain: add it, then the wallet lands the user on it.
      const params = CHAIN_PARAMS[chainId];
      if (!params) throw new Error(`No config for chain ${chainId}`);
      await window.ethereum.request({
        method: "wallet_addEthereumChain",
        params: [params],
      });
    } else if (err.code === 4001) {
      throw new Error("You cancelled the network switch.");
    } else {
      throw err;
    }
  }
}
```

Note that `decimals` for `nativeCurrency` is effectively always `18` in practice, and `chainId` inside the params **must** match the actual chain ID of the RPC you list — wallets verify this and reject a mismatch.

---

## 6. Security: adding chains is a real attack surface

`wallet_addEthereumChain` lets a website inject an RPC endpoint and a block-explorer URL into the user's wallet. That is exactly as dangerous as it sounds, and it's why wallets show a prominent warning when a site asks to add a chain.

- **A malicious or compromised RPC URL can lie.** It can report a fake balance, hide or fabricate transactions, censor your transactions, or front-run them. The wallet still signs with the user's real key, but everything the user *sees* about the chain comes through that RPC. Only ever add RPC URLs from sources you trust (the chain's official docs, Chainlist's verified entries, your own infra).
- **Spoofing a well-known chain ID is the classic scam.** A site adds "Ethereum Mainnet" with `chainId: "0x1"` but an attacker-controlled `rpcUrls`. Wallets defend against this for known chains, but the lesson stands: never let user-supplied or untrusted data flow into `wallet_addEthereumChain` params.
- **Hard-code your chain configs.** Keep `CHAIN_PARAMS` as a constant in your code, reviewed and pinned. Do not build it from query strings, `localStorage`, or anything an attacker could influence.
- **Switching is safe; adding is the risk.** `wallet_switchEthereumChain` only selects an existing, user-approved network. The trust decision happens at *add* time, so that's where your scrutiny belongs.

---

## 7. Putting it together (ethers v6)

```javascript
import { useState, useEffect } from "react";

const NETWORKS = {
  1: { name: "Ethereum Mainnet", symbol: "ETH" },
  11155111: { name: "Sepolia", symbol: "ETH" },
  137: { name: "Polygon", symbol: "POL" },
  80002: { name: "Polygon Amoy", symbol: "POL" },
};

function NetworkApp() {
  const [chainId, setChainId] = useState(null);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (!window.ethereum) {
      setError("MetaMask not detected");
      return;
    }

    const detectChain = async () => {
      try {
        const hex = await window.ethereum.request({ method: "eth_chainId" });
        setChainId(parseInt(hex, 16));
      } catch {
        setError("Failed to detect network");
      }
    };
    detectChain();

    const handleChainChanged = () => window.location.reload();
    window.ethereum.on("chainChanged", handleChainChanged);
    return () =>
      window.ethereum.removeListener("chainChanged", handleChainChanged);
  }, []);

  const switchToNetwork = async (targetChainId) => {
    setLoading(true);
    setError(null);
    try {
      await window.ethereum.request({
        method: "wallet_switchEthereumChain",
        params: [{ chainId: "0x" + targetChainId.toString(16) }],
      });
    } catch (err) {
      if (err.code === 4902) setError("Chain not in wallet — add it first.");
      else if (err.code === 4001) setError("You cancelled the switch.");
      else setError("Failed to switch network.");
    } finally {
      setLoading(false);
    }
  };

  const info = NETWORKS[chainId] || { name: "Unknown", symbol: "?" };

  return (
    <div>
      <h2>Current Network</h2>
      <p>Chain ID: {chainId}</p>
      <p>Name: {info.name}</p>
      <p>Currency: {info.symbol}</p>

      <h3>Switch Network</h3>
      {Object.entries(NETWORKS).map(([id, n]) => (
        <button
          key={id}
          onClick={() => switchToNetwork(parseInt(id))}
          disabled={loading || chainId === parseInt(id)}
        >
          {chainId === parseInt(id) ? "✓ " : ""}
          {n.name}
        </button>
      ))}

      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

Notice `parseInt(id)` everywhere a chain ID is compared: `Object.entries` keys are strings, and our detected `chainId` is a number, so without the conversion the "currently active" check never matches.

---

## Common mistakes

| Mistake                                       | Problem                                  | Fix                                              |
| --------------------------------------------- | ---------------------------------------- | ------------------------------------------------ |
| Comparing a v6 `bigint` with a `number`       | `11155111n === 11155111` is `false`      | `Number(net.chainId) === 11155111`               |
| Passing a decimal chainId to `wallet_*`       | Wallet rejects the request               | Send hex: `"0x" + id.toString(16)`               |
| Not handling `4902`                           | Switch crashes for chains not yet added  | Catch `4902` → `wallet_addEthereumChain`         |
| Patching state instead of reloading           | Stale provider/contracts after a switch  | `window.location.reload()` on `chainChanged`     |
| Leaving the `chainChanged` listener attached  | Memory leak, setState on unmounted node  | `removeListener` in the effect cleanup           |
| Using `ethers.providers.Web3Provider`         | Throws in ethers v6                       | `new ethers.BrowserProvider(window.ethereum)`    |
| Configuring Goerli / Mumbai                   | Dead testnets, no RPC or faucet          | Use Sepolia (11155111) / Polygon Amoy (80002)    |
| Adding chains from untrusted RPC URLs         | Wallet shows forged balances/txs         | Hard-code trusted `CHAIN_PARAMS` only            |

---

## Testing checklist

- [ ] Current chain ID displays correctly on load
- [ ] Network name maps from chain ID (Unknown fallback works)
- [ ] Switch button fires the MetaMask prompt
- [ ] `4001` (user rejection) shows a friendly message
- [ ] `4902` (unknown chain) triggers add-then-switch
- [ ] `chainChanged` reloads / refreshes the UI
- [ ] Loading state prevents double-clicks
- [ ] Works without MetaMask (graceful error, no crash)
- [ ] Listener cleans up on unmount
- [ ] No Goerli or Mumbai anywhere in the config

---

## Test Cases

Create `__tests__/NetworkSwitch.test.js`:

```js
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
    global.window.ethereum = { request: jest.fn() };
    // ethers v6: providers are top-level, not under ethers.providers.*
    ethers.BrowserProvider = jest.fn().mockReturnValue(fakeProvider);
    ethers.Contract = jest.fn().mockReturnValue(fakeContract);
  });

  it("loads and displays current network", async () => {
    // ethers v6 returns a bigint for uint256, not a { toNumber } BigNumber
    fakeContract.getChainId.mockResolvedValue(11155111n);
    window.ethereum.request.mockResolvedValue("0xaa36a7"); // Sepolia hex
    render(<NetworkStats />);
    expect(await screen.findByText("Chain ID:")).toHaveTextContent("11155111");
    expect(screen.getByText("Chain Name:")).toHaveTextContent("Sepolia");
  });

  it("prompts switch and handles success", async () => {
    window.ethereum.request
      .mockResolvedValueOnce("0x1") // eth_chainId initial
      .mockResolvedValueOnce(); // wallet_switchEthereumChain
    render(<NetworkSwitcher targetChainId={11155111} />);
    expect(await screen.findByText(/Current Chain ID:/)).toHaveTextContent("1");
    fireEvent.click(screen.getByText("Switch to 11155111"));
    await waitFor(() => screen.getByText("✅ Switched!"));
  });

  it("handles user rejection on switch", async () => {
    window.ethereum.request
      .mockResolvedValueOnce("0x1") // initial
      .mockRejectedValueOnce({ code: 4001 }); // user rejected
    render(<NetworkSwitcher targetChainId={11155111} />);
    await screen.findByText("Switch to 11155111");
    fireEvent.click(screen.getByText("Switch to 11155111"));
    await waitFor(() => screen.getByText("You cancelled the switch."));
  });

  it("adds an unrecognized chain on 4902", async () => {
    const params = {
      chainId: "0x13882",
      chainName: "Polygon Amoy",
      nativeCurrency: { name: "POL", symbol: "POL", decimals: 18 },
      rpcUrls: ["https://rpc-amoy.polygon.technology"],
      blockExplorerUrls: ["https://amoy.polygonscan.com"],
    };
    window.ethereum.request
      .mockRejectedValueOnce({ code: 4902 }) // switch fails: unknown chain
      .mockResolvedValueOnce(); // add succeeds
    render(<AddChainButton chainParams={params} />);
    fireEvent.click(screen.getByText("Add Polygon Amoy"));
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

## References

- EIP-3326 — `wallet_switchEthereumChain` — https://eips.ethereum.org/EIPS/eip-3326
- EIP-3085 — `wallet_addEthereumChain` — https://eips.ethereum.org/EIPS/eip-3085
- EIP-155 — Chain ID / replay protection — https://eips.ethereum.org/EIPS/eip-155
- MetaMask — `chainChanged` and handling network changes — https://docs.metamask.io/wallet/reference/provider-api/#chainchanged
- ethers v6 — Providers (`BrowserProvider`, `JsonRpcProvider`) — https://docs.ethers.org/v6/api/providers/
- Chainlist (verify chain IDs and RPC URLs) — https://chainlist.org/

---

## Closing Story

At the LA hackathon finals, a judge accidentally switched MetaMask to the wrong L2; Odessa's UI caught it instantly, prompted a switch back to Sepolia, and the live demo stayed flawless. Judges congratulated the duo: "This UX is rock solid." Back in Cebu, over halo-halo, Neri and Odessa plotted automatic RPC fallback and cross-chain asset checks — pinning only trusted endpoints, of course. From Cebu to LA, Filipino Web3 devs just raised the bar for seamless, *safe* multi-network dApps. Mabuhay network-agnostic builds! 🇵🇭🔄🌐
