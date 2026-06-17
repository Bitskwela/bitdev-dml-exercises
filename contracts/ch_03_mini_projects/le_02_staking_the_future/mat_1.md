# Mini Project #2: Staking the Future – Neri and the Farmers of Yield

![Staking the Future](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_3/C3+2.0+-+COVER.png)

## Scene

Hackana's bugs once devastated crypto farms in Pampanga, wiping out yield farming operations. With the country stabilizing, farmers are re-entering DeFi to grow wealth sustainably.

![Neri and the Farmers](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_3/C3+2.1.png)

Neri must build a simple yet secure staking contract: users stake tokens, and after a set duration, they can withdraw with a 10% yield bonus. It's time to rebuild the Filipino DeFi farming ecosystem—one stake at a time.

## Why this matters

Staking is the engine room of DeFi. Users lock a token, time passes, and they withdraw more than they put in. Sounds simple — but a staking contract that moves ERC-20 tokens has a whole new class of footguns that ETH contracts don't. The biggest one: **not every ERC-20 token behaves the same way.** Some return `false` on a failed transfer instead of reverting. Some (famously USDT) don't return a `bool` at all. A staking contract that assumes every token plays by the rules will silently lose funds the day it touches a non-conforming token.

This project teaches you to handle tokens *defensively* — the way every audited protocol does — using OpenZeppelin's `IERC20` and `SafeERC20`. You'll also confront the question every reward contract must answer: **where do the rewards actually come from?**

## 1. Talking to a token: `IERC20`

Your staking contract doesn't *contain* the token — the token is its own deployed contract (here, `SanJuanToken`, an OpenZeppelin ERC-20). To move tokens, your contract calls the token contract through its interface, `IERC20`.

Use OpenZeppelin's canonical interface, not a hand-rolled one:

```solidity
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

IERC20 public stakingToken;

constructor(address _token) {
    stakingToken = IERC20(_token);
}
```

The two functions that matter for staking:

- `transferFrom(from, to, amount)` — pulls tokens *from a user into your contract*. Requires the user to have **approved** your contract first (more below).
- `transfer(to, amount)` — sends tokens *out of your contract* to a user.

## 2. The `approve` → `transferFrom` handshake

You can't just grab a user's tokens. ERC-20 uses a two-step **allowance** model:

1. The user calls `token.approve(stakingContract, amount)` — "I permit the staking contract to move up to `amount` of my tokens."
2. Your contract calls `token.transferFrom(user, address(this), amount)` — which succeeds only up to the approved allowance.

```solidity
function stake(uint256 amount) external {
    require(amount > 0, "Nothing to stake");
    // pulls `amount` from msg.sender — requires prior approve()
    stakingToken.safeTransferFrom(msg.sender, address(this), amount);
    stakes[msg.sender] = Stake(amount, block.timestamp + LOCK_DURATION);
}
```

**Key gotcha:** if a user forgets to `approve` first, `transferFrom` reverts. That's a frontend/UX concern, not a contract bug — but you should document it. Also note `address(this)` is the staking contract's own address: it's where the staked tokens are custodied.

## 3. `SafeERC20` — why unchecked `transfer` is a bug

Here's the trap the activity starter falls into:

```solidity
// FLAWED — the return value is ignored
stakingToken.transfer(msg.sender, reward);
```

The ERC-20 standard says `transfer` returns a `bool`. A well-behaved token returns `false` (instead of reverting) when a transfer can't complete. If you ignore that `bool`, your contract **believes the user was paid when they weren't** — it'll happily `delete` their stake and move on, and the tokens never arrived. Worse, some real-world tokens (USDT, BNB) don't return a `bool` at all, so a strict `require(token.transfer(...))` reverts on a *successful* transfer.

OpenZeppelin's `SafeERC20` library solves both problems. Its `safeTransfer` / `safeTransferFrom` wrappers:

- check the return value and revert if it's `false`, and
- tolerate non-standard tokens that return no value.

```solidity
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract SimpleStaker {
    using SafeERC20 for IERC20; // attaches safe* methods to IERC20 values

    IERC20 public stakingToken;
    // ...
    stakingToken.safeTransfer(msg.sender, reward);          // out
    stakingToken.safeTransferFrom(msg.sender, address(this), amount); // in
}
```

| Call | Checks return value? | Handles non-standard tokens? | Use it? |
|---|---|---|---|
| `token.transfer(...)` (unchecked) | no | no | Never |
| `require(token.transfer(...))` | yes | no (reverts on USDT) | No |
| `token.safeTransfer(...)` | yes | yes | **Always** |

## 4. Time-based rewards — and where they come from

The reward is the stake plus a 10% bonus, gated behind a lock period:

```solidity
uint256 public constant LOCK_DURATION = 60; // seconds
uint256 public constant REWARD_BPS = 11_000; // 110.00% in basis points

function unstake() external nonReentrant {
    Stake memory userStake = stakes[msg.sender];
    require(userStake.amount > 0, "Nothing staked");
    require(block.timestamp >= userStake.unlockTime, "Still locked");

    uint256 payout = (userStake.amount * REWARD_BPS) / 10_000; // 110%
    delete stakes[msg.sender];               // Effects before Interactions
    stakingToken.safeTransfer(msg.sender, payout);
}
```

