## 🧑‍💻 Background Story

![DAO Voting UI](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+10.0+-+COVER.png)

It was a humid afternoon in Barangay San Perfecto when Det stepped into the barangay hall-turned-coworking-space. The Barangay Council was debating whether to fund new basketball courts—a dream for every hoops-mad teenager in San Perfecto. Neri had already deployed the on-chain “BarangayDAO” smart contract on a Sepolia testnet, complete with proposals and token-weighted voting. Now, Det’s mission was to build the frontend.

![DAO Voting UI Sketch](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+10.1.png)

With teammates sipping sikwate, she sketched a three-panel UI:

1. **Proposal List**: showing each proposal ID, description, and vote tallies.
2. **Vote Form**: let members pick “Yes” or “No” and cast their vote.
3. **Results Panel**: live update when new votes come in.

In under 30 minutes, Det fired up a React app, wired Ethers.js, and connected MetaMask. She fetched `getProposalCount()` and looped through `proposals(id)` to render a table. Next, she built the vote handler: request signer, call `vote(proposalId, support)`, await confirmation, then refresh tallies. Finally, she subscribed to `Voted` events so the Results panel would update in real time.

As the sun set over the riverbanks, barangay members logged in, voted on Court Proposal #0, and watched the on-chain tally climb. No paper ballots. No middlemen. Just code and civic spirit. That night, under filipiniana decor and basketball posters, Det toasted: “Mabuhay Web3 civic-tech, one barangay at a time!” 🇵🇭🏀🚀

---

## 📚 Theory & Web3 Lecture

Welcome to **DAO Voting**! In this lesson, you'll build a decentralized governance system where community members can create proposals and vote on them. This is the heart of Web3 democracy—no central authority, just code and consensus!

---

### 1. Understanding DAOs (Decentralized Autonomous Organizations)

#### **What is a DAO?**

A DAO is an organization governed by code instead of people:

```
Traditional Organization:
┌─────────────────────────────────────────────────────────────┐
│  Members → elect → Board of Directors → make decisions     │
│                                                             │
│  Problems:                                                  │
│  • Decisions made behind closed doors                       │
│  • Leaders can be corrupt                                   │
│  • Slow bureaucratic processes                              │
│  • Members have little real power                           │
└─────────────────────────────────────────────────────────────┘

DAO (Decentralized Autonomous Organization):
┌─────────────────────────────────────────────────────────────┐
│  Members → vote directly → Smart Contract → executes       │
│                                                             │
│  Benefits:                                                  │
│  • All votes public and verifiable                          │
│  • Rules encoded in smart contracts                         │
│  • Instant execution of decisions                           │
│  • Everyone has a voice                                     │
└─────────────────────────────────────────────────────────────┘
```

#### **Real-World DAO Examples**

| DAO          | Purpose                     | Treasury |
| ------------ | --------------------------- | -------- |
| **MakerDAO** | Manages DAI stablecoin      | $7B+     |
| **Uniswap**  | Governs DEX protocol        | $2B+     |
| **Aave**     | Lending protocol governance | $500M+   |
| **ENS DAO**  | Ethereum Name Service       | $1B+     |
| **Gitcoin**  | Public goods funding        | $500M+   |

---

### 2. Core Voting Concepts

#### **Proposal Lifecycle**

