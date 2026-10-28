## 🧑‍💻 Background Story

![BaryoToken Transfer UI](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+8.0+-+COVER.png)

The old bodega in Queens had seen everything: balikbayan boxes, night-shift coders, and now a cozy coworking nook. Odessa ("Det") hauled in her laptop, ready to prove that remittance fees could be a thing of the past. Neri's BaryoToken, once built for Marikina sari-sari stores, needed an intuitive "send" UI.

![Token Transfer UI](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+8.1.png)

With a Hardhat node running on her laptop, Det sketched a minimal form: recipient address, amount, and a "Send" button. She wired ethers to a BaryoToken contract deployed on that local chain. Her mantra? "Make it so simple that Mang Jun's nanay can use it."

Line by line, she added: request MetaMask accounts, get a signer, parse units, call `transfer()`, wait for the transaction, and show the result. By midnight, transfers were flying: Det sent 10 BARYO to her test wallet, and the screen lit up with the tx hash and a success message. No hidden fees, no waiting for the branch to open. Just on-chain remittance.

Tomorrow she would move it to Sepolia, add gas estimates, and listen for `Transfer` events in real time. But tonight, in that converted bodega, Web3 felt like the future of Pinoy remittance. 🚀🇵🇭

---

## 📚 Theory & Web3 Lecture

Welcome to building a **Token Transfer UI**! This is one of the most important features of any Web3 app: letting people send tokens to each other. Think of it as building your own GCash "Send Money" screen, powered by a blockchain.

> **This lesson uses ethers v6.** The two changes that bite most often when you send transactions: `getSigner()` must be **awaited**, and amounts are native **`bigint`** values. Older tutorials using `ethers.providers.Web3Provider` or `ethers.utils.parseUnits` are ethers v5 and will not run here. <!-- v5-ok -->

---

### 1. Understanding ERC-20 Transfers

#### **How Token Transfers Work**

When you "transfer" tokens, nothing moves between wallets. You ask the token contract to update its own ledger:

```
Before Transfer:
┌─────────────────────────────────────────────────────────────┐
│  BaryoToken Contract Ledger                                 │
│    balances[0xAlice] = 100 BARYO                            │
│    balances[0xBob]   = 50 BARYO                             │
│                                                             │
│  Alice calls: transfer(Bob, 25)                             │
│                                                             │
│  After Transfer:                                            │
│    balances[0xAlice] = 75 BARYO    (-25)                    │
│    balances[0xBob]   = 75 BARYO    (+25)                    │
└─────────────────────────────────────────────────────────────┘
```

#### **What `transfer` Does (simplified)**

```solidity
// A simplified picture of ERC-20 transfer, not OpenZeppelin's exact code
function transfer(address to, uint256 amount) external returns (bool) {
    require(balances[msg.sender] >= amount, "Insufficient balance"); // 1. enough?
    balances[msg.sender] -= amount;                                  // 2. subtract
    balances[to] += amount;                                          // 3. add
    emit Transfer(msg.sender, to, amount);                           // 4. announce
    return true;
}
```

OpenZeppelin v5's real `ERC20` does the same steps, but reverts with a **custom error**, `ERC20InsufficientBalance(sender, balance, needed)`, instead of a text message, and refuses to send to the zero address (`ERC20InvalidReceiver`).

#### **transfer vs transferFrom**

| Function                         | Use Case                         | Who Pays Gas         |
| -------------------------------- | -------------------------------- | -------------------- |
| `transfer(to, amount)`           | Send YOUR tokens                 | You (the sender)     |
| `transferFrom(from, to, amount)` | Send tokens someone approved you | Whoever calls it     |

```js
// transfer: you send your own tokens
await token.transfer(recipientAddress, amount);

// transferFrom: two steps, two different people
await token.approve(spenderAddress, amount);                      // owner approves
await token.transferFrom(ownerAddress, recipientAddress, amount); // spender sends
```

This lesson only uses `transfer`.

---

### 2. Provider vs Signer: Why It Matters for Transfers

```
┌─────────────────────────────────────────────────────────────┐
│                    READ vs WRITE                            │
├─────────────────────────────────────────────────────────────┤
│  Provider (read-only):                                      │
│  • balanceOf(), name(), decimals()  ✅                      │
│  • transfer()                       ❌ (no one to sign it)  │
│                                                             │
│  Signer (read + write):                                     │
│  • everything above                 ✅                      │
│  • transfer() and any state change  ✅ (MetaMask signs)     │
└─────────────────────────────────────────────────────────────┘
```

A transfer spends the user's tokens, so the user's wallet must **sign** it. In ethers, the object that can sign is a **Signer**.

#### **Getting a Signer (ethers v6)**

