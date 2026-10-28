## 🧑‍💻 Background Story

![BaryoToken Launch](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+6.0+-+COVER.png)

It was a humid afternoon in Marikina, rain clouds gathering over the riverbanks. Inside a humble sari-sari store turned DAO hub, barangay residents gathered around a laptop. Neri's latest innovation, BaryoToken, had just launched. Each token represented a voucher for rice, canned goods, even sari-sari store credit.

![Det Building Token Tracker](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+6.1.png)

Odessa ("Det") was on the case. Fresh from building an NFT gallery in SF, she now needed a simple wallet page for OFWs sending BaryoToken back home. Her mission, a "Balancer" page that:

1. Reads and displays the token's `name()`, `symbol()`, and `decimals()`
2. Connects to MetaMask
3. Fetches the user's `balanceOf()` and shows it in human-readable form

In about 30 minutes, Det had a React page with a "Fetch My Balance" button. When barangay captain Mang Jun clicked it, his balance lit up on screen: 25.5 BARYO. Smiles spread. Now elders, OFWs, and sari-sari store owners could see their holdings in plain numbers. For Det, this proof of concept was enough: Filipino ingenuity and Web3 could transform local economies.

---

## 📚 Theory & Web3 Lecture

Welcome to the world of **ERC-20 tokens**! In this lesson you build a Token Tracker, a UI that displays a token's information and your balance. Think of it as the "balance inquiry" screen of a digital wallet.

> **This lesson uses ethers v6.** If you find older tutorials online that write `ethers.utils...` or `ethers.providers...`, those are ethers v5 and will not run here. Every snippet below is v6. <!-- v5-ok -->

---

### 1. Understanding ERC-20 Tokens

#### **What is ERC-20?**

ERC-20 is a **standard interface** for fungible tokens on Ethereum. "Fungible" means each token is identical and interchangeable, like how one peso coin equals any other peso coin.

```
ERC-20 Token vs Traditional Currency:
┌─────────────────────────────────────────────────────────────┐
│  Philippine Peso (₱)          │  BaryoToken (BARYO)         │
├─────────────────────────────────────────────────────────────┤
│  Physical coins/bills         │  Digital on blockchain      │
│  Managed by BSP               │  Managed by smart contract  │
│  Bank tracks your balance     │  Contract tracks balances   │
│  Transfer via bank/GCash      │  Transfer via blockchain    │
└─────────────────────────────────────────────────────────────┘
```

#### **The ERC-20 Interface**

Every ERC-20 token exposes these functions (`name`, `symbol` and `decimals` are technically optional in the standard, but nearly every real token has them):

```solidity
// Metadata functions (read-only)
function name() external view returns (string memory);      // "BaryoToken"
function symbol() external view returns (string memory);    // "BARYO"
function decimals() external view returns (uint8);          // 18

// Supply
function totalSupply() external view returns (uint256);

// Balances
function balanceOf(address account) external view returns (uint256);

// Transfers
function transfer(address to, uint256 amount) external returns (bool);
function approve(address spender, uint256 amount) external returns (bool);
function transferFrom(address from, address to, uint256 amount) external returns (bool);
function allowance(address owner, address spender) external view returns (uint256);
```

This lesson only **reads**: `name`, `symbol`, `decimals` and `balanceOf`. Sending tokens is Lesson 08.

#### **Understanding Decimals**

This is crucial! Token amounts are stored as **whole integers**, never as decimals:

```
Real-World Example:
┌─────────────────────────────────────────────────────────────┐
│  Human sees:        25.5 BARYO                              │
│  Blockchain stores: 25500000000000000000 (with 18 decimals) │
│                                                             │
│  Think of it like:                                          │
│  ₱25.50 = 2550 centavos                                     │
│  But with 18 decimal places instead of 2!                   │
└─────────────────────────────────────────────────────────────┘

Common decimal values:
┌──────────────┬──────────┬────────────────────────────────────┐
│ Token        │ Decimals │ 1 token = raw value                │
├──────────────┼──────────┼────────────────────────────────────┤
│ Most tokens  │ 18       │ 1000000000000000000                │
│ USDC, USDT   │ 6        │ 1000000                            │
│ WBTC         │ 8        │ 100000000                          │
└──────────────┴──────────┴────────────────────────────────────┘
```

So the screen must always **divide by 10^decimals** before showing a balance. ethers does that for you with `formatUnits`.

---

### 2. React + ethers Architecture

#### **Component Shape**