```
Proposal Lifecycle:
┌─────────────────────────────────────────────────────────────┐
│                                                              │
│  1. CREATION                                                 │
│     │  Member submits proposal with description              │
│     │  Proposal gets unique ID                               │
│     │  State: "Active" or "Pending"                          │
│     ▼                                                        │
│  2. VOTING PERIOD                                            │
│     │  Members cast Yes/No votes                             │
│     │  Each vote recorded on-chain                           │
│     │  Can't change vote after casting                       │
│     ▼                                                        │
│  3. TALLYING                                                 │
│     │  Count all Yes vs No votes                             │
│     │  Check if quorum met (minimum participation)           │
│     │  Determine: Passed or Failed                           │
│     ▼                                                        │
│  4. EXECUTION (if passed)                                    │
│        Execute the proposed action                           │
│        Could be: transfer funds, change parameters, etc.     │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

#### **Voting Power**

Different DAOs use different voting systems:

| System                | How It Works               | Pros                   | Cons                          |
| --------------------- | -------------------------- | ---------------------- | ----------------------------- |
| **1 Wallet = 1 Vote** | Each address gets 1 vote   | Simple, democratic     | Sybil attacks (fake accounts) |
| **Token-Weighted**    | More tokens = more votes   | Stakeholders matter    | Whales dominate               |
| **Quadratic**         | Vote power = √(tokens)     | Balances wealth        | Complex                       |
| **Conviction**        | Votes strengthen over time | Reduces snap decisions | Slow                          |

---

### 3. Smart Contract Design

#### **The Proposal Struct**

```solidity
struct Proposal {
    uint256 id;            // Unique identifier
    string description;    // What's being voted on
    uint256 yes;           // Yes vote count
    uint256 no;            // No vote count
    // Could also add:
    // uint256 deadline;   // When voting ends
    // bool executed;      // Has action been taken?
    // address proposer;   // Who created it?
}
```

#### **Complete DAO Contract**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayDAO {
    // Data structure for proposals
    struct Proposal {
        uint256 id;
        string description;
        uint256 yes;
        uint256 no;
    }

    // Storage
    Proposal[] public proposals;

    // Track who voted on what (prevent double voting)
    mapping(uint256 => mapping(address => bool)) public hasVoted;

    // Events for frontend reactivity
    event ProposalCreated(uint256 indexed id, string description);
    event Voted(address indexed voter, uint256 indexed proposalId, bool support);

    // Create a new proposal
    function createProposal(string calldata description) external {
        uint256 id = proposals.length;
        proposals.push(Proposal(id, description, 0, 0));
        emit ProposalCreated(id, description);
    }

    // Cast a vote
    function vote(uint256 proposalId, bool support) external {
        require(proposalId < proposals.length, "Proposal doesn't exist");
        require(!hasVoted[proposalId][msg.sender], "Already voted");

        // Record the vote
        hasVoted[proposalId][msg.sender] = true;

        // Update tally
        if (support) {
            proposals[proposalId].yes += 1;
        } else {
            proposals[proposalId].no += 1;
        }

        emit Voted(msg.sender, proposalId, support);
    }

    // Get total number of proposals
    function getProposalCount() external view returns (uint256) {
        return proposals.length;
    }
}
```

#### **Key Contract Features**

1. **Double-vote prevention**: `mapping(uint256 => mapping(address => bool)) hasVoted`
2. **Event emission**: Frontend knows when to update
3. **Simple counting**: Yes/No tallies stored in struct

---

### 4. The ABI for DAO Interactions

```js
const DAO_ABI = [
  // Read functions
  "function getProposalCount() view returns (uint256)",
  "function proposals(uint256) view returns (uint256 id, string description, uint256 yes, uint256 no)",
  "function hasVoted(uint256 proposalId, address voter) view returns (bool)",

  // Write functions
  "function createProposal(string calldata description)",
  "function vote(uint256 proposalId, bool support)",

  // Events
  "event ProposalCreated(uint256 indexed id, string description)",
  "event Voted(address indexed voter, uint256 indexed proposalId, bool support)",
];
```

---

### 5. Fetching & Displaying Proposals

#### **Loading All Proposals**

```js
async function loadProposals() {
  const provider = new ethers.providers.Web3Provider(window.ethereum);
  const dao = new ethers.Contract(DAO_ADDRESS, DAO_ABI, provider);

  // Get total count
  const count = await dao.getProposalCount();
  console.log(`Total proposals: ${count}`);

  // Fetch each proposal
  const proposals = [];
  for (let i = 0; i < count; i++) {
    const [id, description, yes, no] = await dao.proposals(i);
    proposals.push({
      id: id.toNumber(),
      description,
      yes: yes.toNumber(),
      no: no.toNumber(),
    });
  }

  return proposals;
}
```

