## 🧑‍💻 Background Story

![Write to the Blockchain](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+3.0+-+COVER.png)

Sunlight danced off Laguna’s rolling rice fields as Neri stepped into the barangay hall, laptop in hand. The cooperative needed a transparent way to decide its budget: no more paper ballots lost under stacks of receipts. She’d just deployed a `CooperativeVote` contract on the Sepolia testnet.

![Laguna Cooperative Meeting](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+3.1.png)

Half a world away in Brooklyn, Odessa sipped her iced coffee at a buzzing co-working space. On Zoom, Neri shared her screen with three proposals: “Bagong Palengke,” “Solar Streetlights,” “Barangay WiFi.” “Build the frontend,” Neri challenged. Odessa cracked her knuckles, booted up her editor, and scaffolded a React app.

![Odessa Coding the Frontend](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+3.2.png)

Soon her screen showed a dropdown, a “Vote” button and a status line. She switched MetaMask to Sepolia, clicked “Vote,” and MetaMask popped up with the gas fee: test ETH, worth nothing, but real enough to practice on. She clicked “Confirm,” the button read “Voting…”, and about twelve seconds later the status flipped to “confirmed.” Odessa pumped her fist.

From Laguna’s cooperative to Brooklyn’s co-working café, Web3 had bridged the gap. It was her first write call, her first gas fee, and her first taste of changing on-chain state.

Welcome to **Write to the Blockchain**: triggering state-changing transactions with Ethers.js v6, MetaMask and React. 🇵🇭✨

---

## 📚 Theory & Web3 Lecture

### 1. Understanding Read vs. Write Operations

In the last lesson you only **read**. This lesson **writes**, and a write works very differently.

#### **The Fundamental Difference**

| Aspect            | Read Operations              | Write Operations                         |
| ----------------- | ---------------------------- | ---------------------------------------- |
| **What it does**  | Fetches data from blockchain | Changes data on blockchain               |
| **Gas cost**      | Free                         | Costs ETH (gas fees)                     |
| **Speed**         | About as fast as a web request | Waits to be mined (about 12 s per block on Ethereum and Sepolia) |
| **User approval** | Not needed                   | MetaMask popup required                  |
| **Example**       | `contract.name()`            | `contract.vote("Bagong Palengke")`       |

#### **Why Write Operations Cost Money**

When you write to the blockchain, the network's nodes must:

1. Validate your transaction
2. Execute the smart contract code
3. Store the new state permanently
4. Agree (reach consensus) that this is the correct new state

Gas fees pay for that computation and storage, and they stop people from spamming the network with free work.

#### **Provider vs. Signer: The Key Distinction**

A **Provider** is a read-only connection. Think of a newspaper: you can read it, but you can't edit it.

```js
import { ethers } from "ethers";

// Anyone can create a provider—no wallet needed
const provider = new ethers.JsonRpcProvider(RPC_URL);
```

A **Signer** is an account that can sign transactions, so it can change things. In a browser, the signer is the user's MetaMask account. You reach it through a `BrowserProvider`:

```js
// Requires MetaMask (window.ethereum)
const browserProvider = new ethers.BrowserProvider(window.ethereum);

// In ethers v6, getSigner() is async — it returns a Promise
const signer = await browserProvider.getSigner();
```

Forgetting the `await` is the most common v6 slip. Without it, `signer` is a Promise, not a signer, and every write fails.

> Ethers **version 5** wrote this as `new ethers.providers.Web3Provider(window.ethereum)` with a synchronous `getSigner()`. That code throws on ethers v6. <!-- v5-ok -->

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
   "pending"          Tx signed         wait to be mined      "confirmed"
```

---

### 2. Contract Instances: Read vs. Write

An `ethers.Contract` is built from an address, an ABI, and a **runner**: the thing that carries out its calls. The runner decides what the contract can do.

#### **Creating a Read-Only Contract Instance**

Use this when you only need to fetch data (like vote counts):

```js
import { ethers } from "ethers";
import abi from "./abi/CooperativeVote.json";

