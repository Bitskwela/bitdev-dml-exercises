## 🧑‍💻 Background Story

![BaryoToken Launch](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+6.0+-+COVER.png)

It was a humid afternoon in Marikina—rain clouds gathering over the riverbanks. Inside a humble sari-sari store turned DAO-hub, barangay residents gathered around a laptop. Neri’s latest innovation, BaryoToken, had just launched. Each token represented a voucher for rice, canned goods, even sari-sari store credit.

![Det Building Token Tracker](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+6.1.png)

Odessa (“Det”) was on the case. Fresh from her stint building an NFT gallery in SF, she now needed to craft a remittance-ready wallet UI for OFWs sending BaryoToken back home. Her mission: a “Balancer” page that:

1. Connects to MetaMask or any Ethers wallet
2. Reads and displays the token’s `name()`, `symbol()`, and `decimals()`
3. Fetches and formats the user’s token `balanceOf()` in human-readable form

In just 30 minutes, Det sketched a React page: an input to switch BaryoToken contract addresses, a “Connect Wallet” button, and a “Fetch Balance” card. When barangay captain Mang Jun clicked “Load,” the balance lit up on screen—₱25.50 worth of BaryoToken. Smiles spread: now elders, OFWs, and sari-sari store owners could see their holdings in real pesos. For Det, this POCs’ magic was enough—proof that Filipino ingenuity and Web3 could transform local economies. Next stop: cross-border remittances for OFWs.

---

## 📚 Theory & Web3 Lecture

Welcome to the world of **ERC-20 tokens**! In this lesson, you'll learn how to build a Token Tracker—a UI that displays token information and balances. Think of it like a digital wallet display for crypto tokens!

---

### 1. Understanding ERC-20 Tokens

#### **What is ERC-20?**

ERC-20 is a **standard interface** for fungible tokens on Ethereum. "Fungible" means each token is identical and interchangeable—like how one peso coin equals any other peso coin.

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

Every ERC-20 token must implement these functions:

```solidity
// Metadata functions (read-only)
function name() external view returns (string);      // "BaryoToken"
function symbol() external view returns (string);    // "BARYO"
function decimals() external view returns (uint8);   // 18

// Supply functions
function totalSupply() external view returns (uint256);

// Balance functions
function balanceOf(address account) external view returns (uint256);

// Transfer functions
function transfer(address to, uint256 amount) external returns (bool);
function approve(address spender, uint256 amount) external returns (bool);
function transferFrom(address from, address to, uint256 amount) external returns (bool);
function allowance(address owner, address spender) external view returns (uint256);
```

#### **Understanding Decimals**

This is crucial! Token amounts are stored as **integers**, not decimals:

```
Real-World Example:
┌─────────────────────────────────────────────────────────────┐
│  Human sees:     25.50 BARYO                                │
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

---

### 2. React + Ethers.js Architecture

#### **Component Architecture**

```
Token Tracker App Structure:
┌─────────────────────────────────────────────────────────────┐
│                       App.js                                 │
│  ┌─────────────────────────────────────────────────────────┐│
│  │                  TokenInfo.js                           ││
│  │  • Displays name, symbol, decimals                      ││
│  │  • Uses Provider (read-only)                            ││
│  └─────────────────────────────────────────────────────────┘│
│  ┌─────────────────────────────────────────────────────────┐│
│  │                TokenBalance.js                          ││
│  │  • Shows user's token balance                           ││
│  │  • Formats raw BigNumber to human-readable              ││
│  └─────────────────────────────────────────────────────────┘│
│  ┌─────────────────────────────────────────────────────────┐│
│  │                TokenTransfer.js (Bonus)                 ││
│  │  • Send tokens to another address                       ││
│  │  • Uses Signer (write operations)                       ││
│  └─────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────┘
```

#### **Provider vs Signer Recap**

| Component    | Type         | Purpose               | Gas Cost  |
| ------------ | ------------ | --------------------- | --------- |
| **Provider** | Read-only    | Call `view` functions | FREE      |
| **Signer**   | Read + Write | Send transactions     | Costs ETH |

```js
// Provider: For reading data (name, symbol, balance)
const provider = new ethers.BrowserProvider(window.ethereum);
const contract = new ethers.Contract(address, ABI, provider);
const name = await contract.name(); // Free!