#### **Displaying with Vote Stats**

```jsx
function ProposalCard({ proposal }) {
  const total = proposal.yes + proposal.no;
  const yesPercent = total > 0 ? Math.round((proposal.yes / total) * 100) : 0;

  return (
    <div className="proposal-card">
      <h3>Proposal #{proposal.id}</h3>
      <p>{proposal.description}</p>

      <div className="vote-bar">
        <div className="yes-bar" style={{ width: `${yesPercent}%` }} />
      </div>

      <div className="vote-stats">
        <span>
          👍 {proposal.yes} ({yesPercent}%)
        </span>
        <span>
          👎 {proposal.no} ({100 - yesPercent}%)
        </span>
      </div>
    </div>
  );
}
```

---

### 6. Casting Votes

#### **Vote Function Implementation**

```js
async function castVote(proposalId, support) {
  // Get signer for transaction
  await window.ethereum.request({ method: "eth_requestAccounts" });
  const provider = new ethers.providers.Web3Provider(window.ethereum);
  const signer = provider.getSigner();
  const dao = new ethers.Contract(DAO_ADDRESS, DAO_ABI, signer);

  // Check if already voted
  const userAddress = await signer.getAddress();
  const alreadyVoted = await dao.hasVoted(proposalId, userAddress);

  if (alreadyVoted) {
    throw new Error("You have already voted on this proposal");
  }

  // Cast the vote
  console.log(`Voting ${support ? "Yes" : "No"} on proposal #${proposalId}`);
  const tx = await dao.vote(proposalId, support);

  // Wait for confirmation
  const receipt = await tx.wait();
  console.log("Vote confirmed in block:", receipt.blockNumber);

  return receipt;
}
```

#### **Vote UI Component**

```jsx
function VoteForm({ proposalId, onVoted }) {
  const [support, setSupport] = useState(true);
  const [status, setStatus] = useState("idle");
  const [error, setError] = useState("");

  async function handleVote() {
    setStatus("pending");
    setError("");

    try {
      await castVote(proposalId, support);
      setStatus("success");
      onVoted(); // Refresh proposal data
    } catch (err) {
      if (err.code === 4001) {
        setError("Vote cancelled");
      } else if (err.message.includes("Already voted")) {
        setError("You've already voted on this proposal");
      } else {
        setError(err.message);
      }
      setStatus("error");
    }
  }

  return (
    <div className="vote-form">
      <div className="vote-options">
        <label>
          <input
            type="radio"
            checked={support === true}
            onChange={() => setSupport(true)}
            disabled={status === "pending"}
          />
          👍 Yes
        </label>
        <label>
          <input
            type="radio"
            checked={support === false}
            onChange={() => setSupport(false)}
            disabled={status === "pending"}
          />
          👎 No
        </label>
      </div>

      <button onClick={handleVote} disabled={status === "pending"}>
        {status === "pending" ? "Submitting..." : "Cast Vote"}
      </button>

      {status === "success" && <p className="success">✅ Vote recorded!</p>}
      {error && <p className="error">❌ {error}</p>}
    </div>
  );
}
```

---

### 7. Real-Time Vote Updates with Events

#### **Why Events for Voting?**

When someone votes, all users should see updated tallies immediately:

```
Event-Driven Updates:
┌─────────────────────────────────────────────────────────────┐
│                                                              │
│  Alice votes Yes on Proposal #0                              │
│       │                                                      │
│       ▼                                                      │
│  Contract emits: Voted(Alice, 0, true)                       │
│       │                                                      │
│       ├──────────────────┬──────────────────┐               │
│       ▼                  ▼                  ▼               │
│  [Alice's Browser]  [Bob's Browser]  [Carol's Browser]      │
│  Updates UI         Updates UI       Updates UI             │
│  instantly          instantly        instantly               │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

#### **Implementing Event Listeners**

```js
function useVoteEvents(daoAddress, onVoteReceived) {
  useEffect(() => {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const dao = new ethers.Contract(daoAddress, DAO_ABI, provider);

    // Handler for vote events
    function handleVote(voter, proposalId, support, event) {
      console.log(
        `Vote received: ${voter} voted ${
          support ? "Yes" : "No"
        } on #${proposalId}`
      );

      // Update the specific proposal
      onVoteReceived(proposalId.toNumber(), support);
    }

    // Subscribe
    dao.on("Voted", handleVote);

    // Cleanup
    return () => {
      dao.off("Voted", handleVote);
    };
  }, [daoAddress, onVoteReceived]);
}

