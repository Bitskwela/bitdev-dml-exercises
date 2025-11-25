## 🧑‍💻 Background Story

The old bodega in Queens had seen everything: balikbayan boxes, night-shift coders, and now a cozy coworking nook. Odessa (“Det”) hauled in her laptop, ready to prove that GCash fees were a thing of the past. Neri’s BaryoToken—once built for Marikina sari-sari stores—needed an intuitive “send” UI.

With Ganache running locally, Det sketched a minimal form: recipient address, amount input, and a “Send BaryoToken” button. She wired Ethers.js to a local Hardhat‐deployed BaryoToken contract. Her mantra? “Make it so simple that Mang Jun’s nanay can use it.”

Line by line, she added: request MetaMask accounts, get a signer, parse units, call `transfer()`, wait for the transaction, and update balances. By midnight, transfers were flying: Det sent 10 BARYO to her test wallet; the console lit up with the tx hash and a success message. No more hidden fees, no more delays. Just pure, on‐chain remittance.

Tomorrow, she’d refine the UI, add gas estimations, and listen for `Transfer` events in real time. But tonight, in that converted bodega, Web3 felt like the future of Pinoy remittance. 🚀🇵🇭

---

## 📚 Theory & Web3 Lecture

Welcome to building a **Token Transfer UI**! This is one of the most important features in any Web3 app—allowing users to send tokens to each other. Think of it as building your own GCash or PayMaya, but powered by blockchain!

---

### 1. Understanding ERC-20 Transfers

#### **How Token Transfers Work**

When you "transfer" tokens, you're not moving files. You're telling the smart contract to update its internal ledger:

```
Before Transfer:
┌─────────────────────────────────────────────────────────────┐
│  BaryoToken Contract Ledger                                  │
│  ┌─────────────────────────────────────────────────────────┐│
│  │  balances[0xAlice] = 100 BARYO                         ││
│  │  balances[0xBob]   = 50 BARYO                          ││
│  └─────────────────────────────────────────────────────────┘│
│                                                              │
│  Alice calls: transfer(Bob, 25)                             │
│                                                              │
│  After Transfer:                                             │
│  ┌─────────────────────────────────────────────────────────┐│
│  │  balances[0xAlice] = 75 BARYO    (-25)                 ││
│  │  balances[0xBob]   = 75 BARYO    (+25)                 ││
│  └─────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────┘
```

#### **The `transfer` Function**

```solidity
// ERC-20 transfer function
function transfer(address to, uint256 amount) external returns (bool) {
    // 1. Check sender has enough balance
    require(balanceOf[msg.sender] >= amount, "Insufficient balance");
    
    // 2. Subtract from sender
    balanceOf[msg.sender] -= amount;
    
    // 3. Add to recipient
    balanceOf[to] += amount;
    
    // 4. Emit event for tracking
    emit Transfer(msg.sender, to, amount);
    
    return true;
}
```

#### **Key Differences: Transfer vs transferFrom**

| Function | Use Case | Who Pays Gas |
|----------|----------|--------------|
| `transfer(to, amount)` | Send YOUR tokens | You (sender) |
| `transferFrom(from, to, amount)` | Send APPROVED tokens | Transaction initiator |

```js
// transfer: You send your own tokens
await token.transfer(recipientAddress, amount);

// transferFrom: Send tokens you're approved to spend
await token.approve(spenderAddress, amount);  // First, approve
await token.transferFrom(ownerAddress, recipientAddress, amount);  // Then transfer
```

---

### 2. Provider vs Signer: Why It Matters for Transfers

#### **The Critical Difference**

```
┌─────────────────────────────────────────────────────────────┐
│                    READ vs WRITE Operations                  │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Provider (Read-Only):                                       │
│  • balanceOf() ✅                                            │
│  • name(), symbol() ✅                                       │
│  • transfer() ❌ (will fail!)                                │
│                                                              │
│  Signer (Read + Write):                                      │
│  • balanceOf() ✅                                            │
│  • transfer() ✅                                             │
│  • Any state-changing function ✅                            │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

#### **Getting a Signer**

```js
// Step 1: Request wallet access
await window.ethereum.request({ method: "eth_requestAccounts" });

