# Understanding OpenZeppelin — Standing on Audited Shoulders

![24.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_24_understanding-openzeppelin/24.0%20-%20COVER.png)

## Scene

After tirelessly building strategies against Hackana, Neri stumbles upon a repository of tools shared by blockchain protectors worldwide—the **OpenZeppelin** library.

It's a treasure trove of reusable, battle-tested contracts that can help her implement security protocols faster. Every line has been read by hundreds of auditors and deployed on contracts holding billions in value. Why hand-roll an ERC20 token — and risk a typo that drains the community fund — when the safest version on Earth is one `import` away?

Eager to level up her defenses, Neri realizes that OpenZeppelin might hold the secret to countering Hackana's next big attack. In this lesson she'll mint the **DefenseToken**, the currency that will rebuild San Juan — built on code she didn't have to audit herself.

![24.1 - OpenZeppelin](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_24_understanding-openzeppelin/24.1.png)

## Why this matters

Smart contracts are **immutable and hold real money**. A single overlooked edge case in a token's `transfer` logic isn't a bug ticket — it's a permanent, on-chain hole that anyone in the world can exploit, forever. The history of DeFi is littered with eight-figure losses from contracts that re-implemented standard logic and got one line wrong.

OpenZeppelin solves this by giving you **reference implementations of the ERC standards** that are:

- **Audited** — reviewed by professional auditors and battle-tested across thousands of live deployments.
- **Standard-compliant** — they implement the exact behavior wallets, exchanges, and explorers expect, so your token "just works" everywhere.
- **Extensible** — you inherit the base and add only your custom behavior, instead of copy-pasting hundreds of lines you now have to maintain.

The rule of professional Solidity is simple: **don't write what OpenZeppelin already wrote.** Your job is the business logic on top.

> **A note on this lesson's version.** This course targets **Solidity 0.8.26** and **OpenZeppelin Contracts v5**. v5 changed several APIs from the v4 tutorials you'll find scattered around the web — most importantly, `Ownable` now *requires* an initial-owner argument. The code below is correct for v5. When you read other guides, check whether they're v4 or v5; mixing them is the most common reason a beginner's contract won't compile.

## 1. Importing — pull the implementation in

You bring an OpenZeppelin contract into your file with a normal import. The `@openzeppelin/contracts/` prefix resolves to the installed npm package.

```solidity
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
```

**Use named imports (`{ERC20}`) instead of the bare `import "..."` form.** Named imports pull in only the symbols you reference, keep your namespace clean, and make it obvious where each contract came from — exactly the style OpenZeppelin v5 itself uses.

**Key gotcha — the path is the version.** `@openzeppelin/contracts/...` is the *standard* (non-upgradeable) package. There is a separate `@openzeppelin/contracts-upgradeable/...` package for proxy-based contracts (Lesson 29). They are *not* interchangeable — importing the wrong one is a classic source of confusing errors.

## 2. Extending — inherit and add