// Usage in component
function ResultsPanel() {
  const [proposals, setProposals] = useState([]);

  const handleVoteReceived = useCallback((proposalId, support) => {
    setProposals((prev) =>
      prev.map((p) => {
        if (p.id === proposalId) {
          return {
            ...p,
            yes: support ? p.yes + 1 : p.yes,
            no: support ? p.no : p.no + 1,
          };
        }
        return p;
      })
    );
  }, []);

  useVoteEvents(DAO_ADDRESS, handleVoteReceived);

  // ... render proposals
}
```

---

### 8. Creating Proposals

#### **Proposal Creation Flow**

```js
async function createProposal(description) {
  // Validate
  if (!description || !description.trim()) {
    throw new Error("Proposal description is required");
  }

  // Get signer
  await window.ethereum.request({ method: "eth_requestAccounts" });
  const provider = new ethers.providers.Web3Provider(window.ethereum);
  const signer = provider.getSigner();
  const dao = new ethers.Contract(DAO_ADDRESS, DAO_ABI, signer);

  // Create proposal
  console.log("Creating proposal...");
  const tx = await dao.createProposal(description);

  // Wait for confirmation
  const receipt = await tx.wait();

  // Get the new proposal ID from event
  const event = receipt.events.find((e) => e.event === "ProposalCreated");
  const newId = event.args.id.toNumber();

  console.log(`Proposal #${newId} created!`);
  return newId;
}
```

---

### 9. Checking Vote Status

#### **Has User Already Voted?**

```js
async function checkVoteStatus(proposalId, userAddress) {
  const provider = new ethers.providers.Web3Provider(window.ethereum);
  const dao = new ethers.Contract(DAO_ADDRESS, DAO_ABI, provider);

  const hasVoted = await dao.hasVoted(proposalId, userAddress);
  return hasVoted;
}

// In your component
function ProposalActions({ proposalId }) {
  const [hasVoted, setHasVoted] = useState(false);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function check() {
      const [account] = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      const voted = await checkVoteStatus(proposalId, account);
      setHasVoted(voted);
      setLoading(false);
    }
    check();
  }, [proposalId]);

  if (loading) return <p>Loading...</p>;

  if (hasVoted) {
    return <p className="voted-badge">✅ You've voted</p>;
  }

  return <VoteForm proposalId={proposalId} />;
}
```

---

### 10. Best Practices for DAO UIs

#### **User Experience Guidelines**

```
Good DAO UI Practices:
┌─────────────────────────────────────────────────────────────┐
│                                                              │
│  1. TRANSPARENCY                                             │
│     • Show all proposal details clearly                      │
│     • Display vote counts and percentages                    │
│     • Link to transaction on Etherscan                       │
│                                                              │
│  2. FEEDBACK                                                 │
│     • Confirm vote was recorded                              │
│     • Show pending state during transaction                  │
│     • Display "Already Voted" if applicable                  │
│                                                              │
│  3. ACCESSIBILITY                                            │
│     • Clear Yes/No options                                   │
│     • Disabled buttons when appropriate                      │
│     • Error messages that explain what went wrong            │
│                                                              │
│  4. REAL-TIME                                                │
│     • Use events for live updates                            │
│     • No need to refresh page                                │
│     • Show when new proposals are created                    │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

### 11. Complete DAO App Component