const provider = new ethers.JsonRpcProvider(import.meta.env.VITE_RPC_URL);

const readContract = new ethers.Contract(
  import.meta.env.VITE_CONTRACT_ADDRESS, // Where the contract lives
  abi, // What functions exist
  provider // Read-only connection
);

// Inside an async function:
const count = await readContract.getVoteCount("Bagong Palengke"); // a bigint
```

#### **Creating a Write-Capable Contract Instance**

Use this when you need to change blockchain state (like casting a vote):

```js
// Step 1: Connect to the user's MetaMask
const browserProvider = new ethers.BrowserProvider(window.ethereum);

// Step 2: Get the signer (await — it is async in v6)
const signer = await browserProvider.getSigner();

// Step 3, Option A: build the contract with the signer as its runner
const writeContract = new ethers.Contract(
  import.meta.env.VITE_CONTRACT_ADDRESS,
  abi,
  signer // signer instead of provider!
);

// Step 3, Option B: reuse a read contract, attached to the signer
// (connect() is synchronous: no await needed)
const sameWriteContract = readContract.connect(signer);

// Now you can call state-changing functions
const tx = await writeContract.vote("Bagong Palengke"); // costs gas
```

#### **Why Two Different Instances?**

Think of it like a bank:

- **Read instance** = looking at the posted balance (anyone can look)
- **Write instance** = making a withdrawal (needs your signature)

```
┌─────────────────────────────────────────────────────────────┐
│                    Contract Instance                        │
├─────────────────────────────────────────────────────────────┤
│  Read-Only (Provider)         │  Write-Capable (Signer)     │
│  ─────────────────────        │  ────────────────────────   │
│  • Free to use                │  • Costs gas (ETH)          │
│  • No wallet needed           │  • Requires MetaMask        │
│  • Fast response              │  • Waits for confirmation   │
│  • contract.name()            │  • contract.vote()          │
│  • contract.getVoteCount()    │  • contract.transfer()      │
└─────────────────────────────────────────────────────────────┘
```

---

### 3. Sending a Transaction: Step-by-Step

#### **Step 1: Request Wallet Access**

Before you can send transactions, you need the user's permission. This is the same call you wrote in Lesson 1:

```js
// Opens the MetaMask "Connect to this site?" popup if needed
await window.ethereum.request({ method: "eth_requestAccounts" });
```

**What happens:**

- First time: MetaMask asks the user to choose an account and connect
- Already connected: it returns straight away with the connected account
- User rejects: it throws an error (handle it with `try/catch`)

#### **Step 2: Call the Write Function**

```js
const tx = await writeContract.vote(selectedProposal, {
  gasLimit: 100_000, // optional: the most gas this transaction may use
});

console.log("Transaction hash:", tx.hash);
// e.g. "0x1234abcd..." — the unique ID of this transaction
```

The last argument, `{ gasLimit: ... }`, is an optional **overrides** object. If you leave it out, ethers asks the node to estimate the gas for you, which is usually what you want (see section 4).

**What happens at this moment:**

1. MetaMask shows the gas fee and asks for confirmation
2. The user clicks "Confirm" (or "Reject")
3. MetaMask signs the transaction with the user's private key
4. The transaction is broadcast to the network
5. Your `await` resolves with a **transaction response**. The transaction has been sent, but it is not mined yet.

**The transaction response contains, among other fields:**

```js
{
  hash: "0x1234...",      // Unique transaction ID
  from: "0xYourAddress",  // Who sent it
  to: "0xContractAddr",   // The contract address
  gasLimit: 100000n,      // Max gas (a bigint in v6)
  nonce: 42,              // How many transactions this address sent before
  data: "0x...",          // The encoded function call
}
```

#### **Step 3: Wait for Confirmation**

The transaction is now "pending". It has been broadcast but not yet included in a block:

```js
// Wait for the transaction to be mined (included in a block)
const receipt = await tx.wait();

