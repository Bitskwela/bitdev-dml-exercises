## 🧑‍💻 Background Story

Odessa sat in a chic SoHo café, sipping kapeng barako over Zoom with her New York mentor. "In the Philippines, corporate boards need at least three of five signatures to greenlight a decision," she explained. "Kung wala kang quorum, wala kang chain move." Inspired by this real-world governance rule, she sketched a UI for a Multisig DApp: a proposal form, a live list of pending transactions, and signer buttons that flip green when each of the five owners signs off.

Back in her Makati apartment, Det spun up Hardhat and coded a `MultisigWallet.sol` with five owners and a threshold of three. She deployed it on Sepolia; next, she scaffolded a React app with Create React App. In under 30 minutes, she had:

1. A **Proposal Form** where board members enter destination address, ETH value, and call data.
2. A **Proposal List** showing each tx's ID, to-address, value, data preview, confirmation count, and "Execute" button (disabled until quorum).
3. **Confirm Buttons** for each owner—simulated via MetaMask's multiple accounts—so Det could log in as Owner #1, #2, #3, etc.

Every time an owner clicked "Confirm," the UI listened to the `Confirmation` event, updated the confirmation tally, and marked that owner in the proposal's row. Once three signatures were in, the "Execute" button lit up, and a follow-up click triggered the on-chain call.

By midnight, Odessa demoed to her mentor: "See? Three signatures, transaction executed, and funds moved." Her mentor nodded, impressed that Filipino governance customs had been encoded in Solidity and rendered in a sleek React UI. That night, under the glow of neon jeepneys, Det toasted: "To real-world multisig, PH style!" 🇵🇭🔐🚀

---

## 📚 Theory & Web3 Lecture

### 🎯 What You'll Learn

In this lesson, you'll build a **Multisig Wallet UI** that allows multiple owners to propose, confirm, and execute transactions. This pattern mirrors real-world corporate governance where multiple signatures are required for important decisions.

---

### 📐 Multisig Wallet Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                   MULTISIG GOVERNANCE FLOW                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │                    5 OWNERS                              │   │
│   │   👤 Owner1  👤 Owner2  👤 Owner3  👤 Owner4  👤 Owner5  │   │
│   └─────────────────────────────────────────────────────────┘   │
│                              │                                  │
│                    THRESHOLD: 3 of 5                            │
│                              │                                  │
│   ┌──────────────────────────▼──────────────────────────────┐   │
│   │                                                          │   │
│   │  STEP 1: SUBMIT PROPOSAL                                 │   │
│   │  ┌────────────────────────────────────────────────────┐  │   │
│   │  │ submitTransaction(to, value, data) → txId: 0       │  │   │
│   │  └────────────────────────────────────────────────────┘  │   │
│   │                         │                                │   │
│   │                         ▼                                │   │
│   │  STEP 2: COLLECT CONFIRMATIONS                           │   │
│   │  ┌────────────────────────────────────────────────────┐  │   │
│   │  │ Owner1: confirmTransaction(0) ✅                   │  │   │
│   │  │ Owner2: confirmTransaction(0) ✅                   │  │   │
│   │  │ Owner3: confirmTransaction(0) ✅  ← QUORUM!        │  │   │
│   │  └────────────────────────────────────────────────────┘  │   │
│   │                         │                                │   │
│   │                         ▼                                │   │
│   │  STEP 3: EXECUTE                                         │   │
│   │  ┌────────────────────────────────────────────────────┐  │   │
│   │  │ executeTransaction(0) → Funds transferred! 💰       │  │   │
│   │  └────────────────────────────────────────────────────┘  │   │
│   │                                                          │   │
│   └──────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

### 🔑 Key Concepts

#### 1. Multisig Security Model