```
TokenTracker (one component)
┌─────────────────────────────────────────────────────────────┐
│ On mount (useEffect):                                       │
│   • validate tokenAddress                                   │
│   • read name, symbol, decimals  (read-only provider)       │
│                                                             │
│ On click "Fetch My Balance":                                │
│   • ask MetaMask for the account                            │
│   • read balanceOf(account), format with decimals           │
└─────────────────────────────────────────────────────────────┘
```

#### **Provider vs Signer Recap**

| Piece        | Type         | Purpose               | Gas Cost  |
| ------------ | ------------ | --------------------- | --------- |
| **Provider** | Read-only    | Call `view` functions | FREE      |
| **Signer**   | Read + Write | Send transactions     | Costs ETH |

```js
// Provider: for reading data (name, symbol, balance)
const provider = new ethers.BrowserProvider(window.ethereum);
const contract = new ethers.Contract(address, ABI, provider);
const name = await contract.name(); // Free!

// Signer: for writing data (Lesson 08). In v6, getSigner() is async.
const signer = await provider.getSigner();
const tokenWithSigner = contract.connect(signer);
// const tx = await tokenWithSigner.transfer(to, amount); // Costs gas!
```

There are two providers you will meet in v6:

- `new ethers.JsonRpcProvider(url)`: talks straight to an RPC node (Infura, Alchemy, a public Sepolia endpoint). No wallet needed, perfect for reading on page load.
- `new ethers.BrowserProvider(window.ethereum)`: talks through MetaMask, so it knows which account the user picked.

---

### 3. Fetching Token Information

#### **The ABI (Application Binary Interface)**

To talk to a smart contract you need its ABI, a description of its functions. ethers accepts a short "human-readable" form:

```js
// Minimal ABI for reading token info
const ERC20_ABI = [
  "function name() view returns (string)",
  "function symbol() view returns (string)",
  "function decimals() view returns (uint8)",
  "function totalSupply() view returns (uint256)",
  "function balanceOf(address) view returns (uint256)",
];
```

You only list the functions you actually call. Much easier than a full JSON ABI.

#### **Where the RPC URL Lives**

Never paste an RPC key straight into code. Put it in an environment file.

In a **Vite** React app (the modern default), variables must start with `VITE_` and you read them from `import.meta.env`:

```
# .env  (keep it out of git)
VITE_RPC_URL=https://sepolia.infura.io/v3/YOUR_KEY
```

```js
const provider = new ethers.JsonRpcProvider(import.meta.env.VITE_RPC_URL);
```

The activity's grader uses the older naming instead and supplies `process.env.REACT_APP_RPC_URL` for you, so **in the activity write `process.env.REACT_APP_RPC_URL`**. Same idea, different label.

Anything starting with `VITE_` ends up inside the JavaScript bundle that every visitor downloads, so only put **public-safe** values there (an RPC URL with a rate-limited key is normal; a private key never is).

#### **Fetching Token Info, Step by Step**

```js
async function fetchTokenInfo(contractAddress) {
  // Step 1: Validate the address before touching the chain
  if (!ethers.isAddress(contractAddress)) {
    throw new Error("Invalid contract address");
  }

  // Step 2: Connect to the contract with a read-only provider
  const provider = new ethers.JsonRpcProvider(import.meta.env.VITE_RPC_URL);
  const contract = new ethers.Contract(contractAddress, ERC20_ABI, provider);

  // Step 3: Fetch everything in parallel
  const [name, symbol, decimals, totalSupply] = await Promise.all([
    contract.name(),
    contract.symbol(),
    contract.decimals(),
    contract.totalSupply(),
  ]);

  // Step 4: Format the total supply for humans
  const formattedSupply = ethers.formatUnits(totalSupply, decimals);

  return {
    name, // "BaryoToken"
    symbol, // "BARYO"
    decimals, // 18n  (a bigint in v6)
    totalSupply: formattedSupply, // "1000000.0"
  };
}
```

---

### 4. Fetching & Formatting Balances

#### **Big Numbers in JavaScript**

A normal JavaScript `number` is only exact up to `Number.MAX_SAFE_INTEGER` (about 9 quadrillion, 9 × 10^15). Token balances blow past that easily: 25.5 tokens is 25.5 × 10^18 raw units.

JavaScript has a built-in type for this: **`bigint`**, written with an `n` at the end (`123n`). ethers v6 returns every `uint256` (and even `uint8`) as a `bigint`.

