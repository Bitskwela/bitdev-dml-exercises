# Mini Project #1: Liquidity Lockdown – Neri vs. the Phantom Pool

![Liquidity Lockdown](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_3/C3+1.0+-+COVER.png)

## Scene

The San Juan Digital Payment System thrives, but an emerging threat lurks. Deep in the DeFi underworld, one of Hackana's corrupted DEX protocols—codenamed "_Phantom Pool_"—has resurfaced. It exploits poorly locked liquidity to allow rug-pulls.

Neri, the digital guardian of Pinaglabanan, must deploy a new contract that properly locks liquidity and deters malicious exits. The contract must allow LPs (Liquidity Providers) to deposit tokens and lock them for a fixed time. Withdrawals should only be allowed after the lock period expires.

![Neri vs Phantom Pool](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_3/C3+1.1.png)

The fate of the retail investors in Barangay Blockchain hangs in the balance.

## Why this matters

A "rug-pull" is the oldest trick in DeFi: a team attracts deposits by promising the liquidity is *locked*, then quietly drains it the moment it suits them. The only thing standing between investors and a rug-pull is whether the lock is enforced **by code on the blockchain** or merely promised in a whitepaper.

This is your first project-scale contract — it custodies other people's ETH. That raises the stakes from "does it compile" to "can an attacker steal everything." A liquidity locker that gets the lock right but the *withdrawal* wrong is worse than useless: it advertises safety while leaving the vault door open. By the end of this lesson you'll build a locker that is correct on both halves — the time gate **and** the payout.

## 1. Tracking deposits with a `mapping`

Each LP has their own balance, so we store balances in a `mapping(address => uint256)`. A mapping is a key-value store: give it an address, get back that address's deposited amount. Unset keys default to `0`, which is exactly what we want for someone who never deposited.

```solidity
mapping(address => uint256) public deposits;

function deposit() external payable {
    require(msg.value > 0, "Must deposit ETH");
    deposits[msg.sender] += msg.value; // accumulate, don't overwrite
}
```

**Key gotcha:** use `+=`, not `=`. If an LP deposits twice, `=` would silently erase their first deposit. `+=` accumulates — and in Solidity 0.8.x the `+` reverts automatically on overflow, so you don't need SafeMath.

## 2. Time-locking with `block.timestamp`

Solidity reads the current time from `block.timestamp` — the Unix timestamp (seconds) of the block being mined. To lock for 60 seconds, you record a deadline and compare against it on withdrawal.

```solidity
uint256 public constant LOCK_PERIOD = 60; // seconds

function withdraw() external {
    require(block.timestamp >= unlockTime[msg.sender], "Still locked");
    // ...
}
```

**Per-user vs. shared lock — a real design bug.** A naïve locker keeps a single `lockEnd` that every deposit overwrites:

```solidity
// FLAWED: one shared deadline for everyone
uint256 public lockEnd;
function deposit() external payable {
    deposits[msg.sender] += msg.value;
    lockEnd = block.timestamp + 60; // any new depositor re-locks EVERYONE
}
```

The problem: if Alice deposits and her 60 seconds nearly elapse, then Bob deposits, Bob's call resets the *global* `lockEnd` and re-locks Alice's funds. A griefer could deposit 1 wei every 59 seconds and freeze the whole pool forever. The fix is a **per-user** unlock time:

```solidity
mapping(address => uint256) public unlockTime;

function deposit() external payable {
    require(msg.value > 0, "Must deposit ETH");
    deposits[msg.sender] += msg.value;
    unlockTime[msg.sender] = block.timestamp + LOCK_PERIOD;
}
```

> **On miner influence:** validators can nudge `block.timestamp` by a few seconds, so don't use it for sub-minute precision or as a randomness source. For lock periods measured in minutes, hours, or days it's perfectly fine.

## 3. Paying ETH out safely — never `.transfer()`

This is the single most important lesson in the project. The old tutorials you'll find online send ETH like this:

```solidity
payable(msg.sender).transfer(amount); // DON'T — see below
```

`.transfer()` (and `.send()`) forward a hardcoded **2300 gas** stipend. That number was chosen years ago and is now a liability: after gas-cost repricings (EIP-1884 and others), a recipient that is a smart contract — a multisig like Safe, a smart-contract wallet, an account-abstraction (ERC-4337) account — can legitimately need *more* than 2300 gas in its `receive()` function. With `.transfer()`, those withdrawals **revert forever**. Your LP's funds get stuck not because of an attack, but because you used a deprecated primitive.

The modern, correct way is a low-level `.call` with no gas cap, and you **must** check the returned success flag:

```solidity
(bool success, ) = payable(msg.sender).call{value: amount}("");
require(success, "ETH transfer failed");
```

| Method | Gas forwarded | Reverts on failure? | Verdict |
|---|---|---|---|
| `.transfer()` | 2300 (fixed) | yes | Deprecated — breaks for contract recipients |
| `.send()` | 2300 (fixed) | no (returns `false`) | Dangerous — easy to ignore the `false` |
| `.call{value: x}("")` | all remaining | no (returns `bool`) | **Correct** — forward the success check yourself |

The catch: because `.call` forwards all gas, it re-opens the door to **reentrancy** — which the next section closes.

## 4. Checks-Effects-Interactions + ReentrancyGuard

