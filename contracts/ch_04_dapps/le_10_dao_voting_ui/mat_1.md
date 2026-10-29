## 🧑‍💻 Background Story

![DAO Voting UI](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+10.0+-+COVER.png)

It was a humid afternoon in Barangay San Perfecto when Det stepped into the barangay hall-turned-coworking-space. The Barangay Council was debating whether to fund a new basketball court, a dream for every hoops-mad teenager in San Perfecto. Neri had already deployed the "BarangayDAO" smart contract on the Sepolia testnet, complete with proposals and one-wallet-one-vote rules. Now Det's mission was to build the frontend.

![DAO Voting UI Sketch](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+10.1.png)

With teammates sipping sikwate, she sketched a simple page:

1. **Proposal list**: each proposal's ID, description, and Yes/No tally.
2. **Vote buttons**: "Vote Yes" or "Vote No", shown only if you haven't voted yet.
3. **Live results**: tallies that update the moment anyone's vote is mined.

Det fired up a React app, wired ethers, and connected MetaMask. She read `getProposalCount()` and looped through `proposals(i)` to render the list. Next came the vote handler: get a signer, call `vote(proposalId, support)`, wait for the receipt. Finally, she subscribed to `Voted` events so the tallies would move in real time.

As the sun set over the riverbanks, barangay members logged in, voted on Proposal #0, and watched the on-chain tally climb. No paper ballots. No middlemen. Just code and civic spirit. That night, under basketball posters, Det toasted: "Mabuhay Web3 civic-tech, one barangay at a time!" 🇵🇭🏀🚀

---

## 📚 Theory & Web3 Lecture

Welcome to **DAO Voting**! In this lesson you build the voting screen of a small decentralized organization: members see proposals and vote on them, and the contract enforces the rules.

> **This lesson uses ethers v6**: `ethers.BrowserProvider`, `await provider.getSigner()`, values as `bigint` (convert small counts with `Number(x)`), and events with `contract.on` / `contract.off`. Snippets using `ethers.providers...` or `.toNumber()` are ethers v5 and will not run here. <!-- v5-ok -->

---

### 1. Understanding DAOs

A **DAO** (Decentralized Autonomous Organization) is a group whose rules live in a smart contract. Members vote on-chain, and the contract counts the votes. No one can quietly change the count.

```
Traditional Organization:
┌─────────────────────────────────────────────────────────────┐
│  Members → elect → Board → decides behind closed doors      │
│  • Members can't easily check how decisions were made       │
└─────────────────────────────────────────────────────────────┘

DAO:
┌─────────────────────────────────────────────────────────────┐
│  Members → vote directly → Smart Contract counts            │
│  • Every vote is public and verifiable                      │
│  • The rules (who can vote, how often) are code             │
│  • Results can even trigger actions automatically           │
└─────────────────────────────────────────────────────────────┘
```

Well-known DAOs govern real protocols: **Uniswap**, **Aave**, **ENS** and **MakerDAO (now Sky)** members vote on upgrades and treasury spending. Our BarangayDAO is a tiny version of the same idea.

---

### 2. Core Voting Concepts

#### **Proposal Lifecycle**

```
1. CREATION      a member submits a proposal; it gets an id
       ▼
2. VOTING        members vote Yes/No, each vote recorded on-chain
       ▼
3. TALLYING      count Yes vs No, check quorum (minimum turnout)
       ▼
4. EXECUTION     if it passed, carry out the action
```

Our BarangayDAO covers steps 1 and 2 (and shows the tally). Deadlines, quorum and execution are what production systems like OpenZeppelin Governor add.

#### **Voting Power**

| System                | How It Works                      | Pros               | Cons                               |
| --------------------- | --------------------------------- | ------------------ | ---------------------------------- |
| **1 Wallet = 1 Vote** | Each address gets 1 vote          | Simple             | One person can make many wallets   |
| **Token-Weighted**    | More tokens = more votes          | Stakeholders count | Big holders ("whales") dominate    |
| **Quadratic**         | Cost of n votes grows like n²     | Softens whales     | Needs identity checks to be fair   |

BarangayDAO uses **1 wallet = 1 vote**.

---

