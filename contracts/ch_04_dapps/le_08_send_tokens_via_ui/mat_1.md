## 🧑‍💻 Background Story

The old bodega in Queens had seen everything: balikbayan boxes, night-shift coders, and now a cozy coworking nook. Odessa (“Det”) hauled in her laptop, ready to prove that GCash fees were a thing of the past. Neri’s BaryoToken—once built for Marikina sari-sari stores—needed an intuitive “send” UI.

With Ganache running locally, Det sketched a minimal form: recipient address, amount input, and a “Send BaryoToken” button. She wired Ethers.js to a local Hardhat‐deployed BaryoToken contract. Her mantra? “Make it so simple that Mang Jun’s nanay can use it.”

Line by line, she added: request MetaMask accounts, get a signer, parse units, call `transfer()`, wait for the transaction, and update balances. By midnight, transfers were flying: Det sent 10 BARYO to her test wallet; the console lit up with the tx hash and a success message. No more hidden fees, no more delays. Just pure, on‐chain remittance.

Tomorrow, she’d refine the UI, add gas estimations, and listen for `Transfer` events in real time. But tonight, in that converted bodega, Web3 felt like the future of Pinoy remittance. 🚀🇵🇭

---

## 📚 Theory & Web3 Lecture

1. ERC-20 Transfers  
   • `function transfer(address to, uint256 amount) returns (bool)` moves tokens from `msg.sender` to `to`.  
   • Requires a Signer (wallet with private key) to send a state-changing transaction.  
   • Amounts are BigNumbers; always use `ethers.utils.parseUnits()` when sending and `formatUnits()` when displaying.

2. Ethers.js Essentials  
   • Provider (read) vs Signer (write)  
    – Provider: `new ethers.providers.Web3Provider(window.ethereum)`  
    – Signer: `provider.getSigner()`  
   • Contract object:

   ```js
   const token = new ethers.Contract(address, ABI, signer);
   ```

   • Sending a tx:

   ```js
   const tx = await token.transfer(to, amount);
   await tx.wait(); // wait for mining
   console.log("Sent:", tx.hash);
   ```

3. React Patterns  
   • useState for form fields, txHash, error, loading  
   • Async handlers with `try/catch`  
   • Disable form while pending to avoid double‐spend  
   • Optionally listen to `contract.on("Transfer", (from, to, value) => { … })` for live updates

4. Gas & UX  
   • Estimate gas: `token.estimateGas.transfer(to, amount)`  
   • Show estimated fee: `gasLimit.mul(gasPrice)`  
   • Provide user feedback: loading spinner, success/error alerts

5. Security & Best Practices  
   • Validate `to` with `ethers.utils.isAddress()`  
   • Validate `amt` is a positive number  
   • Catch user-rejected transactions  
   • Never expose private keys; always use injected wallets

🔗 Docs  
– Ethers.js: https://docs.ethers.org/v5  
– OpenZeppelin ERC-20: https://docs.openzeppelin.com/contracts/4.x/erc20  
– React Hooks: https://reactjs.org/docs/hooks-intro.html

---

## 🧪 Exercises

### Exercise 1: Basic Token Transfer Form

**Problem Statement**  
Create a React component that lets the user send BaryoToken. Inputs: recipient address, amount. On submit, call `transfer(to, parsedAmount)` and display the transaction hash.

**Solidity Contract (`BaryoToken.sol`)**

```sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BaryoToken is ERC20, Ownable {
    constructor(string memory _name, string memory _symbol, uint256 initialSupply)
        ERC20(_name, _symbol)
    {
        _mint(msg.sender, initialSupply);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}
```

**Starter Code (`TokenTransfer.js`)**

