## 🧑‍💻 Background Story

Sunlight danced off Laguna’s rolling rice fields as Neri stepped into the barangay hall, laptop in hand. The cooperative needed a transparent way to decide budget allocations—no more paper ballots lost under stacks of receipts. She’d just deployed `CooperativeVote` on a local Hardhat node.

Half a world away in Brooklyn, Odessa sipped her iced coffee at a buzzing co-working space. On Zoom, she watched Neri share her terminal: three proposals—“Infrastructure,” “Education,” “Health.” “Build the frontend,” Neri challenged. Odessa cracked her knuckles, booted up her IDE, and scaffolded a React app.

Moments later, her screen showed a dropdown menu, a “Vote” button, and live vote tallies. She connected MetaMask to Hardhat’s RPC, clicked “Vote,” and got the MetaMask gas-fee simulation popup. “Confirm,” she clicked—₿🌱 simulated gas burned—and the spinner spun. In seconds, the Hardhat console logged the transaction hash, the vote count updated, and Odessa pumped her fist.

From Laguna’s cooperative to Brooklyn’s co-working café, Web3 had bridged the gap. This was her first write call, her first gas-fee simulation, and her first taste of on-chain transformation. But tonight, she’d celebrate that spinner turning into success.

Welcome to **Write to the Blockchain**: triggering state-changing transactions with Ethers.js, MetaMask, and React. 🇵🇭✨

---

## 📚 Theory & Web3 Lecture

### 1. Read vs. Write in Ethers.js

- **Provider** (read-only):

  ```js
  const provider = new ethers.providers.JsonRpcProvider(RPC_URL);
  ```

  Use for `view`/`pure` calls—no gas, no signer.

- **Signer** (write-capable):
  ```js
  const web3Provider = new ethers.providers.Web3Provider(window.ethereum);
  const signer = web3Provider.getSigner();
  ```
  Use for state-changing functions—requires gas & user approval.

### 2. Contract Instances

```js
import { ethers } from "ethers";
import abi from "./abi/CooperativeVote.json";

// Read-only instance
const provider = new ethers.providers.JsonRpcProvider(
  process.env.REACT_APP_RPC_URL
);
const readContract = new ethers.Contract(
  process.env.REACT_APP_CONTRACT_ADDRESS,
  abi,
  provider
);

// Write instance (MetaMask)
const web3Provider = new ethers.providers.Web3Provider(window.ethereum);
const signer = web3Provider.getSigner();
const writeContract = readContract.connect(signer);
```

### 3. Sending a Transaction

1. **Request account**:
   ```js
   await window.ethereum.request({ method: "eth_requestAccounts" });
   ```
2. **Call write function**:
   ```js
   const tx = await writeContract.vote(selectedProposal, {
     gasLimit: 100_000, // or estimate
   });
   console.log("Tx hash:", tx.hash);
   ```
3. **Await confirmation**:
   ```js
   const receipt = await tx.wait(); // waits for 1 block
   if (receipt.status === 1) {
     // success!
   }
   ```
4. **Error handling**: wrap in `try/catch` and display user-friendly messages.

### 4. Event Subscriptions

Listen to on-chain events for real-time UI updates:

```js
readContract.on("Voted", (voter, proposal) => {
  console.log(`${voter} voted for ${proposal}`);
  // e.g. re-fetch counts
});
```

### 5. UX & Gas Best Practices

- **Estimate gas** with `contract.estimateGas.vote(...)`.
- Show pending “Voting…⏳” and confirmed “Success!✅” states.
- Disable the “Vote” button during pending or after voted.
- Clean up event listeners in `useEffect` cleanup.
- Never commit your `.env`; use `create-react-app` conventions.

External Docs

- Ethers.js Providers & Signers: https://docs.ethers.org/v5/api/providers/
- React Hooks: https://reactjs.org/docs/hooks-intro.html

---

## 🧪 Exercises

### Solidity Baseline (`contracts/CooperativeVote.sol`)

