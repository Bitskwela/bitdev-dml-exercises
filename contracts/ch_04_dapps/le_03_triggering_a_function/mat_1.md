## 🧑‍💻 Background Story

![Write to the Blockchain](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+3.0+-+COVER.png)

Sunlight danced off Laguna’s rolling rice fields as Neri stepped into the barangay hall, laptop in hand. The cooperative needed a transparent way to decide budget allocations—no more paper ballots lost under stacks of receipts. She’d just deployed `CooperativeVote` on a local Hardhat node.

![Laguna Cooperative Meeting](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+3.1.png)

Half a world away in Brooklyn, Odessa sipped her iced coffee at a buzzing co-working space. On Zoom, she watched Neri share her terminal: three proposals—“Infrastructure,” “Education,” “Health.” “Build the frontend,” Neri challenged. Odessa cracked her knuckles, booted up her IDE, and scaffolded a React app.

![Odessa Coding the Frontend](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+3.2.png)

Moments later, her screen showed a dropdown menu, a “Vote” button, and live vote tallies. She connected MetaMask to Hardhat’s RPC, clicked “Vote,” and got the MetaMask gas-fee simulation popup. “Confirm,” she clicked—₿🌱 simulated gas burned—and the spinner spun. In seconds, the Hardhat console logged the transaction hash, the vote count updated, and Odessa pumped her fist.

From Laguna’s cooperative to Brooklyn’s co-working café, Web3 had bridged the gap. This was her first write call, her first gas-fee simulation, and her first taste of on-chain transformation. But tonight, she’d celebrate that spinner turning into success.

Welcome to **Write to the Blockchain**: triggering state-changing transactions with Ethers.js, MetaMask, and React. 🇵🇭✨

---

## 📚 Theory & Web3 Lecture

### 1. Understanding Read vs. Write Operations

This is one of the most important concepts in blockchain development. Let's break it down completely.

#### **The Fundamental Difference**

| Aspect            | Read Operations              | Write Operations                 |
| ----------------- | ---------------------------- | -------------------------------- |
| **What it does**  | Fetches data from blockchain | Changes data on blockchain       |
| **Gas cost**      | Free (no cost)               | Costs ETH (gas fees)             |
| **Speed**         | Instant                      | Takes 12-15 seconds (block time) |
| **User approval** | Not needed                   | MetaMask popup required          |
| **Example**       | `contract.name()`            | `contract.vote("Health")`        |

#### **Why Write Operations Cost Money**

When you write to the blockchain, thousands of computers (nodes) around the world must:

1. Validate your transaction
2. Execute the smart contract code
3. Store the new state permanently
4. Reach consensus that this is the correct state

Gas fees compensate these nodes for their computational work and storage.

#### **Provider vs. Signer: The Key Distinction**

