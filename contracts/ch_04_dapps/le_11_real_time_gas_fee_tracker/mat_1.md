## 🧑‍💻 Background Story

![Gas Tracker](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+11.0+-+COVER.png)

In a sleek Silicon Valley pitch room, Odessa ("Det") stood before investors with her laptop open on a slide: "GaslessPH: Philippine-style gas fee insights." The room was quiet until she clicked "Live Demo." A clean dashboard appeared showing Low, Medium and High gas estimates in gwei and peso equivalents. The investors leaned in.

![Gas Dashboard](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+11.1.png)

There was one problem. Back in her SoMa apartment, Det had mocked the numbers for speed. The UI felt real, but the fees were not. "Show us a live number," one investor said. "Just one. From the chain."

So that night Det did the smallest honest thing: she wrote a tiny Solidity helper that returns the base fee, deployed it on Sepolia, and wired ethers.js to read it. One number, read from the chain, with a clear "Loading" line while it arrives and a clear error if it does not. Everything fancier (tiers, pesos, auto-refresh) could be built on top of that one trustworthy read.

---

## 📚 Theory & Web3 Lecture

### 🎯 What You'll Learn

By the end of this lesson you can **read a public value from a contract with a read-only provider, with no wallet**, and display it with proper loading and error states. That is exactly what the activity grades.

The second half of this lecture explains what the base fee *means* and how a real gas dashboard turns it into Low/Medium/High estimates. That part is background for your own projects; the activity does not grade it.

---

### 📐 What the Activity Builds

```
┌──────────────┐   eth_call    ┌──────────────┐   bigint (wei)   ┌──────────────┐
│ Sepolia RPC  │ ────────────▶ │  GasTracker  │ ───────────────▶ │  React UI    │
│ (no wallet)  │               │ getBaseFee() │                  │ "Loading…"   │
└──────────────┘               └──────────────┘                  │ or the fee   │
                                                                 │ or the error │
                                                                 └──────────────┘
```

---

### 🔑 Key Concepts

#### 1. Read-only provider: no wallet needed

In earlier lessons you used `ethers.BrowserProvider(window.ethereum)` to talk to MetaMask, because *sending* a transaction needs someone to sign it. Reading public data needs no signature, so you can skip the wallet entirely and talk straight to an RPC node:

```javascript
import { ethers } from "ethers";

// No wallet needed: just reading public data
const provider = new ethers.JsonRpcProvider(process.env.REACT_APP_RPC_URL);

const contract = new ethers.Contract(
  process.env.REACT_APP_GAS_TRACKER_ADDRESS,
  ["function getBaseFee() view returns (uint256)"],
  provider // a provider, not a signer, so the contract is read-only
);

const fee = await contract.getBaseFee(); // a bigint, e.g. 24000000000n
```

Your users do not even need MetaMask installed to see the page. That is a big deal for a public dashboard.

#### 2. The `GasTracker` contract

Since Solidity 0.8.7 a contract can read the current block's base fee through the global `block.basefee`:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract GasTracker {
    // Returns the current block's base fee in wei
    function getBaseFee() external view returns (uint256) {
        return block.basefee;
    }
}
```

> **Honest caveat for real projects.** When you call a `view` function, the node *simulates* it with `eth_call`. Geth (the most common Ethereum client) sets the base fee to 0 during a simulation that carries no gas price, so on a real node this contract can return `0`. For a production dashboard, read the base fee directly from the latest block instead:
>
> ```javascript
> const block = await provider.getBlock("latest");
> console.log(block.baseFeePerGas); // bigint, in wei
> ```
>
> In this activity the grader provides a `GasTracker` that returns a realistic value, so you can focus on the read-and-display pattern.

#### 3. `bigint` and units

ethers v6 returns every `uint256` as a JavaScript `bigint` (written with an `n`, like `24000000000n`). Regular numbers lose precision above about 9 quadrillion (`Number.MAX_SAFE_INTEGER`), and wei amounts get there quickly.

| Unit      | Wei value | Common use                   |
| --------- | --------- | ---------------------------- |
| **Wei**   | 1         | Smallest unit, internal math |
| **Gwei**  | 10⁹ wei   | Gas prices                   |
| **Ether** | 10¹⁸ wei  | Token amounts                |

```javascript
const fee = 24000000000n;
ethers.formatUnits(fee, "gwei");   // "24.0"         (wei → gwei, as a string)
ethers.formatUnits(fee, "ether");  // "0.000000024"  (wei → ether)
ethers.parseUnits("50", "gwei");   // 50000000000n   (gwei → wei)
fee.toString();                    // "24000000000"
```

#### 4. Loading and error states

A network read takes time and can fail. A good component always shows one of three things:

1. **Error**: the read failed. Show the message, in red.
2. **Loading**: no value yet (`base === null`).
3. **The value**, with its unit.

If you forget the `catch`, a failed read leaves the page on "Loading…" forever, and the user has no idea anything went wrong. That is the worst kind of bug: silent.

---

### ⛽ Background: What the Base Fee Means (EIP-1559)

Since the London upgrade (August 2021), every Ethereum transaction fee has two parts:

| Component                                | What it is                                                                                   |
| ---------------------------------------- | -------------------------------------------------------------------------------------------- |
| **Base fee**                             | Set by the protocol for each block, and burned. Everyone in the block pays the same base fee. |
| **Priority fee** (`maxPriorityFeePerGas`) | A tip to the validator. This is what buys you a faster place in line.                        |
| **Max fee** (`maxFeePerGas`)             | The most you are willing to pay per gas, base fee plus tip combined.                         |

```
Effective price per gas = base fee + priority fee   (never more than your max fee)
Total cost              = effective price × gas used
```

Two facts that trip people up:

- **You cannot pay less than the base fee.** If your max fee is below the current base fee, your transaction simply cannot be included until the base fee drops. A "cheap tier" of *base fee × 0.9* is not a slower option; it is a stuck transaction.
- **The base fee moves by at most 12.5% per block** (a block is about every 12 seconds). It goes up when blocks are full and down when they are empty.

So real gas dashboards build their speed tiers from the **priority fee**, and set the max fee with headroom above the base fee so the transaction survives a few rising blocks. ethers v6's own `provider.getFeeData()` uses `maxFeePerGas = 2 × baseFee + priorityFee`, with a default tip of 1 gwei.

```javascript
// Extension idea (not graded): tiers from the tip, max fee with headroom
const tips = {
  low: ethers.parseUnits("1", "gwei"),
  medium: ethers.parseUnits("1.5", "gwei"),
  high: ethers.parseUnits("2", "gwei"),
};
const maxFee = (tip) => baseFee * 2n + tip; // all bigint math, no rounding