```sol
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

    function vote(string calldata proposal) external {
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
    }

    function getVoteCount(string calldata proposal) external view returns (uint256) {
        return votes[proposal];
    }
}
```

.env Sample

```
REACT_APP_RPC_URL=http://localhost:8545
REACT_APP_CONTRACT_ADDRESS=0xYourDeployedAddress
```

---

### Exercise 1: Display Vote Counts

Problem Statement  
On component mount, fetch `getVoteCount` for each proposal and render a list.

Starter Code (`VoteCounts.js`):

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/CooperativeVote.json";

export default function VoteCounts({ proposals }) {
  const [counts, setCounts] = useState({});

  useEffect(() => {
    // TODO: implement loadCounts()
  }, [proposals]);

  return (
    <ul>
      {proposals.map((p) => (
        <li key={p}>
          {p}: {counts[p] ?? "..."}
        </li>
      ))}
    </ul>
  );
}
```

To Do List

- Instantiate `JsonRpcProvider` with `REACT_APP_RPC_URL`.
- Create `Contract` instance with ABI & provider.
- Loop through `proposals`: call `contract.getVoteCount(p)`.
- Convert BigNumber → number, update `counts` state.

Full Solution

```js
useEffect(() => {
  const provider = new ethers.providers.JsonRpcProvider(
    process.env.REACT_APP_RPC_URL
  );
  const contract = new ethers.Contract(
    process.env.REACT_APP_CONTRACT_ADDRESS,
    abi,
    provider
  );
  async function loadCounts() {
    const result = {};
    for (const p of proposals) {
      const bn = await contract.getVoteCount(p);
      result[p] = bn.toNumber();
    }
    setCounts(result);
  }
  loadCounts();
}, [proposals]);
```

Solidity Signature

```sol
function getVoteCount(string calldata) external view returns (uint256);
```

---

### Exercise 2: Cast a Vote Transaction

Problem Statement  
Let users pick a proposal, send `vote()` transaction, show pending/confirmed states, then refresh counts via `onVoted()` callback.

Starter Code (`CastVote.js`):

```js
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/CooperativeVote.json";

export default function CastVote({ proposals, onVoted }) {
  const [selected, setSelected] = useState(proposals[0]);
  const [status, setStatus] = useState("");

  const castVote = async () => {
    // TODO: implement write transaction
  };

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
}
```

To Do List

- Check `window.ethereum`; alert if missing.
- Request accounts: `eth_requestAccounts`.
- Create `Web3Provider` & `signer`; connect to contract.
- Call `contract.vote(selected, { gasLimit: 100_000 })`.
- `await tx.wait()`, then set “confirmed” & call `onVoted()`.
- Catch errors → `setStatus('error: …')`.

Full Solution

```js
const castVote = async () => {
  if (!window.ethereum) {
    alert("Please install MetaMask");
    return;
  }
  try {
    setStatus("pending");
    await window.ethereum.request({ method: "eth_requestAccounts" });
    const web3Provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = web3Provider.getSigner();
    const contract = new ethers.Contract(
      process.env.REACT_APP_CONTRACT_ADDRESS,
      abi,
      signer
    );
    const tx = await contract.vote(selected, { gasLimit: 100_000 });
    console.log("Tx Hash:", tx.hash);
    await tx.wait();
    setStatus("confirmed ✅");
    onVoted();
  } catch (err) {
    console.error(err);
    setStatus("error: " + (err.data?.message || err.message));
  }
};
```

Solidity Signature

```sol
function vote(string calldata) external;
```

---

### Exercise 3: Auto-Refresh on Voted Events

Problem Statement  
Subscribe to the `Voted` event so `VoteCounts` reloads automatically when anyone votes.

Starter Code (`VoteApp.js`):

```js
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import abi from "../abi/CooperativeVote.json";
import VoteCounts from "./VoteCounts";
import CastVote from "./CastVote";