```js
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
    try {
      // TODO: Request accounts
      // TODO: Get provider & signer
      // TODO: Instantiate contract with signer
      // TODO: Fetch decimals(), parseUnits(amt, decimals)
      // TODO: Call transfer(to, parsed), await tx.wait()
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
        placeholder="Recipient Address"
      />
      <input
        value={amt}
        onChange={(e) => setAmt(e.target.value)}
        placeholder="Amount"
      />
      <button onClick={sendToken}>Send</button>
      {txHash && <p>Transaction Hash: {txHash}</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

**To Do List**

- [ ] `await window.ethereum.request({ method: "eth_requestAccounts" })`
- [ ] `const provider = new ethers.providers.Web3Provider(window.ethereum)`
- [ ] `const signer = provider.getSigner()`
- [ ] `const token = new ethers.Contract(contractAddress, ABI, signer)`
- [ ] `const dec = await token.decimals()`
- [ ] `const parsed = ethers.utils.parseUnits(amt, dec)`
- [ ] `const tx = await token.transfer(to, parsed)` & `await tx.wait()`
- [ ] `setTxHash(tx.hash)`

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
  const [loading, setLoading] = useState(false);

  async function sendToken() {
    setError("");
    setTxHash("");
    if (!ethers.utils.isAddress(to)) {
      setError("Invalid recipient address");
      return;
    }
    if (isNaN(amt) || Number(amt) <= 0) {
      setError("Enter a positive amount");
      return;
    }
    try {
      setLoading(true);
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const token = new ethers.Contract(contractAddress, ABI, signer);
      const dec = await token.decimals();
      const parsed = ethers.utils.parseUnits(amt, dec);
      const tx = await token.transfer(to, parsed);
      const receipt = await tx.wait();
      setTxHash(receipt.transactionHash);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }

  return (
    <div style={{ maxWidth: 400, margin: "auto" }}>
      <h2>Send BaryoToken</h2>
      <input
        value={to}
        onChange={(e) => setTo(e.target.value)}
        placeholder="Recipient Address"
        style={{ width: "100%", marginBottom: 8 }}
      />
      <input
        value={amt}
        onChange={(e) => setAmt(e.target.value)}
        placeholder="Amount"
        style={{ width: "100%", marginBottom: 8 }}
      />
      <button onClick={sendToken} disabled={loading} style={{ width: "100%" }}>
        {loading ? "Sending…" : "Send"}
      </button>
      {txHash && <p>Transaction Hash: {txHash}</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

.env Sample

```
REACT_APP_RPC_URL=http://127.0.0.1:8545
REACT_APP_CONTRACT_ADDRESS=0xYourLocalBaryoTokenAddress
```

---

### Exercise 2: Update Balances After Transfer

**Problem Statement**  
After sending tokens, fetch and display the sender’s and recipient’s balances without reloading the page.

**Starter Code (`TokenTransferWithBalance.js`)**

```js
import React, { useState } from "react";
import { ethers } from "ethers";
const ABI = [
  "function transfer(address,uint256) returns (bool)",
  "function decimals() view returns (uint8)",
  "function balanceOf(address) view returns (uint256)",
  "function symbol() view returns (string)",
];

export default function TokenTransferWithBalance({ contractAddress }) {
  const [to, setTo] = useState("");
  const [amt, setAmt] = useState("");
  const [balances, setBalances] = useState({ from: "", to: "" });
  const [symbol, setSymbol] = useState("");
  // TODO: implement sendToken and update balances
  return (
    <div>
      <h2>Send & Refresh Balances</h2>
      {/* inputs & button */}
      <p>
        Your Balance: {balances.from} {symbol}
      </p>
      <p>
        Recipient Balance: {balances.to} {symbol}
      </p>
    </div>
  );
}
```

**To Do List**

- [ ] On mount or after send, fetch `symbol()` once and store.
- [ ] After `tx.wait()`, call `balanceOf(sender)` and `balanceOf(to)`.
- [ ] Format both with `formatUnits(raw, decimals)`.
- [ ] `setBalances({ from, to })`.

**Full Solution**

```js
// TokenTransferWithBalance.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = [
  "function transfer(address,uint256) returns (bool)",
  "function decimals() view returns (uint8)",
  "function balanceOf(address) view returns (uint256)",
  "function symbol() view returns (string)",
];