// Step 2: Create provider
const provider = new ethers.providers.Web3Provider(window.ethereum);

// Step 3: Get signer from provider
const signer = provider.getSigner();

// Step 4: Create contract WITH signer (for transfers)
const token = new ethers.Contract(tokenAddress, ABI, signer);

// Now you can call transfer!
const tx = await token.transfer(to, amount);
```

---

### 3. Handling Token Decimals

#### **The Most Common Bug in Token UIs**

```js
// ❌ WRONG: User enters "10", you send 10 wei (0.00000000000000001 tokens!)
const amount = "10";
await token.transfer(to, amount);

// ✅ CORRECT: Parse with decimals
const decimals = await token.decimals(); // Usually 18
const amount = ethers.utils.parseUnits("10", decimals);
// Now amount = 10000000000000000000 (10 * 10^18)
await token.transfer(to, amount);
```

#### **parseUnits vs formatUnits**

```
User Input → Blockchain (parseUnits)
┌──────────────────────────────────────────────────────────┐
│  User types: "25.5"                                       │
│  parseUnits("25.5", 18) → 25500000000000000000           │
│  This is what gets sent to the contract                   │
└──────────────────────────────────────────────────────────┘

Blockchain → Display (formatUnits)
┌──────────────────────────────────────────────────────────┐
│  Contract returns: 25500000000000000000                   │
│  formatUnits(raw, 18) → "25.5"                            │
│  This is what user sees                                   │
└──────────────────────────────────────────────────────────┘
```

---

### 4. Transaction Lifecycle

#### **What Happens When You Click "Send"**

```
Token Transfer Timeline:
┌─────────────────────────────────────────────────────────────┐
│                                                              │
│  1. USER CLICKS "Send"                                       │
│     │                                                        │
│     ▼                                                        │
│  2. MetaMask POPUP appears                                   │
│     • Shows: To, Amount, Gas Fee                             │
│     • User reviews and clicks "Confirm"                      │
│     │                                                        │
│     ▼                                                        │
│  3. TRANSACTION SUBMITTED                                    │
│     • Returns tx object with hash                            │
│     • Status: "pending"                                      │
│     │                                                        │
│     ▼                                                        │
│  4. WAITING FOR CONFIRMATION                                 │
│     • await tx.wait()                                        │
│     • Miners/validators include tx in block                  │
│     • Usually 12-15 seconds on Ethereum                      │
│     │                                                        │
│     ▼                                                        │
│  5. TRANSACTION CONFIRMED                                    │
│     • receipt.status === 1 (success)                         │
│     • Balances updated on-chain                              │
│     • Transfer event emitted                                 │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

#### **Code Implementation**

```js
async function sendTokens(to, amount) {
  try {
    // Step 1: Prepare the transaction
    console.log("Preparing transaction...");
    const decimals = await token.decimals();
    const parsedAmount = ethers.utils.parseUnits(amount, decimals);

    // Step 2: Send transaction (MetaMask popup appears)
    console.log("Waiting for user confirmation...");
    const tx = await token.transfer(to, parsedAmount);
    console.log("Transaction submitted:", tx.hash);
    
    // tx object contains:
    // - hash: "0x123..."
    // - from: sender address
    // - to: contract address
    // - data: encoded function call

    // Step 3: Wait for confirmation
    console.log("Waiting for confirmation...");
    const receipt = await tx.wait();
    
    // receipt contains:
    // - status: 1 (success) or 0 (failed)
    // - blockNumber: which block included this tx
    // - transactionHash: same as tx.hash
    // - events: emitted events (Transfer)
    
    console.log("Transaction confirmed in block:", receipt.blockNumber);
    return receipt;
    
  } catch (error) {
    console.error("Transaction failed:", error);
    throw error;
  }
}
```

---

### 5. Input Validation

#### **Always Validate Before Sending**