// Example: base fee 24 gwei, medium tip 1.5 gwei
// maxFee = 49.5 gwei; a simple transfer (21000 gas) at base + tip costs
// (24 + 1.5) gwei × 21000 = 0.0005355 ETH
```

Converting to pesos is plain multiplication once you have an ETH amount. Use a real price source (an oracle or an exchange API) in production; a hardcoded rate is only for demos:

```javascript
const PHP_PER_ETH = 180000; // demo rate only
const costWei = (baseFee + tips.medium) * 21000n;
const php = Number(ethers.formatEther(costWei)) * PHP_PER_ETH; // ≈ ₱96.39
```

#### Keeping it fresh: polling (extension)

The activity reads the fee once. To refresh it, call the same function on a timer and **clear the timer** when the component unmounts:

```javascript
useEffect(() => {
  fetchBaseFee();
  const id = setInterval(fetchBaseFee, 15000); // about one refresh per block or so
  return () => clearInterval(id);              // stop when the component leaves
}, []);
```

Polling every 12 to 15 seconds matches the block time. Polling faster wastes RPC calls (and many free RPC plans rate-limit you).

---

### ⚠️ Common Mistakes

| Mistake                         | Problem                                 | Solution                                                    |
| ------------------------------- | --------------------------------------- | ----------------------------------------------------------- |
| No `catch` around the read      | Page stays on "Loading…" forever        | Catch the error and show `err.message`                      |
| Rendering a bare number         | `24000000000` means nothing to a user   | Always label the unit (`wei`, `gwei`)                       |
| Dividing wei by hand            | Rounding and lost digits                | Use `ethers.formatUnits(value, "gwei")`                     |
| Using a wallet for a public read | Users without MetaMask see nothing      | Use `ethers.JsonRpcProvider`                                |
| Putting a secret in `REACT_APP_*` or `VITE_*` | It ships to every visitor's browser | Only public values go there (see below)                     |

**About environment variables.** Keeping the RPC URL in an env variable is good practice because you can change networks without editing code. But it is **not** a way to hide secrets. In a front-end app, every `REACT_APP_*` value (Create React App) and every `VITE_*` value (Vite, the build tool you should use for new projects, read through `import.meta.env.VITE_RPC_URL`) is copied into the JavaScript bundle that every visitor downloads. Anyone can open DevTools and read it. So: a public RPC URL or a contract address is fine there; a private key, a paid API secret or a database password never is. If an RPC key must stay private, put it behind your own server.

This course's grader supplies the values as `process.env.REACT_APP_*`, so that is the form the activity uses.

---

### ✅ How This Is Graded

The grader runs your component with ethers v6 against a mock Sepolia contract. It checks that you build a `JsonRpcProvider`, call `getBaseFee()`, render the exact fee (in wei or gwei) with a unit label, leave the loading state, and show an error, not "Loading", when the read reverts. The activity page lists the exact details.

---

### 🔗 External Resources

| Resource                         | Link                                                                    |
| -------------------------------- | ----------------------------------------------------------------------- |
| EIP-1559 specification           | https://eips.ethereum.org/EIPS/eip-1559                                 |
| Ethereum gas and fees            | https://ethereum.org/en/developers/docs/gas/                            |
| ethers v6: Providers             | https://docs.ethers.org/v6/api/providers/                               |
| ethers v6: Units (`formatUnits`) | https://docs.ethers.org/v6/api/utils/                       |
| Solidity global variables        | https://docs.soliditylang.org/en/latest/units-and-global-variables.html |
| Vite env variables               | https://vite.dev/guide/env-and-mode                                     |
| React: effects and cleanup       | https://react.dev/learn/synchronizing-with-effects                      |

---

## 🌟 Closing Story

The next morning Det reopened the demo. This time the number on the screen came from Sepolia itself, and when she pulled her Wi-Fi cable as a test, the page did not freeze on "Loading"; it said plainly that the read had failed. "That," said the quietest investor, "is the part that makes me trust the rest." Next up for GaslessPH: speed tiers built from the priority fee, peso estimates from a live price feed, and a refresh every block. Mabuhay innovation, one gwei at a time! 🇵🇭🚀