```js
// 1. Ask MetaMask for access (pop-up the first time)
await window.ethereum.request({ method: "eth_requestAccounts" });

// 2. Wrap MetaMask in an ethers provider
const provider = new ethers.BrowserProvider(window.ethereum);

// 3. Get the signer: in v6 this is async, so await it
const signer = await provider.getSigner();

// 4. Build the contract WITH the signer, so it can send transactions
const token = new ethers.Contract(tokenAddress, ABI, signer);

const tx = await token.transfer(to, amount);
```

Already have a read-only contract? `contract.connect(signer)` returns a copy that can write.

---

### 3. Handling Token Decimals

#### **The Most Common Bug in Token UIs**

```js
// ❌ WRONG: the user typed "10", you send 10 raw units (0.00000000000000001 tokens!)
await token.transfer(to, 10n);

// ✅ CORRECT: scale by decimals first
const decimals = await token.decimals();            // 18n
const amount = ethers.parseUnits("10", decimals);   // 10000000000000000000n
await token.transfer(to, amount);
```

#### **parseUnits vs formatUnits**

```
User input → contract (parseUnits)
┌──────────────────────────────────────────────────────────┐
│  User types: "25.5"                                      │
│  ethers.parseUnits("25.5", 18) → 25500000000000000000n   │
│  This is what you send to the contract                   │
└──────────────────────────────────────────────────────────┘

Contract → screen (formatUnits, from Lesson 06)
┌──────────────────────────────────────────────────────────┐
│  Contract returns: 25500000000000000000n                 │
│  ethers.formatUnits(raw, 18) → "25.5"                    │
│  This is what the user sees                              │
└──────────────────────────────────────────────────────────┘
```

`parseUnits` takes a **string**. Pass it exactly what the user typed (`"2.5"`), not `Number(...)` of it: floating-point numbers can't hold every decimal exactly.

---

### 4. Transaction Lifecycle

#### **What Happens When You Click "Send"**

```
┌─────────────────────────────────────────────────────────────┐
│ 1. USER CLICKS "Send"                                       │
│      ▼                                                      │
│ 2. METAMASK POP-UP: shows recipient, amount, gas fee        │
│    User clicks "Confirm" (or "Reject")                      │
│      ▼                                                      │
│ 3. SUBMITTED: contract.transfer() resolves with a tx        │
│    tx.hash is known right now. Status: pending              │
│      ▼                                                      │
│ 4. WAITING: await tx.wait()                                 │
│    A validator includes it in a block                       │
│    (Ethereum and Sepolia make a block about every 12s)      │
│      ▼                                                      │
│ 5. CONFIRMED: the receipt arrives                           │
│    receipt.status === 1, balances updated, event emitted    │
└─────────────────────────────────────────────────────────────┘
```

#### **Code Implementation**

```js
async function sendTokens(token, to, amount) {
  // Step 1: prepare
  const decimals = await token.decimals();
  const parsedAmount = ethers.parseUnits(amount, decimals);

  // Step 2: send (MetaMask pop-up appears here)
  const tx = await token.transfer(to, parsedAmount);
  console.log("Submitted:", tx.hash);

  // Step 3: wait for it to be mined
  const receipt = await tx.wait();
  // receipt.status:      1 (success)
  // receipt.blockNumber: the block that included it
  // receipt.hash:        same as tx.hash
  // receipt.logs:        the events it emitted (Transfer)
  console.log("Confirmed in block", receipt.blockNumber);
  return receipt;
}
```

In ethers v6, a receipt's hash is `receipt.hash` and its events are in `receipt.logs`.

---

### 5. Input Validation

Validate **before** opening MetaMask: a bad address or a zero amount should never cost the user a pop-up, let alone gas.

```js
function validateTransfer(to, amount) {
  const errors = [];

  if (!to) {
    errors.push("Recipient address is required");
  } else if (!ethers.isAddress(to)) {
    errors.push("Invalid recipient address");
  } else if (to.toLowerCase() === ethers.ZeroAddress) {
    errors.push("Cannot send to the zero address");
  }

  if (!amount || amount.trim() === "") {
    errors.push("Amount is required");
  } else if (isNaN(amount)) {
    errors.push("Amount must be a number");
  } else if (Number(amount) <= 0) {
    errors.push("Amount must be greater than 0");
  }

  return { valid: errors.length === 0, errors };
}
```

Checking the user's balance up front is a nice extra: read `balanceOf(user)`, then compare `parseUnits(amount, decimals) <= balance` (both `bigint`, so the comparison is exact).

---

### 6. Forms in React: `preventDefault`

The activity uses a real `<form>` with `onSubmit`, so pressing Enter works too. But a browser's default reaction to a form submit is to **reload the page**, which would wipe out your pending transaction and every bit of state.