You don't instantiate an OpenZeppelin contract; you **inherit** from it with `is` and add your own logic. Here is the full DefenseToken:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract HackanaDefenseToken is ERC20 {
    constructor() ERC20("DefenseToken", "DEF") {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }
}
```

Three things are happening:

- **`is ERC20`** — `HackanaDefenseToken` *becomes* a fully functional ERC20. It inherits `transfer`, `approve`, `transferFrom`, `balanceOf`, `totalSupply`, the `Transfer`/`Approval` events — everything the standard requires.
- **`ERC20("DefenseToken", "DEF")`** — you call the parent's constructor to set the token's **name** and **symbol**. This is required; `ERC20` has no default constructor.
- **`_mint(msg.sender, 1000 * 10 ** decimals())`** — the internal `_mint` function creates new tokens and credits them to an address. Here it gives the **deployer** (`msg.sender`) the initial supply.

**Why `10 ** decimals()`?** ERC20 has no decimal point — balances are integers. `decimals()` returns `18` by default, meaning the token uses 18 places of precision (like ETH's wei). So "1000 whole tokens" is stored as `1000 * 10**18`. Writing `_mint(msg.sender, 1000)` would mint a thousand *millionths-of-a-millionth* of a token — almost nothing. Always scale your human-readable amount by `10 ** decimals()`.

**Key gotcha — `_mint` is internal.** It has a leading underscore because it's *not* meant to be called from outside. If you want a public minting endpoint, you wrap it in your own function and guard it (see the next section) — never expose `_mint` directly, or anyone could print unlimited supply.

## 3. Access control — `Ownable` and the v5 constructor

Most contracts need privileged functions: pause trading, mint more tokens, withdraw fees. OpenZeppelin's `Ownable` gives you a single owner address and an `onlyOwner` modifier for free.

```solidity
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract SecureContract is Ownable {
    // In OpenZeppelin v5, Ownable REQUIRES an initial owner argument.
    constructor() Ownable(msg.sender) {}

    function restrictedAction() external onlyOwner {
        // Only the contract owner can call this.
    }
}
```

> **THE v5 GOTCHA — read this twice.** In OpenZeppelin **v5**, `Ownable` has **no default constructor**. You **must** pass the initial owner explicitly: `constructor() Ownable(msg.sender) {}`. Old v4 tutorials wrote just `contract X is Ownable {}` with no constructor — that **will not compile against v5** and produces a confusing "no arguments" error. Passing `msg.sender` makes the deployer the owner; passing any other address transfers ownership at deployment.

To combine a token with ownership, list both parents and call both constructors:

```solidity
contract MintableToken is ERC20, Ownable {
    constructor() ERC20("DefenseToken", "DEF") Ownable(msg.sender) {}

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount); // safely wrapped: only the owner can call it
    }
}
```

`onlyOwner` reverts for anyone who isn't the current owner, so Hackana can't print tokens even if it finds the function.

## The OpenZeppelin toolbox at a glance

| You need… | Import from | What you inherit |
|---|---|---|
| A fungible currency | `token/ERC20/ERC20.sol` | balances, transfers, allowances |
| An NFT | `token/ERC721/ERC721.sol` | unique-token ownership |
| Multi-token (items + currency) | `token/ERC1155/ERC1155.sol` | batched fungible + NFT (Lesson 28) |
| A single admin | `access/Ownable.sol` | `owner()`, `onlyOwner` |
| Many roles (MINTER, PAUSER…) | `access/AccessControl.sol` | role-based permissions |
| An emergency stop | `utils/Pausable.sol` | `whenNotPaused`, `_pause()` |
| Reentrancy protection | `utils/ReentrancyGuard.sol` | `nonReentrant` (Lesson 30) |

Notice `ReentrancyGuard` and `Pausable` live under `utils/` in v5 — **not** the old `security/` path from v4.

## Security & gas notes

- **You no longer need SafeMath.** Old guides list "overflow protection via SafeMath" as a reason to use OpenZeppelin. That is obsolete: **since Solidity 0.8.0, arithmetic reverts on overflow/underflow automatically**, and OpenZeppelin **removed the `SafeMath` library entirely in v5**. Importing it is a v4 relic. Plain `a + b` is already overflow-safe.
- **Inheriting is cheaper to maintain, not always cheaper in gas.** OZ code is general-purpose; a hyper-optimized hand-rolled version *can* use less gas. But for 99% of contracts the audited safety is worth far more than the marginal gas — reach for OZ first, optimize only if profiling proves you need to.
- **Pin your pragma.** This course pins to `pragma solidity 0.8.26;` (an exact version, no `^`). A floating pragma like `^0.8.0` lets the contract compile under a future compiler whose behavior you never tested. For anything you deploy, **lock the exact compiler version** so the bytecode is reproducible. (More on this in Lesson 30.)

## Common mistakes to avoid

1. **Omitting `Ownable(msg.sender)` in v5.** The #1 beginner error against OpenZeppelin v5. No-arg `Ownable` is a v4 pattern and won't compile.
2. **Listing SafeMath as a reason to use OZ.** It's gone in v5 and unnecessary since 0.8 — don't import or reference it.
3. **Forgetting `* 10 ** decimals()` when minting.** You'll mint a dust amount and wonder why your balance reads as zero in a wallet.
4. **Exposing `_mint` / `_burn` publicly.** Internal functions are internal on purpose. Wrap them in guarded public functions.
5. **Mixing v4 and v5 docs.** If a guide writes `import "@openzeppelin/contracts/security/ReentrancyGuard.sol"` or no-arg `Ownable`, it's v4 — adjust the paths and constructors.
6. **Using a floating pragma for deployed code.** Pin the exact version.

## What's next

You just inherited a complete ERC20 in five lines — that's the OpenZeppelin payoff. In **Lesson 28** you'll level up to **ERC1155**, the multi-token standard that manages currencies *and* one-of-a-kind artifacts in a single contract. **Lesson 29** uses the *upgradeable* sibling package (`@openzeppelin/contracts-upgradeable`) to make contracts you can evolve after deployment. And **Lesson 30** combines `Ownable` with `ReentrancyGuard` and the Checks-Effects-Interactions pattern into a fully hardened contract.

## References

- OpenZeppelin Contracts v5 docs — https://docs.openzeppelin.com/contracts/5.x/
- OpenZeppelin — ERC20 guide — https://docs.openzeppelin.com/contracts/5.x/erc20
- OpenZeppelin — Access Control (`Ownable`) — https://docs.openzeppelin.com/contracts/5.x/access-control
- OpenZeppelin Contracts Wizard (generate a starting contract) — https://wizard.openzeppelin.com/
- Solidity docs — Inheritance — https://docs.soliditylang.org/en/latest/contracts.html#inheritance

## Closing

As Neri introduces the DefenseToken to the community, she sees a spark of hope reignite in their eyes. Vendors in the palengke begin using the token for transactions, jeepney drivers adopt it for QR-based fares, and even barangay halls accept it for local permits.

With OpenZeppelin's audited framework ensuring security, Neri establishes trust among the people, reassuring them that their funds are safe. The token becomes a symbol of resilience, uniting San Juan City against Hackana's looming threat. Hackana deploys a malicious contract to disrupt the network — but Neri's defenses, backed by code the whole world has already vetted, hold strong. San Juan begins to rebuild stronger than ever, and Neri knows she's one step closer to vanquishing Hackana for good.
