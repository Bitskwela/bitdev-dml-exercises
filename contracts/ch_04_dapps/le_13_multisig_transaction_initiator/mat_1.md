## 🧑‍💻 Background Story

![Multisig DApp Concept](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+13.0+-+COVER.png)

Odessa sat in a chic SoHo café, sipping kapeng barako over Zoom with her New York mentor. "In the Philippines, corporate boards need at least three of five signatures to greenlight a decision," she explained. "Kung wala kang quorum, wala kang chain move." Inspired by this real-world governance rule, she sketched a Multisig DApp: a proposal form, a list of pending transactions, and signer buttons that flip green when each of the five owners signs off.

![Odessa](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_4/C4+13.1.png)

Back in her Makati apartment, Det deployed a `MultisigWallet` contract on Sepolia with five owners and a threshold of three. Then her mentor asked the question that reset the whole plan: "Before anyone signs anything, how does a board member see what they are signing?"

So Det started with the screen every signer opens first: **the proposal list**. For each proposal it shows who receives the money, how much (in ETH, not wei), which function it calls, how many owners have confirmed, and whether it has already executed. The Propose, Confirm and Execute buttons would come next, on top of a list everyone could trust. 🇵🇭🔐🚀

---

## 📚 Theory & Web3 Lecture

### 🎯 What You'll Learn

By the end of this lesson you can **build a read-only viewer for a multisig wallet**: read how many proposals exist, read each one by index, unpack its fields, and display them in human units.

That is what the activity grades. You will also understand the full multisig flow (propose → confirm → execute) so you know what the numbers on your screen mean, and the last section previews how the write buttons are added. Those write steps are **not** part of this activity.

---

### 📐 How a Multisig Works

A **multisig** (multi-signature) wallet is a contract that holds funds and only moves them when enough of its owners agree.

```
          5 OWNERS, THRESHOLD 3
 👤 Owner1  👤 Owner2  👤 Owner3  👤 Owner4  👤 Owner5

 STEP 1  submitTransaction(to, value, data)   → proposal #0 created, 0 confirmations
 STEP 2  confirmTransaction(0) by 3 owners    → numConfirmations: 1 → 2 → 3 (quorum!)
 STEP 3  executeTransaction(0)                → funds move, executed = true

 THIS ACTIVITY: read and display every proposal's state at any point above
```

| Term             | Meaning                                   | Example              |
| ---------------- | ----------------------------------------- | -------------------- |
| **Owners**       | Addresses allowed to propose and sign     | 5 board members      |
| **Threshold**    | Confirmations needed before execution     | 3 of 5               |
| **Proposal**     | A transaction waiting for signatures      | Send 1.5 ETH to a vendor |
| **Confirmation** | One owner's on-chain "I approve"          | Owner 2 confirms #0  |
| **Execution**    | Actually sending it, once quorum is met   | Funds transferred    |

Common setups: 2-of-3 for small teams, 3-of-5 for boards, larger thresholds for big treasuries. In production, teams use audited multisigs such as **Safe** rather than writing their own.

---

### 🔑 Key Concepts

#### 1. The contract your viewer reads

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MultisigWallet {
    struct Transaction {
        address to;               // where the money or call goes
        uint256 value;            // ETH amount, in wei
        bytes data;               // encoded function call (empty for a plain transfer)
        bool executed;            // already sent?
        uint256 numConfirmations; // how many owners have signed
    }

    address[] public owners;
    mapping(address => bool) public isOwner;
    uint256 public threshold;                                          // e.g. 3 of 5

    Transaction[] public transactions;                                 // every proposal, by id
    mapping(uint256 => mapping(address => bool)) public confirmations; // txId => owner => signed?

    event Submitted(uint256 indexed txId, address indexed owner);
    event Confirmed(uint256 indexed txId, address indexed owner);
    event Executed(uint256 indexed txId);

    modifier onlyOwner() {
        require(isOwner[msg.sender], "Not an owner");
        _;
    }

    constructor(address[] memory _owners, uint256 _threshold) {
        require(_threshold > 0 && _threshold <= _owners.length, "Bad threshold");
        for (uint256 i = 0; i < _owners.length; i++) {
            require(!isOwner[_owners[i]], "Duplicate owner");
            isOwner[_owners[i]] = true;
            owners.push(_owners[i]);
        }
        threshold = _threshold;
    }

    receive() external payable {}

    function getTransactionCount() external view returns (uint256) {
        return transactions.length;
    }

    function submitTransaction(address to, uint256 value, bytes calldata data)
        external
        onlyOwner
        returns (uint256 txId)
    {
        txId = transactions.length;
        transactions.push(Transaction(to, value, data, false, 0));
        emit Submitted(txId, msg.sender);
    }

    function confirmTransaction(uint256 txId) external onlyOwner {
        Transaction storage txn = transactions[txId];
        require(!txn.executed, "Already executed");
        require(!confirmations[txId][msg.sender], "Already confirmed");
        confirmations[txId][msg.sender] = true;
        txn.numConfirmations += 1;
        emit Confirmed(txId, msg.sender);
    }

    function executeTransaction(uint256 txId) external onlyOwner {
        Transaction storage txn = transactions[txId];
        require(!txn.executed, "Already executed");
        require(txn.numConfirmations >= threshold, "Not enough confirmations");
        txn.executed = true; // update state before the external call
        (bool ok, ) = txn.to.call{value: txn.value}(txn.data);
        require(ok, "Execution failed");
        emit Executed(txId);
    }
}
```

Notice `executed = true` is set **before** the external `call`. That is the checks-effects-interactions habit from the reentrancy lessons: if the receiver tries to call back in, the proposal is already marked as done.

#### 2. Public getters: one item per call

Marking `transactions` as `public` makes Solidity generate a getter function `transactions(uint256 index)`. It returns **one** proposal's fields, not the whole array. That is why the viewer needs two steps:

```javascript
const count = Number(await wallet.getTransactionCount()); // how many?
for (let i = 0; i < count; i++) {
  const [to, value, data, executed, numConfirmations] = await wallet.transactions(i);
}
```

The getter returns the struct's fields in declaration order, and ethers v6 hands them back as a `Result` you can destructure like an array. The same is true of `confirmations(txId, owner)`, which answers "has this owner signed this proposal?" with a `bool`.

#### 3. Human units

- `value` is in **wei** (a `bigint`). `ethers.formatEther(1500000000000000000n)` gives `"1.5"`.
- `numConfirmations` is a `bigint` too, but tiny, so `Number(numConfirmations)` is safe.
- `data` is hex. Its first 4 bytes (`data.slice(0, 10)`, counting the `0x`) are the **function selector**: `0xa9059cbb` is ERC-20 `transfer(address,uint256)`, `0x23b872dd` is `transferFrom(address,address,uint256)`. Showing the selector helps a signer spot what a proposal will actually do.

#### 4. Which provider, and why

| Screen                                     | Provider                                   | Why                                  |
| ------------------------------------------ | ------------------------------------------ | ------------------------------------ |
| Public stats anyone can see (Lessons 11, 12) | `new ethers.JsonRpcProvider(rpcUrl)`     | No wallet needed, works for everyone |
| A signers' screen with write buttons (this lesson) | `new ethers.BrowserProvider(window.ethereum)` | The same provider later gives you a signer |

Reading through MetaMask's `BrowserProvider` is perfectly valid; it just requires MetaMask. The activity connects the wallet up front because this list is the page where owners will confirm and execute next.

---

### ➕ Preview: Adding the Write Buttons (not graded)

Writes need a **signer**. In ethers v6, `getSigner()` is `async`, so you must `await` it:

```javascript
const provider = new ethers.BrowserProvider(window.ethereum);
const signer = await provider.getSigner();
const multisig = new ethers.Contract(contractAddress, ABI_WITH_WRITES, signer);

