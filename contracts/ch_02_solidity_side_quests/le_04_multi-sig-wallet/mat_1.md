# Side Quest 4: Multi-Signature Wallet

![Multi-Signature Wallet](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_2/C2+4.0+-+COVER.png)

## Scene

The digital governance of San Juan is in chaos. Hackana's minions struck again—this time targeting trust among the city's digital board of directors. Important transfers of development funds are stalled, unable to proceed without consensus.

![Neri the Blockchain Defender](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_2/C2+4.1.png)

Neri, the legendary engineer, must restore order by building a _multi-signature wallet_ — a contract that requires majority approval from board members before any critical transaction can be executed. This time, trust must be enforced not by people, but by code.

**Time Allotment**: 20 minutes
**Solidity Topics Covered**: Multisig Wallets, Threshold Approval Logic, Access Control.

## Why this matters

A normal wallet has a single private key. Whoever holds it has total power — and a single point of failure. If that one key is phished, lost, or its owner goes rogue, every peso in the treasury is gone. That's unacceptable for a city's development fund, a DAO treasury, or a startup's reserves.

A **multi-signature (multisig) wallet** fixes this by requiring **M-of-N** approvals: of `N` authorized signers, at least `M` must agree before any transfer executes. Compromise one key and nothing happens — the attacker still needs M-1 more. This is how nearly every serious on-chain treasury is custodied today (Gnosis Safe being the canonical example). Neri's job is to encode that consensus rule so funds move *only* when the board genuinely agrees.

## The three-step flow

A multisig turns "send money" into a small workflow with three distinct actions:

1. **Propose** — a signer registers an intended transfer (recipient + amount). It's recorded but *not* executed.
2. **Approve** — other signers vote on it. Each signer can approve a given proposal at most once.
3. **Execute** — once approvals reach the threshold, anyone can trigger the actual transfer.

Separating these stages is the whole point: no single signer can move funds alone, and every approval is recorded on-chain for anyone to audit.

## The data structures

We need to know *who* may sign, *how many* approvals are required, and *what* has been proposed.

```solidity
address[] public signers;            // the N board members
uint256 public approvalThreshold;    // the M required to execute
mapping(address => bool) public isSigner; // O(1) "is this address a signer?"

struct Transaction {
    address to;
    uint256 value;
    uint256 approvals;   // running tally
    bool executed;       // prevents double-spend
}

Transaction[] public transactions;
// proposal id => signer => has this signer already approved?
mapping(uint256 => mapping(address => bool)) public approved;
```

Two design choices worth calling out:

- **`isSigner` mapping alongside the `signers` array.** The array lets us *list* signers; the mapping lets us *check membership in O(1)* without looping. Looping over an array to check membership wastes gas and can hit the block gas limit if the list grows.
- **The nested `approved` mapping** records each signer's vote per proposal, so we can enforce "one vote per signer per transaction."

### The constructor sets the rules at deploy time

```solidity
constructor(address[] memory _signers, uint256 _threshold) {
    require(_threshold <= _signers.length, "Threshold too high");

    for (uint256 i = 0; i < _signers.length; i++) {
        isSigner[_signers[i]] = true;
    }
    signers = _signers;
    approvalThreshold = _threshold;
}
```

