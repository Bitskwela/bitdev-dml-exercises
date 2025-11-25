# Triggering Smart Contract Functions Activity

## Initial Code

```solidity
// CooperativeVote.sol - Contract Baseline
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

```js
// CastVote.js - Starter Code
import { useState } from "react";
import { ethers } from "ethers";
import abi from "../abi/CooperativeVote.json";

export default function CastVote({ proposals, onVoted }) {
  const [selected, setSelected] = useState(proposals[0]);
  const [status, setStatus] = useState("");

  const castVote = async () => {
    // TODO: Implement write transaction
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

```bash
# .env Configuration
REACT_APP_RPC_URL=http://localhost:8545
REACT_APP_CONTRACT_ADDRESS=0xYourDeployedAddress
```

**Time Allotment: 15 minutes**

## Tasks for Learners

Topics Covered: Write transactions, Web3Provider, Signer, gas estimation, transaction confirmation, error handling

---

### Task 1: Check MetaMask and Request Account Access

Before sending any transaction, check if MetaMask is installed and request account access using `eth_requestAccounts`. Set the status to "pending" when starting the transaction.

```js
if (!window.ethereum) {
  alert("Please install MetaMask");
  return;
}

setStatus("pending");
await window.ethereum.request({ method: "eth_requestAccounts" });
```

---

### Task 2: Create Web3Provider, Signer, and Contract Instance

Create a `Web3Provider` using MetaMask's `window.ethereum`, get the signer for transaction signing, and instantiate the contract with the signer (not provider) to enable write operations.

```js
const web3Provider = new ethers.providers.Web3Provider(window.ethereum);
const signer = web3Provider.getSigner();
const contract = new ethers.Contract(
  process.env.REACT_APP_CONTRACT_ADDRESS,
  abi,
  signer
);
```

---

### Task 3: Execute the Vote Transaction and Handle Confirmation

Call the contract's `vote` function with the selected proposal and a gas limit. Wait for the transaction to be confirmed using `tx.wait()`, then update the status and trigger the `onVoted` callback. Wrap everything in a try-catch to handle errors gracefully.

```js
try {
  const tx = await contract.vote(selected, { gasLimit: 100_000 });
  console.log("Tx Hash:", tx.hash);
  await tx.wait();
  setStatus("confirmed ✅");
  onVoted();
} catch (err) {
  console.error(err);
  setStatus("error: " + (err.data?.message || err.message));
}
```

---

## Complete Solution

```js

```

---

## Breakdown of the Activity

**Variables Defined:**

- `selected`: A React state variable that stores the user's chosen proposal from the dropdown. This value is passed to the smart contract's `vote` function when the user submits their vote.

- `status`: A state variable that tracks the current state of the transaction. It can be empty (idle), "pending" (transaction in progress), "confirmed ✅" (success), or "error: ..." (failure). This is used to provide visual feedback and disable the button during pending transactions.

- `web3Provider`: A `Web3Provider` instance that wraps MetaMask's `window.ethereum` object. Unlike `JsonRpcProvider` which is read-only, `Web3Provider` can access the user's wallet for signing transactions.

- `signer`: The signer object obtained from the Web3Provider. This represents the user's wallet and is required for any state-changing operation on the blockchain. The signer holds the ability to sign transactions with the user's private key.

- `contract`: An Ethers.js contract instance connected to the signer (not just a provider). When connected to a signer, the contract can execute write operations that modify blockchain state and require gas.

**Key Functions:**

- `castVote`:
  An async function that handles the complete voting flow. It first validates MetaMask is installed, then requests account access (triggering a MetaMask popup if not already connected). It creates a Web3Provider and signer to enable transaction signing, then instantiates the contract with the signer. The function calls `contract.vote()` with the selected proposal and a gas limit, which triggers a MetaMask confirmation popup showing the estimated gas cost. After the user confirms, it waits for the transaction to be mined using `tx.wait()`, then updates the UI status and calls the `onVoted` callback to refresh vote counts. The try-catch block handles all error scenarios including user rejection (clicking "Reject" in MetaMask), insufficient funds, and contract reverts.

- `tx.wait()`:
  Pauses execution until the transaction is included in a block (mined). This typically takes 12-15 seconds on mainnet. The returned receipt contains information about the transaction including its success status, gas used, and emitted events.
