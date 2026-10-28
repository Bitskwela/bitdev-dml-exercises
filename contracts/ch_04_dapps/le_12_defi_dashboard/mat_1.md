## 🧑‍💻 Background Story

![DeFi Dashboard](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+12.0+-+COVER.png)

In a virtual workshop hosted by Ateneo's Blockchain Society, Neri was ready to impress. She had sketched a DeFi dashboard, "Simulated, pero feels real", and turned to Odessa ("Det") to wire up the frontend. Their goal: show a liquidity pool's real numbers, without needing a production protocol.

![DeFi Sim Dashboard](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+12.1.png)

Neri had deployed a tiny `MockLP` contract on Sepolia. It stores two token reserves and a total supply of LP tokens. Det's plan for the first card was simple and strict:

1. Make sure the pool address is valid before touching the network.
2. Read `getReserves()` (two numbers in one call) and `getTotalSupply()`.
3. Show all three, with a clear "Loading" line and a clear error.

"Price and APR badges can come later," Det said. "If the raw numbers are wrong, every badge built on them is wrong too." The Ateneo scholars watched the three numbers appear, straight from the chain. Next stop: prices and rewards. 🇵🇭🪙🚀

---

## 📚 Theory & Web3 Lecture

### 🎯 What You'll Learn

By the end of this lesson you can:

- **validate an address** with `ethers.isAddress` before using it,
- **read a tuple** (a function that returns several values) and unpack it with destructuring,
- keep on-chain numbers as **`bigint`** so nothing is rounded away.

That is what the activity grades. The sections marked **Extension** (price and APR) show what a real DeFi dashboard does next, with correct `bigint` math, but they are not graded.

---

### 📐 What the Activity Builds

```
REACT_APP_LP_ADDRESS ──▶ ethers.isAddress? ──no──▶ throw → red error message
                                 │
                                yes
                                 ▼
   JsonRpcProvider ──▶ MockLP.getReserves()   ──▶ [r0, r1]  ┐
                   └─▶ MockLP.getTotalSupply() ──▶ ts       ├─▶ Reserve0 / Reserve1 / Total Supply
                                                            ┘
```

---

### 🔑 Key Concepts

#### 1. Liquidity pool basics

A **liquidity pool** holds two tokens so people can swap between them. People who deposit tokens receive **LP tokens** as a receipt for their share.

| Component        | Meaning                                  | Example        |
| ---------------- | ---------------------------------------- | -------------- |
| **Reserve0**     | How much of token 0 sits in the pool     | 120 TKO        |
| **Reserve1**     | How much of token 1 sits in the pool     | 45,000 USDC    |
| **Total Supply** | How many LP tokens exist                 | 7.35 LP        |

```
Your share of the pool = your LP tokens / total supply
```

#### 2. The `MockLP` contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MockLP {
    uint112 public reserve0;     // token 0 reserves, in its base units
    uint112 public reserve1;     // token 1 reserves, in its base units
    uint256 public totalSupply;  // LP tokens, 18 decimals

    // Two values in one call: this is a tuple return
    function getReserves() external view returns (uint112, uint112) {
        return (reserve0, reserve1);
    }

    function getTotalSupply() external view returns (uint256) {
        return totalSupply;
    }
}
```

The real Uniswap V2 pair has a similar `getReserves()`, but it returns **three** values: the two reserves plus the timestamp of the last update. Our mock keeps it to two.

#### 3. Validate before you call

```javascript
ethers.isAddress("0x4444444444444444444444444444444444444444"); // true
ethers.isAddress("not-an-address");                             // false
```

Check the address first and `throw` if it is bad. Your `catch` turns that into an error message, and no network call is wasted on a typo. Without the check, ethers v6 treats `"not-an-address"` as a name to look up (like an ENS name), and you get a confusing error such as *"contract runner does not support name resolution"* instead of one that says what is actually wrong.

#### 4. Tuples and destructuring

When a Solidity function returns several values, ethers v6 gives you a `Result`, which behaves like an array. Unpack it in one line:

```javascript
const [r0, r1] = await lp.getReserves(); // both are bigint
const ts = await lp.getTotalSupply();    // bigint
```

#### 5. Base units, decimals and `bigint`

On-chain, token amounts are whole numbers in the token's smallest unit. A token's **decimals** says where the decimal point goes: most tokens use 18, USDC uses 6, WBTC uses 8.

```javascript
const r0 = 120000000000000000000n; // token 0, 18 decimals
const r1 = 45000000000n;           // token 1, 6 decimals (like USDC)
const ts = 7350000000000000000n;   // LP token, 18 decimals