### 3. The Smart Contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BarangayDAO {
    struct Proposal {
        uint256 id;
        string description;
        uint256 yes;
        uint256 no;
    }

    Proposal[] public proposals;

    // hasVoted[proposalId][voter] is true once that wallet has voted
    mapping(uint256 => mapping(address => bool)) public hasVoted;

    event ProposalCreated(uint256 indexed id, string description);
    event Voted(address indexed voter, uint256 indexed proposalId, bool support);

    function createProposal(string calldata description) external {
        uint256 id = proposals.length;
        proposals.push(Proposal(id, description, 0, 0));
        emit ProposalCreated(id, description);
    }

    function vote(uint256 proposalId, bool support) external {
        require(proposalId < proposals.length, "Proposal doesn't exist");
        require(!hasVoted[proposalId][msg.sender], "Already voted");

        hasVoted[proposalId][msg.sender] = true;

        if (support) {
            proposals[proposalId].yes += 1;
        } else {
            proposals[proposalId].no += 1;
        }

        emit Voted(msg.sender, proposalId, support);
    }

    function getProposalCount() external view returns (uint256) {
        return proposals.length;
    }
}
```

Three things the frontend relies on:

1. **`proposals(i)`**: the getter Solidity generates for `Proposal[] public proposals`. It returns one proposal by index, which is why the UI loops (the same pattern as the to-do list in Lesson 09).
2. **`hasVoted(proposalId, voter)`**: the getter for the nested mapping. A **nested mapping** is a table of tables: for each proposal, a table of addresses. The UI asks it so it can hide the buttons; the contract checks it so cheating is impossible either way.
3. **`Voted` event**: announced on every vote, so every open browser can update.

`require(!hasVoted[...])` is the real protection. Hiding buttons in the UI is only a convenience: anyone can call the contract directly.

---

### 4. The ABI

```js
const DAO_ABI = [
  "function getProposalCount() view returns (uint256)",
  "function proposals(uint256) view returns (uint256 id, string description, uint256 yes, uint256 no)",
  "function hasVoted(uint256 proposalId, address voter) view returns (bool)",
  "function createProposal(string description)",
  "function vote(uint256 proposalId, bool support)",
  "event ProposalCreated(uint256 indexed id, string description)",
  "event Voted(address indexed voter, uint256 indexed proposalId, bool support)",
];
```

---

### 5. Loading Proposals

```js
async function loadProposals(account) {
  const provider = new ethers.BrowserProvider(window.ethereum);
  const dao = new ethers.Contract(DAO_ADDRESS, DAO_ABI, provider);

  const count = await dao.getProposalCount(); // bigint, e.g. 2n

  const items = [];
  for (let i = 0; i < count; i++) {
    const [id, description, yes, no] = await dao.proposals(i);
    const voted = await dao.hasVoted(i, account);
    items.push({
      id: Number(id),
      description,
      yes: Number(yes),
      no: Number(no),
      hasVoted: voted,
    });
  }
  return items;
}
```

#### **Positional or Named?**

Because the ABI names the outputs (`uint256 yes`), ethers v6 lets you read them either way:

```js
const p = await dao.proposals(0);
p[2];   // yes, by position
p.yes;  // yes, by name: same value (a bigint)
```

#### **Why `Number()`?**

v6 returns every `uint256` as a `bigint`. A `bigint` and a normal number **cannot be mixed** in arithmetic:

```js
5n + 1;          // TypeError: Cannot mix BigInt and other types
Number(5n) + 1;  // 6
5n + 1n;         // 6n   (also fine: keep both as bigint)
```

Vote counts are small, so converting them to `Number` once, right after reading, keeps the rest of your React code simple. Comparisons like `5n > 1n` or `1 < 2n` work without conversion.

#### **Showing a Percentage Bar**

```jsx
function ProposalCard({ proposal }) {
  const total = proposal.yes + proposal.no;
  const yesPercent = total > 0 ? Math.round((proposal.yes / total) * 100) : 0;

  return (
    <div>
      <h3>#{proposal.id}: {proposal.description}</h3>
      <div style={{ background: "#eee", height: 8 }}>
        <div style={{ background: "green", height: 8, width: `${yesPercent}%` }} />
      </div>
      <p>Yes: {proposal.yes} ({yesPercent}%) | No: {proposal.no}</p>
    </div>
  );
}
```

---

### 6. Casting a Vote

A vote changes contract state, so it needs a **signer**:

```js
async function castVote(proposalId, support) {
  const provider = new ethers.BrowserProvider(window.ethereum);
  const signer = await provider.getSigner();               // v6: await!
  const dao = new ethers.Contract(DAO_ADDRESS, DAO_ABI, signer);

  // Friendly early check: the contract would reject a second vote anyway
  if (await dao.hasVoted(proposalId, signer.address)) {
    throw new Error("You have already voted on this proposal");
  }

  const tx = await dao.vote(proposalId, support);          // MetaMask pop-up
  const receipt = await tx.wait();                         // mined
  console.log("Vote confirmed in block", receipt.blockNumber);
}
```

#### **Handling Errors**

```js
try {
  await castVote(id, true);
} catch (err) {
  if (err.code === "ACTION_REJECTED") {
    setError("Vote cancelled");
  } else if (err.code === "CALL_EXCEPTION") {
    // a require() failed, e.g. "Already voted"
    setError(err.reason || "The DAO rejected this vote");
  } else {
    setError(err.shortMessage || err.message);
  }
}
```

---

### 7. Live Updates with Events

```
Alice votes Yes on Proposal #0
      │
      ▼
