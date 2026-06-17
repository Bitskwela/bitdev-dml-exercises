# Writing Secured Smart Contracts — The Final Showdown

![30.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_30_writing_secured_smart_contracts/30.0%20-%20COVER.png)

## Scene: The Final Showdown

The battle reaches its peak. Hackana, furious over its inability to breach Neri's defenses, unleashes a catastrophic attack aimed at destabilizing the entire blockchain infrastructure.

As chaos looms, Neri rallies her team one last time. They realize that ultimate security lies not just in technology but in **thoughtful design** — the order you do things in, the assumptions you refuse to make, the checks you never skip.

Together, they craft an unbreachable fortress: a **SecureDonation** contract that withstands even Hackana's most devious exploits. Every wei is accounted for, every caller is verified, and the one trick that has drained more contracts than any other — the **reentrancy attack** — dies at the door.

![30.1 - Writing Secured Smart Contracts](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_30_writing_secured_smart_contracts/30.1.png)

## Why this matters

Smart contracts are **public, immutable, and hold money.** That combination is unforgiving: anyone in the world can read your code and probe it 24/7, you can't patch a deployed bug, and a single flaw is a direct withdrawal from real funds. The 2016 DAO hack drained ~3.6M ETH through *one* reentrancy bug and forced a hard fork of Ethereum itself. Security isn't a final checklist item — it's a mindset that lives in every line.

This lesson distills the non-negotiables into a single contract you'll build: accept donations, let *only* the owner withdraw, and make reentrancy impossible.

## The headline threat: reentrancy

A **reentrancy attack** happens when your contract makes an external call (sending ETH, calling another contract) **before** it finishes updating its own state. The called contract can *call you back* — re-enter the same function — while your books still show the old, pre-update values, and drain you in a loop.

The classic vulnerable withdraw:

```solidity
// ❌ VULNERABLE — sends ETH before zeroing the balance
function withdraw() external {
    uint256 amount = balances[msg.sender];
    (bool ok, ) = msg.sender.call{value: amount}(""); // attacker re-enters HERE
    require(ok, "send failed");
    balances[msg.sender] = 0;                          // ...too late
}
```

When the attacker is a contract, that `call` triggers its `receive()` function, which calls `withdraw()` *again* — and since `balances[msg.sender]` hasn't been zeroed yet, it pays out again. And again. Until the contract is empty.

There are two defenses, and serious contracts use **both**.

## Defense 1 — Checks-Effects-Interactions (CEI)

Order your function in three strict phases. This single discipline kills most reentrancy on its own:

- **Checks** — validate everything first (caller, inputs, balances). Revert early if anything is wrong.
- **Effects** — update your contract's state *next*, while you're still fully in control.
- **Interactions** — talk to the outside world (send ETH, call other contracts) **last**, after your books are already correct.

```solidity
function safeTransfer(address recipient, uint256 amount) public {
    require(balances[msg.sender] >= amount, "Insufficient balance."); // Checks
    balances[msg.sender] -= amount;                                   // Effects
    (bool success, ) = recipient.call{value: amount}("");             // Interactions
    require(success, "Transfer failed.");
}
```

**Why it works:** by the time the external `call` fires, your balance is *already* decremented. A re-entrant call sees the updated state and fails the `require` — the loop is broken before it starts. **Effects before interactions** is the whole trick.

## Defense 2 — `ReentrancyGuard` (defense in depth)

OpenZeppelin's `ReentrancyGuard` adds a **`nonReentrant`** modifier that locks a function while it runs: any attempt to re-enter *any* `nonReentrant` function reverts. It's a belt-and-suspenders backup for the cases CEI alone can miss (e.g. cross-function reentrancy).

```solidity
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract SafeContract is ReentrancyGuard {
    function safeAction() public nonReentrant {
        // The nonReentrant modifier ensures safeAction() cannot be
        // re-entered before its first execution completes — blocking
        // reentrancy even if the logic inside makes an external call.
    }
}
```

