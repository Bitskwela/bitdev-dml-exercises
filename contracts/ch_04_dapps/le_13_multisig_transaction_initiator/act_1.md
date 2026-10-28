# List All Multisig Proposals Activity

**Goal:** read every proposal stored in a multisig wallet contract (count first, then one read per proposal), convert each value from wei to ether, and render one readable block per proposal showing recipient, value, confirmations and executed state.

Odessa's board members need one screen that answers "what is waiting for my signature?" Before anyone can confirm or execute anything, they have to *see* the proposals. That list is what you build here.

## Initial Code

This is the starter file you will edit (`ProposalList.jsx`):

```jsx
// ProposalList.js - Starter Code
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getTransactionCount() view returns (uint256)",
  "function transactions(uint256) view returns (address to, uint256 value, bytes data, bool executed, uint256 numConfirmations)",
  "function confirmations(uint256, address) view returns (bool)",
];

export default function ProposalList({ contractAddress }) {
  const [proposals, setProposals] = useState([]);
  const [error, setError] = useState("");

  useEffect(() => {
    async function loadProposals() {
      // TODO: Task 1 - Connect the wallet and build the contract
      // TODO: Task 2 - Read getTransactionCount(), then transactions(i) for each
      // TODO: Task 3 - Format value as ether and keep the confirmation count
    }
    loadProposals();
  }, [contractAddress]);

  // TODO: Task 4 - Render the error, then one block per proposal showing its
  //                recipient, value, confirmations and executed state
  return <p>Placeholder</p>;
}
```

The multisig address arrives as the `contractAddress` prop, so the parent page decides which wallet to show. The effect re-runs whenever that prop changes (`[contractAddress]`).

**Time Allotment: 35 minutes**

## Tasks for Learners

Topics Covered: `ethers.BrowserProvider` (ethers v6), reading a count and looping over an indexed getter, destructuring a struct return, `ethers.formatEther`, `Number()` on a `bigint`.

Tasks 1, 2 and 3 all go **inside** `loadProposals()`, in place of its three TODO lines, inside one `try`/`catch`. Task 4 replaces the `return <p>Placeholder</p>;` line.

> **Why a wallet for a read?** In the Gas Fee Checker and DeFi Dashboard lessons you read public data with `JsonRpcProvider` and no wallet, and that still works here. This screen is different: it is the **signers'** screen. The next step on this page (Confirm and Execute buttons) needs a signer, and a signer comes from the wallet's `BrowserProvider`. So this component connects MetaMask once, up front, and reads through the same provider. For a page that only shows public data to anyone, prefer `JsonRpcProvider`.

---

### Task 1: Connect the wallet and build the contract

Open a `try` block (you close it in Task 3). Ask MetaMask for access, wrap it in a v6 `BrowserProvider`, and build the contract from the prop address:

```jsx
try {
  await window.ethereum.request({ method: "eth_requestAccounts" });
  const provider = new ethers.BrowserProvider(window.ethereum);
  const wallet = new ethers.Contract(contractAddress, ABI, provider);
```

We call the contract `wallet` because the contract *is* the multisig wallet.

---

### Task 2: Read `getTransactionCount()`, then `transactions(i)` for each

Solidity cannot hand you "all proposals" in one call from a public array getter; it gives you **one item per index**. So you read how many there are, then loop. The count comes back as a `bigint`; wrap it in `Number()` so it works in a normal `for` loop:

```jsx
  const count = Number(await wallet.getTransactionCount());
  const items = [];
  for (let i = 0; i < count; i++) {
    const [to, value, data, executed, numConfirmations] =
      await wallet.transactions(i);
    // Task 3 goes here
  }
```

`transactions(i)` returns the five fields of one proposal, in the order the ABI lists them. Destructuring `[to, value, data, executed, numConfirmations]` gives each one a name.

---

### Task 3: Format the value as ether and keep the confirmation count

Inside the loop, in place of `// Task 3 goes here`, push one tidy object per proposal. After the loop, save the list and close the `try`:

```jsx
    items.push({
      id: i,
      to,
      value: ethers.formatEther(value),
      data: data.slice(0, 10) + "…",
      executed,
      numConfirmations: Number(numConfirmations),
    });
  }
  setProposals(items);
} catch (err) {
  setError(err.message);
}
```