export default function VoteApp({ proposals }) {
  const [refreshKey, setRefreshKey] = useState(0);
  const refresh = () => setRefreshKey((k) => k + 1);

  useEffect(() => {
    // TODO: subscribe to Voted events
  }, []);

  return (
    <div>
      <VoteCounts key={refreshKey} proposals={proposals} />
      <CastVote proposals={proposals} onVoted={refresh} />
    </div>
  );
}
```

To Do List

- Instantiate `JsonRpcProvider` & `Contract`.
- In `useEffect`, add `contract.on('Voted', handler)` where `handler` calls `refresh()`.
- Clean up with `contract.off('Voted', handler)` in return.

Full Solution

```js
useEffect(() => {
  const provider = new ethers.providers.JsonRpcProvider(
    process.env.REACT_APP_RPC_URL
  );
  const contract = new ethers.Contract(
    process.env.REACT_APP_CONTRACT_ADDRESS,
    abi,
    provider
  );
  const handler = (voter, proposal) => {
    console.log(`Event: ${voter} voted ${proposal}`);
    refresh();
  };
  contract.on("Voted", handler);
  return () => {
    contract.off("Voted", handler);
  };
}, []);
```

Solidity Event

```sol
event Voted(address indexed voter, string proposal);
```

---

## ✅ Test Cases

```js
// __tests__/VoteCounts.test.js
import React from "react";
import { render, screen, waitFor } from "@testing-library/react";
import VoteCounts from "../components/VoteCounts";
import { ethers } from "ethers";

jest.mock("ethers", () => {
  const original = jest.requireActual("ethers");
  const fake = {
    getVoteCount: jest.fn((p) =>
      Promise.resolve(
        original.BigNumber.from(p.length) // dummy count
      )
    ),
  };
  return {
    ...original,
    providers: { JsonRpcProvider: jest.fn() },
    Contract: jest.fn(() => fake),
  };
});

test("loads and displays vote counts", async () => {
  const proposals = ["Infra", "Ed"];
  render(<VoteCounts proposals={proposals} />);
  for (const p of proposals) {
    await waitFor(() => {
      expect(screen.getByText(new RegExp(`${p}:`))).toHaveTextContent(
        `${p}: ${p.length}`
      );
    });
  }
});
```

```js
// __tests__/CastVote.test.js
import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import CastVote from "../components/CastVote";
import { ethers } from "ethers";

jest.mock("ethers", () => {
  const original = jest.requireActual("ethers");
  const fakeContract = {
    vote: jest.fn().mockResolvedValue({
      hash: "0xABC",
      wait: () => Promise.resolve({ status: 1 }),
    }),
  };
  return {
    ...original,
    providers: {
      Web3Provider: jest.fn(() => ({ getSigner: () => ({}) })),
    },
    Contract: jest.fn(() => fakeContract),
  };
});

test("casts vote and calls onVoted", async () => {
  const proposals = ["A", "B"];
  const onVoted = jest.fn();
  window.ethereum = { request: jest.fn().mockResolvedValue(["0x1"]) };

  render(<CastVote proposals={proposals} onVoted={onVoted} />);
  fireEvent.change(screen.getByRole("combobox"), { target: { value: "B" } });
  fireEvent.click(screen.getByText("Vote"));

  expect(screen.getByText(/Voting…/i)).toBeInTheDocument();
  await waitFor(() => expect(onVoted).toHaveBeenCalled());
  expect(screen.getByText(/confirmed/i)).toBeInTheDocument();

  const calledArg = ethers.Contract.mock.results[0].value.vote.mock.calls[0][0];
  expect(calledArg).toBe("B");
});
```

---

## 🌟 Closing Story

As Laguna’s cooperative members cheered at their live-updating dashboard, Odessa leaned back in her Brooklyn seat. She’d just powered a real on-chain vote from across the globe.

Next up: mastering gas estimation (`estimateGas`), meta-transactions, and advanced UX flows for pending receipts. Odessa’s journey from MetaMask connect to write transactions is only heating up—Web3 elite status awaits! 🚀🇵🇭🗳️
