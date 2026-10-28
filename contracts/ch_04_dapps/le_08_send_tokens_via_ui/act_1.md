# Send Tokens via UI Activity

**What you will build:** a `TokenTransfer` form that checks the recipient and amount, asks MetaMask to sign an ERC-20 `transfer`, then shows the transaction hash and a success message once the transfer is mined.

This is your first **write** in this chapter: it spends the user's tokens, so it needs a **signer**, not just a provider.

## Initial Code

This is the starter in your editor. The token's address arrives as the `contractAddress` prop.

```js
// TokenTransfer.js - Starter Code
import { useState } from "react";
import { ethers } from "ethers";

const ABI = [
  "function transfer(address, uint256) returns (bool)",
  "function decimals() view returns (uint8)",
  "function balanceOf(address) view returns (uint256)",
];

export default function TokenTransfer({ contractAddress }) {
  const [recipient, setRecipient] = useState("");
  const [amount, setAmount] = useState("");
  const [status, setStatus] = useState("");
  const [txHash, setTxHash] = useState("");

  const handleTransfer = async (e) => {
    e.preventDefault();
    // TODO: Task 1 - Reject an invalid recipient address and a non-positive amount
    // TODO: Task 2 - Connect the wallet and build a signer-backed contract
    // TODO: Task 3 - Read decimals(), parse the amount, send transfer(), then
    //                store the hash and await the receipt
  };

  return (
    <form onSubmit={handleTransfer}>
      <h3>Send Tokens</h3>
      {/* TODO: Task 4 - Recipient input, amount input, submit button, and
          the pending / success / error states */}
      <p>Placeholder</p>
    </form>
  );
}
```

**Time Allotment: 30 minutes**

## Tasks for Learners

Topics Covered: ERC-20 `transfer`, ethers v6 `BrowserProvider` and `await provider.getSigner()`, `ethers.isAddress`, `ethers.parseUnits`, `tx.wait()`, form handling with `preventDefault`

---

### Task 1: Validate inputs before sending

Keep the `e.preventDefault();` line that is already in the starter: without it the browser reloads the page on submit and your transaction is lost. Right below it, add two guards:

```js
    // Validate inputs
    if (!ethers.isAddress(recipient)) {
      setStatus("error");
      alert("Invalid recipient address");
      return;
    }

    if (!amount || isNaN(amount) || Number(amount) <= 0) {
      setStatus("error");
      alert("Enter a valid positive amount");
      return;
    }
```

Each guard `return`s early, so a bad address or a `0` amount never reaches MetaMask (and never wastes gas).

---

### Task 2: Connect the wallet and build a signer-backed contract

Below the guards, open a `try` block. Mark the form as pending, ask MetaMask for access, get a **signer**, and build the contract with that signer:

```js
    try {
      setStatus("pending");
      setTxHash("");

      // Connect wallet and get signer
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();
      const contract = new ethers.Contract(contractAddress, ABI, signer);

      // Task 3 goes here
    } catch (err) {
      console.error("Transfer failed:", err);
      setStatus("error");
    }
```

- In ethers v6, `getSigner()` returns a Promise, so you **must `await` it**.
- A contract built with a **signer** can send transactions; one built with a provider can only read.

---

### Task 3: Read decimals, send the transfer, wait for the receipt

Replace `// Task 3 goes here` with:

```js
      // Parse amount with decimals and transfer
      const decimals = await contract.decimals();
      const parsedAmount = ethers.parseUnits(amount, decimals);

      const tx = await contract.transfer(recipient, parsedAmount);
      setTxHash(tx.hash);

      await tx.wait();
      setStatus("success");

      // Clear form
      setRecipient("");
      setAmount("");
```

- `ethers.parseUnits("2.5", 18n)` gives `2500000000000000000n`: the raw integer the contract expects. Sending `2.5` itself would be wrong.
- `tx.hash` exists the moment MetaMask sends the transaction, so show it straight away.
- `await tx.wait()` pauses until the transaction is mined. Only **then** is it a success.

---

### Task 4: Build the form

Replace the `{/* TODO: Task 4 ... */}` comment **and** `<p>Placeholder</p>` with this. The `<h3>Send Tokens</h3>` heading stays.

```jsx
      <input
        placeholder="Recipient Address (0x...)"
        value={recipient}
        onChange={(e) => setRecipient(e.target.value)}
      />
      <input
        placeholder="Amount"
        type="number"
        value={amount}
        onChange={(e) => setAmount(e.target.value)}
      />
      <button type="submit" disabled={status === "pending"}>
        {status === "pending" ? "Sending..." : "Send"}
      </button>
      {txHash && <p>Tx Hash: {txHash}</p>}
      {status === "success" && (
        <p style={{ color: "green" }}>✅ Transfer successful!</p>
      )}
      {status === "error" && <p style={{ color: "red" }}>❌ Transfer failed</p>}
```

The button is `type="submit"`, so clicking it (or pressing Enter) fires the form's `onSubmit`, which is `handleTransfer`.

---

> **Graded details: labels and wording are checked.** The hidden test is strict about these, so copy them exactly:
>
> - The test finds the fields **by placeholder**: one placeholder must contain **`Recipient`** and the other **`Amount`**. A placeholder of just `0x...` will not be found.
> - The form must show the word **`Send`** somewhere (the button label does this).
> - Submitting must call **`e.preventDefault()`** (already in the starter: keep it).
> - With an invalid address, or an amount of `0`, **`transfer` must never be called**.
> - **`provider.getSigner()` must be called before `transfer`**: a write needs a signer.
> - **`decimals()` must be read**, and `transfer` must receive the recipient and the **scaled** amount: `2.5` must arrive as `2500000000000000000`.
> - **`tx.wait()` must be awaited**, and afterwards the page must contain the word **`success`** (any case: "Transfer successful!" works, "Transfer complete!" does not).
> - The **transaction hash must appear on screen**.

### Common mistakes

- `const signer = provider.getSigner();` without `await`: in v6 you get a Promise, and `new ethers.Contract(..., signer)` then fails.
- `ethers.utils.parseUnits` or `ethers.providers.Web3Provider`: ethers v5 names that crash in v6. <!-- v5-ok -->
- Showing success right after `contract.transfer(...)` returns. That only means "sent", not "mined". Wait for `tx.wait()`.

---

## Breakdown of the Activity

**Variables Defined:**

- `recipient`: the destination wallet address, checked with `ethers.isAddress()` before anything is sent.
- `amount`: what the user typed, as a string such as `"2.5"`. Converted with `parseUnits` using the token's decimals.
- `status`: the form's state: `""` (idle), `"pending"` (waiting for the chain), `"success"`, or `"error"`. It disables the button and picks the message to show.
- `txHash`: the transaction hash, available as soon as the transaction is sent. Users can paste it into [Sepolia Etherscan](https://sepolia.etherscan.io) to follow it.
- `parsedAmount`: the user's amount scaled to raw units, a `bigint`. `"10.5"` with 18 decimals becomes `10500000000000000000n`.

**Key Functions:**

- `handleTransfer`: the form's submit handler. It validates the inputs, connects MetaMask, gets a signer, builds a write-capable contract, reads `decimals()`, sends `transfer(recipient, parsedAmount)`, shows the hash, and waits for `tx.wait()` before reporting success.
- `ethers.parseUnits(amount, decimals)`: turns a human amount into the integer the contract stores. The opposite of `formatUnits` from Lesson 06.
- `tx.wait()`: resolves with the receipt once the transaction is included in a block.