- `ethers.formatEther(1500000000000000000n)` gives `"1.5"`. Nobody wants to read 18 zeros.
- `data.slice(0, 10)` keeps `0x` plus the first 4 bytes, the **function selector**, which says which function the proposal will call.
- `Number(numConfirmations)` is safe because a confirmation count is a small number.

After Tasks 1 to 3, your whole `loadProposals()` should look exactly like this:

```jsx
async function loadProposals() {
  try {
    await window.ethereum.request({ method: "eth_requestAccounts" });
    const provider = new ethers.BrowserProvider(window.ethereum);
    const wallet = new ethers.Contract(contractAddress, ABI, provider);

    const count = Number(await wallet.getTransactionCount());
    const items = [];
    for (let i = 0; i < count; i++) {
      const [to, value, data, executed, numConfirmations] =
        await wallet.transactions(i);
      items.push({
        id: i,
        to,
        value: ethers.formatEther(value),
        data: data.slice(0, 10) + "…",
        executed,
        numConfirmations: Number(numConfirmations),
      });
    }
    setProposals(items);
  } catch (err) {
    setError(err.message);
  }
}
```

---

### Task 4: Render the error, then one block per proposal

Replace `return <p>Placeholder</p>;` with this. Each proposal gets its own block, and the labels are part of the grade (see below):

```jsx
if (error) return <p style={{ color: "red" }}>{error}</p>;
return (
  <div>
    <h3>Multisig Proposals</h3>
    {proposals.map((p) => (
      <div
        key={p.id}
        style={{ borderBottom: "1px solid #ccc", padding: "8px 0" }}
      >
        <p>
          <strong>ID #{p.id}</strong>
        </p>
        <p>To: {p.to}</p>
        <p>Value: {p.value} ETH</p>
        <p>Data: {p.data}</p>
        <p>Confirmations: {p.numConfirmations}</p>
        <p>Executed: {p.executed ? "✅" : "❌"}</p>
      </div>
    ))}
  </div>
);
```

---

> **Graded details: labels and wording are checked.** The hidden test uses a wallet with **2** proposals and checks:
>
> - You call `getTransactionCount()`, and then `transactions(i)` **exactly twice**, once per proposal.
> - Both recipient addresses appear on the page exactly as the contract returns them (mixed-case checksum form). Render `p.to` as is; do not shorten or lowercase it.
> - The value shows in **ether**: `1.5` must appear, and the raw wei `1500000000000000000` must **not**. Use `ethers.formatEther`.
> - Each confirmation count is **labelled** with the word `Confirmations` (any capitalisation; `Confirmation` also works) next to the number: `Confirmations: 1` and `Confirmations: 2`. The form `2 confirmations` is also accepted. A bare number fails.
> - The word `Executed` (any capitalisation) appears, so the user can tell executed proposals from pending ones.

## Common Mistakes

- **Using `getTransactionCount()` directly in the loop.** `i < await wallet.getTransactionCount()` asks the chain for the count again on every turn of the loop. Read it once, before the loop, and wrap it in `Number()`.
- **Showing raw wei.** `{value.toString()}` puts `1500000000000000000` on screen and fails the test. Format first.
- **Changing the labels.** "Approvals: 1" or "Done: ✅" may read nicely, but the grader looks for `Confirmations` and `Executed`.
- **Using ethers v5 syntax.** This course runs ethers v6: `ethers.BrowserProvider` and `ethers.formatEther`, directly on `ethers`.

## Breakdown of the Activity

**Variables Defined:**

- `proposals`: state array of tidy proposal objects (`id`, `to`, `value`, `data`, `executed`, `numConfirmations`).
- `error`: state holding an error message, empty when everything is fine.
- `provider`: an `ethers.BrowserProvider` wrapping MetaMask (`window.ethereum`).
- `wallet`: the multisig contract, built from the `contractAddress` prop.
- `count`: how many proposals exist, converted from `bigint` to a regular number.

**Key Functions:**

- `loadProposals`: runs on mount and whenever `contractAddress` changes. Connects, reads the count, reads each proposal, and stores the list or the error.
- `wallet.transactions(i)`: the auto-generated getter for the contract's public `transactions` array. It returns one proposal's fields by index.
- `ethers.formatEther(value)`: converts wei (`bigint`) into a human-readable ether string.
