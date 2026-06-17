# Mini Project #3: Iloilo's Barangay Lending Protocol

![Iloilo Lending Protocol](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_3/C3+3.0+-+COVER.png)

## Scene

In a small barangay in Iloilo, farmers are often trapped in 5-6 lending schemes (loan sharks), borrowing PHP 5,000 but paying back PHP 7,500 or more. They can't access formal banks. They have no credit score, no collateral, and no protection.

Hackana's old botnet disrupted rural banking systems, and now the community can't rely on traditional finance. LGU is helpless. Bangko Sentral ng Pilipinas is too slow. The people need a decentralized solution.

![Neri the Blockchain Defender](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_3/C3+3.1+-+COVER.png)

Neri designs a **Barangay Lending Protocol** — a smart contract that allows farmers to request small loans and lenders to offer funds directly, transparently. All activity is recorded on-chain.

## Why this matters

Every time you build something that directly addresses a Philippine socioeconomic pain point, you stop being just a coder and become a nation-builder. A 5-6 loan shark charges 50% interest because they hold all the power: they know the borrower has nowhere else to go, and no one is watching. A smart contract flips that. Loan terms are **public and immutable**, funds move **peer-to-peer with no middleman skimming a cut**, and every request and disbursement is **permanently logged on-chain** for anyone to audit.

This project is your first real *marketplace* contract — two distinct parties (borrowers and lenders) interacting through shared state. You'll model that state with `struct`s and `mapping`s, broadcast every action with `event`s, and move ETH between strangers safely. Getting the data model and the events right is what separates a real protocol from a toy.

## 1. Modeling a loan with a `struct`

A loan is several pieces of related data that belong together. A `struct` bundles them into one custom type:

```solidity
struct LoanRequest {
    address borrower;  // who needs the money
    uint256 amount;    // how much, in wei
    string reason;     // human-readable purpose ("seeds for planting")
    bool isFunded;     // has a lender filled it?
    address lender;    // who funded it (address(0) until funded)
}
```

**Key gotcha — `string` is expensive.** Storing arbitrary-length strings on-chain costs real gas. For a learning protocol `reason` is fine, but in production you'd often store only a hash or an off-chain reference (IPFS CID) and keep the human-readable text off-chain.

## 2. Indexing loans with a `mapping` + counter

We need many loans, each retrievable by an ID. The pattern is a counter plus a `mapping(uint256 => LoanRequest)`:

```solidity
uint256 public loanCounter;
mapping(uint256 => LoanRequest) public loans;

function requestLoan(uint256 amount, string calldata reason) external {
    require(amount > 0, "Amount must be > 0");
    loanCounter++;                         // first loan gets ID 1
    loans[loanCounter] = LoanRequest({
        borrower: msg.sender,
        amount: amount,
        reason: reason,
        isFunded: false,
        lender: address(0)
    });
    emit LoanRequested(loanCounter, msg.sender, amount, reason);
}
```

**Why increment *before* assigning?** It means loan IDs start at `1`, not `0`. That's deliberate: `0` is the default value for every unset mapping key, so reserving it as "no such loan" lets you distinguish a real loan from an empty slot later.

## 3. Events — the on-chain audit log

`event`s write to the transaction log, a cheap, append-only record that block explorers and dApps can read and filter. For a public-facing, government-adjacent protocol, events *are* the transparency feature.

```solidity
event LoanRequested(uint256 indexed loanId, address indexed borrower, uint256 amount, string reason);
event LoanFunded(uint256 indexed loanId, address indexed lender, uint256 amount);

emit LoanFunded(loanId, msg.sender, msg.value);
```

**`indexed` — up to 3 per event.** Marking a parameter `indexed` lets off-chain code filter by it efficiently ("show me every loan funded by this lender"). Index the fields you'll search on (IDs, addresses); leave bulky data like `reason` un-indexed.

> Events are **not** readable by other contracts and cannot be used as contract storage — they're a one-way broadcast to the outside world. Anything your contract logic needs to read later must live in storage (the `struct`), not only in an event.

## 4. Funding a loan: validate, record, then pay

`fundLoan` is `payable` — a lender sends ETH equal to the requested amount, and the contract forwards it to the borrower. This is where the ETH-payout discipline from Project #1 returns.

```solidity
function fundLoan(uint256 loanId) external payable nonReentrant {
    LoanRequest storage loan = loans[loanId];

    // CHECKS
    require(loan.borrower != address(0), "Loan does not exist");
    require(!loan.isFunded, "Loan already funded");
    require(msg.value == loan.amount, "Must send exact amount");

    // EFFECTS — mark funded BEFORE sending
    loan.isFunded = true;
    loan.lender = msg.sender;

    // INTERACTIONS — forward ETH to the borrower
    (bool success, ) = payable(loan.borrower).call{value: msg.value}("");
    require(success, "Transfer to borrower failed");

    emit LoanFunded(loanId, msg.sender, msg.value);
}
```

Three things to notice:

- **`loan.borrower != address(0)`** rejects a `loanId` that was never created (remember, IDs start at 1). Without it, a lender could send ETH to fund a "loan" that doesn't exist and lose their money to `address(0)`.
- **`msg.value == loan.amount`** prevents under- or over-funding. Exact match keeps the accounting clean.
- **CEI again:** set `isFunded = true` *before* the external `.call`. Otherwise a malicious borrower contract could re-enter `fundLoan` for the same ID before it's marked funded.

**`storage` vs `memory` here:** we use `LoanRequest storage loan` because we're *modifying* the stored loan (`isFunded`, `lender`). A `memory` copy would let us read but its changes wouldn't persist.

## Full reference contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract BarangayLending is ReentrancyGuard {
    struct LoanRequest {
        address borrower;
        uint256 amount;
        string reason;
        bool isFunded;
        address lender;
    }

    uint256 public loanCounter;
    mapping(uint256 => LoanRequest) public loans;

    event LoanRequested(uint256 indexed loanId, address indexed borrower, uint256 amount, string reason);
    event LoanFunded(uint256 indexed loanId, address indexed lender, uint256 amount);

    function requestLoan(uint256 amount, string calldata reason) external {
        require(amount > 0, "Amount must be > 0");
        loanCounter++;
        loans[loanCounter] = LoanRequest({
            borrower: msg.sender,
            amount: amount,
            reason: reason,
            isFunded: false,
            lender: address(0)
        });
        emit LoanRequested(loanCounter, msg.sender, amount, reason);
    }

    function fundLoan(uint256 loanId) external payable nonReentrant {
        LoanRequest storage loan = loans[loanId];
        require(loan.borrower != address(0), "Loan does not exist");
        require(!loan.isFunded, "Loan already funded");
        require(msg.value == loan.amount, "Must send exact amount");

        loan.isFunded = true;
        loan.lender = msg.sender;

        (bool success, ) = payable(loan.borrower).call{value: msg.value}("");
        require(success, "Transfer to borrower failed");

        emit LoanFunded(loanId, msg.sender, msg.value);
    }
}
```

## Bonus knowledge

This contract simulates peer-to-peer lending without middlemen — trustless finance, no bank required. Natural next upgrades:

- **Repayment with interest** — a `repayLoan` function and a `dueDate`, so the loop actually closes.
- **Tokenized credit scoring** — track on-time repayments per borrower to unlock larger loans.
- **NFT receipts** — mint an NFT to the lender representing their claim, making the loan tradeable.

## Security & gas notes

- **CEI on every payout.** `fundLoan` forwards ETH; mark state before the `.call` and `require(success)`.
- **`.call` over `.transfer()`.** The borrower might be a smart-contract wallet that needs more than 2300 gas.
- **Validate loan existence.** IDs start at 1; a `borrower == address(0)` check rejects bogus IDs.
- **Exact-amount funding.** `msg.value == loan.amount` avoids stuck change and ambiguous partial funding.
- **`calldata` over `memory`** for the `reason` parameter in external functions — it's cheaper, since the data isn't copied.
- **Mind `string` gas.** On-chain strings cost more than you'd expect; consider hashes/off-chain storage at scale.

## Common mistakes to avoid

1. **No "loan exists" check.** Funding a non-existent ID burns the lender's ETH. Check `borrower != address(0)`.
2. **Marking funded after the transfer.** Reentrancy window — set `isFunded = true` before the `.call`.
3. **Using `.transfer()` to pay the borrower.** Breaks for contract recipients; use `.call` + success check.
4. **Forgetting to emit events.** Without `LoanRequested`/`LoanFunded`, the "all activity is recorded on-chain" promise is broken.
5. **Reading a `storage` struct into `memory` then expecting writes to persist.** Use `storage` when you mutate.

## What's next

Next is **Barangay Aid Vault**, a security-first project where you'll confront access control head-on: `Ownable`, why `tx.origin` authentication is exploitable via phishing, and how to build a vault that's immune to rookie-level exploits.

## References

- Solidity docs — Structs: https://docs.soliditylang.org/en/latest/types.html#structs
- Solidity docs — Events: https://docs.soliditylang.org/en/latest/contracts.html#events
- Solidity docs — Mappings: https://docs.soliditylang.org/en/latest/types.html#mapping-types
- OpenZeppelin v5 — ReentrancyGuard: https://docs.openzeppelin.com/contracts/5.x/api/utils#ReentrancyGuard

## Closing

Neri deploys the protocol and a farmer in Iloilo posts a request: 5,000 pesos' worth of ETH, "binhi para sa tag-ulan" (seeds for the rainy season). Minutes later a lender in Manila funds it — exact amount, straight to the farmer's wallet, the whole exchange logged forever in the loan. No 50% vig, no middleman, no Hackana. "Walang nawawala, lahat nakatala," Neri says. (Nothing goes missing; everything is on the record.) The loan sharks of the barangay just lost their monopoly.