```jsx
function DAOVotingApp() {
  const [proposals, setProposals] = useState([]);
  const [loading, setLoading] = useState(true);
  const [userAddress, setUserAddress] = useState("");

  // Load proposals on mount
  useEffect(() => {
    loadData();
  }, []);

  async function loadData() {
    try {
      setLoading(true);
      const [account] = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      setUserAddress(account);

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const dao = new ethers.Contract(DAO_ADDRESS, DAO_ABI, provider);

      const count = await dao.getProposalCount();
      const items = [];

      for (let i = 0; i < count; i++) {
        const [id, description, yes, no] = await dao.proposals(i);
        const hasVoted = await dao.hasVoted(i, account);

        items.push({
          id: id.toNumber(),
          description,
          yes: yes.toNumber(),
          no: no.toNumber(),
          hasVoted,
        });
      }

      setProposals(items);
    } catch (err) {
      console.error(err);
    } finally {
      setLoading(false);
    }
  }

  if (loading) return <p>Loading DAO...</p>;

  return (
    <div className="dao-app">
      <h1>🏛️ BarangayDAO</h1>
      <p>
        Connected: {userAddress.slice(0, 6)}...{userAddress.slice(-4)}
      </p>

      <CreateProposal onCreated={loadData} />

      <h2>Active Proposals</h2>
      {proposals.map((p) => (
        <div key={p.id} className="proposal">
          <h3>
            #{p.id}: {p.description}
          </h3>
          <p>
            👍 {p.yes} | 👎 {p.no}
          </p>

          {p.hasVoted ? (
            <span className="voted">✅ Voted</span>
          ) : (
            <VoteForm proposalId={p.id} onVoted={loadData} />
          )}
        </div>
      ))}
    </div>
  );
}
```

---

### 12. Common Mistakes to Avoid

#### **1. Not Checking If Already Voted**

```js
// ❌ Transaction will revert
await dao.vote(proposalId, true);

// ✅ Check first
const hasVoted = await dao.hasVoted(proposalId, userAddress);
if (hasVoted) {
  alert("You've already voted!");
  return;
}
await dao.vote(proposalId, true);
```

#### **2. Not Converting BigNumbers**

```js
// ❌ Comparing BigNumber to number
if (proposal.yes > proposal.no) // May not work!

// ✅ Convert to numbers
if (proposal.yes.toNumber() > proposal.no.toNumber())
```

#### **3. Forgetting Event Cleanup**

```js
// ❌ Memory leak
useEffect(() => {
  dao.on("Voted", handleVote);
}, []);

// ✅ Clean up
useEffect(() => {
  dao.on("Voted", handleVote);
  return () => dao.off("Voted", handleVote);
}, []);
```

---

### 13. Testing Your DAO Voting UI

Before deploying, verify:

1. ✅ **Proposals load** - All proposals display correctly
2. ✅ **Vote counts show** - Yes/No tallies are accurate
3. ✅ **Voting works** - Can cast Yes or No vote
4. ✅ **Double-vote prevented** - Can't vote twice
5. ✅ **Already voted shown** - Clear indicator after voting
6. ✅ **Real-time updates** - Other votes appear live
7. ✅ **Create proposal works** - New proposals appear
8. ✅ **User rejection handled** - Graceful cancel

---

### External References & Further Learning

- **Ethers.js Events**: https://docs.ethers.org/v5/api/contract/contract/#Contract--events - Listening to events
- **Compound Governance**: https://docs.compound.finance/v2/governance/ - Real DAO example
- **OpenZeppelin Governor**: https://docs.openzeppelin.com/contracts/4.x/governance - Production governance
- **Snapshot**: https://docs.snapshot.org - Off-chain voting
- **Tally**: https://docs.tally.xyz - DAO governance interface
- **DAOhaus**: https://daohaus.club/docs - Building DAOs

---

## 🧪 Exercises

### Exercise 1: Fetch & Render Proposals

Problem: Build `ProposalList` to read and display all proposals.

