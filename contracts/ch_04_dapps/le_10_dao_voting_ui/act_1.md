# DAO Voting UI Activity

**What you will build:** a `DAOVoting` page for BarangayDAO that lists every proposal with its Yes/No tally, lets you vote once per proposal, hides the buttons on proposals you already voted on, and updates the tallies live when anyone votes.

This is the capstone of the read/write/events trio: reads from Lesson 02, writes from Lessons 03 and 08, events from Lesson 04, and the loop-by-index pattern from Lesson 09. Expect it to take a while; that is normal.

## Initial Code

This is the starter in your editor. The DAO contract address is already read from the environment as `DAO_ADDRESS`.

```js
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

const DAO_ADDRESS = process.env.REACT_APP_DAO_ADDRESS;

export default function DAOVoting() {
  const [proposals, setProposals] = useState([]);
  const [userAddress, setUserAddress] = useState("");
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // TODO: Task 1 - Connect, read getProposalCount(), then for each index read
    //                proposals(i) and hasVoted(i, account)
  }, []);

  useEffect(() => {
    // TODO: Task 3 - Subscribe to the "Voted" event and update the tally live.
    //                Return a cleanup that unsubscribes.
  }, []);

  const castVote = async (proposalId, support) => {
    // TODO: Task 2 - Send vote(proposalId, support), await the receipt, then
    //                update the tally and mark the proposal as voted
  };

  if (loading) return <p>Loading proposals...</p>;

  return (
    <div>
      <h2>BarangayDAO Voting</h2>
      {/* TODO: Task 4 - Render each proposal with its tally, and either the
          Yes/No buttons or a "you've voted" note */}
      <p>Placeholder</p>
    </div>
  );
}
```

**Time Allotment: 45 minutes**

## Tasks for Learners

Topics Covered: reading proposals by index, per-user state with `hasVoted`, signed writes with `await provider.getSigner()`, `tx.wait()`, subscribing to and cleaning up contract events, conditional rendering

---

### Task 1: Load the proposals and your vote status

Replace the body of the **first** `useEffect` (keep `}, []);`). Define an async `loadProposals` inside it and call it at the end:

```js
  useEffect(() => {
    const loadProposals = async () => {
      try {
        const [account] = await window.ethereum.request({
          method: "eth_requestAccounts",
        });
        setUserAddress(account);

        const provider = new ethers.BrowserProvider(window.ethereum);
        const contract = new ethers.Contract(DAO_ADDRESS, ABI, provider);

        const count = await contract.getProposalCount();
        const items = [];

        for (let i = 0; i < count; i++) {
          const [id, description, yes, no] = await contract.proposals(i);
          const voted = await contract.hasVoted(i, account);

          items.push({
            id: Number(id),
            description,
            yes: Number(yes),
            no: Number(no),
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

- Each proposal costs **two** reads: the proposal itself, and whether **this** wallet already voted on it.
- `proposals(i)` returns `[id, description, yes, no]`. Positional destructuring is used here; reading by name (`p.yes`) also works in v6 because the ABI names the outputs.
- The ids and counts come back as `bigint`; `Number(...)` turns them into plain numbers so `p.yes + 1` works later. (Mixing a `bigint` and a number in `+` throws a `TypeError`.)

---

### Task 2: Cast a vote

Fill in `castVote`. A vote is a write, so it needs a signer. After the receipt, update the tally and mark the proposal as voted:

```js
  const castVote = async (proposalId, support) => {
    try {
      const provider = new ethers.BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();
      const contract = new ethers.Contract(DAO_ADDRESS, ABI, signer);

      const tx = await contract.vote(proposalId, support);
      await tx.wait();

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
      console.error("Error casting vote:", err);
    }
  };
```

`support` is `true` for Yes and `false` for No. Setting `hasVoted: true` is what makes the buttons disappear (Task 4).

---

### Task 3: Update the tallies live from the `Voted` event

Replace the body of the **second** `useEffect`. Subscribe with `contract.on`, and **return** a cleanup that unsubscribes with `contract.off`:

```js
  useEffect(() => {
    const provider = new ethers.BrowserProvider(window.ethereum);
    const contract = new ethers.Contract(DAO_ADDRESS, ABI, provider);

    const handleVote = (voter, proposalId, support) => {
      setProposals((prev) =>
        prev.map((p) =>
          p.id === Number(proposalId)
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
    return () => contract.off("Voted", handleVote);
  }, []);
```

- The handler receives the event's arguments in order: `voter`, `proposalId`, `support`.
- `proposalId` arrives as a `bigint`, so compare with `Number(proposalId)`.
- Without the cleanup, every remount adds another listener, and each vote gets counted again and again.

---

### Task 4: Render the proposals

Replace the `<h2>`, the `{/* TODO: Task 4 ... */}` comment and `<p>Placeholder</p>`, that is, **everything inside the outer `<div>`**, with this:

```jsx
      <h2>🏛️ BarangayDAO Voting</h2>
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
            👍 Yes: {p.yes} | 👎 No: {p.no}
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
```

---

> **Graded details: labels and wording are checked.** The hidden test is strict about these, so copy them exactly:
>
> - On load: **`getProposalCount()`**, then **`proposals(i)` and `hasVoted(i, account)` once per proposal** (the test DAO has 2).
> - Both proposal descriptions must appear (`Ayusin ang basketball court`, `Bagong ilaw sa kalye`).
> - The Yes count must sit **right after the word "Yes"**, like **`Yes: 5`** (`Yes 5` or `Yes - 5` also work). A `5` somewhere else on the page does not count.
> - The buttons must be labelled **`Vote Yes`** and **`Vote No`**. The test clicks "Vote Yes" and counts every `<button>` whose label contains "vote": with one unvoted and one voted proposal there must be **exactly 2**. So "You've voted" must be plain text (a `<span>`), **not** a button, and don't add any other button with "vote" in its label.
> - Clicking **Vote Yes** must call **`vote(0, true)`**, then **`await tx.wait()`**.
> - You must subscribe with **`contract.on("Voted", ...)`** and, when the component unmounts, call **`contract.off("Voted", ...)`** from the cleanup you return.

### Common mistakes

- `p.yes + 1` when `p.yes` is still a `bigint`: `TypeError: Cannot mix BigInt and other types`. Convert with `Number()` in Task 1.
- Forgetting `return` in front of `() => contract.off(...)`: the cleanup never runs.
- Using `.toNumber()`: that is ethers v5; v6 values are plain `bigint`, so use `Number(x)`. <!-- v5-ok -->

---

## Breakdown of the Activity

**Variables Defined:**

- `proposals`: one object per proposal: `id`, `description`, `yes`, `no` (plain numbers) and `hasVoted` (whether **this** wallet voted on it).
- `userAddress`: the connected wallet, shown shortened at the top and used for the `hasVoted` checks.
- `loading`: `true` until the first load finishes.

**Key Functions:**

- `loadProposals`: connects MetaMask, reads `getProposalCount()`, then for each index reads `proposals(i)` and `hasVoted(i, account)`, converting `bigint` values with `Number()`.
- `castVote`: signs and sends `vote(proposalId, support)`, waits for the receipt, then bumps the tally and sets `hasVoted: true` so the buttons disappear.
- `handleVote` (event listener): runs whenever **anyone's** vote is mined and bumps that proposal's tally, so the page stays live without a refresh.

**Something to notice:** when **you** vote, your vote is counted by `castVote` *and* again when your own `Voted` event arrives, so on a real network your tally would jump by 2. The grader does not fire events, so this does not affect your grade, but the lesson material shows a simple way to avoid the double count.
