# Mini Project #4: Barangay Aid Vault – Protect Against Common Solidity Vulnerabilities

![Barangay Aid Vault](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_3/C3+4.0+-+COVER.png)

## Scene

After Typhoon Ulysses, digital wallets meant for emergency relief in the barangays were attacked. This time, the vulnerabilities weren't reentrancy — but uninitialized ownership, `tx.origin` misuse, and lack of access control.

The **Department of Social Welfare and Development (DSWD)** is asking Neri to build a vault that's not only functional but immune to rookie-level contract exploits that malicious actors use to target underfunded government systems.

![Neri vs Hackers](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_3/C3+4.1.png)

## Why this matters

The first three projects taught you to make things *work*. This one teaches you to make them *unbreakable*. Relief funds are the highest-stakes money a contract can hold: every peso skimmed is aid that never reaches a family rebuilding after a typhoon. Attackers know government systems are underfunded and rushed, so they hunt for the boring, well-documented bugs — the ones a tired developer forgets. This project is a tour of those bugs and their fixes. Master it and you graduate from "Solidity tinkerer" to **security-first smart contract developer** — the kind every serious protocol wants on its team.

## 1. Access control: who is allowed to do what

The starter contract has a fatal flaw — `emergencyWithdraw` has no real owner check, so anyone can drain the vault. The fix is **access control**: restrict privileged functions to a known owner. The professional way is OpenZeppelin's `Ownable`, which is battle-tested, audited, and gives you ownership transfer and renouncement for free.

```solidity
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract BarangayAidVault is Ownable {
    // In v5, Ownable's constructor REQUIRES the initial owner explicitly:
    constructor() Ownable(msg.sender) {}

    function emergencyWithdraw() external onlyOwner {
        // only the owner reaches this line
    }
}
```

**Key gotcha — OpenZeppelin v5 changed the `Ownable` constructor.** In v4 you could write `Ownable()` and it implicitly used `msg.sender`. In **v5 you must pass the initial owner**: `Ownable(msg.sender)`. Forgetting this is a compile error — and a common one when copying old tutorials.

If you roll your own modifier instead of `Ownable`, it looks like this — note it uses `msg.sender`, not `tx.origin`:

```solidity
address public owner;
modifier onlyOwner() {
    require(msg.sender == owner, "Not authorized");
    _;
}
constructor() { owner = msg.sender; }
```

## 2. `tx.origin` vs `msg.sender` — the phishing exploit, explained

This is the heart of the lesson. The starter's `emergencyWithdraw` authenticates with `tx.origin`:

```solidity
require(tx.origin == owner, "Not owner"); // EXPLOITABLE
```

To see why this is catastrophic, you need the difference between the two:

- **`tx.origin`** — the **original externally-owned account (EOA)** that *started* the whole transaction. Always a wallet, never a contract. It does **not** change no matter how many contracts the call passes through.
- **`msg.sender`** — the **immediate caller** of the current function. If a contract calls you, `msg.sender` is *that contract*, not the human behind it.

Here's the attack. Suppose the vault uses `tx.origin == owner`. An attacker deploys a malicious contract and tricks the owner — via a phishing link, a fake airdrop, a "claim your relief funds here" button — into sending it a transaction:

```solidity
// Attacker's contract — looks innocent ("FreeAirdrop")
contract PhishingTrap {
    BarangayAidVault public vault;
    address public attacker;

    constructor(address _vault) { vault = BarangayAidVault(_vault); attacker = msg.sender; }

    // The owner thinks they're "claiming an airdrop"...
    function claimAirdrop() external {
        // ...but this line runs inside the OWNER's transaction:
        vault.emergencyWithdraw();
        // tx.origin is still the owner (they started the tx),
        // so the owner-check PASSES and the vault drains.
    }
}
```

When the owner calls `claimAirdrop()`, the call chain is **owner → PhishingTrap → vault**. Inside `emergencyWithdraw`:

- `tx.origin` is the **owner** (they signed the original transaction) → the check **passes**. The vault drains.
- `msg.sender` would be **PhishingTrap** (the immediate caller) → the check **fails**, exactly as it should.

**The rule is absolute: never use `tx.origin` for authorization. Always `msg.sender`.** The only legitimate uses of `tx.origin` are niche (e.g. refusing all contract callers), and even those are discouraged because they break account-abstraction wallets.

| | `tx.origin` | `msg.sender` |
|---|---|---|
| Who it is | the EOA that started the tx | the immediate caller (could be a contract) |
| Changes through call chain? | no — always the original signer | yes — updates at each hop |
| Safe for auth? | **No** — phishable | **Yes** — use this |

## 3. Proper initialization & input validation

The starter also has **no constructor**, so `owner` defaults to `address(0)` and the contract is born ownerless — a separate flavor of the same disaster. Two fixes, both shown above: set the owner in the constructor (or let `Ownable(msg.sender)` do it), and validate every input.