**Solidity Contract (`BarangayDAO.sol`)**

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BarangayDAO {
    struct Proposal {
        uint id;
        string description;
        uint yes;
        uint no;
    }

    Proposal[] public proposals;

    event ProposalCreated(uint id, string description);
    event Voted(address indexed voter, uint proposalId, bool support);

    function createProposal(string calldata description) external {
        uint id = proposals.length;
        proposals.push(Proposal(id, description, 0, 0));
        emit ProposalCreated(id, description);
    }

    function vote(uint proposalId, bool support) external {
        Proposal storage p = proposals[proposalId];
        require(proposalId < proposals.length, "Invalid proposal");
        if (support) p.yes += 1;
        else p.no += 1;
        emit Voted(msg.sender, proposalId, support);
    }

    function getProposalCount() external view returns (uint) {
        return proposals.length;
    }
}
```

**Starter Code (`ProposalList.js`)**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getProposalCount() view returns (uint256)",
  "function proposals(uint256) view returns (uint256 id, string description, uint256 yes, uint256 no)",
];

export default function ProposalList() {
  const [proposals, setProposals] = useState([]);
  const [error, setError] = useState("");

  useEffect(() => {
    async function load() {
      try {
        // 1. await window.ethereum.request(...)
        // 2. const provider = new ethers.providers.Web3Provider(...)
        // 3. const dao = new ethers.Contract(address, ABI, provider)
        // 4. const count = await dao.getProposalCount()
        // 5. loop i in [0..count) => dao.proposals(i)
        // 6. setProposals([...])
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
      <ul>
        {proposals.map((p) => (
          <li key={p.id}>
            #{p.id} – {p.description} <br />
            👍 {p.yes} 👎 {p.no}
          </li>
        ))}
      </ul>
    </div>
  );
}
```

To Do List

- [ ] Connect wallet: `eth_requestAccounts`
- [ ] Instantiate `provider` & `dao`
- [ ] Call `getProposalCount()`
- [ ] Loop to fetch each `proposals(i)`
- [ ] Parse BigNumber fields and `setProposals`

**Full Solution**

```js
// ProposalList.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = [
  "function getProposalCount() view returns (uint256)",
  "function proposals(uint256) view returns (uint256 id, string description, uint256 yes, uint256 no)",
];
const DAO_ADDRESS = process.env.REACT_APP_DAO_ADDRESS;

export default function ProposalList() {
  const [proposals, setProposals] = useState([]);
  const [error, setError] = useState("");

  useEffect(() => {
    async function load() {
      try {
        await window.ethereum.request({ method: "eth_requestAccounts" });
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const dao = new ethers.Contract(DAO_ADDRESS, ABI, provider);
        const count = (await dao.getProposalCount()).toNumber();
        const items = [];
        for (let i = 0; i < count; i++) {
          const [id, desc, yes, no] = await dao.proposals(i);
          items.push({
            id: id.toNumber(),
            description: desc,
            yes: yes.toNumber(),
            no: no.toNumber(),
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
      <ul>
        {proposals.map((p) => (
          <li key={p.id} style={{ margin: "12px 0" }}>
            <strong>#{p.id}:</strong> {p.description}
            <br />
            👍 {p.yes} 👎 {p.no}
          </li>
        ))}
      </ul>
    </div>
  );
}
```

.env Sample

```
REACT_APP_RPC_URL=https://sepolia.infura.io/v3/YOUR_KEY
REACT_APP_DAO_ADDRESS=0xYourDaoContractAddress
```

---

### Exercise 2: Cast a Vote

Problem: Build `VoteForm` to let a member vote Yes/No on a selected proposal.

**Starter Code (`VoteForm.js`)**