// Propose 1.5 ETH to a vendor
const tx = await multisig.submitTransaction(vendor, ethers.parseEther("1.5"), "0x");
await tx.wait(); // wait until it is mined before refreshing the list

// Confirm proposal #0 (skip it if this owner already signed)
const me = await signer.getAddress();
if (!(await multisig.confirmations(0, me))) {
  await (await multisig.confirmTransaction(0)).wait();
}
```

To refresh the list when anyone confirms, subscribe to the event once and unsubscribe on cleanup:

```javascript
useEffect(() => {
  const onConfirmed = () => loadProposals();
  multisig.on("Confirmed", onConfirmed);
  return () => {
    multisig.off("Confirmed", onConfirmed);
  };
}, [multisig]);
```

---

### 📊 Proposal Lifecycle (what your list shows)

```
PENDING        PARTIAL         READY           EXECUTED
0/3 ⬜⬜⬜  ──▶  2/3 ✅✅⬜  ──▶  3/3 ✅✅✅  ──▶  executed = true
Confirmations: 0   Confirmations: 2   Confirmations: 3   Executed: ✅
```

---

### ⚠️ Common Mistakes

| Mistake                                  | Problem                                        | Solution                                         |
| ---------------------------------------- | ---------------------------------------------- | ------------------------------------------------ |
| Expecting the getter to return the array | `transactions()` with no index fails           | Read the count, then loop `transactions(i)`      |
| Showing raw wei                          | `1500000000000000000` is unreadable            | `ethers.formatEther(value)`                      |
| Unlabelled numbers                       | "1" could mean anything                        | Label it: `Confirmations: 1`                     |
| `provider.getSigner()` without `await`   | In v6 it returns a Promise, not a signer       | `const signer = await provider.getSigner()`      |
| Refreshing before the write is mined     | List still shows old counts                    | `await tx.wait()` first                          |
| Rolling your own multisig for real money | Unaudited code holding a treasury              | Use an audited wallet such as Safe               |

---

### ✅ How This Is Graded

The grader runs your component with ethers v6 against a mock Sepolia multisig holding two proposals. It checks that you read the count and then each proposal exactly once, render both recipient addresses unchanged, show the value in ether (not wei), label each confirmation count with the word "Confirmations", and show whether each proposal has "Executed". The activity page lists every detail.

---

### 🔗 External Resources

| Resource                         | Link                                                                      |
| -------------------------------- | ------------------------------------------------------------------------- |
| Safe (production multisig)       | https://safe.global/                                                      |
| ethers v6: Contracts             | https://docs.ethers.org/v6/api/contract/                                  |
| ethers v6: BrowserProvider       | https://docs.ethers.org/v6/api/providers/                 |
| Solidity: getter functions       | https://docs.soliditylang.org/en/latest/contracts.html#getter-functions   |
| Function selector lookup         | https://www.4byte.directory/                                              |

---

## 🌟 Closing Story

With the proposal list live, Odessa shared her screen with her NY mentor. "Proposal #0: 1.5 ETH to the vendor, one confirmation, not executed. Proposal #1: already done." Her mentor nodded: "Now every signer knows exactly what they are approving. That is PH-style corporate security." Next up: the Propose, Confirm and Execute buttons, built on top of a list the whole board can trust. Mabuhay decentralized governance! 🇵🇭🔐🚀
