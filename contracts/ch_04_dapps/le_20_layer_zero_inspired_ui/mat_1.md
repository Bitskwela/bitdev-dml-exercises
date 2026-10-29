## 🧑‍💻 Background Story

![LayerZero Bridge Simulator UI](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+20.0+-+COVER.png)

At a bustling cross-chain hackathon in New York City, Odessa ("Det") teamed up with Neri to demo a **bridge**. A real bridge would need two chains and a messaging network between them, and they had one afternoon and one testnet. No problem. They deployed a single **BridgeSimulator** contract on **Sepolia** and built a React UI that *feels* like moving money between two chains, "PHChain" and "NYChain".

![LayerZero Bridge Simulator UI](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+20.1.png)

Front and center: an **Amount** input and a big **Bridge** button. Click it, and a confirmation box asks: "Lock 1.5 ETH on PHChain?" Click **Yes, lock** → MetaMask pops up → the transaction is sent → "Locking on chain…" → "Locked! Lock ID #42." Then the UI flips to NYChain and offers to release lock #42 there.

Under the hood, both "chains" are the same contract on Sepolia. The UI simulates the second chain, but every lock is a real, signed, payable transaction. By the end of the demo, the judges were asking which messaging protocol they had used. Filipino ingenuity turned a sandbox into a convincing cross-chain flow. 🇵🇭🔗🌐

---

## 📚 Theory & Web3 Lecture

### 🎯 What You'll Learn

- How a lock-and-release bridge works, and what a real cross-chain messaging protocol such as LayerZero adds.
- How to send ETH with a **payable** call in ethers v6 (`{ value: ethers.parseEther(...) }`).
- How to get a result out of a transaction by reading its **event** from `receipt.logs`.
- Why the ABI must match the contract's event *exactly*, `indexed` keywords included.
- Why a confirmation step matters before any transaction that moves money.

**Activity:** build `LockForm`. It has an amount input and a **Bridge** button, then a "Yes, lock" confirmation. It calls `lockTokens()` with the ETH attached, waits for the receipt, and passes the `Locked` event's id to `onLocked`.

---

### 📐 Bridge simulator flow

```
   "PHChain" (UI)                               "NYChain" (UI)
        │  1. LOCK: lockTokens{value: 1.5 ETH}        │
        ▼                                             │
 ┌──────────────────────────────────────────┐        │
 │ BridgeSimulator (one contract on Sepolia)│        │
 │  locks[42] = { user, 1.5 ETH, released:false }    │
 │  emit Locked(user, 1.5 ETH, 42)          │        │
 └──────────────────┬───────────────────────┘        │
                    │ 2. UI "switches chain" (state only)
                    ▼                                 │
          3. RELEASE: releaseTokens(42) ◀─────────────┘
             emit Released(user, 1.5 ETH, 42)
```

---

### 🔑 Key Concepts

#### 1. How real bridges work

A blockchain cannot read another blockchain directly. A bridge therefore **locks** (or burns) assets on the source chain, **sends a message** saying "this happened", and the destination chain **releases** (or mints) the matching assets once it trusts that message. The hard part is the trust in the middle.

**LayerZero v2**, the protocol this lesson is named after, splits that middle into roles:

| Piece | Role in LayerZero v2 | In this lesson |
| ----- | -------------------- | -------------- |
| **Endpoint** | The contract on each chain that apps send messages through and receive messages from | The one `BridgeSimulator` contract |
| **DVNs** (Decentralized Verifier Networks) | Independently verify a message. An app chooses which DVNs it trusts and how many must agree (its "security stack") | Skipped: we trust ourselves |
| **Executor** | Once the message is verified, delivers it on the destination chain by calling the receiving app's `lzReceive` | You, clicking "release" |

If you read older material, you may see "Oracle" and "Relayer" instead. That was LayerZero **v1's** design. v2 replaced it with configurable DVNs and an Executor.

```
Real bridge:   Lock on A ──▶ message ──▶ DVNs verify ──▶ Executor delivers ──▶ Release on B
This lesson:   Lock (tx) ──▶ UI state change ─────────────────────────────────▶ Release (tx)
```