```js
import React, { useState } from "react";
import { ethers } from "ethers";

const ABI = ["function vote(uint256,bool) returns ()"];

export default function VoteForm({ proposalId, onVoted }) {
  const [support, setSupport] = useState(true);
  const [error, setError] = useState("");
  const [txHash, setTxHash] = useState("");

  async function castVote() {
    try {
      // 1. request accounts
      // 2. provider & signer
      // 3. dao = new Contract(address, ABI, signer)
      // 4. tx = await dao.vote(proposalId, support)
      // 5. await tx.wait()
      // 6. setTxHash(tx.hash); onVoted()
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <div>
      <h3>Vote on Proposal #{proposalId}</h3>
      <label>
        <input
          type="radio"
          checked={support === true}
          onChange={() => setSupport(true)}
        />{" "}
        Yes
      </label>
      <label style={{ marginLeft: 12 }}>
        <input
          type="radio"
          checked={support === false}
          onChange={() => setSupport(false)}
        />{" "}
        No
      </label>
      <button onClick={castVote}>Submit Vote</button>
      {txHash && <p>Tx Hash: {txHash}</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

To Do List

- [ ] Connect wallet & get signer
- [ ] Instantiate DAO contract with signer
- [ ] Call `vote(proposalId, support)`
- [ ] Await `tx.wait()`
- [ ] onVoted() to refresh list

**Full Solution**

```js
// VoteForm.js
import React, { useState } from "react";
import { ethers } from "ethers";

const ABI = ["function vote(uint256,bool)"];
const DAO_ADDRESS = process.env.REACT_APP_DAO_ADDRESS;

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
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const dao = new ethers.Contract(DAO_ADDRESS, ABI, signer);
      const tx = await dao.vote(proposalId, support);
      const receipt = await tx.wait();
      setTxHash(receipt.transactionHash);
      onVoted();
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }

  return (
    <div>
      <h3>Vote on Proposal #{proposalId}</h3>
      <label>
        <input
          type="radio"
          checked={support === true}
          onChange={() => setSupport(true)}
        />{" "}
        Yes
      </label>
      <label style={{ marginLeft: 12 }}>
        <input
          type="radio"
          checked={support === false}
          onChange={() => setSupport(false)}
        />{" "}
        No
      </label>
      <button onClick={castVote} disabled={loading}>
        {loading ? "Submitting…" : "Submit Vote"}
      </button>
      {txHash && <p>Tx Hash: {txHash}</p>}
      {error && <p style={{ color: "red" }}>{error}</p>}
    </div>
  );
}
```

---

### Exercise 3: Live Results Panel

Problem: Create `ResultsPanel` that subscribes to `Voted` events and updates tallies live.

**Starter Code (`ResultsPanel.js`)**

```js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getProposalCount() view returns (uint256)",
  "function proposals(uint256) view returns (uint256 id, string description, uint256 yes, uint256 no)",
  "event Voted(address indexed voter, uint256 proposalId, bool support)",
];

export default function ResultsPanel() {
  const [results, setResults] = useState([]);

  useEffect(() => {
    // TODO: connect provider & dao
    // TODO: load current results
    // TODO: dao.on("Voted", handler) to refresh one proposal
    // TODO: cleanup listener
  }, []);

  return (
    <div>
      <h3>Live Voting Results</h3>
      {results.map((r) => (
        <div key={r.id}>
          #{r.id}: 👍 {r.yes} 👎 {r.no}
        </div>
      ))}
    </div>
  );
}
```

To Do List

- [ ] Initialize provider & contract
- [ ] Fetch initial results (like in Exercise 1)
- [ ] Subscribe to `Voted` events and update state for that proposal
- [ ] Remove listener on unmount

**Full Solution**

```js
// ResultsPanel.js
import React, { useState, useEffect } from "react";
import { ethers } from "ethers";
const ABI = [
  "function getProposalCount() view returns (uint256)",
  "function proposals(uint256) view returns (uint256 id, string description, uint256 yes, uint256 no)",
  "event Voted(address indexed voter, uint256 proposalId, bool support)",
];
const DAO_ADDRESS = process.env.REACT_APP_DAO_ADDRESS;