Contract emits Voted(Alice, 0, true)
      │
      ├────────────────┬────────────────┐
      ▼                ▼                ▼
Alice's browser   Bob's browser   Carol's browser
 tally +1          tally +1        tally +1
```

```jsx
useEffect(() => {
  const provider = new ethers.BrowserProvider(window.ethereum);
  const dao = new ethers.Contract(DAO_ADDRESS, DAO_ABI, provider);

  const handleVote = (voter, proposalId, support) => {
    setProposals((prev) =>
      prev.map((p) =>
        p.id === Number(proposalId)
          ? { ...p, yes: support ? p.yes + 1 : p.yes, no: support ? p.no : p.no + 1 }
          : p
      )
    );
  };

  dao.on("Voted", handleVote);
  return () => dao.off("Voted", handleVote); // cleanup on unmount
}, []);
```

- The handler receives the event's arguments in order: `voter`, `proposalId` (a `bigint`), `support`.
- `setProposals((prev) => ...)` matters here: the listener is created once, so it must not rely on a `proposals` value captured at that moment.
- `BrowserProvider` checks for new events by **polling** the node every few seconds, so "live" means "within a few seconds", not instantly.

#### **Avoiding the Double Count**

If your `castVote` also adds 1 to the tally after `tx.wait()` (as the activity does), then **your own** vote is counted twice on a real network: once by `castVote`, and again when your own `Voted` event arrives. Two clean ways out:

```js
// Option A: let the event be the only thing that changes the tally.
// castVote only locks the buttons:
await tx.wait();
setProposals((prev) => prev.map((p) => (p.id === proposalId ? { ...p, hasVoted: true } : p)));

// Option B: after tx.wait(), re-read that one proposal from the chain instead of adding 1.
const fresh = await dao.proposals(proposalId);
// ...set yes/no from Number(fresh.yes) and Number(fresh.no)
```

The activity keeps the simpler "add 1 in both places" version because its grader does not fire events, but in your own projects prefer A or B.

---

### 8. Creating Proposals

```js
async function createProposal(description) {
  if (!description.trim()) throw new Error("Proposal description is required");

  const provider = new ethers.BrowserProvider(window.ethereum);
  const signer = await provider.getSigner();
  const dao = new ethers.Contract(DAO_ADDRESS, DAO_ABI, signer);

  const tx = await dao.createProposal(description);
  const receipt = await tx.wait();

  // ethers decodes logs whose event is in the ABI
  const created = receipt.logs.find((log) => log.eventName === "ProposalCreated");
  return Number(created.args.id);
}
```

The activity does not build proposal creation, but this is how you would add it.

---

### 9. Best Practices for DAO UIs

1. **Transparency**: show every proposal's full text and both counts; link each vote's transaction on [Sepolia Etherscan](https://sepolia.etherscan.io).
2. **Feedback**: a pending state while the transaction mines, and a clear "You've voted" afterwards.
3. **Don't rely on the UI for rules**: the contract enforces one vote per wallet; the UI only reflects it.
4. **Live data**: events keep everyone's screen current, and cleanup keeps listeners from piling up.

---

### 10. Common Mistakes to Avoid

#### **1. Mixing bigint and number**

```js
// ❌ TypeError: Cannot mix BigInt and other types
const [, , yes] = await dao.proposals(0);
setYes(yes + 1);