// Signer: For writing data (transfer tokens)
const signer = await provider.getSigner();
const contractWithSigner = new ethers.Contract(address, ABI, signer);
const tx = await contractWithSigner.transfer(to, amount); // Costs gas!
```

---

### 3. Fetching Token Information

#### **The ABI (Application Binary Interface)**

To talk to a smart contract, you need its ABI—a JSON description of its functions:

```js
// Minimal ABI for reading token info
const ERC20_ABI = [
  // Read functions (view)
  "function name() view returns (string)",
  "function symbol() view returns (string)",
  "function decimals() view returns (uint8)",
  "function totalSupply() view returns (uint256)",
  "function balanceOf(address) view returns (uint256)",

  // Write functions (state-changing)
  "function transfer(address to, uint256 amount) returns (bool)",
];

// Human-readable ABI format (Ethers.js feature!)
// Much easier than full JSON ABI
```

#### **Complete Token Info Fetching**

```js
async function fetchTokenInfo(contractAddress) {
  // Step 1: Validate the address
  if (!ethers.isAddress(contractAddress)) {
    throw new Error("Invalid contract address");
  }

  // Step 2: Connect to the contract
  const provider = new ethers.BrowserProvider(window.ethereum);
  const contract = new ethers.Contract(contractAddress, ERC20_ABI, provider);

  // Step 3: Fetch all info in parallel (faster!)
  const [name, symbol, decimals, totalSupply] = await Promise.all([
    contract.name(),
    contract.symbol(),
    contract.decimals(),
    contract.totalSupply(),
  ]);

  // Step 4: Format the total supply
  const formattedSupply = ethers.formatUnits(totalSupply, decimals);

  return {
    name, // "BaryoToken"
    symbol, // "BARYO"
    decimals, // 18
    totalSupply: formattedSupply, // "1000000.0"
  };
}
```

---

### 4. Fetching & Formatting Balances

#### **The BigNumber Challenge**

JavaScript can't handle numbers larger than `Number.MAX_SAFE_INTEGER` (about 9 quadrillion). Token balances easily exceed this!

```js
// ❌ Problem: JavaScript loses precision
const bigNumber = 123456789012345678901234n;
Number(bigNumber); // 1.2345678901234568e+23 (lost precision!)

// ✅ Solution: Use Ethers.js BigNumber
const balance = await contract.balanceOf(userAddress);
console.log(balance.toString()); // "123456789012345678901234"

// Format for display
const formatted = ethers.formatUnits(balance, 18);
console.log(formatted); // "123456.789012345678901234"
```

#### **Complete Balance Fetching Flow**

```js
async function fetchBalance(contractAddress, userAddress) {
  const provider = new ethers.BrowserProvider(window.ethereum);
  const contract = new ethers.Contract(contractAddress, ERC20_ABI, provider);

  // Fetch balance and decimals
  const [rawBalance, decimals, symbol] = await Promise.all([
    contract.balanceOf(userAddress),
    contract.decimals(),
    contract.symbol(),
  ]);

  // rawBalance is a BigNumber like: 25500000000000000000
  console.log("Raw balance:", rawBalance.toString());

  // Format to human-readable
  const formatted = ethers.formatUnits(rawBalance, decimals);
  console.log("Formatted:", formatted); // "25.5"

  return `${formatted} ${symbol}`; // "25.5 BARYO"
}
```

#### **Formatting Utilities**

```js
// formatUnits: BigNumber → String (for display)
ethers.formatUnits("25500000000000000000", 18); // "25.5"

// parseUnits: String → BigNumber (for transactions)
ethers.parseUnits("25.5", 18);
// BigNumber: 25500000000000000000

// Common patterns:
const displayBalance = ethers.formatUnits(raw, decimals);
const sendAmount = ethers.parseUnits(userInput, decimals);
```

---

### 5. React Hook Patterns

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
        // Validate address first
        if (!ethers.isAddress(contractAddress)) {
          throw new Error("Invalid address");
        }

        const provider = new ethers.BrowserProvider(window.ethereum);
        const contract = new ethers.Contract(contractAddress, ABI, provider);

        const [name, symbol, decimals] = await Promise.all([
          contract.name(),
          contract.symbol(),
          contract.decimals(),
        ]);

        setInfo({ name, symbol, decimals: decimals.toString() });
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }

    load();
  }, [contractAddress]); // Re-run when address changes

  return { info, loading, error };
}
```

#### **Token Balance Hook**