| Term | Definition | Example |
|------|------------|---------|
| **Owners** | Addresses authorized to sign | 5 board members |
| **Threshold** | Minimum confirmations needed | 3 of 5 (60%) |
| **Proposal** | Pending transaction awaiting signatures | Send 1 ETH to vendor |
| **Confirmation** | Owner's signature on a proposal | "I approve" |
| **Execution** | Final action after quorum is met | Transaction sent |

```
Security Trade-offs:
├── 1-of-1: No security (single point of failure)
├── 2-of-3: Light security (small teams)
├── 3-of-5: Balanced (corporate standard)
├── 4-of-7: High security (DAOs, treasuries)
└── 5-of-9: Maximum security (protocol governance)
```

#### 2. Smart Contract Data Structures

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MultisigWallet {
    // List of owner addresses
    address[] public owners;
    
    // Number of confirmations required
    uint256 public threshold;
    
    // Transaction structure
    struct Transaction {
        address to;           // Destination address
        uint256 value;        // ETH amount in wei
        bytes data;           // Encoded function call (optional)
        bool executed;        // Has it been executed?
        uint256 confirmations;// Current confirmation count
    }
    
    // All submitted transactions
    Transaction[] public transactions;
    
    // Tracks who confirmed which transaction
    // mapping(txId => mapping(owner => hasConfirmed))
    mapping(uint256 => mapping(address => bool)) public isConfirmed;
    
    // Check if address is an owner
    mapping(address => bool) public isOwner;
}
```

#### 3. Core Contract Functions

```solidity
// Submit a new transaction proposal
function submitTransaction(
    address _to,
    uint256 _value,
    bytes calldata _data
) external onlyOwner returns (uint256 txId) {
    txId = transactions.length;
    transactions.push(Transaction({
        to: _to,
        value: _value,
        data: _data,
        executed: false,
        confirmations: 0
    }));
    emit Submitted(msg.sender, txId, _to, _value, _data);
}

// Confirm a pending transaction
function confirmTransaction(uint256 _txId) 
    external 
    onlyOwner 
    txExists(_txId) 
    notConfirmed(_txId)
    notExecuted(_txId) 
{
    Transaction storage txn = transactions[_txId];
    txn.confirmations += 1;
    isConfirmed[_txId][msg.sender] = true;
    emit Confirmed(msg.sender, _txId);
}

// Execute after reaching threshold
function executeTransaction(uint256 _txId)
    external
    onlyOwner
    txExists(_txId)
    notExecuted(_txId)
{
    Transaction storage txn = transactions[_txId];
    require(txn.confirmations >= threshold, "Not enough confirmations");
    
    txn.executed = true;
    (bool success, ) = txn.to.call{value: txn.value}(txn.data);
    require(success, "Execution failed");
    
    emit Executed(msg.sender, _txId);
}
```

#### 4. Events for Frontend Reactivity

```solidity
// Emitted when a new transaction is proposed
event Submitted(
    address indexed owner,
    uint256 indexed txId,
    address indexed to,
    uint256 value,
    bytes data
);

// Emitted when an owner confirms
event Confirmed(address indexed owner, uint256 indexed txId);

// Emitted when transaction is revoked
event Revoked(address indexed owner, uint256 indexed txId);

// Emitted when transaction is executed
event Executed(address indexed owner, uint256 indexed txId);
```

---

### 🏗️ React Integration Pattern

```
┌─────────────────────────────────────────────────────────────────┐
│                    REACT COMPONENTS                             │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ┌─────────────────────────────────────────────────────────┐   │
│   │                   MultisigApp                            │   │
│   │  ┌─────────────────────────────────────────────────┐    │   │
│   │  │ Provider + Signer + Contract setup              │    │   │
│   │  │ Event subscriptions (Submitted, Confirmed, etc) │    │   │
│   │  └─────────────────────────────────────────────────┘    │   │
│   └───────────────────────┬─────────────────────────────────┘   │
│                           │                                     │
│       ┌───────────────────┼───────────────────┐                 │
│       ▼                   ▼                   ▼                 │
│   ┌─────────┐      ┌─────────────┐     ┌─────────────┐         │
│   │ Submit  │      │  Proposal   │     │  Confirm    │         │
│   │ Form    │      │    List     │     │   Button    │         │
│   │         │      │             │     │             │         │
│   │ • to    │      │ ID #0       │     │ [Confirm]   │         │
│   │ • value │      │ to: 0xABC   │     │ ✅ 2/3      │         │
│   │ • data  │      │ val: 1 ETH  │     │             │         │
│   │         │      │ conf: 2/3   │     │ [Execute]   │         │
│   │[Submit] │      │ [Execute] 🔓│     │ (disabled)  │         │
│   └─────────┘      └─────────────┘     └─────────────┘         │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