export default function TokenTransferWithBalance({ contractAddress }) {
  const [to, setTo] = useState("");
  const [amt, setAmt] = useState("");
  const [balances, setBalances] = useState({ from: "0", to: "0" });
  const [symbol, setSymbol] = useState("");
  const [decimals, setDecimals] = useState(18);
  const [account, setAccount] = useState("");

  // Initialize symbol, decimals, and user account
  useEffect(() => {
    async function init() {
      const [user] = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      setAccount(user);
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const token = new ethers.Contract(contractAddress, ABI, provider);
      const [sym, dec] = await Promise.all([token.symbol(), token.decimals()]);
      setSymbol(sym);
      setDecimals(dec);
      fetchBalances(user, token, dec);
    }
    init();
  }, [contractAddress]);

  async function fetchBalances(user, token, dec) {
    const [rawFrom, rawTo] = await Promise.all([
      token.balanceOf(user),
      token.balanceOf(to || user), // show own balance if no recipient
    ]);
    setBalances({
      from: ethers.utils.formatUnits(rawFrom, dec),
      to: ethers.utils.formatUnits(rawTo, dec),
    });
  }

  async function sendToken() {
    try {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const token = new ethers.Contract(contractAddress, ABI, signer);
      const parsed = ethers.utils.parseUnits(amt, decimals);
      const tx = await token.transfer(to, parsed);
      await tx.wait();
      await fetchBalances(account, token, decimals);
    } catch (err) {
      console.error(err);
    }
  }

  return (
    <div style={{ maxWidth: 400, margin: "auto" }}>
      <h2>Send & Refresh Balances</h2>
      <input
        placeholder="Recipient Address"
        value={to}
        onChange={(e) => setTo(e.target.value)}
        style={{ width: "100%", marginBottom: 8 }}
      />
      <input
        placeholder="Amount"
        value={amt}
        onChange={(e) => setAmt(e.target.value)}
        style={{ width: "100%", marginBottom: 8 }}
      />
      <button onClick={sendToken} style={{ width: "100%" }}>
        Send
      </button>
      <div style={{ marginTop: 16 }}>
        <p>
          Your Balance: {balances.from} {symbol}
        </p>
        <p>
          Recipient Balance: {balances.to} {symbol}
        </p>
      </div>
    </div>
  );
}
```

---

### Exercise 3 (Bonus): Listen for Transfer Events

**Problem Statement**  
Subscribe to the `Transfer` event on the BaryoToken contract and log every transfer to the console.

**To Do List**

- [ ] In a `useEffect`, after creating the contract with a Provider, call `contract.on("Transfer", handler)`.
- [ ] Handler signature: `(from, to, value, event) => { … }`.
- [ ] Clean up listener on unmount: `return () => contract.off("Transfer", handler)`.

**Solution Snippet**

```js
useEffect(() => {
  const provider = new ethers.providers.Web3Provider(window.ethereum);
  const token = new ethers.Contract(contractAddress, ABI, provider);
  function onTransfer(from, to, value, event) {
    console.log(
      `Transfer: ${ethers.utils.formatUnits(
        value,
        decimals
      )} from ${from} to ${to}`
    );
  }
  token.on("Transfer", onTransfer);
  return () => {
    token.off("Transfer", onTransfer);
  };
}, [contractAddress, decimals]);
```

---

## ✅ Test Cases

Create `__tests__/TokenTransfer.test.js`:

```js
// __tests__/TokenTransfer.test.js
import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import TokenTransfer from "../TokenTransfer";
import { ethers } from "ethers";

jest.mock("ethers");

describe("TokenTransfer Component", () => {
  const fakeAddress = "0xAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAa";
  const fakeSigner = {};
  const fakeProvider = { getSigner: () => fakeSigner };
  const fakeContract = {
    decimals: jest.fn(),
    transfer: jest.fn(),
  };

  beforeAll(() => {
    // Mock window.ethereum
    global.window.ethereum = {
      request: jest.fn().mockResolvedValue([fakeAddress]),
    };
    // Mock provider & signer
    ethers.providers.Web3Provider = jest.fn().mockReturnValue(fakeProvider);
    ethers.Contract = jest.fn().mockReturnValue(fakeContract);
  });

  it("renders form and sends a transaction", async () => {
    fakeContract.decimals.mockResolvedValue(18);
    const fakeTx = {
      wait: jest.fn().mockResolvedValue({ transactionHash: "0xTxHash" }),
    };
    fakeContract.transfer.mockResolvedValue(fakeTx);

    render(<TokenTransfer contractAddress="0xTokenAddr" />);

    // Fill inputs
    fireEvent.change(screen.getByPlaceholderText(/Recipient Address/i), {
      target: { value: fakeAddress },
    });
    fireEvent.change(screen.getByPlaceholderText(/Amount/i), {
      target: { value: "5" },
    });
    fireEvent.click(screen.getByText("Send"));

    await waitFor(() => screen.getByText(/Transaction Hash:/i));
    expect(screen.getByText("Transaction Hash: 0xTxHash")).toBeInTheDocument();
    // Ensure ethers calls
    expect(fakeContract.decimals).toHaveBeenCalled();
    expect(fakeContract.transfer).toHaveBeenCalledWith(
      fakeAddress,
      ethers.utils.parseUnits("5", 18)
    );
  });

  it("validates invalid inputs", async () => {
    render(<TokenTransfer contractAddress="0xTokenAddr" />);
    fireEvent.change(screen.getByPlaceholderText(/Recipient Address/i), {
      target: { value: "badAddress" },
    });
    fireEvent.change(screen.getByPlaceholderText(/Amount/i), {
      target: { value: "-1" },
    });
    fireEvent.click(screen.getByText("Send"));
    expect(
      await screen.findByText(/Invalid recipient address/i)
    ).toBeInTheDocument();
  });
});
```

In `jest.config.js`:

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

As the bodega’s neon sign blinked, Odessa watched her “Send BaryoToken” UI in action—twenty quick transfers, zero GCash fees. A visiting OFW tried it on her phone and beamed: “Parang padadala ko na agad sa nanay ko!” Next up: gas-fee estimation, cross-chain swaps, and a polished design system. From Queens to Marikina, Det’s UI was proof—Filipino devs are building Web3 tools that matter. Mabuhay, next level awaits! 🇵🇭💪🚀