```js
// ❌ Problem: a regular number loses precision
const huge = 123456789012345678901234n;
Number(huge); // 1.2345678901234569e+23  (digits lost!)

// ✅ ethers v6 gives you a bigint, exact to the last digit
const balance = await contract.balanceOf(userAddress);
console.log(balance);            // 123456789012345678901234n
console.log(balance.toString()); // "123456789012345678901234"

// Format for display
console.log(ethers.formatUnits(balance, 18)); // "123456.789012345678901234"
```

#### **Complete Balance Flow**

```js
async function fetchBalance(contractAddress) {
  // Ask MetaMask which account to use (opens the pop-up the first time)
  const [user] = await window.ethereum.request({
    method: "eth_requestAccounts",
  });

  const provider = new ethers.BrowserProvider(window.ethereum);
  const contract = new ethers.Contract(contractAddress, ERC20_ABI, provider);

  const [rawBalance, decimals, symbol] = await Promise.all([
    contract.balanceOf(user),
    contract.decimals(),
    contract.symbol(),
  ]);

  console.log("Raw balance:", rawBalance); // 25500000000000000000n

  const formatted = ethers.formatUnits(rawBalance, decimals);
  console.log("Formatted:", formatted); // "25.5"

  return `${formatted} ${symbol}`; // "25.5 BARYO"
}
```

#### **Formatting Utilities**

```js
// formatUnits: raw bigint → string (for display)
ethers.formatUnits(25500000000000000000n, 18); // "25.5"
ethers.formatUnits(12345n, 2);                 // "123.45"

// parseUnits: human string → raw bigint (for sending, Lesson 08)
ethers.parseUnits("25.5", 18); // 25500000000000000000n

// formatEther / parseEther: shortcuts for 18 decimals
ethers.formatEther(1000000000000000000n); // "1.0"
```

---

### 5. React Hook Patterns

You can wrap these reads in your own hook so any component can reuse them.

#### **Token Info Hook**

```jsx
function useTokenInfo(contractAddress) {
  const [info, setInfo] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    async function load() {
      if (!contractAddress) return;
      setLoading(true);
      setError(null);

      try {
        if (!ethers.isAddress(contractAddress)) {
          throw new Error("Invalid address");
        }

        const provider = new ethers.JsonRpcProvider(import.meta.env.VITE_RPC_URL);
        const contract = new ethers.Contract(contractAddress, ABI, provider);

        const [name, symbol, decimals] = await Promise.all([
          contract.name(),
          contract.symbol(),
          contract.decimals(),
        ]);

        setInfo({ name, symbol, decimals: Number(decimals) });
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }

    load();
  }, [contractAddress]); // Re-run when the address changes

  return { info, loading, error };
}
```

`Number(decimals)` is safe here because decimals is always a small number (0 to 255). Never do `Number(balance)` on a token balance: that is exactly the precision trap from section 4.

#### **Why `useEffect` Needs an Inner Function**

`useEffect(async () => {...})` looks tempting but is wrong: React expects the effect to return nothing or a cleanup function, and an `async` function always returns a Promise. So you define an `async` function **inside** the effect and call it, as `load()` does above.

---

### 6. Input Validation & Error Handling

#### **Validating Contract Addresses**

```js
function validateAddress(address) {
  // Is it a well-formed Ethereum address?
  if (!ethers.isAddress(address)) {
    return { valid: false, error: "Invalid address format" };
  }

  // Is it the zero address (0x000...0)?
  if (address === ethers.ZeroAddress) {
    return { valid: false, error: "Cannot use zero address" };
  }

  return { valid: true, error: null };
}
```

`ethers.isAddress("not-an-address")` returns `false`, so your code can stop before sending a request that would only fail.

#### **Common Error Scenarios (ethers v6 codes)**

| Error code         | Typical cause                                   | What to show                     |
| ------------------ | ----------------------------------------------- | -------------------------------- |
| `BAD_DATA`         | Address has no contract (call returned `0x`)    | "That is not a token contract"   |
| `CALL_EXCEPTION`   | The contract reverted                           | "The token rejected the request" |
| `ACTION_REJECTED`  | User clicked Reject in MetaMask                 | "Request cancelled"              |
| `NETWORK_ERROR`    | RPC unreachable, or the user switched networks  | "Network problem, try again"     |