#### Setting Up Signer for Write Operations

```javascript
import { ethers } from "ethers";

// Connect to MetaMask for write operations
async function setupContract() {
    // Check if MetaMask is installed
    if (!window.ethereum) {
        throw new Error("MetaMask not detected");
    }

    // Request account access
    await window.ethereum.request({ method: "eth_requestAccounts" });

    // Create provider and signer
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();

    // Create contract with signer (for write operations)
    const contract = new ethers.Contract(
        process.env.REACT_APP_MULTISIG_ADDRESS,
        MULTISIG_ABI,
        signer
    );

    return { provider, signer, contract };
}
```

#### Event Listening for Real-Time Updates

```javascript
useEffect(() => {
    const setupListeners = async () => {
        const { contract } = await setupContract();

        // Listen for new submissions
        contract.on("Submitted", (owner, txId, to, value, data) => {
            console.log(`New proposal #${txId} by ${owner}`);
            refreshProposals();
        });

        // Listen for confirmations
        contract.on("Confirmed", (owner, txId) => {
            console.log(`Owner ${owner} confirmed #${txId}`);
            refreshProposals();
        });

        // Listen for executions
        contract.on("Executed", (owner, txId) => {
            console.log(`Proposal #${txId} executed!`);
            refreshProposals();
        });

        // Cleanup on unmount
        return () => {
            contract.removeAllListeners();
        };
    };

    setupListeners();
}, []);
```

---

### 📊 Transaction Lifecycle

```
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│ PENDING  │───▶│ PARTIAL  │───▶│  READY   │───▶│ EXECUTED │
│          │    │ CONFIRM  │    │          │    │          │
│ 0/3 ⬜⬜⬜│    │ 2/3 ✅✅⬜│    │ 3/3 ✅✅✅│    │ ✔ Done   │
└──────────┘    └──────────┘    └──────────┘    └──────────┘
     │               │               │               │
     └───────────────┴───────────────┴───────────────┘
              Can still add confirmations
              until threshold is met
```

---

### ⚠️ Common Mistakes

| Mistake | Problem | Solution |
|---------|---------|----------|
| Not validating addresses | Invalid `to` address | Use `ethers.utils.isAddress()` |
| Allowing re-confirmation | Owner confirms twice | Check `isConfirmed` mapping |
| Forgetting `tx.wait()` | UI updates before confirmation | Always await receipt |
| No loading states | User clicks multiple times | Disable buttons while pending |
| Hardcoding threshold | Inflexible governance | Make it constructor parameter |

---

### ✅ Testing Checklist

Before considering this lesson complete, verify:

- [ ] Only owners can submit proposals
- [ ] Owners can confirm proposals exactly once
- [ ] Confirmation count updates in real-time
- [ ] Execute button disabled until threshold met
- [ ] Execute button enabled at threshold
- [ ] Executed proposals marked as complete
- [ ] Events trigger UI refresh
- [ ] Error handling for rejected transactions
- [ ] Input validation for addresses and values

---

### 🔗 External Resources

| Resource | Link |
|----------|------|
| Gnosis Safe (Production Multisig) | https://safe.global/ |
| OpenZeppelin Governor | https://docs.openzeppelin.com/contracts/4.x/governance |
| Ethers.js Events | https://docs.ethers.org/v5/api/contract/contract/#Contract--events |
| Solidity Modifiers | https://docs.soliditylang.org/en/latest/contracts.html#function-modifiers |



---

## ✅ Test Cases

Create `__tests__/MultisigUI.test.js`:

```js
// __tests__/MultisigUI.test.js
import React from "react";
import { render, screen, fireEvent, waitFor } from "@testing-library/react";
import ProposalList from "../ProposalList";
import SubmitProposal from "../SubmitProposal";
import ConfirmButton from "../ConfirmButton";
import { ethers } from "ethers";