```js
function validateTransfer(to, amount, balance) {
  const errors = [];

  // 1. Validate recipient address
  if (!to) {
    errors.push("Recipient address is required");
  } else if (!ethers.utils.isAddress(to)) {
    errors.push("Invalid recipient address");
  } else if (to === ethers.constants.AddressZero) {
    errors.push("Cannot send to zero address");
  }

  // 2. Validate amount
  if (!amount || amount.trim() === "") {
    errors.push("Amount is required");
  } else if (isNaN(Number(amount))) {
    errors.push("Amount must be a number");
  } else if (Number(amount) <= 0) {
    errors.push("Amount must be greater than 0");
  } else if (Number(amount) > Number(balance)) {
    errors.push("Insufficient balance");
  }

  return {
    valid: errors.length === 0,
    errors,
  };
}
```

---

### 6. Error Handling

#### **Common Transfer Errors**

| Error Code | Meaning | User Message |
|------------|---------|--------------|
| `4001` | User rejected | "Transaction cancelled" |
| `INSUFFICIENT_FUNDS` | Not enough ETH for gas | "Not enough ETH for gas" |
| `UNPREDICTABLE_GAS_LIMIT` | Transaction would fail | "Transfer would fail - check balance" |
| `CALL_EXCEPTION` | Contract reverted | "Transfer failed - insufficient balance" |

#### **Comprehensive Error Handler**

```js
function handleTransferError(error) {
  // User rejected in MetaMask
  if (error.code === 4001 || error.code === "ACTION_REJECTED") {
    return {
      type: "cancelled",
      message: "Transaction cancelled by user",
    };
  }

  // Not enough ETH for gas
  if (error.code === "INSUFFICIENT_FUNDS") {
    return {
      type: "no_gas",
      message: "Not enough ETH to pay for gas fees",
    };
  }

  // Contract would revert
  if (error.code === "UNPREDICTABLE_GAS_LIMIT") {
    return {
      type: "would_fail",
      message: "Transaction would fail. Check your token balance.",
    };
  }

  // Contract reverted
  if (error.code === "CALL_EXCEPTION") {
    // Try to extract revert reason
    const reason = error.reason || error.message;
    return {
      type: "reverted",
      message: `Transfer failed: ${reason}`,
    };
  }

  // Unknown error
  return {
    type: "unknown",
    message: error.message || "Something went wrong",
  };
}
```

---

### 7. Updating Balances After Transfer

#### **Why Refresh Balances?**

After a successful transfer:
- Sender's balance decreased
- Recipient's balance increased
- UI should reflect this immediately!

```js
async function transferAndRefresh(to, amount) {
  // 1. Send the transaction
  const tx = await token.transfer(to, parsedAmount);
  await tx.wait();

  // 2. Fetch updated balances
  const [senderBalance, recipientBalance] = await Promise.all([
    token.balanceOf(senderAddress),
    token.balanceOf(to),
  ]);

  // 3. Format for display
  const decimals = await token.decimals();
  return {
    senderBalance: ethers.utils.formatUnits(senderBalance, decimals),
    recipientBalance: ethers.utils.formatUnits(recipientBalance, decimals),
  };
}
```

---

### 8. Listening to Transfer Events

#### **Real-Time Updates with Events**

Instead of polling, subscribe to `Transfer` events:

```js
useEffect(() => {
  const provider = new ethers.providers.Web3Provider(window.ethereum);
  const token = new ethers.Contract(tokenAddress, ABI, provider);

  // Define the event handler
  function handleTransfer(from, to, value, event) {
    console.log("Transfer detected!");
    console.log("From:", from);
    console.log("To:", to);
    console.log("Amount:", ethers.utils.formatUnits(value, decimals));
    
    // Refresh balances if this affects the current user
    if (from === userAddress || to === userAddress) {
      refreshBalance();
    }
  }

  // Subscribe to Transfer events
  token.on("Transfer", handleTransfer);

  // Cleanup on unmount
  return () => {
    token.off("Transfer", handleTransfer);
  };
}, [tokenAddress, userAddress]);
```

---

### 9. Complete React Transfer Component