```solidity
function depositAid(address recipient) external payable {
    require(msg.value > 0, "Cannot send 0 ETH");        // reject dust/spam
    require(recipient != address(0), "Invalid recipient"); // never credit the zero address
    claimable[recipient] += msg.value;
    emit AidDeposited(msg.sender, recipient, msg.value);
}
```

## 4. Safe payout: CEI + `.call`, plus events for auditability

Even a security lesson must pay funds out correctly. `claimAid` follows Checks-Effects-Interactions (zero the balance before sending) and uses `.call` instead of `.transfer()`. Every state-changing function emits an event so DSWD auditors can reconstruct exactly who deposited, who claimed, and when.

```solidity
function claimAid() external nonReentrant {
    uint256 amount = claimable[msg.sender];
    require(amount > 0, "Nothing to claim");

    claimable[msg.sender] = 0; // EFFECTS before INTERACTIONS

    (bool success, ) = payable(msg.sender).call{value: amount}("");
    require(success, "Transfer failed");
    emit AidClaimed(msg.sender, amount);
}
```

## Full reference contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract BarangayAidVault is Ownable, ReentrancyGuard {
    mapping(address => uint256) public claimable;

    event AidDeposited(address indexed donor, address indexed recipient, uint256 amount);
    event AidClaimed(address indexed recipient, uint256 amount);
    event EmergencyWithdrawn(uint256 amount);

    constructor() Ownable(msg.sender) {}

    function depositAid(address recipient) external payable {
        require(msg.value > 0, "Cannot send 0 ETH");
        require(recipient != address(0), "Invalid recipient");
        claimable[recipient] += msg.value;
        emit AidDeposited(msg.sender, recipient, msg.value);
    }

    function claimAid() external nonReentrant {
        uint256 amount = claimable[msg.sender];
        require(amount > 0, "Nothing to claim");

        claimable[msg.sender] = 0;
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");
        emit AidClaimed(msg.sender, amount);
    }

    function emergencyWithdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds");
        (bool success, ) = payable(owner()).call{value: balance}("");
        require(success, "Transfer failed");
        emit EmergencyWithdrawn(balance);
    }
}
```

> With OpenZeppelin `Ownable`, the owner is read via `owner()` (a function), not a public `owner` variable you declared. The starter activity uses a hand-rolled `onlyOwner` + `address public owner`; both are valid, but `Ownable` is the production standard.

## Security & gas notes

- **`msg.sender` for auth, always.** `tx.origin` is phishable through any contract the owner is tricked into calling.
- **Initialize ownership in the constructor.** An ownerless contract (`owner == address(0)`) is either unusable or hijackable.
- **CEI even in "trusted" withdrawals.** Zero state before the external `.call`; the recipient could be hostile.
- **Validate the zero address.** Crediting `address(0)` silently burns funds — no one can ever claim them.
- **Events on every privileged action.** For government-facing money, the audit log is a feature, not a nicety.
- **`Ownable` over hand-rolled.** Less code to get wrong, plus free, tested ownership transfer/renounce.

## Common mistakes to avoid

1. **`tx.origin == owner` for authorization.** The phishing exploit above drains the vault. Use `msg.sender`.
2. **No constructor / uninitialized owner.** Defaults to `address(0)`; set ownership explicitly.
3. **`Ownable()` with no argument on v5.** v5 requires `Ownable(msg.sender)` — won't compile otherwise.
4. **Accepting zero-value or zero-address deposits.** Spam and silent fund-burns; validate both.
5. **Paying out before zeroing the balance.** Reentrancy; follow CEI and add `nonReentrant`.

## What's next

The final project, **SariSari Token**, brings it all together: you'll mint a real ERC-20 token with an enforced supply cap, applying the `Ownable` access control you just learned to gate who can create new tokens.

## References

- Solidity docs — `tx.origin` & security considerations: https://docs.soliditylang.org/en/latest/security-considerations.html#tx-origin
- OpenZeppelin v5 — Ownable / Access Control: https://docs.openzeppelin.com/contracts/5.x/api/access#Ownable
- OpenZeppelin v5 — ReentrancyGuard: https://docs.openzeppelin.com/contracts/5.x/api/utils#ReentrancyGuard
- SWC-115 — Authorization through `tx.origin`: https://swcregistry.io/docs/SWC-115/

## Closing

Neri rewrites the vault and hands DSWD a contract with no soft spots: `msg.sender` auth that phishing can't fool, ownership locked in at deployment, every claim and withdrawal stamped into the log. An attacker deploys a "FreeAidClaim" trap and lures a barangay captain into clicking it — the call arrives as `msg.sender = trap`, the owner check rejects it, and nothing moves. "Ang seguridad, hindi swerte — disenyo." (Security isn't luck — it's design.) The relief funds reach the families they were meant for, every centavo accounted for.