```jsx
function useTokenBalance(contractAddress) {
  const [account, setAccount] = useState("");
  const [balance, setBalance] = useState("");
  const [error, setError] = useState(null);

  useEffect(() => {
    async function loadBalance() {
      if (!contractAddress) return;

      try {
        // Request account access
        const [user] = await window.ethereum.request({
          method: "eth_requestAccounts",
        });
        setAccount(user);

        // Fetch balance
        const provider = new ethers.BrowserProvider(window.ethereum);
        const contract = new ethers.Contract(contractAddress, ABI, provider);

        const [rawBalance, decimals, symbol] = await Promise.all([
          contract.balanceOf(user),
          contract.decimals(),
          contract.symbol(),
        ]);

        const formatted = ethers.formatUnits(rawBalance, decimals);
        setBalance(`${formatted} ${symbol}`);
      } catch (err) {
        setError(err.message);
      }
    }

    loadBalance();
  }, [contractAddress]);

  return { account, balance, error };
}
```

---

### 6. Input Validation & Error Handling

#### **Validating Contract Addresses**

```js
function validateAddress(address) {
  // Check if it's a valid Ethereum address format
  if (!ethers.isAddress(address)) {
    return { valid: false, error: "Invalid address format" };
  }

  // Check if it's the zero address
  if (address === ethers.ZeroAddress) {
    return { valid: false, error: "Cannot use zero address" };
  }

  return { valid: true, error: null };
}

// Usage in component
const handleSubmit = async () => {
  const { valid, error } = validateAddress(inputAddress);
  if (!valid) {
    setError(error);
    return;
  }
  // Proceed with fetching...
};
```

#### **Common Error Scenarios**

| Error                   | Cause                  | Solution                    |
| ----------------------- | ---------------------- | --------------------------- |
| "Invalid address"       | Wrong format           | Validate with `isAddress()` |
| "call revert exception" | Not an ERC-20 contract | Verify contract address     |
| "network changed"       | User switched networks | Re-connect and re-fetch     |
| "user rejected"         | User denied MetaMask   | Show friendly message       |

```js
async function safeContractCall(contractFn) {
  try {
    return await contractFn();
  } catch (err) {
    if (err.code === "CALL_EXCEPTION") {
      throw new Error("This doesn't appear to be a valid ERC-20 token");
    }
    if (err.code === 4001) {
      throw new Error("Request cancelled by user");
    }
    if (err.code === "NETWORK_ERROR") {
      throw new Error("Network error - check your connection");
    }
    throw err;
  }
}
```

---

### 7. Best Practices & Security

#### **Environment Variables**

Never hardcode sensitive values:

```js
// ❌ BAD: Hardcoded
const RPC_URL = "https://mainnet.infura.io/v3/abc123secret";

// ✅ GOOD: Environment variable
const RPC_URL = process.env.REACT_APP_RPC_URL;
```

**.env file:**

```
REACT_APP_RPC_URL=https://sepolia.infura.io/v3/YOUR_KEY
REACT_APP_CONTRACT_ADDRESS=0x...
```

#### **Security Checklist**

1. ✅ Validate all user inputs
2. ✅ Never store private keys
3. ✅ Use HTTPS for RPC endpoints
4. ✅ Handle all error cases
5. ✅ Don't trust user-provided ABIs
6. ✅ Verify contract addresses on Etherscan

---

### 8. Common Mistakes to Avoid

#### **1. Not Handling Decimals**

```js
// ❌ BAD: Displaying raw value
const balance = await contract.balanceOf(user);
display(balance.toString()); // "25500000000000000000" 😱

// ✅ GOOD: Format with decimals
const decimals = await contract.decimals();
const formatted = ethers.formatUnits(balance, decimals);
display(formatted); // "25.5" 👍
```

#### **2. Forgetting to Request Accounts**

```js
// ❌ BAD: Will fail - no account connected
const signer = await provider.getSigner();
const address = await signer.getAddress(); // Error!

// ✅ GOOD: Request first
await window.ethereum.request({ method: "eth_requestAccounts" });
const signer = await provider.getSigner();
const address = await signer.getAddress(); // Works!
```

#### **3. Not Using Promise.all**

```js
// ❌ SLOW: Sequential calls (3 round trips)
const name = await contract.name();
const symbol = await contract.symbol();
const decimals = await contract.decimals();

// ✅ FAST: Parallel calls (1 round trip)
const [name, symbol, decimals] = await Promise.all([
  contract.name(),
  contract.symbol(),
  contract.decimals(),
]);
```

---

### 9. Testing Your Token Tracker

Before deploying, verify:

1. ✅ **Valid addresses work** - Token info displays correctly
2. ✅ **Invalid addresses show error** - Clear error message
3. ✅ **Balance formats correctly** - Uses proper decimals
4. ✅ **Loading states shown** - User knows something is happening
5. ✅ **Network switching handled** - Refreshes on chain change
6. ✅ **Zero balance displays** - Shows "0" not error

