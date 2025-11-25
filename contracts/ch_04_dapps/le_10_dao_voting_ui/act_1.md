# DAO Voting UI Activity

## Initial Code

```js
// .env Configuration
// REACT_APP_RPC_URL=https://sepolia.infura.io/v3/YOUR_KEY
// REACT_APP_DAO_ADDRESS=0xYourDAOAddress

// DAOVoting.js - Starter Code
import { useState, useEffect } from "react";
import { ethers } from "ethers";

const ABI = [
  "function getProposalCount() view returns (uint256)",
  "function proposals(uint256) view returns (uint256 id, string description, uint256 yes, uint256 no)",
  "function hasVoted(uint256, address) view returns (bool)",
  "function vote(uint256, bool)",
  "event Voted(address indexed voter, uint256 indexed proposalId, bool support)",
];

export default function DAOVoting() {
  const [proposals, setProposals] = useState([]);
  const [userAddress, setUserAddress] = useState("");
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // TODO: Task 1 - Load proposals and check vote status
    // @note Connect to MetaMask and get user address
    // @note Create provider and contract instance
    // @note Loop through proposals using getProposalCount()
    // @note For each proposal, check if user hasVoted
    // @note Convert BigNumbers to regular numbers with .toNumber()
  }, []);

  // TODO: Task 3 - Add real-time vote updates with events
  // @note Create a second useEffect to subscribe to Voted events
  // @note Update local state when any user votes
  // @note Clean up listener on unmount

  const castVote = async (proposalId, support) => {
    // TODO: Task 2 - Cast vote on proposal
    // @note Get signer for write operation
    // @note Call contract.vote(proposalId, support)
    // @note Wait for transaction confirmation
    // @note Update local state to reflect new vote
  };

  return (
    <div>
      <h2> BarangayDAO Voting</h2>
      <p>
        Connected: {userAddress.slice(0, 6)}...{userAddress.slice(-4)}
      </p>
      {proposals.map((p) => (
        <div
          key={p.id}
          style={{ border: "1px solid #ccc", padding: 16, margin: 8 }}
        >
          <h3>
            #{p.id}: {p.description}
          </h3>
          <p>
            {p.yes} | {p.no}
          </p>
          {p.hasVoted ? (
            <span>You've voted</span>
          ) : (
            <div>
              <button onClick={() => castVote(p.id, true)}>Vote Yes</button>
              <button onClick={() => castVote(p.id, false)}>Vote No</button>
            </div>
          )}
        </div>
      ))}
    </div>
  );
}
```

**Time Allotment: 15 minutes**

## Tasks for Learners

Topics Covered: DAO governance, proposal enumeration, double-vote prevention, vote tallies, BigNumber conversion

---

### Task 1: Load Proposals and Check Vote Status

Implement the `useEffect` to fetch all proposals. For each proposal, also check if the current user has already voted using `hasVoted(proposalId, address)`.

```js
useEffect(() => {
  const loadProposals = async () => {
    try {
      const [account] = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      setUserAddress(account);

      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const contract = new ethers.Contract(
        process.env.REACT_APP_DAO_ADDRESS,
        ABI,
        provider
      );

      const count = await contract.getProposalCount();
      const items = [];

      for (let i = 0; i < count; i++) {
        const [id, description, yes, no] = await contract.proposals(i);
        const voted = await contract.hasVoted(i, account);

        items.push({
          id: id.toNumber(),
          description,
          yes: yes.toNumber(),
          no: no.toNumber(),
          hasVoted: voted,
        });
      }

      setProposals(items);
    } catch (err) {
      console.error("Error loading proposals:", err);
    } finally {
      setLoading(false);
    }
  };

  loadProposals();
}, []);
```

---

### Task 2: Implement the castVote Function

Create a function that calls the contract's `vote()` method with the proposal ID and support boolean, waits for confirmation, and updates the UI.

```js
const castVote = async (proposalId, support) => {
  try {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const contract = new ethers.Contract(
      process.env.REACT_APP_DAO_ADDRESS,
      ABI,
      signer
    );

    const tx = await contract.vote(proposalId, support);
    await tx.wait();

    // Update local state
    setProposals((prev) =>
      prev.map((p) =>
        p.id === proposalId
          ? {
              ...p,
              yes: support ? p.yes + 1 : p.yes,
              no: support ? p.no : p.no + 1,
              hasVoted: true,
            }
          : p
      )
    );
  } catch (err) {
    if (err.message.includes("Already voted")) {
      alert("You have already voted on this proposal");
    } else {
      console.error("Error casting vote:", err);
    }
  }
};
```

---

### Task 3: Add Real-Time Vote Updates with Events

Subscribe to the `Voted` event so the UI updates automatically when anyone votes, and clean up the listener on unmount.

```js
useEffect(() => {
  const provider = new ethers.providers.Web3Provider(window.ethereum);
  const contract = new ethers.Contract(
    process.env.REACT_APP_DAO_ADDRESS,
    ABI,
    provider
  );

  const handleVote = (voter, proposalId, support) => {
    setProposals((prev) =>
      prev.map((p) =>
        p.id === proposalId.toNumber()
          ? {
              ...p,
              yes: support ? p.yes + 1 : p.yes,
              no: support ? p.no : p.no + 1,
            }
          : p
      )
    );
  };

  contract.on("Voted", handleVote);

  return () => {
    contract.off("Voted", handleVote);
  };
}, []);
```

---

## Breakdown of the Activity

**Variables Defined:**

- `proposals`: An array of proposal objects containing `id`, `description`, `yes` (yes vote count), `no` (no vote count), and `hasVoted` (whether current user has voted). BigNumbers are converted to regular numbers for display.

- `userAddress`: The connected wallet address. Used to check voting status and display a truncated address in the UI.

- `hasVoted`: A per-proposal boolean indicating if the current user has already voted. Determined by calling `contract.hasVoted(proposalId, userAddress)`. Used to conditionally show vote buttons or "Already voted" badge.

**Key Functions:**

- `loadProposals`:
  Fetches all proposals from the DAO contract. First connects to MetaMask and stores the user's address. Then iterates through all proposals using `getProposalCount()` and `proposals(i)`. For each proposal, also checks if the user has voted using the `hasVoted` mapping. All BigNumbers are converted to regular numbers using `.toNumber()`.

- `castVote`:
  Submits a vote to the blockchain. Takes the proposal ID and a boolean indicating support (true for yes, false for no). Uses a signer for the write operation, calls `vote(proposalId, support)`, waits for confirmation, then optimistically updates local state to reflect the new vote count and mark the proposal as voted.

- `handleVote` (Event Listener):
  A real-time event handler that listens for `Voted` events from the contract. When any user votes, this updates the local state to reflect the new tallies without requiring a page refresh. This creates a live, collaborative voting experience.