**Provider** = Read-only connection (like a newspaper—you can read it but can't edit it)

```js
// Anyone can create a provider—no wallet needed
const provider = new ethers.JsonRpcProvider(RPC_URL);

// Use for view/pure functions
const name = await contract.name(); // Free, instant
```

**Signer** = Write-capable connection (like having editing rights—you can make changes)

```js
// Requires MetaMask or another wallet
const web3Provider = new ethers.BrowserProvider(window.ethereum);
const signer = await web3Provider.getSigner();

// Use for state-changing functions
const tx = await contract.vote("Health"); // Costs gas, needs approval
```

#### **Visual Flow: What Happens During a Write Transaction**

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐     ┌────────────┐
│   Your App  │────▶│   MetaMask   │────▶│   Network   │────▶│ Blockchain │
│  calls vote │     │ shows popup  │     │  broadcasts │     │  executes  │
└─────────────┘     └──────────────┘     └─────────────┘     └────────────┘
       │                   │                    │                   │
       │            User clicks           Transaction          New state
       │             "Confirm"            propagates            saved!
       │                   │                    │                   │
       ▼                   ▼                    ▼                   ▼
   "pending"          Gas paid           12-15 sec wait      "confirmed"
```

---

### 2. Contract Instances: Read vs. Write

A contract instance is a JavaScript object that represents your smart contract. You need different types depending on what you want to do.

#### **Creating a Read-Only Contract Instance**

Use this when you only need to fetch data (like getting vote counts):

```js
import { ethers } from "ethers";
import abi from "./abi/CooperativeVote.json";

// Step 1: Create provider (connection to blockchain)
const provider = new ethers.JsonRpcProvider(
  process.env.REACT_APP_RPC_URL
);

// Step 2: Create read-only contract instance
const readContract = new ethers.Contract(
  process.env.REACT_APP_CONTRACT_ADDRESS, // Where the contract lives
  abi, // What functions exist
  provider // Read-only connection
);

// Now you can call view functions
const count = await readContract.getVoteCount("Health"); // Free!
```

#### **Creating a Write-Capable Contract Instance**

Use this when you need to change blockchain state (like casting a vote):

```js
// Step 1: Connect to user's MetaMask wallet
const web3Provider = new ethers.BrowserProvider(window.ethereum);

// Step 2: Get the signer (the user's wallet that will sign transactions)
// Note: in ethers v6, getSigner() is async — remember to await it
const signer = await web3Provider.getSigner();

// Step 3: Create write-capable contract instance
// Option A: Create new instance with signer
const writeContract = new ethers.Contract(
  process.env.REACT_APP_CONTRACT_ADDRESS,
  abi,
  signer // Note: signer instead of provider!
);

// Option B: Convert existing read contract to write contract
const writeContract = readContract.connect(signer);

// Now you can call state-changing functions
const tx = await writeContract.vote("Health"); // Costs gas!
```

#### **Why Two Different Instances?**

Think of it like a bank:

- **Read instance** = Looking at your balance on a screen (anyone can look)
- **Write instance** = Making a withdrawal (needs your signature/PIN)

```
┌─────────────────────────────────────────────────────────────┐
│                    Contract Instance                        │
├─────────────────────────────────────────────────────────────┤
│  Read-Only (Provider)         │  Write-Capable (Signer)     │
│  ─────────────────────        │  ────────────────────────   │
│  • Free to use                │  • Costs gas (ETH)          │
│  • No wallet needed           │  • Requires MetaMask        │
│  • Instant response           │  • Waits for confirmation   │
│  • contract.name()            │  • contract.vote()          │
│  • contract.getVoteCount()    │  • contract.transfer()      │
└─────────────────────────────────────────────────────────────┘
```

---

### 3. Sending a Transaction: Step-by-Step

Sending a write transaction involves multiple steps. Let's understand each one.

#### **Step 1: Request Wallet Access**

Before you can send transactions, you need the user's permission:

```js
// This triggers the MetaMask popup asking "Connect to this site?"
await window.ethereum.request({ method: "eth_requestAccounts" });
```

**What happens:**

- First time: MetaMask shows account selection popup
- Already connected: Returns immediately with the connected account
- User rejects: Throws an error (handle with try/catch)

#### **Step 2: Call the Write Function**

```js
const tx = await writeContract.vote(selectedProposal, {
  gasLimit: 100_000, // Maximum gas willing to spend
});

console.log("Transaction hash:", tx.hash);
// Example: "0x1234abcd..." - unique ID for this transaction
```

**What happens at this moment:**

1. MetaMask popup shows gas estimate and asks for confirmation
2. User clicks "Confirm" (or "Reject")
3. Transaction is signed with user's private key
4. Transaction is broadcast to the network
5. Function returns a "pending" transaction object

**The transaction object contains:**

```js
{
  hash: "0x1234...",      // Unique transaction ID
  from: "0xYourAddress",  // Who sent it
  to: "0xContractAddr",   // The contract address
  gasLimit: bigint,       // Max gas
  gasPrice: bigint,       // Price per gas unit
  nonce: 42,              // Transaction count from this address
  data: "0x...",          // Encoded function call
}
```

#### **Step 3: Wait for Confirmation**

The transaction is now "pending"—it's been broadcast but not yet included in a block:

```js
// Wait for the transaction to be mined (included in a block)
const receipt = await tx.wait(); // Waits ~12-15 seconds on mainnet

// Or wait for multiple confirmations (more secure)
const receipt = await tx.wait(3); // Wait for 3 block confirmations
```

**The receipt object contains:**

```js
{
  status: 1,              // 1 = success, 0 = failed
  blockNumber: 12345678,  // Which block included this tx
  gasUsed: bigint,        // Actual gas consumed
  transactionHash: "0x..",
  logs: [...],            // Events emitted during execution
}
```

#### **Step 4: Handle Success and Errors**

```js
try {
  const tx = await contract.vote(proposal);
  console.log("Pending:", tx.hash);

  const receipt = await tx.wait();

  if (receipt.status === 1) {
    console.log("Success! Gas used:", receipt.gasUsed.toString());
  } else {
    console.log("Transaction failed");
  }
} catch (error) {
  // Handle different error types
  if (error.code === 4001) {
    // User rejected the transaction in MetaMask
    console.log("User cancelled");
  } else if (error.code === "INSUFFICIENT_FUNDS") {
    console.log("Not enough ETH for gas");
  } else if (error.code === "UNPREDICTABLE_GAS_LIMIT") {
    // Contract will revert - check your inputs!
    console.log("Transaction would fail:", error.reason);
  } else {
    console.log("Error:", error.message);
  }
}
```

#### **Transaction Lifecycle Visualization**

```
        User clicks "Vote"
              │
              ▼
     ┌─────────────────┐
     │ MetaMask Popup  │  ◄── User sees gas estimate
     │ "Confirm" button│
     └────────┬────────┘
              │ User confirms
              ▼
     ┌─────────────────┐
     │    PENDING      │  ◄── tx.hash available
     │ "Voting...⏳"   │      Show spinner to user
     └────────┬────────┘
              │ ~12-15 seconds
              ▼
     ┌─────────────────┐
     │   CONFIRMED     │  ◄── receipt.status === 1
     │ "Success! ✅"   │      Update UI, celebrate!
     └─────────────────┘
```

### 4. Event Subscriptions for Real-Time Updates

After a vote is cast, how do you update the UI? You could refresh the page, but that's poor UX. Instead, listen to events!

#### **What Are Smart Contract Events?**

Events are logs that smart contracts emit during execution. They're like announcements: "Hey, something happened!"

```solidity
// In Solidity
event Voted(address indexed voter, string proposal);

function vote(string calldata proposal) external {
    // ... voting logic ...
    emit Voted(msg.sender, proposal);  // Announce the vote!
}
```

#### **Listening to Events in JavaScript**

```js
// Subscribe to the "Voted" event
contract.on("Voted", (voter, proposal) => {
  console.log(`${voter} voted for ${proposal}`);

  // Update your React state to refresh the UI
  refreshVoteCounts();
});

// Don't forget to clean up when component unmounts!
contract.off("Voted", handler);
```

#### **Complete React Pattern**

```js
useEffect(() => {
  const provider = new ethers.JsonRpcProvider(RPC_URL);
  const contract = new ethers.Contract(ADDRESS, abi, provider);

  const handleVote = (voter, proposal) => {
    console.log(`New vote: ${voter} → ${proposal}`);
    setRefreshTrigger((prev) => prev + 1); // Trigger re-render
  };

  contract.on("Voted", handleVote);

  // Cleanup: remove listener when component unmounts
  return () => {
    contract.off("Voted", handleVote);
  };
}, []);
```

---

### 5. Gas Estimation: Don't Overpay!

Gas is the "fuel" for your transaction. Too little = transaction fails. Too much = you overpay.

#### **Automatic Estimation**

```js
// Let Ethers.js estimate the gas needed (v6: estimateGas lives on the method)
const estimatedGas = await contract.vote.estimateGas("Health");
console.log("Estimated gas:", estimatedGas.toString()); // e.g., "45000"

// estimatedGas is a bigint in v6, so add a 20% buffer with native bigint math
const gasLimit = (estimatedGas * 120n) / 100n;

const tx = await contract.vote("Health", { gasLimit });
```

#### **Why Estimation Can Fail**

If `estimateGas` throws an error, it usually means the transaction would revert:

```js
try {
  await contract.vote.estimateGas("Health");
} catch (error) {
  // Transaction would fail! Common reasons:
  // - Already voted
  // - Invalid proposal
  // - Not enough tokens
  console.log("Would revert:", error.reason);
}
```

---

### 6. UX Best Practices for Write Operations

#### **1. Clear Status Indicators**

Users should always know what's happening:

```js
const [status, setStatus] = useState("idle");
// States: 'idle' | 'pending' | 'confirmed' | 'error'

return (
  <div>
    <button onClick={castVote} disabled={status === "pending"}>
      {status === "pending" ? "Voting... ⏳" : "Vote 🗳️"}
    </button>

    {status === "confirmed" && <p>✅ Vote recorded!</p>}
    {status === "error" && <p>❌ Something went wrong</p>}
  </div>
);
```

#### **2. Disable Buttons During Pending State**

Prevent double-clicks and confusion:

```js
<button onClick={castVote} disabled={status === "pending" || hasVoted}>
  {hasVoted ? "Already Voted" : "Vote"}
</button>
```

#### **3. Show Transaction Hash**

Let users verify their transaction on Etherscan:

```js
{
  txHash && (
    <p>
      View on Etherscan:
      <a
        href={`https://sepolia.etherscan.io/tx/${txHash}`}
        target="_blank"
        rel="noopener noreferrer"
      >
        {txHash.slice(0, 10)}...
      </a>
    </p>
  );
}
```

#### **4. Handle All Error Cases**

```js
catch (error) {
  if (error.code === 4001) {
    setStatus('cancelled');  // User rejected
  } else if (error.code === 'INSUFFICIENT_FUNDS') {
    setStatus('no_funds');   // Not enough ETH
  } else if (error.reason) {
    setStatus('reverted');   // Contract rejected
    setErrorMessage(error.reason);
  } else {
    setStatus('error');
  }
}
```

---

### 7. Common Mistakes to Avoid

1. **Forgetting to request accounts first**

   ```js
   // ❌ This will fail - no account connected
   const signer = await provider.getSigner();

   // ✅ Always request accounts first
   await window.ethereum.request({ method: "eth_requestAccounts" });
   const signer = await provider.getSigner();
   ```

2. **Not waiting for confirmation**

   ```js
   // ❌ Returns immediately while tx is still pending
   const tx = await contract.vote("Health");
   updateUI(); // Too early! Vote not confirmed yet

   // ✅ Wait for the transaction to be mined
   const tx = await contract.vote("Health");
   await tx.wait();
   updateUI(); // Now it's safe!
   ```

3. **Not handling user rejection**

   ```js
   // ❌ Crashes if user clicks "Reject"
   const tx = await contract.vote("Health");

   // ✅ Always wrap in try/catch
   try {
     const tx = await contract.vote("Health");
   } catch (e) {
     if (e.code === 4001) {
       console.log("User cancelled");
     }
   }
   ```

---

### 8. Testing Your Write Operations

Before deploying, verify these scenarios:

1. ✅ **MetaMask popup appears** when clicking Vote
2. ✅ **Pending state shows** ("Voting...⏳")
3. ✅ **Success state shows** after confirmation ("✅ Done")
4. ✅ **Button disabled** during pending state
5. ✅ **User rejection handled** gracefully
6. ✅ **Vote counts update** after successful vote

---

### External References & Further Learning

- **Ethers.js Signers**: https://docs.ethers.org/v6/api/providers/#Signer - Complete signer documentation
- **Ethers.js Providers**: https://docs.ethers.org/v6/api/providers/ - Provider types explained
- **Gas Estimation**: https://docs.ethers.org/v6/api/contract/#BaseContractMethod-estimateGas - Estimate gas usage
- **React Hooks**: https://reactjs.org/docs/hooks-intro.html - Managing state in React
- **Etherscan**: https://etherscan.io - Verify transactions on-chain

---

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
- Create `BrowserProvider` & `signer` (await `getSigner()`); connect to contract.
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
    const web3Provider = new ethers.BrowserProvider(window.ethereum);
    const signer = await web3Provider.getSigner();
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
  const provider = new ethers.JsonRpcProvider(
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
        BigInt(p.length) // dummy count — ethers v6 returns uint256 as a native bigint
      )
    ),
  };
  return {
    ...original,
    JsonRpcProvider: jest.fn(),
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
    BrowserProvider: jest.fn(() => ({ getSigner: async () => ({}) })),
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