// Or wait for several blocks on top of it, for more certainty
const safeReceipt = await tx.wait(3);
```

**The receipt contains, among other fields:**

```js
{
  status: 1,              // 1 = success, 0 = reverted
  blockNumber: 6123456,   // Which block included this tx
  gasUsed: 45000n,        // Actual gas consumed (a bigint)
  hash: "0x..",           // The transaction hash
  logs: [...],            // Events emitted during execution
}
```

In ethers v6, `tx.wait()` **throws** a `CALL_EXCEPTION` error if the transaction reverted on-chain. So reaching the line after `await tx.wait()` means it succeeded.

#### **Step 4: Handle Success and Errors**

Ethers v6 gives each error a string `code`, and `ethers.isError(error, code)` checks it:

```js
try {
  const tx = await contract.vote(proposal);
  console.log("Pending:", tx.hash);

  const receipt = await tx.wait();
  console.log("Mined! Gas used:", receipt.gasUsed.toString());
} catch (error) {
  if (ethers.isError(error, "ACTION_REJECTED")) {
    // The user clicked "Reject" in MetaMask
    console.log("User cancelled");
  } else if (ethers.isError(error, "INSUFFICIENT_FUNDS")) {
    console.log("Not enough ETH for gas");
  } else if (ethers.isError(error, "CALL_EXCEPTION")) {
    // The contract reverted, e.g. "Already voted"
    console.log("Transaction would fail or failed:", error.reason);
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
     │ MetaMask Popup  │  ◄── User sees the gas fee
     │ "Confirm" button│
     └────────┬────────┘
              │ User confirms
              ▼
     ┌─────────────────┐
     │    PENDING      │  ◄── tx.hash available
     │  "Voting…"      │      Show progress to the user
     └────────┬────────┘
              │ mined in a block (about 12 s)
              ▼
     ┌─────────────────┐
     │   CONFIRMED     │  ◄── await tx.wait() resolved
     │  "confirmed"    │      Update the UI, celebrate!
     └─────────────────┘
```

#### **Refreshing the UI After a Vote**

Once a vote is mined, other parts of the page (like vote counts) should refresh. The simple way is a callback: the parent passes in a function (in this lesson, `onVoted`), and you call it after `await tx.wait()`. Contracts can also emit **events** that your app listens to live. That is the whole topic of the next lesson.

---

### 4. Gas Estimation: Don't Overpay

Gas is the fuel for your transaction. Set the limit too low and the transaction fails. A limit is a maximum, though: you only pay for the gas actually used.

#### **Automatic Estimation**

By default ethers estimates the gas for you. You can also ask for the estimate yourself. In v6 the estimate lives on the method:

```js
// Ask the node how much gas vote("Bagong Palengke") would use
const estimatedGas = await contract.vote.estimateGas("Bagong Palengke");
console.log("Estimated gas:", estimatedGas.toString()); // e.g. "45000"

// Add a 20% buffer for safety (bigint math: both sides need the n)
const gasLimit = (estimatedGas * 120n) / 100n;

const tx = await contract.vote("Bagong Palengke", { gasLimit });
```

#### **Why Estimation Can Fail**

If estimation throws, the transaction would almost certainly revert, so don't send it:

```js
try {
  await contract.vote.estimateGas("Bagong Palengke");
} catch (error) {
  // Common reasons: already voted, invalid proposal
  console.log("Would revert:", error.reason);
}
```

> Ethers **version 5** wrote this as `contract.estimateGas.vote(...)` and did math with `.mul()` and `.div()`. Neither works in v6. <!-- v5-ok -->

---

### 5. UX Best Practices for Write Operations

#### **1. Clear Status Indicators**

Users should always know what's happening:

```js
const [status, setStatus] = useState("");
// "" (idle) | "pending" | "confirmed" | "error: ..."

return (
  <div>
    <button onClick={castVote} disabled={status === "pending"}>
      {status === "pending" ? "Voting…" : "Vote"}
    </button>
    {status && <p>{status}</p>}
  </div>
);
```

#### **2. Disable Buttons During the Pending State**

A disabled button stops a second click from sending a second transaction:

```js
<button onClick={castVote} disabled={status === "pending" || hasVoted}>
  {hasVoted ? "Already Voted" : "Vote"}
</button>
```

#### **3. Show the Transaction Hash**

Let users check their transaction on a block explorer. For Sepolia, that is Sepolia Etherscan:

```js
{txHash && (
  <p>
    View on Etherscan:{" "}
    <a
      href={`https://sepolia.etherscan.io/tx/${txHash}`}
      target="_blank"
      rel="noopener noreferrer"
    >
      {txHash.slice(0, 10)}...
    </a>
  </p>
)}
```

#### **4. Turn Errors into Plain Words**

`error.message` from a wallet can be long and technical. Map the common codes from section 3 to messages a cooperative member understands, such as "You cancelled the vote" or "You need a little Sepolia ETH for gas."

---

### 6. Common Mistakes to Avoid

1. **Forgetting `await` on `getSigner()`**

   ```js
   // ❌ signer is a Promise — the contract cannot send with it
   const signer = browserProvider.getSigner();

   // ✅ v6: await it
   const signer = await browserProvider.getSigner();
   ```

2. **Not waiting for confirmation**

   ```js
   // ❌ The transaction is only sent, not mined
   const tx = await contract.vote("Bagong Palengke");
   updateUI(); // Too early! The vote is not confirmed yet

   // ✅ Wait for the transaction to be mined
   const tx = await contract.vote("Bagong Palengke");
   await tx.wait();
   updateUI(); // Now it's safe
   ```

3. **Building the write contract with a provider**

   A contract built with a `JsonRpcProvider` can only read. Calling `vote()` on it fails, because nobody is there to sign. Writes need the signer.

4. **Not handling user rejection**

   Wrap the whole flow in `try/catch`. "Reject" is a normal user choice, not a crash.

---

### 7. Testing Your Write Operations

In your own app on Sepolia, check these scenarios:

1. ✅ **MetaMask popup appears** when clicking Vote
2. ✅ **Pending state shows** ("Voting…")
3. ✅ **Confirmed state shows** after the transaction is mined
4. ✅ **Button disabled** while pending
5. ✅ **User rejection handled** gracefully
6. ✅ **Parent refreshes** after a successful vote

**How this is graded:** the platform mounts your component against a pretend MetaMask and a pretend `CooperativeVote` contract. It clicks **Vote**, then checks four things: that you requested accounts, built a `BrowserProvider` and awaited its signer, called `vote()` with the selected proposal, and awaited `tx.wait()`. It also checks that you then called `onVoted()` and showed a confirmation. No real ETH is spent. The activity page lists the exact wording it looks for.

---

### External References & Further Learning

- **Ethers v6 Signers**: https://docs.ethers.org/v6/api/providers/#Signer - The signer interface
- **Ethers v6 Providers**: https://docs.ethers.org/v6/api/providers/ - `BrowserProvider`, `JsonRpcProvider` and more
- **Ethers v6 Contracts**: https://docs.ethers.org/v6/api/contract/ - Calling methods, overrides and `estimateGas`
- **Ethers v6 Migration Notes**: https://docs.ethers.org/v6/migrating/ - What changed from v5
- **Sepolia Etherscan**: https://sepolia.etherscan.io - Look up testnet transactions

---

## 🌟 Closing Story

As Laguna’s cooperative members cheered at their first transparent vote, Odessa leaned back in her Brooklyn seat. She’d just powered a real on-chain vote from across the globe.

Next up: the contract talks back. Odessa will listen for events, so the screen updates the moment something happens on-chain. Her journey from MetaMask connect to write transactions is only heating up! 🚀🇵🇭🗳️