---

### External References & Further Learning

- **Ethers.js Documentation**: https://docs.ethers.org/v6 - Complete Ethers.js guide
- **OpenZeppelin ERC-20**: https://docs.openzeppelin.com/contracts/4.x/erc20 - Standard implementation
- **EIP-20 Specification**: https://eips.ethereum.org/EIPS/eip-20 - The official ERC-20 standard
- **React Hooks**: https://reactjs.org/docs/hooks-overview.html - React state management
- **Etherscan Token Tracker**: https://etherscan.io/tokens - See real token examples

---

## 🧪 Exercises

### Exercise 1: Show Token Info (name, symbol, decimals)

**Problem Statement**  
Build a React component that, given a contract address, reads `name()`, `symbol()`, and `decimals()` from an ERC-20 contract and displays them.

**Solidity Contract (`BaryoToken.sol`)**

```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BaryoToken is ERC20, Ownable {
    constructor(string memory _name, string memory _symbol, uint256 initialSupply) ERC20(_name, _symbol) {
        _mint(msg.sender, initialSupply);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}
```

**Starter Code (`TokenInfo.js`)**

```js
import React, { useState } from "react";
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

**To Do List**

- [ ] Use `ethers.isAddress(addr)` to validate.
- [ ] `await window.ethereum.request({ method: "eth_requestAccounts" })`.
- [ ] `provider = new ethers.BrowserProvider(window.ethereum)`.
- [ ] `contract = new ethers.Contract(addr, ABI, provider)`.
- [ ] Call `name()`, `symbol()`, `decimals()`, then `setInfo`.

**Full Solution**

```js
// TokenInfo.js
import React, { useState } from "react";
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
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.BrowserProvider(window.ethereum);
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

.env Sample

```
REACT_APP_RPC_URL=https://sepolia.infura.io/v3/YOUR_INFURA_KEY
```

---

### Exercise 2: Display Connected Wallet’s Token Balance

**Problem Statement**  
Extend your UI to fetch `balanceOf(userAddress)`, format it with `decimals()`, and show “Your Balance: 123.45 BARYO”.

**Starter Code (`TokenBalance.js`)**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = [
  "function symbol() view returns (string)",
  "function decimals() view returns (uint8)",
  "function balanceOf(address) view returns (uint256)",
];