// ✅ convert once, right after reading
setYes(Number(yes) + 1);
```

#### **2. Comparing a bigint id with a number using ===**

```js
// ❌ never true: 0n and 0 are different types
p.id === proposalId; // when proposalId came straight from an event

// ✅
p.id === Number(proposalId);
```

#### **3. Forgetting Event Cleanup**

```js
// ❌ every remount adds another listener, and votes get counted many times
useEffect(() => {
  dao.on("Voted", handleVote);
}, []);

// ✅
useEffect(() => {
  dao.on("Voted", handleVote);
  return () => dao.off("Voted", handleVote);
}, []);
```

---

### 11. How This Is Graded

The activity runs in a sandbox with a fake wallet and a fake DAO holding two proposals: #0 "Ayusin ang basketball court" (5 Yes, 1 No, you haven't voted) and #1 "Bagong ilaw sa kalye" (you already voted). The grader checks that you read the count, each proposal and each `hasVoted`, show the descriptions and a tally like "Yes: 5", offer **Vote Yes** / **Vote No** only on the unvoted proposal, send `vote(0, true)` and wait for the receipt, and subscribe to and unsubscribe from `Voted`.

---

### External References & Further Learning

- **ethers v6, Contracts and events**: https://docs.ethers.org/v6/api/contract/
- **OpenZeppelin Governance (v5)**: https://docs.openzeppelin.com/contracts/5.x/governance
- **Solidity, mappings (including nested ones)**: https://docs.soliditylang.org/en/latest/types.html#mapping-types
- **React `useEffect` cleanup**: https://react.dev/learn/synchronizing-with-effects

---

## 🧪 Exercises

### Exercise 1: Fetch & Render Proposals (Read Only)

**Problem Statement**
Build `ProposalList`: read and display every proposal without asking the visitor to connect a wallet.

**Full Solution (`ProposalList.jsx`)**

```jsx
import { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getProposalCount() view returns (uint256)",
  "function proposals(uint256) view returns (uint256 id, string description, uint256 yes, uint256 no)",
];
const DAO_ADDRESS = import.meta.env.VITE_DAO_ADDRESS;

export default function ProposalList() {
  const [proposals, setProposals] = useState([]);
  const [error, setError] = useState("");

  useEffect(() => {
    async function load() {
      try {
        const provider = new ethers.JsonRpcProvider(import.meta.env.VITE_RPC_URL);
        const dao = new ethers.Contract(DAO_ADDRESS, ABI, provider);
        const count = await dao.getProposalCount();
        const items = [];
        for (let i = 0; i < count; i++) {
          const p = await dao.proposals(i);
          items.push({
            id: Number(p.id),
            description: p.description,
            yes: Number(p.yes),
            no: Number(p.no),
          });
        }
        setProposals(items);
      } catch (err) {
        setError(err.message);
      }
    }
    load();
  }, []);

  if (error) return <p style={{ color: "red" }}>{error}</p>;
  return (
    <div>
      <h2>BarangayDAO Proposals</h2>
      {proposals.length === 0 && <p>No proposals yet.</p>}
      <ul>
        {proposals.map((p) => (
          <li key={p.id} style={{ margin: "12px 0" }}>
            <strong>#{p.id}:</strong> {p.description}
            <br />
            Yes: {p.yes} | No: {p.no}
          </li>
        ))}
      </ul>
    </div>
  );
}
```

**.env sample (Vite)**

```
VITE_RPC_URL=https://sepolia.infura.io/v3/YOUR_KEY
VITE_DAO_ADDRESS=0xYourDaoContractAddress
```

(The activity's grader supplies `process.env.REACT_APP_DAO_ADDRESS` instead, and the starter already reads it.)

---

### Exercise 2: A Vote Form With a Pending State

**Problem Statement**
Build `VoteForm`: pick Yes or No with radio buttons, submit, show "Submitting..." while the transaction mines, then show the transaction hash.

**Full Solution (`VoteForm.jsx`)**

```jsx
import { useState } from "react";
import { ethers } from "ethers";