#### 2. The contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BridgeSimulator {
    struct Lock {
        address user;
        uint256 amount;
        bool released;
    }

    uint256 public nextId;
    mapping(uint256 => Lock) public locks;

    event Locked(address indexed user, uint256 amount, uint256 id);
    event Released(address indexed user, uint256 amount, uint256 id);

    function lockTokens() external payable returns (uint256 id) {
        require(msg.value > 0, "Must send ETH");
        id = nextId++;
        locks[id] = Lock({user: msg.sender, amount: msg.value, released: false});
        emit Locked(msg.sender, msg.value, id);
    }

    function releaseTokens(uint256 id) external {
        Lock storage lock = locks[id];
        require(lock.user == msg.sender, "Not your lock");
        require(!lock.released, "Already released");
        require(lock.amount > 0, "Invalid lock");

        lock.released = true;                                    // effect first
        (bool ok, ) = payable(msg.sender).call{value: lock.amount}(""); // then pay
        require(ok, "Transfer failed");

        emit Released(msg.sender, lock.amount, id);
    }

    function getLock(uint256 id) external view returns (address user, uint256 amount, bool released) {
        Lock memory lock = locks[id];
        return (lock.user, lock.amount, lock.released);
    }
}
```

Look closely at the event: `Locked(address indexed user, uint256 amount, uint256 id)`. Only `user` is `indexed`, and that matches the activity's ABI line for line. `releaseTokens` sets `released = true` **before** sending ETH and uses `call` rather than `transfer`, the same checks-effects-interactions rule you saw in the escrow lesson.

#### 3. The ABI must match the event exactly

An **indexed** event parameter is stored in the log's *topics*, where it can be searched. A non-indexed one is packed into the log's *data*. The ABI tells ethers where to look. If your ABI says `uint256 indexed id` but the contract emits an unindexed `id`, ethers looks for a topic that isn't there. With ethers 6.13.4 against this contract, the receipt log came back as an `UndecodedEventLog` (no `args`), and `interface.parseLog(log)` threw `data out-of-bounds`. Always copy event signatures from the compiled artifact, not from memory.

#### 4. Payable calls in ethers v6

```javascript
const provider = new ethers.BrowserProvider(window.ethereum);
const signer = await provider.getSigner();
const bridge = new ethers.Contract(BRIDGE_ADDR, ABI, signer);

const tx = await bridge.lockTokens({ value: ethers.parseEther("1.5") }); // sent
const receipt = await tx.wait();                                       // mined
```

The ETH travels in the **overrides** object, the extra last argument. `ethers.parseEther("1.5")` is `1500000000000000000n` wei. Passing the amount as a normal argument (`bridge.lockTokens(ethers.parseEther("1.5"))`) fails with `no matching fragment`, because `lockTokens` takes no parameters.

#### 5. Getting the lock id: read the event

A mined transaction does not return `lockTokens`'s `uint256` to your code. You get a receipt. The id is in the `Locked` event, and in ethers v6 the receipt keeps events in `receipt.logs`. Each of these finds it (all were run against the contract above):

```javascript
// A. by the decoded fragment (what the activity uses)
const evt = receipt.logs.find((l) => l.fragment && l.fragment.name === "Locked");

// B. by eventName, a shortcut on EventLog
const evt2 = receipt.logs.find((l) => l.eventName === "Locked");

// C. by type: only logs this ABI could decode are EventLogs
const evt3 = receipt.logs.find((l) => l instanceof ethers.EventLog && l.eventName === "Locked");

// D. decode a raw log yourself
const parsed = bridge.interface.parseLog(receipt.logs[0]);   // parsed.name === "Locked"

Number(evt.args.id);      // bigint → number, e.g. 42
evt.args.amount;          // 1500000000000000000n
```

`receipt.events` <!-- v5-ok --> was ethers v5 and is `undefined` in v6, which is the most common reason copied bridge tutorials crash.

#### 6. The UI state machine

```
 Idle ──Bridge──▶ Confirm ──Yes, lock──▶ Locking ──receipt──▶ Idle (onLocked(id))
   ▲                 │                      │
   └────Cancel───────┘                      └──error──▶ Idle (show error)