ethers.formatUnits(r0, 18); // "120.0"
ethers.formatUnits(r1, 6);  // "45000.0"
ethers.formatEther(ts);     // "7.35"   (formatEther = formatUnits(x, 18))
```

ethers v6 returns these as native JavaScript `bigint`. You do math with normal operators (`+ - * /`) as long as **both sides are `bigint`** (write literals with an `n`, like `10n`). Division rounds down to a whole number, so **multiply before you divide** to keep precision.

| Operation      | `bigint` example         | Note                                         |
| -------------- | ------------------------ | -------------------------------------------- |
| Add / subtract | `a + b`, `a - b`         | Mixing `bigint` and `Number` throws an error |
| Multiply       | `a * 10n`                | Exact, no size limit                         |
| Divide         | `a / b`                  | Rounds down (`7n / 2n` is `3n`)              |
| Compare        | `a > b`, `a === b`       | Works like normal numbers                    |
| Display        | `a.toString()`, `ethers.formatUnits(a, 18)` | Never `Number(a)` for big values |

---

### ➕ Extension: Price from reserves (not graded)

In a constant-product pool (x × y = k), the spot price of token 0 in token 1 is the ratio of reserves. You must first account for the two tokens' **different decimals**, and keep everything `bigint`:

```javascript
// price of 1 token0, measured in token1, scaled by 1e18 for precision
const d0 = 18n, d1 = 6n;
const SCALE = 10n ** 18n;

const priceScaled = (r1 * 10n ** d0 * SCALE) / (r0 * 10n ** d1);
ethers.formatUnits(priceScaled, 18); // "375.0"  →  1 TKO ≈ 375 USDC
```

Check it by hand: 45,000 USDC / 120 TKO = 375 USDC per TKO. Note that we multiplied by `SCALE` **before** dividing; dividing first would round to a whole number and lose the decimals.

### ➕ Extension: APR in basis points (not graded)

Contracts usually store percentages as **basis points** (bps), because Solidity has no decimals: 1 bps = 0.01%, so 1200 bps = 12.00%.

```javascript
const aprBps = 1200n; // e.g. read from a getMockAPR() function
const label = `${aprBps / 100n}.${(aprBps % 100n).toString().padStart(2, "0")}%`;
// "12.00%"
```

A real pool's APR comes from trading fees and rewards over time, not from a stored number. A mock APR is fine for a demo, as long as the UI says it is simulated.

---

### 📊 Real vs Mock LP Contracts

| Feature      | Real LP (Uniswap V2)        | Mock LP (this lesson)  |
| ------------ | --------------------------- | ---------------------- |
| Reserves     | Change with every swap      | Set by the deployer    |
| `getReserves` | Two reserves + a timestamp | Two reserves           |
| Total supply | Minted on deposit, burned on withdraw | Fixed value  |
| Swapping     | Full AMM logic              | Not implemented        |

---

### ⚠️ Common Mistakes

| Mistake                                | Problem                                   | Solution                                     |
| -------------------------------------- | ----------------------------------------- | -------------------------------------------- |
| Validating the address too late       | A typo reaches the network                | `ethers.isAddress` check first, then `throw` |
| `const r = await lp.getReserves()`     | Only the pair object, not two values      | `const [r0, r1] = await lp.getReserves()`    |
| `Number(r0)` for math                  | Precision loss above about 9 quadrillion  | Keep `bigint`, format only for display       |
| Mixing `bigint` and `Number`           | `TypeError: Cannot mix BigInt and other types` | Write `10n`, not `10`                    |
| Dividing before multiplying           | Decimals rounded away                     | Multiply by a scale first                    |
| Ignoring token decimals in a price     | Price off by 10¹² or more                 | Adjust by `10n ** decimals`                  |

---

### ✅ How This Is Graded

The grader runs your component with ethers v6 against a mock Sepolia pool. It sets an invalid address once and checks you never call `getReserves()` and never get stuck on "Loading". With the real address it checks you use a `JsonRpcProvider`, call both functions, and show both reserves and the total supply as exact values (raw, or formatted with 6, 8 or 18 decimals). The activity page lists every detail.

---

### 🔗 External Resources

| Resource                           | Link                                                                               |
| ---------------------------------- | ---------------------------------------------------------------------------------- |
| ethers v6: Addresses (`isAddress`) | https://docs.ethers.org/v6/api/address/                                            |
| ethers v6: Units (`formatUnits`)   | https://docs.ethers.org/v6/api/utils/                                  |
| ethers v6 migration (BigNumber → bigint) <!-- v5-ok --> | https://docs.ethers.org/v6/migrating/                                        |
| MDN: BigInt                        | https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/BigInt |
| Uniswap V2: how it works           | https://docs.uniswap.org/contracts/v2/concepts/protocol-overview/how-uniswap-works |
| Uniswap V2 whitepaper              | https://uniswap.org/whitepaper.pdf                                                 |

---

## 🌟 Closing Story

After the workshop, the Ateneo scholars chatted excitedly: "Feels like real DeFi!" One of them had typed the pool address wrong on purpose, and instead of a blank screen the dashboard said plainly, "Invalid LP contract address." Neri raised a virtual toast. Next up: a price badge using the decimal-aware `bigint` formula, a simulated APR, and a version on Polygon's Amoy testnet. From simulation to mainnet, Filipino Web3 excellence marches on! 🇵🇭🪙🚀
