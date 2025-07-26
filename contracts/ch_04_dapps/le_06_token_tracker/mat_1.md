## 🧑‍💻 Background Story

It was a humid afternoon in Marikina—rain clouds gathering over the riverbanks. Inside a humble sari-sari store turned DAO-hub, barangay residents gathered around a laptop. Neri’s latest innovation, BaryoToken, had just launched. Each token represented a voucher for rice, canned goods, even sari-sari store credit.

Odessa (“Det”) was on the case. Fresh from her stint building an NFT gallery in SF, she now needed to craft a remittance-ready wallet UI for OFWs sending BaryoToken back home. Her mission: a “Balancer” page that:

1. Connects to MetaMask or any Ethers wallet
2. Reads and displays the token’s `name()`, `symbol()`, and `decimals()`
3. Fetches and formats the user’s token `balanceOf()` in human-readable form

In just 30 minutes, Det sketched a React page: an input to switch BaryoToken contract addresses, a “Connect Wallet” button, and a “Fetch Balance” card. When barangay captain Mang Jun clicked “Load,” the balance lit up on screen—₱25.50 worth of BaryoToken. Smiles spread: now elders, OFWs, and sari-sari store owners could see their holdings in real pesos. For Det, this POCs’ magic was enough—proof that Filipino ingenuity and Web3 could transform local economies. Next stop: cross-border remittances for OFWs.

---

## 📚 Theory & Web3 Lecture

1. ERC-20 Standard Basics  
   • `name()`, `symbol()`, `decimals()`, `totalSupply()`, `balanceOf(address)`, `transfer(to,amount)`  
   • `decimals()` defines how many decimal places a token has (e.g., 18). Use it to humanize `balanceOf`.

2. React + Ethers.js Architecture  
   • React Functional Components + Hooks (`useState`, `useEffect`)  
   • `ethers.providers.Web3Provider` for wallet injection  
   • `ethers.Contract` to call on-chain read methods

3. Provider vs Signer  
   • Provider: read-only calls (`balanceOf`, `name`, etc.)  
   • Signer: for sending transactions (`transfer`)

4. Fetching & Formatting Balance

   ```js
   const raw = await contract.balanceOf(userAddress); // BigNumber
   const decimals = await contract.decimals(); // e.g. 18
   const formatted = ethers.utils.formatUnits(raw, decimals); // string “25.5”
   ```

5. React Hook Flow

   ```js
   useEffect(() => {
     if (walletConnected) {
       fetchTokenData();
     }
   }, [walletConnected]);
   ```

6. Best Practices & Security  
   – Always `await window.ethereum.request({ method: "eth_requestAccounts" })`  
   – Validate user input for contract address (use regex or Ethers’ `isAddress()`)  
   – Catch errors (network issues, user rejection) with `try/catch`  
   – Store RPC URLs & addresses in `.env` (never commit keys)

🔗 Further Reading  
– Ethers.js: https://docs.ethers.org/v5  
– OpenZeppelin ERC-20: https://docs.openzeppelin.com/contracts/4.x/erc20  
– React Hooks: https://reactjs.org/docs/hooks-overview.html

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
      // TODO: Validate address with ethers.utils.isAddress
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

- [ ] Use `ethers.utils.isAddress(addr)` to validate.
- [ ] `await window.ethereum.request({ method: "eth_requestAccounts" })`.
- [ ] `provider = new ethers.providers.Web3Provider(window.ethereum)`.
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
    if (!ethers.utils.isAddress(addr)) {
      setError("Invalid address");
      return;
    }
    try {
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
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
- [ ] Format via `ethers.utils.formatUnits(raw, decimals)`.

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
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const token = new ethers.Contract(contractAddress, ABI, provider);
        const [sym, dec, raw] = await Promise.all([
          token.symbol(),
          token.decimals(),
          token.balanceOf(user),
        ]);
        const formatted = ethers.utils.formatUnits(raw, dec);
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
      // TODO: signer = provider.getSigner()
      // TODO: contract = new ethers.Contract(address, ABI, signer)
      // TODO: decimals = (fetch from token or assume 18)
      // TODO: amount = ethers.utils.parseUnits(amt, decimals)
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
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const token = new ethers.Contract(contractAddress, ABI, signer);
      const dec = await token.decimals();
      const parsed = ethers.utils.parseUnits(amt, dec);
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
    ethers.providers.Web3Provider = jest.fn().mockReturnValue({});
    ethers.Contract = jest.fn().mockReturnValue(fakeContract);
  });

  it("displays formatted balance correctly", async () => {
    fakeContract.symbol.mockResolvedValue("BARYO");
    fakeContract.decimals.mockResolvedValue(2);
    fakeContract.balanceOf.mockResolvedValue(ethers.BigNumber.from("12345")); // 123.45

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