export default function ResultsPanel() {
  const [results, setResults] = useState([]);

  useEffect(() => {
    let dao;
    async function init() {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      dao = new ethers.Contract(DAO_ADDRESS, ABI, provider);
      const count = (await dao.getProposalCount()).toNumber();
      const arr = [];
      for (let i = 0; i < count; i++) {
        const [id, , yes, no] = await dao.proposals(i);
        arr.push({ id: id.toNumber(), yes: yes.toNumber(), no: no.toNumber() });
      }
      setResults(arr);

      // subscribe
      dao.on("Voted", (_voter, pid, _support) => {
        setResults((prev) =>
          prev.map((r) =>
            r.id === pid.toNumber()
              ? {
                  ...r,
                  yes: _support ? r.yes + 1 : r.yes,
                  no: !_support ? r.no + 1 : r.no,
                }
              : r
          )
        );
      });
    }
    init();

    return () => {
      if (dao) dao.removeAllListeners("Voted");
    };
  }, []);

  return (
    <div>
      <h3>Live Voting Results</h3>
      {results.map((r) => (
        <div key={r.id}>
          <strong>#{r.id}</strong>: 👍 {r.yes} 👎 {r.no}
        </div>
      ))}
    </div>
  );
}
```

---

## ✅ Test Cases

Create `__tests__/ProposalList.test.js`:

```js
// __tests__/ProposalList.test.js
import React from "react";
import { render, screen, waitFor } from "@testing-library/react";
import ProposalList from "../ProposalList";
import { ethers } from "ethers";

jest.mock("ethers");

describe("ProposalList Component", () => {
  const fakeCount = 2;
  const fakeProposals = [
    [0, "Build Court", 3, 1],
    [1, "Plant Trees", 5, 0],
  ];
  beforeAll(() => {
    global.window.ethereum = {
      request: jest.fn().mockResolvedValue(["0xACC"]),
    };
    ethers.providers.Web3Provider = jest.fn().mockReturnValue({});
    ethers.Contract = jest.fn().mockReturnValue({
      getProposalCount: jest.fn().mockResolvedValue({
        toNumber: () => fakeCount,
      }),
      proposals: jest
        .fn()
        .mockResolvedValueOnce(fakeProposals[0])
        .mockResolvedValueOnce(fakeProposals[1]),
    });
  });

  it("lists all proposals", async () => {
    render(<ProposalList />);
    await waitFor(() => screen.getByText(/Build Court/));
    expect(screen.getByText("#0 – Build Court")).toBeInTheDocument();
    expect(screen.getByText("#1 – Plant Trees")).toBeInTheDocument();
    expect(screen.getByText("👍 3 👎 1")).toBeInTheDocument();
    expect(screen.getByText("👍 5 👎 0")).toBeInTheDocument();
  });
});
```

Create `__tests__/VoteForm.test.js`:

```js
// __tests__/VoteForm.test.js
import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import VoteForm from "../VoteForm";
import { ethers } from "ethers";

jest.mock("ethers");

describe("VoteForm Component", () => {
  const pid = 0;
  let mockVote;
  beforeAll(() => {
    global.window.ethereum = {
      request: jest.fn().mockResolvedValue(["0xACC"]),
    };
    ethers.providers.Web3Provider = jest.fn().mockReturnValue({});
    mockVote = jest.fn().mockResolvedValue({
      wait: () => Promise.resolve({ transactionHash: "0xHash" }),
    });
    ethers.Contract = jest.fn().mockReturnValue({ vote: mockVote });
  });

  it("submits a yes vote", async () => {
    const onVoted = jest.fn();
    render(<VoteForm proposalId={pid} onVoted={onVoted} />);
    fireEvent.click(screen.getByText("Submit Vote"));
    await waitFor(() => screen.getByText(/Tx Hash:/));
    expect(mockVote).toHaveBeenCalledWith(pid, true);
    expect(onVoted).toHaveBeenCalled();
  });
});
```

jest.config.js:

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

As the sun peeked over Marikina Heights, barangay members gathered around their phones. Proposal #0—“Build Court”—was passing with resounding on-chain support. Odessa watched live tallies climb and felt a surge of pride: code had become civic voice. Next up, they’ll add token-weighted voting, quorum checks, and timelocks—true Filipino DAO governance. Mabuhay Web3 civic-tech! 🇵🇭🏀🚀