```jsx
function TokenTransfer({ contractAddress }) {
  const [to, setTo] = useState("");
  const [amount, setAmount] = useState("");
  const [status, setStatus] = useState("idle"); // idle | validating | pending | success | error
  const [txHash, setTxHash] = useState("");
  const [error, setError] = useState("");

  async function handleTransfer(e) {
    e.preventDefault();
    setError("");
    setTxHash("");

    // Validate inputs
    setStatus("validating");
    if (!ethers.utils.isAddress(to)) {
      setError("Invalid recipient address");
      setStatus("error");
      return;
    }
    if (!amount || Number(amount) <= 0) {
      setError("Enter a valid amount");
      setStatus("error");
      return;
    }

    try {
      setStatus("pending");

      // Get signer and contract
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const token = new ethers.Contract(contractAddress, ABI, signer);

      // Parse amount with decimals
      const decimals = await token.decimals();
      const parsedAmount = ethers.utils.parseUnits(amount, decimals);

      // Send transaction
      const tx = await token.transfer(to, parsedAmount);
      setTxHash(tx.hash);

      // Wait for confirmation
      await tx.wait();
      setStatus("success");

      // Clear form
      setTo("");
      setAmount("");

    } catch (err) {
      const { message } = handleTransferError(err);
      setError(message);
      setStatus("error");
    }
  }

  return (
    <form onSubmit={handleTransfer}>
      <h2>Send Tokens</h2>
      
      <input
        type="text"
        placeholder="Recipient Address (0x...)"
        value={to}
        onChange={(e) => setTo(e.target.value)}
        disabled={status === "pending"}
      />
      
      <input
        type="number"
        placeholder="Amount"
        value={amount}
        onChange={(e) => setAmount(e.target.value)}
        disabled={status === "pending"}
        step="any"
        min="0"
      />
      
      <button type="submit" disabled={status === "pending"}>
        {status === "pending" ? "Sending..." : "Send"}
      </button>

      {txHash && (
        <p>
          Transaction: {" "}
          <a 
            href={`https://etherscan.io/tx/${txHash}`}
            target="_blank"
            rel="noopener noreferrer"
          >
            View on Etherscan
          </a>
        </p>
      )}
      
      {status === "success" && <p style={{ color: "green" }}>✅ Transfer successful!</p>}
      {error && <p style={{ color: "red" }}>❌ {error}</p>}
    </form>
  );
}
```

---

### 10. Common Mistakes to Avoid

#### **1. Forgetting to Parse Amounts**

```js
// ❌ Sends almost nothing (10 wei)
await token.transfer(to, "10");

// ✅ Sends 10 tokens
const decimals = await token.decimals();
await token.transfer(to, ethers.utils.parseUnits("10", decimals));
```

#### **2. Not Waiting for Confirmation**

```js
// ❌ Returns immediately (transaction not confirmed)
const tx = await token.transfer(to, amount);
showSuccess(); // Too early!

// ✅ Wait for mining
const tx = await token.transfer(to, amount);
await tx.wait(); // Now it's confirmed
showSuccess();
```

#### **3. Not Handling User Rejection**

```js
// ❌ Crashes if user clicks "Reject"
const tx = await token.transfer(to, amount);

// ✅ Handle rejection
try {
  const tx = await token.transfer(to, amount);
} catch (err) {
  if (err.code === 4001) {
    setStatus("cancelled");
    return;
  }
  throw err;
}
```

---

### 11. Testing Your Transfer UI

Before deploying, verify:

1. ✅ **Valid transfer works** - Tokens move, balances update
2. ✅ **Invalid address rejected** - Shows error before sending
3. ✅ **Zero/negative amounts rejected** - Validation works
4. ✅ **Insufficient balance caught** - Clear error message
5. ✅ **User rejection handled** - Doesn't crash
6. ✅ **Transaction hash shown** - User can verify on Etherscan
7. ✅ **Button disabled during pending** - No double-sends
8. ✅ **Balances refresh** - UI updates after transfer

---

### External References & Further Learning

- **Ethers.js Contract Interaction**: https://docs.ethers.org/v5/api/contract/contract/ - Sending transactions
- **ERC-20 Standard**: https://eips.ethereum.org/EIPS/eip-20 - Token transfer specification
- **Gas Estimation**: https://docs.ethers.org/v5/api/contract/contract/#contract-estimateGas - Estimating gas
- **Etherscan**: https://etherscan.io - Verify transactions
- **OpenZeppelin ERC-20**: https://docs.openzeppelin.com/contracts/4.x/erc20 - Safe implementations

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