```jsx
const handleTransfer = async (e) => {
  e.preventDefault(); // stop the reload, handle it ourselves
  // ...validate, sign, send...
};

<form onSubmit={handleTransfer}>
  {/* inputs */}
  <button type="submit">Send</button>
</form>
```

---

### 7. Error Handling (ethers v6 codes)

| Error code           | Meaning                                   | User message                        |
| -------------------- | ----------------------------------------- | ----------------------------------- |
| `ACTION_REJECTED`    | User clicked "Reject" in MetaMask         | "Transaction cancelled"             |
| `INSUFFICIENT_FUNDS` | Not enough ETH to pay the gas             | "Not enough ETH for gas"            |
| `CALL_EXCEPTION`     | The contract reverted (or would revert)   | "Transfer failed: check your balance" |

```js
function handleTransferError(error) {
  if (error.code === "ACTION_REJECTED") {
    return { type: "cancelled", message: "Transaction cancelled by user" };
  }
  if (error.code === "INSUFFICIENT_FUNDS") {
    return { type: "no_gas", message: "Not enough ETH to pay for gas fees" };
  }
  if (error.code === "CALL_EXCEPTION") {
    // v6 puts a decoded revert on error.revert when the ABI knows the error
    const reason = error.reason || error.revert?.name || "the token rejected it";
    return { type: "reverted", message: `Transfer failed: ${reason}` };
  }
  return { type: "unknown", message: error.shortMessage || error.message || "Something went wrong" };
}
```

When ethers estimates gas before sending and the contract would revert (for example, too little balance), v6 throws `CALL_EXCEPTION` straight away, before any pop-up. You may see `UNPREDICTABLE_GAS_LIMIT` in old answers online: that code was removed in v6. <!-- v5-ok -->

To decode OpenZeppelin's custom errors by name, add them to your ABI, for example `"error ERC20InsufficientBalance(address sender, uint256 balance, uint256 needed)"`.

---

### 8. Updating Balances After a Transfer

After a successful transfer the sender's balance went down and the recipient's went up. Read them again so the UI tells the truth:

```js
async function refreshBalances(token, sender, recipient) {
  const [decimals, fromRaw, toRaw] = await Promise.all([
    token.decimals(),
    token.balanceOf(sender),
    token.balanceOf(recipient),
  ]);
  return {
    sender: ethers.formatUnits(fromRaw, decimals),
    recipient: ethers.formatUnits(toRaw, decimals),
  };
}
```

Call it only **after** `await tx.wait()`. Before that, the chain has not changed yet.

---

### 9. Listening to Transfer Events

Instead of polling, subscribe to the token's `Transfer` event (you met events in Lesson 04). The event must be in your ABI:

```js
const ABI = [
  "event Transfer(address indexed from, address indexed to, uint256 value)",
  "function decimals() view returns (uint8)",
];

useEffect(() => {
  const provider = new ethers.BrowserProvider(window.ethereum);
  const token = new ethers.Contract(tokenAddress, ABI, provider);

  function onTransfer(from, to, value) {
    console.log(`Transfer: ${ethers.formatUnits(value, decimals)} from ${from} to ${to}`);
  }

  token.on("Transfer", onTransfer);
  return () => {
    token.off("Transfer", onTransfer); // clean up on unmount
  };
}, [tokenAddress, decimals]);
```

---

### 10. Common Mistakes to Avoid

#### **1. Forgetting `await` on `getSigner()`**

```js
// ❌ v6: signer is a Promise here, and the contract can't sign with it
const signer = provider.getSigner();

// ✅
const signer = await provider.getSigner();
```

#### **2. Forgetting to Parse Amounts**

```js
// ❌ sends 10 raw units
await token.transfer(to, 10n);

// ✅ sends 10 tokens
await token.transfer(to, ethers.parseUnits("10", await token.decimals()));
```

#### **3. Celebrating Too Early**

```js
// ❌ transfer() resolving only means "submitted"
const tx = await token.transfer(to, amount);
showSuccess(); // too early!

// ✅ wait until it is mined
const tx = await token.transfer(to, amount);
await tx.wait();
showSuccess();
```

#### **4. Not Handling "Reject"**

Wrap the send in `try/catch` and treat `ACTION_REJECTED` as a normal outcome, not a crash.

---

### 11. How This Is Graded

The activity runs in a sandbox with a fake wallet and a fake 18-decimal token. The grader types into the fields **by placeholder** (one containing `Recipient`, one containing `Amount`), submits the form, and checks that you prevent the page reload, refuse a bad address and a `0` amount, get a signer before `transfer`, send `2.5` as `2500000000000000000`, wait for `tx.wait()`, then show the hash and the word "success".

---

### External References & Further Learning