The `require(_threshold <= _signers.length)` guard is essential: a threshold higher than the number of signers would make the wallet **permanently unable to execute anything** — funds locked forever. (A production wallet would also `require(_threshold > 0)` so it can't execute with *zero* approvals, and guard against duplicate signer addresses, which would let one person register two votes.)

## 1. Propose — gated to signers only

```solidity
function proposeTransaction(address _to, uint256 _value) public {
    require(isSigner[msg.sender], "Not authorized");
    transactions.push(
        Transaction({to: _to, value: _value, approvals: 0, executed: false})
    );
}
```

Only a signer may propose. The proposal starts with `0` approvals and `executed = false`, and its index in the `transactions` array becomes its `txId`.

## 2. Approve — one signer, one vote, once

```solidity
function approveTransaction(uint256 txId) public {
    require(isSigner[msg.sender], "Not authorized");        // must be a signer
    require(!approved[txId][msg.sender], "Already approved"); // can't vote twice
    require(!transactions[txId].executed, "Already executed"); // can't vote on a done deal

    approved[txId][msg.sender] = true;
    transactions[txId].approvals++;
}
```

Each `require` blocks a specific abuse:

- **`isSigner`** — outsiders can't influence the vote.
- **`!approved[txId][msg.sender]`** — a single signer can't pump the tally by approving repeatedly. *This is the line people forget*, and without it the whole M-of-N guarantee collapses — one signer could approve `M` times and execute alone.
- **`!executed`** — no point approving something already done.

## 3. Execute — only when consensus is reached

```solidity
function executeTransaction(uint256 txId) public {
    Transaction storage txn = transactions[txId];
    require(!txn.executed, "Already executed");                  // Checks
    require(txn.approvals >= approvalThreshold, "Not enough approvals");

    txn.executed = true;                                         // Effects (FIRST)

    (bool success, ) = txn.to.call{value: txn.value}("");        // Interactions (LAST)
    require(success, "Transaction failed");
}
```

This function is where the reentrancy lesson pays off. Look at the ordering: we set **`txn.executed = true` *before* the external `call`**. That's Checks-Effects-Interactions in action. If the recipient is a malicious contract that re-enters `executeTransaction(txId)`, the re-entrant call hits `require(!txn.executed)` — which is now `true` — and reverts. Without that ordering, a hostile recipient could drain the wallet by re-executing the same approved transaction in a loop. We also use **`.call{value:}("")` with a `success` check**, never `.transfer()`/`.send()`.

## Putting it together

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract MultiSigWallet {
    address[] public signers;
    uint256 public approvalThreshold;
    mapping(address => bool) public isSigner;

    struct Transaction {
        address to;
        uint256 value;
        uint256 approvals;
        bool executed;
    }

    Transaction[] public transactions;
    mapping(uint256 => mapping(address => bool)) public approved;

    constructor(address[] memory _signers, uint256 _threshold) {
        require(_threshold <= _signers.length, "Threshold too high");
        for (uint256 i = 0; i < _signers.length; i++) {
            isSigner[_signers[i]] = true;
        }
        signers = _signers;
        approvalThreshold = _threshold;
    }

    function proposeTransaction(address _to, uint256 _value) public {
        require(isSigner[msg.sender], "Not authorized");
        transactions.push(Transaction({to: _to, value: _value, approvals: 0, executed: false}));
    }

    function approveTransaction(uint256 txId) public {
        require(isSigner[msg.sender], "Not authorized");
        require(!approved[txId][msg.sender], "Already approved");
        require(!transactions[txId].executed, "Already executed");
        approved[txId][msg.sender] = true;
        transactions[txId].approvals++;
    }

    function executeTransaction(uint256 txId) public {
        Transaction storage txn = transactions[txId];
        require(!txn.executed, "Already executed");
        require(txn.approvals >= approvalThreshold, "Not enough approvals");
        txn.executed = true;
        (bool success, ) = txn.to.call{value: txn.value}("");
        require(success, "Transaction failed");
    }

    receive() external payable {} // lets the wallet hold ETH
}
```

The `receive()` function lets the wallet *hold* ETH so it has something to send when a transaction executes.

## Security focus

| Threat | Defense in this contract |
|---|---|
| Outsider moves funds | `require(isSigner[msg.sender])` on propose & approve |
| One signer fakes consensus | `require(!approved[txId][msg.sender])` — one vote each |
| Same transaction executed twice | `require(!txn.executed)` + set `executed = true` first |
| Reentrancy via recipient | Checks-Effects-Interactions ordering in `executeTransaction` |
| Funds locked forever | `require(_threshold <= signers.length)` (and, ideally, `> 0`) |

## Common mistakes to avoid

1. **Forgetting the one-vote-per-signer check.** Without `!approved[txId][msg.sender]`, a lone signer can reach the threshold alone — the entire multisig is defeated.
2. **Setting `executed` *after* the call.** Same shape as the reentrancy bug from the last lesson; set the flag *before* sending funds.
3. **Threshold of 0 or greater than the signer count.** Zero lets anyone execute with no approvals; too-high locks the wallet permanently.
4. **Duplicate signer addresses in the constructor.** The same person registered twice can cast two "independent" votes — validate uniqueness on setup.
5. **Looping over the signers array to check membership.** Use the `isSigner` mapping for O(1) checks; large arrays can exceed the gas limit.
6. **Trusting `.call` blindly.** Always `require(success, ...)` — a failed send must revert the execution, not silently mark the transaction done.
7. **Hand-rolling instead of using a battle-tested safe.** This is a teaching implementation. For real treasuries, use an audited solution like **Gnosis Safe** rather than deploying your own.

## What's next

You've completed the Solidity side quests — token approvals, NFT minting, reentrancy defense, and now consensus-gated treasuries. These four are the security patterns auditors look for first. From here, the mini-projects chapter combines them into full dApps, where you'll wire these contracts to a frontend and watch real users interact with them.

## References

- Solidity by Example — Multi-Sig Wallet — https://solidity-by-example.org/app/multi-sig-wallet/
- Gnosis Safe (production multisig) — https://docs.safe.global/
- Solidity docs — Members of address (`.call`) — https://docs.soliditylang.org/en/latest/types.html#members-of-addresses
- OpenZeppelin v5 — Access Control — https://docs.openzeppelin.com/contracts/5.x/access-control

## Closing

Neri deploys the `MultiSigWallet` with the board's five keys and a threshold of three. A development-fund transfer is proposed; the approvals trickle in — one, two, three — and only then does the ETH move, exactly where the board agreed it should. No single hand, not even a compromised one, can move a single wei alone. "Ang tiwala, hinati sa marami; ang lakas, mula sa pagkakaisa." (Trust, divided among many; strength, from agreement.) San Juan's governance runs on consensus again — enforced not by people, but by code.