```js
async function safeContractCall(contractFn) {
  try {
    return await contractFn();
  } catch (err) {
    if (err.code === "BAD_DATA") throw new Error("This doesn't look like an ERC-20 token");
    if (err.code === "CALL_EXCEPTION") throw new Error("The token rejected the request");
    if (err.code === "ACTION_REJECTED") throw new Error("Request cancelled by user");
    if (err.code === "NETWORK_ERROR") throw new Error("Network error - check your connection");
    throw err;
  }
}
```

---

### 7. Best Practices & Security

1. ✅ Validate every address before using it
2. ✅ Never put a private key in frontend code or a `VITE_` variable
3. ✅ Use HTTPS RPC endpoints
4. ✅ Handle the error cases above with friendly messages
5. ✅ Hard-code the ABI you expect; don't trust an ABI a stranger sends you
6. ✅ Check a token's address on [Sepolia Etherscan](https://sepolia.etherscan.io) before trusting it

---

### 8. Common Mistakes to Avoid

#### **1. Not Handling Decimals**

```js
// ❌ BAD: displaying the raw value
const balance = await contract.balanceOf(user);
display(balance.toString()); // "25500000000000000000" 😱

// ✅ GOOD: format with decimals
const decimals = await contract.decimals();
display(ethers.formatUnits(balance, decimals)); // "25.5" 👍
```

#### **2. Forgetting That `getSigner()` Is Async in v6**

```js
// ❌ BAD: signer is a Promise, not a signer
const signer = provider.getSigner();
await signer.getAddress(); // TypeError!

// ✅ GOOD: await it. MetaMask asks the user to connect if needed.
const signer = await provider.getSigner();
const address = await signer.getAddress();
```

#### **3. Not Using Promise.all**

```js
// ❌ SLOW: three waits in a row
const name = await contract.name();
const symbol = await contract.symbol();
const decimals = await contract.decimals();

// ✅ FAST: all three in flight at once
const [name, symbol, decimals] = await Promise.all([
  contract.name(),
  contract.symbol(),
  contract.decimals(),
]);
```

---

### 9. How This Is Graded

Your activity runs inside a sandbox with a fake wallet and a fake token called **Barangay Peso (BPSO)**, holding a raw balance of `2500000000000000000` with 18 decimals. The grader checks that you read the metadata on mount, skip every read for an invalid address, ask for the account and read `balanceOf` when the **Fetch** button is clicked, and show `2.5`, never the raw integer.

---

### External References & Further Learning

- **ethers v6 documentation**: https://docs.ethers.org/v6/ (see "Contracts" and "Utilities → Units")
- **OpenZeppelin ERC-20 (v5)**: https://docs.openzeppelin.com/contracts/5.x/erc20
- **EIP-20 specification**: https://eips.ethereum.org/EIPS/eip-20
- **React `useEffect`**: https://react.dev/reference/react/useEffect
- **Vite environment variables**: https://vite.dev/guide/env-and-mode
- **Sepolia Etherscan token tracker**: https://sepolia.etherscan.io/tokens

---

## 🧪 Exercises

### Exercise 1: Show Token Info From a Typed Address

**Problem Statement**
Build a component where the user pastes a contract address, clicks **Load**, and sees the token's `name()`, `symbol()` and `decimals()`.

**Solidity Contract (`BaryoToken.sol`, OpenZeppelin v5)**

```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BaryoToken is ERC20, Ownable {
    constructor(uint256 initialSupply)
        ERC20("BaryoToken", "BARYO")
        Ownable(msg.sender)
    {
        _mint(msg.sender, initialSupply);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}
```

In OpenZeppelin v5, `Ownable` needs the first owner passed in: `Ownable(msg.sender)`.

**Starter Code (`TokenInfo.jsx`)**

```jsx
import { useState } from "react";
import { ethers } from "ethers";

const ABI = [
  "function name() view returns (string)",
  "function symbol() view returns (string)",
  "function decimals() view returns (uint8)",
];

export default function TokenInfo() {
  const [addr, setAddr] = useState("");
  const [info, setInfo] = useState({});
  const [error, setError] = useState("");

  async function loadInfo() {
    try {
      // TODO: Validate address with ethers.isAddress
      // TODO: Create provider & contract
      // TODO: Call name(), symbol(), decimals()
      // TODO: setInfo({ name, symbol, decimals })
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <div>
      <h2>ERC-20 Token Info</h2>
      <input
        type="text"
        placeholder="Contract Address"
        value={addr}
        onChange={(e) => setAddr(e.target.value)}
      />
      <button onClick={loadInfo}>Load</button>
      {error && <p style={{ color: "red" }}>{error}</p>}
      {info.name && (
        <div>
          <p>Name: {info.name}</p>
          <p>Symbol: {info.symbol}</p>
          <p>Decimals: {info.decimals}</p>
        </div>
      )}
    </div>
  );
}
```