Reentrancy is the attack that drained The DAO of $60M in 2016. When you `.call` an external address, that address can be a contract whose `receive()` function calls *back* into your `withdraw()` before your first call finishes — and if you haven't zeroed their balance yet, they withdraw again, and again, draining the pool.

The defense is **Checks-Effects-Interactions (CEI)**: do all your validation (Checks), then update your storage (Effects), and only *then* talk to the outside world (Interactions). If you zero the balance *before* the `.call`, the re-entrant call sees a balance of `0` and reverts.

```solidity
function withdraw() external nonReentrant {
    // CHECKS
    require(block.timestamp >= unlockTime[msg.sender], "Still locked");
    uint256 amount = deposits[msg.sender];
    require(amount > 0, "No funds");

    // EFFECTS — zero the balance BEFORE sending
    deposits[msg.sender] = 0;

    // INTERACTIONS — external call comes last
    (bool success, ) = payable(msg.sender).call{value: amount}("");
    require(success, "ETH transfer failed");
}
```

For belt-and-suspenders safety, also add OpenZeppelin's `ReentrancyGuard`. Its `nonReentrant` modifier flips a storage lock that makes any re-entrant call revert outright — defense in depth on top of CEI.

```solidity
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract LiquidityLocker is ReentrancyGuard {
    // ...withdraw() uses the nonReentrant modifier above
}
```

## Full reference contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract LiquidityLocker is ReentrancyGuard {
    uint256 public constant LOCK_PERIOD = 60; // seconds

    mapping(address => uint256) public deposits;
    mapping(address => uint256) public unlockTime;

    event Deposited(address indexed lp, uint256 amount, uint256 unlockTime);
    event Withdrawn(address indexed lp, uint256 amount);

    function deposit() external payable {
        require(msg.value > 0, "Must deposit ETH");
        deposits[msg.sender] += msg.value;
        unlockTime[msg.sender] = block.timestamp + LOCK_PERIOD;
        emit Deposited(msg.sender, msg.value, unlockTime[msg.sender]);
    }

    function withdraw() external nonReentrant {
        require(block.timestamp >= unlockTime[msg.sender], "Still locked");
        uint256 amount = deposits[msg.sender];
        require(amount > 0, "No funds");

        deposits[msg.sender] = 0; // Effects before Interactions

        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "ETH transfer failed");

        emit Withdrawn(msg.sender, amount);
    }
}
```

> The activity starter uses a single shared `lockEnd` and `.transfer()`. Your task there is to make `deposit`/`withdraw` work; this material shows you the production-grade version. When you graduate to mainnet, the per-user lock, `.call` + success check, and CEI are non-negotiable.

## Security & gas notes

- **Atomicity is your friend.** Every `require` that fails reverts the whole transaction and refunds remaining gas. An attacker pays gas to probe your guards and gets nothing.
- **Emit events on state changes.** `Deposited`/`Withdrawn` give LPs and block explorers an auditable trail — essential for a contract that holds funds.
- **`constant` for fixed values.** `LOCK_PERIOD` as `constant` is baked into bytecode (no storage read), saving gas on every call.
- **Don't trust the recipient.** The `.call` hands control to an arbitrary address. CEI + `nonReentrant` ensures your state is already final before that happens.
- **Integer overflow is handled.** Solidity 0.8.x reverts on overflow by default — no SafeMath, no `unchecked` unless you've proven it's safe.

## Common mistakes to avoid

1. **Using `.transfer()` or `.send()`.** Hardcoded 2300 gas breaks for contract recipients. Use `.call` + `require(success)`.
2. **A single global `lockEnd`.** Lets one depositor re-lock everyone. Use a per-user `unlockTime` mapping.
3. **Sending before zeroing the balance.** Classic reentrancy. Effects (zero the balance) must come before Interactions (the `.call`).
4. **Overwriting deposits with `=`.** Use `+=` so repeat deposits accumulate.
5. **Ignoring the `.call` return value.** A silent failed transfer leaves the user thinking they were paid. Always `require(success)`.

## What's next

Next is **Staking the Future**, where you'll lock *ERC-20 tokens* instead of raw ETH — which means learning `IERC20`, `SafeERC20`, and why an unchecked token `transfer` is a bug waiting to happen.

## References

- Solidity docs — Sending and receiving Ether: https://docs.soliditylang.org/en/latest/security-considerations.html#sending-and-receiving-ether
- Solidity docs — Units & global variables (`block.timestamp`): https://docs.soliditylang.org/en/latest/units-and-global-variables.html#block-and-transaction-properties
- OpenZeppelin v5 — ReentrancyGuard: https://docs.openzeppelin.com/contracts/5.x/api/utils#ReentrancyGuard
- ConsenSys — Reentrancy & the Checks-Effects-Interactions pattern: https://consensys.github.io/smart-contract-best-practices/attacks/reentrancy/

## Closing

Neri deploys the locker and watches Phantom Pool's bots probe it: deposit, then a withdrawal one block later — reverted, "Still locked." A contract recipient tries to re-enter mid-payout — reverted, the balance already zeroed. "Hindi mananakaw ang hindi mo mabubuksan," she murmurs. (You can't steal what you can't open.) The retail investors of Barangay Blockchain sleep soundly; their liquidity is locked by math, not by promises.