```

The confirmation step costs one click and saves people from the most expensive mistake in crypto: sending value they didn't mean to send. Bridge transfers in particular cannot be reversed.

---

### 🏗️ The full simulator (beyond the activity)

The release half mirrors the lock half:

```javascript
async function confirmRelease(lockId) {
  setStep("Releasing");
  try {
    const signer = await new ethers.BrowserProvider(window.ethereum).getSigner();
    const bridge = new ethers.Contract(BRIDGE_ADDR, FULL_ABI, signer);
    const tx = await bridge.releaseTokens(lockId);
    await tx.wait();
    setStep("Done");
  } catch (err) {
    setError(ethers.isError(err, "ACTION_REJECTED") ? "Release cancelled" : err.message);
    setStep("Locked");
  }
}
```

Here, `FULL_ABI` also lists `function releaseTokens(uint256)` and the `Released` event.

---

### 📊 Real bridge vs this simulator

| Aspect | Real bridge (e.g. LayerZero v2) | This simulator |
| ------ | ------------------------------- | -------------- |
| Networks | Two or more real chains | One Sepolia contract, two chains in the UI |
| Verification | DVNs the app configures | None (trusted) |
| Delivery | Executor calls `lzReceive` on the destination | A button click |
| Assets | Locked/burned on one side, released/minted on the other | Native test ETH, locked and released by the same contract |
| Fees | Source gas + messaging fees + destination gas | Sepolia gas only |
| Time | Depends on both chains' finality and verification | One block per step |

---

### ⚠️ Common Mistakes

| Mistake | Problem | Solution |
| ------- | ------- | -------- |
| ETH passed as an argument | `no matching fragment` | `{ value: ethers.parseEther(amt) }` |
| `receipt.events` <!-- v5-ok --> | `undefined` in ethers v6 | `receipt.logs` |
| ABI event differs from the contract (`indexed`) | `UndecodedEventLog`, no `args` | Copy the event from the artifact |
| `args.id.toNumber()` <!-- v5-ok --> | `bigint` has no `toNumber` | `Number(args.id)` |
| No confirmation step | Accidental, irreversible transfers | Bridge → Confirm → "Yes, lock" |
| Not resetting `step` | "Locking on chain…" stays forever | `setStep("Idle")` after success and in `catch` |
| Releasing before marking released | Reentrancy can double-pay | Effects before interactions |

---

### 🧪 How this is graded

Your `LockForm` runs against a simulated Sepolia bridge whose `Locked` event carries id `42`. The grader types `1.5`, clicks **Bridge** (which must not send anything yet), then clicks the button containing **Yes**. It checks that you requested accounts and awaited a signer, sent `1500000000000000000` wei as `{ value }`, awaited `tx.wait()`, called `onLocked` with `42`, and cleared the "Locking on chain" message afterwards.

---

### 🔗 External Resources

| Resource | Link |
| -------- | ---- |
| LayerZero v2 protocol overview | https://docs.layerzero.network/v2/concepts/protocol/protocol-overview |
| ethereum.org: bridges | https://ethereum.org/en/developers/docs/bridges/ |
| ethers v6: Contract and EventLog | https://docs.ethers.org/v6/api/contract/ |
| ethers v6: parseEther | https://docs.ethers.org/v6/api/utils/#parseEther |

---

## 🌟 Closing Story

On the demo stage, the crowd watched Det's UI lock 1.5 ETH on "PHChain", show "Lock ID #42", and release it on "NYChain". "Feels like the real thing!" a judge said. Neri answered honestly: "Same contract, one testnet. The real thing adds DVNs to verify and an Executor to deliver, and that's our next build." Back in Cebu they started sketching a version across two real testnets. Filipino dev power: bridging chains, building futures! 🇵🇭🌐🔥