- **ethers v6, Contracts (sending transactions)**: https://docs.ethers.org/v6/api/contract/
- **ethers v6, Signers**: https://docs.ethers.org/v6/api/providers/#Signer
- **EIP-20 specification**: https://eips.ethereum.org/EIPS/eip-20
- **OpenZeppelin ERC-20 (v5)**: https://docs.openzeppelin.com/contracts/5.x/erc20
- **Hardhat Network (local chain)**: https://hardhat.org/hardhat-network/docs/overview
- **Sepolia Etherscan**: https://sepolia.etherscan.io

---

## 🧪 Exercises

### Exercise 1: Deploy BaryoToken and Send It Locally

**Solidity Contract (`BaryoToken.sol`, OpenZeppelin v5)**

```solidity
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

**Run a local chain with Hardhat** (Ganache, which older tutorials use, was sunset in 2023):

```bash
npx hardhat node
```

This starts a chain at `http://127.0.0.1:8545` (chain ID `31337`) and prints 20 funded test accounts with their private keys. Import one into MetaMask (test accounts only, never a real key), add the network `http://127.0.0.1:8545` / chain ID `31337`, deploy `BaryoToken` to it, and point your form at the deployed address.

When it works locally, deploy the same contract to **Sepolia** and share the transaction links from `https://sepolia.etherscan.io/tx/<hash>`.

---

### Exercise 2: Link the Transaction to Etherscan

**Problem Statement**
Instead of printing the raw hash, show a link the user can click to follow the transaction on Sepolia Etherscan.

**Solution Snippet**

```jsx
{txHash && (
  <p>
    Tx Hash: {txHash}{" "}
    <a
      href={`https://sepolia.etherscan.io/tx/${txHash}`}
      target="_blank"
      rel="noopener noreferrer"
    >
      View on Etherscan
    </a>
  </p>
)}
```

`rel="noopener noreferrer"` stops the new tab from being able to control your page.

---

### Exercise 3: Show Balances After Sending

**Problem Statement**
After a transfer is mined, show the sender's and recipient's new balances without reloading the page.

**Solution (`TokenTransferWithBalance.jsx`)**

```jsx
import { useState } from "react";
import { ethers } from "ethers";

const ABI = [
  "function transfer(address, uint256) returns (bool)",
  "function decimals() view returns (uint8)",
  "function balanceOf(address) view returns (uint256)",
  "function symbol() view returns (string)",
];

export default function TokenTransferWithBalance({ contractAddress }) {
  const [to, setTo] = useState("");
  const [amount, setAmount] = useState("");
  const [balances, setBalances] = useState(null);
  const [error, setError] = useState("");

  async function handleSubmit(e) {
    e.preventDefault();
    setError("");
    if (!ethers.isAddress(to) || !(Number(amount) > 0)) {
      setError("Check the address and amount");
      return;
    }
    try {
      const provider = new ethers.BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();
      const token = new ethers.Contract(contractAddress, ABI, signer);

      const [decimals, symbol] = await Promise.all([token.decimals(), token.symbol()]);
      const tx = await token.transfer(to, ethers.parseUnits(amount, decimals));
      await tx.wait();

      const [fromRaw, toRaw] = await Promise.all([
        token.balanceOf(signer.address),
        token.balanceOf(to),
      ]);
      setBalances({
        from: `${ethers.formatUnits(fromRaw, decimals)} ${symbol}`,
        to: `${ethers.formatUnits(toRaw, decimals)} ${symbol}`,
      });
    } catch (err) {
      setError(err.shortMessage || err.message);
    }
  }

  return (
    <form onSubmit={handleSubmit}>
      <h2>Send & Refresh Balances</h2>
      <input placeholder="Recipient Address" value={to} onChange={(e) => setTo(e.target.value)} />
      <input placeholder="Amount" value={amount} onChange={(e) => setAmount(e.target.value)} />
      <button type="submit">Send</button>
      {error && <p style={{ color: "red" }}>{error}</p>}
      {balances && (
        <div>
          <p>Your Balance: {balances.from}</p>
          <p>Recipient Balance: {balances.to}</p>
        </div>
      )}
    </form>
  );
}
```

`signer.address` is the connected wallet's address; in v6 a signer from `getSigner()` carries it directly.

---

## 🌟 Closing Story

As the bodega's neon sign blinked, Odessa watched her "Send BaryoToken" UI in action: twenty quick transfers, each one confirmed with a hash anyone could check on Etherscan. A visiting OFW tried it on her phone and beamed: "Parang padala ko na agad sa nanay ko!" Next up: gas-fee estimates, swaps, and a polished design. From Queens to Marikina, Det's UI was proof that Filipino devs are building Web3 tools that matter. Mabuhay, the next level awaits! 🇵🇭💪🚀
