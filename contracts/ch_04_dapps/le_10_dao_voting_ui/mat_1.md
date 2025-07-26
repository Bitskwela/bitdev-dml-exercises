## 🧑‍💻 Background Story

It was a humid afternoon in Barangay San Perfecto when Det stepped into the barangay hall-turned-coworking-space. The Barangay Council was debating whether to fund new basketball courts—a dream for every hoops-mad teenager in San Perfecto. Neri had already deployed the on-chain “BarangayDAO” smart contract on a Sepolia testnet, complete with proposals and token-weighted voting. Now, Det’s mission was to build the frontend.

With teammates sipping sikwate, she sketched a three-panel UI:

1. **Proposal List**: showing each proposal ID, description, and vote tallies.
2. **Vote Form**: let members pick “Yes” or “No” and cast their vote.
3. **Results Panel**: live update when new votes come in.

In under 30 minutes, Det fired up a React app, wired Ethers.js, and connected MetaMask. She fetched `getProposalCount()` and looped through `proposals(id)` to render a table. Next, she built the vote handler: request signer, call `vote(proposalId, support)`, await confirmation, then refresh tallies. Finally, she subscribed to `Voted` events so the Results panel would update in real time.

As the sun set over the riverbanks, barangay members logged in, voted on Court Proposal #0, and watched the on-chain tally climb. No paper ballots. No middlemen. Just code and civic spirit. That night, under filipiniana decor and basketball posters, Det toasted: “Mabuhay Web3 civic-tech, one barangay at a time!” 🇵🇭🏀🚀

---

## 📚 Theory & Web3 Lecture

1. DAO Smart Contract Overview

   - `struct Proposal { uint id; string description; uint yes; uint no; }`
   - State array `Proposal[] public proposals;`
   - Functions:  
     • `createProposal(string description)` — adds proposal & emits `ProposalCreated`  
     • `vote(uint proposalId, bool support)` — increments `yes` or `no` & emits `Voted`  
     • `getProposalCount() view returns (uint)`  
     • Public getter `proposals(uint) view returns (Proposal)`

2. Events for React Reactivity

   - `event ProposalCreated(uint id, string description)`
   - `event Voted(address voter, uint proposalId, bool support)`

3. Ethers.js Integration

   - Provider vs Signer  
     • Provider: `new ethers.providers.Web3Provider(window.ethereum)` (read-only)  
     • Signer: `provider.getSigner()` (write transactions)
   - Contract Instance:
     ```js
     const dao = new ethers.Contract(
       process.env.REACT_APP_DAO_ADDRESS,
       DAO_ABI,
       signerOrProvider
     );
     ```
   - Reading Proposals:
     ```js
     const count = await dao.getProposalCount();
     for (let i = 0; i < count; i++) {
       const { id, description, yes, no } = await dao.proposals(i);
       // parse BigNumbers: id.toNumber(), yes.toNumber(), no.toNumber()
     }
     ```
   - Casting a Vote:
     ```js
     const tx = await dao.vote(proposalId, support);
     await tx.wait();
     ```
   - Listening to Events:
     ```js
     dao.on("Voted", (voter, pid, support) => {
       console.log(`Voted: ${voter} → ${pid} (${support})`);
       // refresh UI
     });
     ```

4. React Hooks & State Flow

   - `useState` for proposals array, loading, error
   - `useEffect` to load proposals on mount and on vote
   - Cleanup event listeners on unmount

5. Best Practices & Security
   - Validate proposalId is within range
   - Wrap blockchain calls in `try/catch`
   - Use `.env` for `REACT_APP_RPC_URL` and `REACT_APP_DAO_ADDRESS`
   - Avoid UI freezing: show spinners during tx confirmation

🔗 Further Reading

- Ethers.js: https://docs.ethers.org
- Solidity Events: https://docs.soliditylang.org
- React Hooks: https://reactjs.org/docs/hooks-intro.html

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