export default function TokenBalance({ contractAddress }) {
  const [account, setAccount] = useState("");
  const [balance, setBalance] = useState("");
  const [symbol, setSymbol] = useState("");
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadBalance() {
      try {
        // TODO: request accounts & setAccount
        // TODO: provider & contract
        // TODO: fetch decimals & symbol
        // TODO: rawBalance = await contract.balanceOf(account)
        // TODO: formatted = formatUnits(rawBalance, decimals)
        // TODO: setBalance(`${formatted} ${symbol}`)
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

**To Do List**

- [ ] `await window.ethereum.request({ method: "eth_requestAccounts" })`
- [ ] Grab `account`, set `setAccount`.
- [ ] Instantiate contract with `provider`.
- [ ] Call `decimals()`, `symbol()`, and `balanceOf(account)`.
- [ ] Format via `ethers.formatUnits(raw, decimals)`.

**Full Solution**

```js
// TokenBalance.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = [
  "function symbol() view returns (string)",
  "function decimals() view returns (uint8)",
  "function balanceOf(address) view returns (uint256)",
];

export default function TokenBalance({ contractAddress }) {
  const [account, setAccount] = useState("");
  const [balance, setBalance] = useState("");
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadBalance() {
      try {
        const [user] = await window.ethereum.request({
          method: "eth_requestAccounts",
        });
        setAccount(user);
        const provider = new ethers.BrowserProvider(window.ethereum);
        const token = new ethers.Contract(contractAddress, ABI, provider);
        const [sym, dec, raw] = await Promise.all([
          token.symbol(),
          token.decimals(),
          token.balanceOf(user),
        ]);
        const formatted = ethers.formatUnits(raw, dec);
        setBalance(`${formatted} ${sym}`);
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

---

### Exercise 3: Token Transfer Form (Bonus)

**Problem Statement**  
Add a form to send BaryoToken: input recipient & amount, then call `transfer(to, amount)` via Signer.

**Starter Code (`TokenTransfer.js`)**

```js
import React, { useState } from "react";
import { ethers } from "ethers";
const ABI = ["function transfer(address,uint256) returns (bool)"];
export default function TokenTransfer({ contractAddress }) {
  const [to, setTo] = useState("");
  const [amt, setAmt] = useState("");
  const [txHash, setTxHash] = useState("");
  const [error, setError] = useState("");

  async function sendToken() {
    try {
      // TODO: ethereum.request(accounts)
      // TODO: signer = await provider.getSigner()
      // TODO: contract = new ethers.Contract(address, ABI, signer)
      // TODO: decimals = (fetch from token or assume 18)
      // TODO: amount = ethers.parseUnits(amt, decimals)
      // TODO: tx = await contract.transfer(to, amount)
      // TODO: setTxHash(tx.hash)
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <div>
      <h2>Send BaryoToken</h2>
      <input
        value={to}
        onChange={(e) => setTo(e.target.value)}
        placeholder="Recipient"
      />
      <input
        value={amt}
        onChange={(e) => setAmt(e.target.value)}
        placeholder="Amount"
      />
      <button onClick={sendToken}>Send</button>
      {txHash && <p>Tx Hash: {txHash}</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

**To Do List**

- [ ] Request accounts
- [ ] Get `signer` and connect contract
- [ ] Fetch `decimals()` or assume 18
- [ ] `parseUnits(amt, decimals)` & call `transfer(to, parsed)`
- [ ] Show tx hash

**Full Solution**

```js
// TokenTransfer.js
import React, { useState } from "react";
import { ethers } from "ethers";
const ABI = [
  "function transfer(address,uint256) returns (bool)",
  "function decimals() view returns (uint8)",
];

export default function TokenTransfer({ contractAddress }) {
  const [to, setTo] = useState("");
  const [amt, setAmt] = useState("");
  const [txHash, setTxHash] = useState("");
  const [error, setError] = useState("");

  async function sendToken() {
    setError("");
    setTxHash("");
    try {
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();
      const token = new ethers.Contract(contractAddress, ABI, signer);
      const dec = await token.decimals();
      const parsed = ethers.parseUnits(amt, dec);
      const tx = await token.transfer(to, parsed);
      setTxHash(tx.hash);
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <div>
      <h2>Send BaryoToken</h2>
      <input
        value={to}
        onChange={(e) => setTo(e.target.value)}
        placeholder="Recipient"
      />
      <input
        value={amt}
        onChange={(e) => setAmt(e.target.value)}
        placeholder="Amount"
      />
      <button onClick={sendToken}>Send</button>
      {txHash && <p>Tx Hash: {txHash}</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

---

## ✅ Test Cases

Create `__tests__/TokenBalance.test.js` with Jest & React Testing Library.

```js
// __tests__/TokenBalance.test.js
import React from "react";
import { render, screen, waitFor } from "@testing-library/react";
import TokenBalance from "../TokenBalance";
import { ethers } from "ethers";

jest.mock("ethers");

describe("TokenBalance Component", () => {
  const fakeAccount = "0xAbCdEf0123456789";
  const fakeContract = {
    symbol: jest.fn(),
    decimals: jest.fn(),
    balanceOf: jest.fn(),
  };

  beforeAll(() => {
    global.window.ethereum = {
      request: jest.fn().mockResolvedValue([fakeAccount]),
    };
    ethers.BrowserProvider = jest.fn().mockReturnValue({});
    ethers.Contract = jest.fn().mockReturnValue(fakeContract);
  });

  it("displays formatted balance correctly", async () => {
    fakeContract.symbol.mockResolvedValue("BARYO");
    fakeContract.decimals.mockResolvedValue(2);
    fakeContract.balanceOf.mockResolvedValue(12345n); // 123.45

    render(<TokenBalance contractAddress="0xTokenAddr" />);

    expect(screen.getByText(/Loading\.\.\./i)).toBeInTheDocument();

    await waitFor(() => screen.getByText(/123.45 BARYO/));

    expect(screen.getByText("123.45 BARYO")).toBeInTheDocument();
  });

  it("handles errors gracefully", async () => {
    fakeContract.symbol.mockRejectedValue(new Error("fail"));
    render(<TokenBalance contractAddress="0xTokenAddr" />);
    await waitFor(() => screen.getByText("fail"));
  });
});
```

`jest.config.js`:

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

As the barangay credit card machines hummed, Mang Jun saw “125.50 BARYO” pop on his screen. “Para bang cash!” he exclaimed. Odessa leaned back—her Balancer UI was a hit. OFWs in Tokyo could now check Marikina tokens in real-time. Next up: cross-chain remittance bridges and auto-swap to peso stablecoins. Odessa’s journey had only begun. Mabuhay Web3 in the Philippines—let’s code the future! 🇵🇭🚀