jest.mock("ethers");

describe("Multisig UI Integration", () => {
  const fakeProvider = {};
  const fakeSigner = {};
  const fakeContract = {
    getTransactionCount: jest.fn(),
    transactions: jest.fn(),
    submitTransaction: jest.fn(),
    confirmations: jest.fn(),
    confirmTransaction: jest.fn(),
  };

  beforeAll(() => {
    global.window.ethereum = {
      request: jest.fn().mockResolvedValue(["0xABC"]),
    };
    ethers.providers.Web3Provider = jest.fn().mockReturnValue(fakeProvider);
    fakeProvider.getSigner = () => fakeSigner;
    ethers.Contract = jest.fn().mockReturnValue(fakeContract);
  });

  it("lists proposals", async () => {
    fakeContract.getTransactionCount.mockResolvedValue({ toNumber: () => 1 });
    fakeContract.transactions.mockResolvedValue([
      "0xTo",
      ethers.BigNumber.from("1000000000000000000"),
      "0x1234",
      false,
      ethers.BigNumber.from("2"),
    ]);
    render(<ProposalList contractAddress="0xWallet" />);
    expect(await screen.findByText(/ID #0/)).toBeInTheDocument();
  });

  it("submits a new proposal", async () => {
    const receipt = {
      wait: () =>
        Promise.resolve({
          events: [
            { event: "Submit", args: { txId: ethers.BigNumber.from("5") } },
          ],
        }),
    };
    fakeContract.submitTransaction.mockResolvedValue(receipt);
    const onSubmitted = jest.fn();
    render(
      <SubmitProposal contractAddress="0xWallet" onSubmitted={onSubmitted} />
    );
    fireEvent.change(screen.getByPlaceholderText("To Address"), {
      target: { value: "0xTo" },
    });
    fireEvent.change(screen.getByPlaceholderText("Value (ETH)"), {
      target: { value: "1" },
    });
    fireEvent.change(screen.getByPlaceholderText("Data (hex)"), {
      target: { value: "0x1234" },
    });
    fireEvent.click(screen.getByText("Submit"));
    await waitFor(() => screen.getByText(/Submitted TX ID: 5/));
    expect(onSubmitted).toHaveBeenCalled();
  });

  it("confirms a proposal", async () => {
    fakeContract.confirmations.mockResolvedValue(false);
    const onConfirmed = jest.fn();
    render(
      <ConfirmButton
        contractAddress="0xWallet"
        txId={0}
        onConfirmed={onConfirmed}
      />
    );
    await waitFor(() => screen.getByText("Confirm"));
    fireEvent.click(screen.getByText("Confirm"));
    await waitFor(() =>
      expect(fakeContract.confirmTransaction).toHaveBeenCalledWith(0)
    );
    expect(onConfirmed).toHaveBeenCalled();
  });
});
```

jest.config.js:

```js
module.exports = {
  testEnvironment: "jsdom",
  moduleNameMapper: { "\\.(css|scss)$": "identity-obj-proxy" },
};
```

---

## 🌟 Closing Story

With her Multisig UI live, Odessa clicked through a full governance cycle: propose, three confirmations, execute. Her NY mentor gave a thumbs-up on Zoom: "Exactly PH-style corporate security." Next up: transaction execution and on-chain audit logs—Det's multisig saga is just beginning. Mabuhay decentralized governance! 🇵🇭🔐🚀