**Full Solution**

```jsx
// TokenInfo.jsx
import { useState } from "react";
import { ethers } from "ethers";

const ABI = [
  "function name() view returns (string)",
  "function symbol() view returns (string)",
  "function decimals() view returns (uint8)",
];

export default function TokenInfo() {
  const [addr, setAddr] = useState("");
  const [info, setInfo] = useState({});
  const [error, setError] = useState("");

  async function loadInfo() {
    setError("");
    setInfo({});
    if (!ethers.isAddress(addr)) {
      setError("Invalid address");
      return;
    }
    try {
      const provider = new ethers.JsonRpcProvider(import.meta.env.VITE_RPC_URL);
      const token = new ethers.Contract(addr, ABI, provider);
      const [name, symbol, decimals] = await Promise.all([
        token.name(),
        token.symbol(),
        token.decimals(),
      ]);
      setInfo({ name, symbol, decimals: decimals.toString() });
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <div>
      <h2>ERC-20 Token Info</h2>
      <input
        type="text"
        placeholder="Contract Address"
        value={addr}
        onChange={(e) => setAddr(e.target.value)}
      />
      <button onClick={loadInfo}>Load</button>
      {error && <p style={{ color: "red" }}>{error}</p>}
      {info.name && (
        <div>
          <p>Name: {info.name}</p>
          <p>Symbol: {info.symbol}</p>
          <p>Decimals: {info.decimals}</p>
        </div>
      )}
    </div>
  );
}
```

Reading metadata needs no wallet at all, which is why this uses `JsonRpcProvider` and never asks MetaMask.

---

### Exercise 2: Display the Connected Wallet's Balance

**Problem Statement**
Extend your UI to read `balanceOf(userAddress)`, format it with `decimals()`, and show "Your Balance: 123.45 BARYO".

**Full Solution (`TokenBalance.jsx`)**

```jsx
import { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function symbol() view returns (string)",
  "function decimals() view returns (uint8)",
  "function balanceOf(address) view returns (uint256)",
];

export default function TokenBalance({ contractAddress }) {
  const [balance, setBalance] = useState("");
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadBalance() {
      try {
        const provider = new ethers.BrowserProvider(window.ethereum);
        const signer = await provider.getSigner(); // prompts MetaMask if needed
        const user = await signer.getAddress();

        const token = new ethers.Contract(contractAddress, ABI, provider);
        const [sym, dec, raw] = await Promise.all([
          token.symbol(),
          token.decimals(),
          token.balanceOf(user),
        ]);
        setBalance(`${ethers.formatUnits(raw, dec)} ${sym}`);
      } catch (err) {
        setError(err.message);
      }
    }
    if (contractAddress) loadBalance();
  }, [contractAddress]);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  return (
    <div>
      <h3>Your Balance</h3>
      <p>{balance || "Loading..."}</p>
    </div>
  );
}
```

This version asks for the account with `await provider.getSigner()` instead of `eth_requestAccounts`. Both open the same MetaMask "connect" prompt; pick whichever reads clearer to you.

Popping a wallet prompt the moment a page loads can feel pushy. In a real app, prefer a button the user clicks, which is exactly what the activity does.

---

### Exercise 3 (Bonus Preview): A Transfer Form

Sending tokens is the whole point of **Lesson 08**, so here is only a preview of the one new idea: `parseUnits` turns what the user typed back into raw units, and the call goes through a **signer**.

```js
const provider = new ethers.BrowserProvider(window.ethereum);
const signer = await provider.getSigner();
const token = new ethers.Contract(contractAddress, ABI, signer);

const decimals = await token.decimals();
const tx = await token.transfer(to, ethers.parseUnits(amount, decimals));
await tx.wait(); // wait until it is mined
```

---

## 🌟 Closing Story

As the barangay store's old credit machine hummed, Mang Jun saw "125.5 BARYO" pop up on his screen. "Para bang cash!" he exclaimed. Odessa leaned back: her Balancer UI was a hit. OFWs in Tokyo could now check their Marikina tokens in real time. Next up: letting them actually send tokens home. Odessa's journey had only begun. Mabuhay Web3 in the Philippines, let's code the future! 🇵🇭🚀