**The reward-funding gotcha — this is the one people miss.** If a user stakes 100 tokens, the contract holds exactly 100. But `unstake` tries to pay out **110**. Where do the extra 10 come from? They don't appear by magic — *someone must have pre-funded the contract with reward tokens.* If nobody did, `safeTransfer` reverts (insufficient balance) and the user can't even get their principal back. A real protocol funds a reward reserve up front (the project owner transfers, say, 1,000,000 SJMM into the contract at deploy time) and tracks it. Never write a reward contract whose math promises tokens the contract doesn't hold.

**Basis points over `* 110 / 100`.** Integer math truncates, so always multiply before dividing. Expressing the rate in basis points (`11_000 / 10_000`) makes the precision explicit and lets you express rates like 110.25% without fractions.

## 5. Reuse the locker discipline: CEI + `nonReentrant`

Even though we're moving ERC-20 tokens (not raw ETH), the same Checks-Effects-Interactions rule applies. `safeTransfer` is an external call into the token contract; a malicious or hook-bearing token (e.g. an ERC-777-style token with transfer callbacks) could re-enter `unstake`. So we `delete stakes[msg.sender]` **before** the transfer, and add `nonReentrant` for defense in depth.

```solidity
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
contract SimpleStaker is ReentrancyGuard { /* unstake() uses nonReentrant */ }
```

## Full reference contract

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract SimpleStaker is ReentrancyGuard {
    using SafeERC20 for IERC20;

    IERC20 public immutable stakingToken;
    uint256 public constant LOCK_DURATION = 60;  // seconds
    uint256 public constant REWARD_BPS = 11_000; // 110.00%

    struct Stake {
        uint256 amount;
        uint256 unlockTime;
    }

    mapping(address => Stake) public stakes;

    event Staked(address indexed user, uint256 amount, uint256 unlockTime);
    event Unstaked(address indexed user, uint256 payout);

    constructor(address _token) {
        stakingToken = IERC20(_token);
    }

    function stake(uint256 amount) external {
        require(amount > 0, "Nothing to stake");
        stakingToken.safeTransferFrom(msg.sender, address(this), amount);
        stakes[msg.sender] = Stake(amount, block.timestamp + LOCK_DURATION);
        emit Staked(msg.sender, amount, block.timestamp + LOCK_DURATION);
    }

    function unstake() external nonReentrant {
        Stake memory userStake = stakes[msg.sender];
        require(userStake.amount > 0, "Nothing staked");
        require(block.timestamp >= userStake.unlockTime, "Still locked");

        uint256 payout = (userStake.amount * REWARD_BPS) / 10_000;
        delete stakes[msg.sender];                 // Effects
        stakingToken.safeTransfer(msg.sender, payout); // Interactions
        emit Unstaked(msg.sender, payout);
    }
}
```

## Security & gas notes

- **`SafeERC20` is mandatory.** Unchecked token transfers are the most common silent-loss bug in DeFi. `using SafeERC20 for IERC20` gives you safe methods for free.
- **Pre-fund the reward reserve.** Rewards are real tokens that must exist in the contract. Don't promise yield you haven't funded.
- **`immutable` for the token address.** Set once in the constructor, never changeable — cheaper to read than storage and removes a rug-pull vector (no swapping in a fake token).
- **`delete` before transfer.** Clears the stake (refunding some gas) *and* enforces CEI in one move.
- **One stake per user.** This simple model overwrites a user's existing stake on a second `stake()`. A production contract would either reject a second stake or track multiple positions — decide deliberately, don't leave it ambiguous.
- **Multiply before divide.** `(amount * 11_000) / 10_000`, never `amount / 10_000 * 11_000` — the latter truncates to zero for small amounts.

## Common mistakes to avoid

1. **Ignoring `transfer`/`transferFrom` return values.** Use `safeTransfer`/`safeTransferFrom`.
2. **Assuming tokens are already in the contract for rewards.** The 10% bonus must be pre-funded or `unstake` reverts.
3. **Forgetting the `approve` step.** `transferFrom` needs a prior allowance; surface this in your dApp UX.
4. **Dividing before multiplying** when computing the reward — integer truncation eats the yield.
5. **Skipping CEI on token payouts.** Hook-bearing tokens can re-enter; `delete` the stake before transferring.

## What's next

Next is the **Iloilo Barangay Lending Protocol**, where you'll model loans as `struct`s in a mapping, emit `event`s for every action, and route ETH between borrowers and lenders — applying the same payout discipline to a peer-to-peer marketplace.

## References

- OpenZeppelin v5 — ERC-20 & SafeERC20: https://docs.openzeppelin.com/contracts/5.x/api/token/erc20#SafeERC20
- OpenZeppelin v5 — IERC20: https://docs.openzeppelin.com/contracts/5.x/api/token/erc20#IERC20
- Solidity docs — Using `using ... for`: https://docs.soliditylang.org/en/latest/contracts.html#using-for
- Solidity by Example — ERC-20: https://solidity-by-example.org/app/erc20/

## Closing

Neri funds the reward reserve from the cooperative's treasury, then opens staking. A farmer in Pampanga stakes 100 SJMM, waits out the lock, and withdraws 110 — the extra ten drawn from the reserve, not from thin air. A bot tries to unstake early: "Still locked." A weird fee-on-transfer token tries to sneak in: `safeTransferFrom` catches the mismatch and reverts. "Tama ang pananim, tama ang ani," she says. (Plant it right, harvest it right.) The yield farms of the Philippines are growing again — on rails that don't break.