const ABI = ["function vote(uint256, bool)"];
const DAO_ADDRESS = import.meta.env.VITE_DAO_ADDRESS;

export default function VoteForm({ proposalId, onVoted }) {
  const [support, setSupport] = useState(true);
  const [error, setError] = useState("");
  const [txHash, setTxHash] = useState("");
  const [loading, setLoading] = useState(false);

  async function castVote() {
    setError("");
    setTxHash("");
    try {
      setLoading(true);
      const provider = new ethers.BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();
      const dao = new ethers.Contract(DAO_ADDRESS, ABI, signer);
      const tx = await dao.vote(proposalId, support);
      const receipt = await tx.wait();
      setTxHash(receipt.hash);
      onVoted();
    } catch (err) {
      setError(err.shortMessage || err.message);
    } finally {
      setLoading(false);
    }
  }

  return (
    <div>
      <h3>Vote on Proposal #{proposalId}</h3>
      <label>
        <input type="radio" checked={support} onChange={() => setSupport(true)} /> Yes
      </label>
      <label style={{ marginLeft: 12 }}>
        <input type="radio" checked={!support} onChange={() => setSupport(false)} /> No
      </label>
      <button onClick={castVote} disabled={loading}>
        {loading ? "Submitting..." : "Submit Vote"}
      </button>
      {txHash && <p>Tx Hash: {txHash}</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

In ethers v6 the receipt's hash is `receipt.hash` (v5 called it `receipt.transactionHash`). <!-- v5-ok -->

---

### Exercise 3: Live Results Panel

**Problem Statement**
Create `ResultsPanel`: load the current tallies once, then update them from `Voted` events, and clean up on unmount.

**Full Solution (`ResultsPanel.jsx`)**

```jsx
import { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getProposalCount() view returns (uint256)",
  "function proposals(uint256) view returns (uint256 id, string description, uint256 yes, uint256 no)",
  "event Voted(address indexed voter, uint256 indexed proposalId, bool support)",
];
const DAO_ADDRESS = import.meta.env.VITE_DAO_ADDRESS;

export default function ResultsPanel() {
  const [results, setResults] = useState([]);

  useEffect(() => {
    const provider = new ethers.JsonRpcProvider(import.meta.env.VITE_RPC_URL);
    const dao = new ethers.Contract(DAO_ADDRESS, ABI, provider);

    async function loadInitial() {
      const count = await dao.getProposalCount();
      const rows = [];
      for (let i = 0; i < count; i++) {
        const p = await dao.proposals(i);
        rows.push({ id: Number(p.id), yes: Number(p.yes), no: Number(p.no) });
      }
      setResults(rows);
    }

    const onVoted = (_voter, proposalId, support) => {
      setResults((prev) =>
        prev.map((r) =>
          r.id === Number(proposalId)
            ? { ...r, yes: support ? r.yes + 1 : r.yes, no: support ? r.no : r.no + 1 }
            : r
        )
      );
    };

    loadInitial();
    dao.on("Voted", onVoted);
    return () => dao.off("Voted", onVoted);
  }, []);

  return (
    <div>
      <h3>Live Voting Results</h3>
      {results.map((r) => (
        <div key={r.id}>
          <strong>#{r.id}</strong>: Yes: {r.yes} | No: {r.no}
        </div>
      ))}
    </div>
  );
}
```

Subscribing synchronously inside the effect (instead of after an `await`) means the cleanup always has the listener to remove, even if the component unmounts before the first load finishes.

---

## 🌟 Closing Story

As the sun peeked over the barangay hall, members gathered around their phones. Proposal #0, the basketball court, was passing with resounding on-chain support. Odessa watched the live tallies climb and felt a surge of pride: code had become a civic voice. Next up: voting deadlines, quorum checks, and maybe token-weighted votes for the cooperative. True Filipino DAO governance, one barangay at a time. Mabuhay Web3 civic-tech! 🇵🇭🏀🚀