> **CRITICAL — the import path changed in OpenZeppelin v5.** `ReentrancyGuard` lives at **`@openzeppelin/contracts/utils/ReentrancyGuard.sol`**. The old `@openzeppelin/contracts/security/ReentrancyGuard.sol` path is **OpenZeppelin v4** and **will not compile** against the v5 this course uses. The same move applies to `Pausable` — it's now under `utils/` too. If a tutorial imports from `security/`, it's outdated; switch to `utils/`.

## Putting it together — Neri's SecureDonation

This is the full contract this lesson builds — `Ownable` for access control, `ReentrancyGuard` for the lock, CEI ordering inside, and a safe ETH transfer:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract SecureDonation is Ownable, ReentrancyGuard {
    uint256 public totalDonations;
    mapping(address => uint256) public donations;

    // v5 Ownable requires the initial owner; deployer becomes owner.
    constructor() Ownable(msg.sender) {}

    function donate() external payable nonReentrant {
        require(msg.value > 0, "Donation must be greater than zero."); // Checks
        donations[msg.sender] += msg.value;                            // Effects
        totalDonations += msg.value;
    }

    function withdraw() external onlyOwner nonReentrant {
        require(totalDonations > 0, "No funds to withdraw.");          // Checks
        uint256 amount = address(this).balance;
        totalDonations = 0;                                            // Effects (before the call)
        (bool success, ) = owner().call{value: amount}("");            // Interactions
        require(success, "Withdrawal failed.");
    }
}
```

Every defensive idea is visible here:

- **`Ownable(msg.sender)`** — v5's required constructor argument; makes the deployer the owner so `onlyOwner` works (Lesson 24).
- **`onlyOwner` on `withdraw`** — only Neri can pull funds. Hackana calling `withdraw` reverts instantly.
- **`nonReentrant` on both functions** — the lock that backstops CEI.
- **CEI ordering** — `totalDonations` is zeroed *before* the external `call`, so a re-entrant `withdraw` sees zero and reverts at the `require`.
- **`.call{value:}("")` + `require(success, ...)`** — see the next section for why this exact form.

## Sending ETH the right way: `.call` over `.transfer`/`.send`

You'll see old guides send ETH with `payable(to).transfer(amount)`. **Don't.** `transfer` and `send` forward a fixed **2300 gas** stipend. That number was hardcoded years ago and broke when gas costs of certain opcodes changed — recipients that are smart contracts (multisigs, smart wallets) can legitimately need more than 2300 gas to accept ETH, so `transfer` reverts on them. It's a compatibility landmine.

The modern best practice is a low-level `call`, which forwards all available gas, **paired with a `require` on the returned success flag**:

```solidity
(bool success, ) = recipient.call{value: amount}("");
require(success, "Transfer failed.");
```

**Key gotcha — `call` returns `false` instead of reverting on failure.** If you ignore the boolean, a failed transfer silently "succeeds" in your code and your accounting drifts from reality. You **must** check it. And because `call` forwards all gas, you **must** pair it with CEI + `nonReentrant` (which the contract above does) so the extra gas can't be turned into a reentrancy weapon.

## More security essentials

- **Lock your pragma.** Use an exact version — `pragma solidity 0.8.26;` — not a floating `^0.8.0`. A floating pragma lets your contract compile under a future compiler whose behavior you never tested, which can subtly change semantics.
- **Validate every input, in every external function.** `require(msg.value > 0, ...)`, bounds checks, address-not-zero checks. Never assume an earlier call already validated.
- **Use access control.** Gate privileged functions with `onlyOwner` (or `AccessControl` roles for finer permissions). An ungated admin function is an open vault.
- **Never authenticate with `tx.origin`.** `tx.origin` is the *original* externally-owned account in the call chain; a malicious intermediary contract can trick a victim into calling it, and your `tx.origin == owner` check passes for the attacker. **Always use `msg.sender`** for authorization.
- **Arithmetic is overflow-safe since 0.8.** No SafeMath needed (and OZ v5 removed it). Plain `a + b` reverts on overflow.
- **Mind the dead patterns.** No `now` (use `block.timestamp`), no `var`, no `throw` (use `revert`/custom errors), no `sha3` (use `keccak256`). If a tutorial uses these, it predates Solidity 0.5 — ignore it.

## Test like an attacker: the modern toolchain

Reading your own code isn't enough; tools find what your eyes miss. The current, maintained toolchain:

- **Slither** (Trail of Bits) — a fast **static analyzer** that flags reentrancy, unchecked calls, bad access control, and dozens of other patterns. Run it on every contract. (`pip install slither-analyzer`, then `slither .`)
- **Foundry** — the standard test framework, and its **fuzzing** is the headline feature: write property tests and Foundry hammers them with thousands of random inputs to find edge cases you'd never hand-write. Pair it with **invariant testing** to assert "this must *always* be true" across random call sequences.
- **Mythril** (optional) — a **symbolic-execution** engine that explores execution paths to surface deeper logic bugs. Heavier than Slither; reach for it when you want a symbolic tool.

> **Note:** older course material recommended *MythX*, a hosted analysis service that has since been discontinued. Use **Slither + Foundry fuzzing** as your baseline (add **Mythril** for symbolic analysis). For anything holding meaningful value, follow tool-based testing with a **professional audit** — tools catch known patterns; auditors catch the novel logic flaws that tools and beginners both miss.

## Common mistakes to avoid

1. **Importing `ReentrancyGuard`/`Pausable` from `security/`.** That's the v4 path and won't compile against v5 — use **`utils/`**.
2. **Interactions before effects.** Sending ETH before updating state is *the* reentrancy bug. Effects always come before interactions.
3. **Ignoring the return value of `.call`.** It returns `false` on failure instead of reverting — always `require(success, ...)`.
4. **Using `.transfer()`/`.send()` as your transfer method.** The 2300-gas stipend breaks contract recipients; prefer `.call` + success check + guards.
5. **Authenticating with `tx.origin`.** Phishable. Use `msg.sender`.
6. **Floating pragma on deployed code.** Pin the exact version.
7. **Skipping `Ownable(msg.sender)` in v5.** The contract won't compile, and without access control `withdraw` would be open to everyone.
8. **Shipping without running Slither / fuzzing.** "It worked in my one happy-path test" is how funds get drained.

## What's next

This lesson is the security capstone of Chapter 1 — you now wield the same defenses that protect real value on mainnet. The themes echo throughout the course: **Lesson 5** introduced `require`/`revert`/`assert` validation (the "Checks" of CEI); **Lesson 24** gave you `Ownable(msg.sender)`; and **Lesson 29** showed why guarding an *upgrade authority* is just access control applied to the most dangerous function of all. Carry the CEI discipline and the Slither-plus-fuzzing habit into every contract you write from here on.

## References

- OpenZeppelin v5 — `ReentrancyGuard` (note the `utils/` path) — https://docs.openzeppelin.com/contracts/5.x/api/utils#ReentrancyGuard
- Solidity docs — Security considerations — https://docs.soliditylang.org/en/latest/security-considerations.html
- Solidity docs — Checks-Effects-Interactions — https://docs.soliditylang.org/en/latest/security-considerations.html#use-the-checks-effects-interactions-pattern
- Slither — https://github.com/crytic/slither
- Foundry Book — fuzz & invariant testing — https://book.getfoundry.sh/forge/fuzz-testing
- Smart Contract Security Field Guide — https://scsfg.io/

## Closing

As Neri's SecureDonation contract goes live, Hackana's final attack begins. Every exploit attempt is met with impenetrable defenses: reentrancy calls bounce off the `nonReentrant` lock and the CEI ordering, input manipulations are rejected by `require`, and `onlyOwner` slams the door on every unauthorized withdrawal. With no vulnerabilities left to exploit, Hackana disintegrates — defeated not by brute force, but by Neri's brilliance and discipline.

The city of San Juan rejoices, its blockchain infrastructure restored and fortified. Neri's journey inspires a new wave of secure development, ensuring a future where trust in technology is unshakable. She stands as a hero — not just for her technical skill, but for her unwavering commitment to a secure digital world.
