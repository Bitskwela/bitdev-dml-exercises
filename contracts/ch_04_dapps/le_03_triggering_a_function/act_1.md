# Triggering Smart Contract Functions Activity

The Laguna cooperative is ready to vote, and Odessa needs the button that actually casts a ballot on-chain. In this activity you build `CastVote`. It lets a member pick a proposal, sends a signed `vote()` transaction through MetaMask, waits for it to be mined, and tells the member it is confirmed.

**What you will learn:** how to send a state-changing transaction with ethers v6. You get a **signer** from a `BrowserProvider`, build the contract with that signer, and wait for the receipt with `tx.wait()` before you report success.

## The Contract You Are Calling

You do not write or deploy this contract. It is here so you know what `vote()` does. A second vote from the same address, or a proposal name that is not on the list, makes it revert.

```solidity
// CooperativeVote.sol - already deployed on Sepolia
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CooperativeVote {
    mapping(string => uint256) public votes;
    mapping(address => bool)    public hasVoted;
    string[] public proposals;

    event Voted(address indexed voter, string proposal);

    constructor(string[] memory _proposals) {
        proposals = _proposals;
    }

    function vote(string calldata proposal) external returns (bool) {
        require(!hasVoted[msg.sender], "Already voted");
        bool valid = false;
        for (uint i; i < proposals.length; i++) {
            if (keccak256(bytes(proposals[i])) == keccak256(bytes(proposal))) {
                valid = true;
                break;
            }
        }
        require(valid, "Invalid proposal");
        votes[proposal] += 1;
        hasVoted[msg.sender] = true;
        emit Voted(msg.sender, proposal);
        return true;
    }

    function getVoteCount(string calldata proposal) external view returns (uint256) {
        return votes[proposal];
    }
}
```

## Initial Code

This is the starter that opens in your editor. The comment on line 1 says `.js`, but the file you are editing is `CastVote.jsx`.

```js
// CastVote.js - Starter Code
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/CooperativeVote.json";

export default function CastVote({ proposals, onVoted }) {
  const [selected, setSelected] = useState(proposals[0]);
  const [status, setStatus] = useState("");

  const castVote = async () => {
    // TODO: Task 1 - Guard against a missing wallet, then request accounts
    // TODO: Task 2 - Build a BrowserProvider, await its signer, and construct
    //                the contract with that signer (a write needs a signer)
    // TODO: Task 3 - Send the vote, await tx.wait(), then report and call onVoted()
  };

  return (
    <div>
      {/* TODO: Task 4 - Render the proposal picker, the Vote button, and status */}
      <p>Placeholder</p>
    </div>
  );
}
```

The component receives two props from its parent. `proposals` is a list of names, for example `["Bagong Palengke", "Solar Streetlights", "Barangay WiFi"]`. `onVoted` is a function to call once a vote is confirmed. The editor provides `process.env.REACT_APP_CONTRACT_ADDRESS` and the ABI file `../abi/CooperativeVote.json`.

**Time Allotment: 25 minutes**

## Tasks for Learners

Topics Covered: write transactions, `ethers.BrowserProvider`, signers, `tx.wait()`, transaction status, error handling

This lesson uses **ethers v6**. `ethers.providers.Web3Provider` and a synchronous `getSigner()` are version 5 and fail here. <!-- v5-ok -->

Tasks 1 to 3 all go inside `castVote`. Put them in order, in a single `try { ... } catch { ... }` block, as shown. The full function appears at the end of Task 3.

---

### Task 1: Guard for MetaMask and Request Accounts

Stop early if there is no wallet. Otherwise, mark the vote as pending and ask MetaMask for the account:

```js
if (!window.ethereum) {
  alert("Please install MetaMask");
  return;
}

try {
  setStatus("pending");
  await window.ethereum.request({ method: "eth_requestAccounts" });
```

The `try {` stays open. Tasks 2 and 3 continue inside it.

---

### Task 2: Build the BrowserProvider, Signer and Contract

A write must be signed by the user, so the contract is built with a **signer**, not a provider:

```js
  // A state-changing call must be signed, so the contract is built with a
  // signer rather than the provider. getSigner() is async in ethers v6.
  const browserProvider = new ethers.BrowserProvider(window.ethereum);
  const signer = await browserProvider.getSigner();
  const contract = new ethers.Contract(
    process.env.REACT_APP_CONTRACT_ADDRESS,
    abi,
    signer
  );
```

- `new ethers.BrowserProvider(window.ethereum)` wraps MetaMask so ethers can talk to it.
- `await browserProvider.getSigner()`: the `await` is required in v6.
- Passing `signer` as the third argument is what lets `contract.vote(...)` send a transaction.

---

### Task 3: Send the Vote, Wait, Then Report

Send the selected proposal, wait for it to be mined, then tell the user and the parent. Close the `try` with a `catch`:

```js
  const tx = await contract.vote(selected, { gasLimit: 100_000 });
  console.log("Tx Hash:", tx.hash);
  // Sending is not the same as being mined; wait for the receipt.
  await tx.wait();
  setStatus("confirmed");
  onVoted();
} catch (err) {
  console.error(err);
  setStatus("error: " + (err.data?.message || err.message));
}
```

- `contract.vote(selected, ...)` resolves as soon as the transaction is **sent**. `await tx.wait()` resolves once it is **mined**. Only then may you say "confirmed" and call `onVoted()`.
- `{ gasLimit: 100_000 }` is optional. Without it, ethers estimates the gas for you.

Put together, your finished `castVote` reads:

```js
const castVote = async () => {
  if (!window.ethereum) {
    alert("Please install MetaMask");
    return;
  }

  try {
    setStatus("pending");
    await window.ethereum.request({ method: "eth_requestAccounts" });

    // A state-changing call must be signed, so the contract is built with a
    // signer rather than the provider. getSigner() is async in ethers v6.
    const browserProvider = new ethers.BrowserProvider(window.ethereum);
    const signer = await browserProvider.getSigner();
    const contract = new ethers.Contract(
      process.env.REACT_APP_CONTRACT_ADDRESS,
      abi,
      signer
    );

    const tx = await contract.vote(selected, { gasLimit: 100_000 });
    console.log("Tx Hash:", tx.hash);
    // Sending is not the same as being mined; wait for the receipt.
    await tx.wait();
    setStatus("confirmed");
    onVoted();
  } catch (err) {
    console.error(err);
    setStatus("error: " + (err.data?.message || err.message));
  }
};
```

---

### Task 4: Render the Picker, the Vote Button and the Status

Replace the whole `return (...)` block (including `<p>Placeholder</p>`) with:

```js
return (
  <div>
    <select onChange={(e) => setSelected(e.target.value)}>
      {proposals.map((p) => (
        <option key={p}>{p}</option>
      ))}
    </select>
    <button onClick={castVote} disabled={status === "pending"}>
      {status === "pending" ? "Voting…" : "Vote"}
    </button>
    {status && <p>{status}</p>}
  </div>
);
```

- The `<select>` starts on the first proposal, which matches `useState(proposals[0])`.
- The button is disabled while the vote is pending, so a double-click cannot send two transactions.
- `{status && <p>{status}</p>}` shows `pending`, then `confirmed` or the error.

> **Graded details: labels and wording are checked.**
>
> - The page must show the word **Vote**, and the button's label must contain **Vote**. The grader clicks it by that text.
> - Clicking it must call `window.ethereum.request` with `method: "eth_requestAccounts"`.
> - You must build `new ethers.BrowserProvider(...)` and call `getSigner()` on it.
> - `contract.vote(...)` must receive the selected proposal as its first argument. With no change to the dropdown, that is the first proposal, `Bagong Palengke`.
> - You must call `tx.wait()`, then `onVoted()`.
> - After success, the page must show text containing **confirm** (any case), for example `confirmed`. A message like "Vote recorded on-chain" reads fine but fails, because it does not contain "confirm".

---

## Common Mistakes

- **`getSigner()` without `await`.** In v6 it returns a Promise, and the contract cannot send with it.
- **Building the contract with a provider instead of the signer.** It can read but not write.
- **Saying "confirmed" before `await tx.wait()`.** The transaction is only sent at that point, not mined.
- **Calling `onVoted()` outside the `try`, or before `tx.wait()`.** The parent would refresh before the vote exists.
- **Rewording the success status** so it no longer contains "confirm".

---

## Breakdown of the Activity

**Variables Defined:**

- `selected`: The proposal chosen in the dropdown. It is passed to `contract.vote()`.

- `status`: The state of the transaction: empty (idle), `"pending"`, `"confirmed"` or `"error: ..."`. It drives the message on screen and disables the button while pending.

- `browserProvider`: An `ethers.BrowserProvider` wrapped around MetaMask's `window.ethereum`. Unlike a `JsonRpcProvider`, it can reach the user's account.

- `signer`: The user's account, as returned by `await browserProvider.getSigner()`. Every state-changing call must be signed by it.

- `contract`: An `ethers.Contract` built with the signer, so its methods send transactions instead of only reading.

**Key Functions:**

- `castVote`:
  Handles the whole voting flow. It checks for MetaMask and requests the account. It builds a `BrowserProvider`, awaits the signer, and creates the contract with that signer. Then it calls `vote(selected)`, which opens the MetaMask confirmation popup. After the user confirms, `await tx.wait()` waits for the transaction to be mined. Only then does it set `confirmed` and call `onVoted()`. The `try/catch` covers a rejection in MetaMask, too little ETH for gas, and a contract revert such as "Already voted".

- `tx.wait()`:
  Waits until the transaction is included in a block, which takes about 12 seconds on Sepolia. It resolves with a receipt. In ethers v6 it throws if the transaction reverted.
