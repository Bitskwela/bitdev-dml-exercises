# Upgradable Smart Contracts — Evolving Code Behind a Fixed Address

![29.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_29_upgradable_smart_contracts/29.0%20-%20COVER.png)

## Scene: The Adaptive Shield

As Neri and her team near the climax of their battle against Hackana, they realize one critical flaw: **static systems can't counter evolving threats.** Hackana's malware adapts rapidly, learning to bypass traditional defenses.

But smart contracts are *immutable* — once deployed, the bytecode is frozen forever. How do you fix a bug in something that can't be changed? To outsmart Hackana, Neri's team reaches for the **proxy pattern**: a way to keep a contract's *address and data* fixed while swapping the *logic* underneath it. The shield stays in place; the spell powering it can be rewritten mid-battle.

This marks a revolutionary step in their quest — a system that can be updated in real time to counter any challenge, without losing a single registered user.

![29.1 - Upgradable Smart Contracts](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_01_basic_solidity/le_29_upgradable_smart_contracts/29.1.png)

## Why this matters

Deployed contract code is **immutable**. That immutability is a feature — users trust that the rules won't change out from under them — but it's also a trap: a discovered bug or a missing feature normally means deploying a *brand-new* contract at a *new address*, then somehow migrating every balance and every integration over. For a live system holding real funds, that's a nightmare.

Upgradeability buys you the best of both worlds: a **permanent address** users and other contracts can rely on, plus the ability to **fix bugs and ship features** behind it. The cost is added complexity and a new class of mistakes — which is exactly what this lesson teaches you to avoid.

## The core idea: split logic from storage

A proxy setup is **two contracts working as one**:

```
  User / wallet
       │  calls  registerUser("Neri")
       ▼
┌──────────────────┐        delegatecall        ┌─────────────────────────┐
│  PROXY            │ ─────────────────────────► │  IMPLEMENTATION (logic) │
│  • fixed address  │                            │  • the code that runs   │
│  • holds STORAGE  │ ◄───────────────────────── │  • holds NO state        │
│  • points at impl │   reads/writes proxy state │  • swappable             │
└──────────────────┘                            └─────────────────────────┘
```

- The **proxy** has the address everyone talks to. It **stores all the data** and remembers which implementation is current. It contains almost no logic of its own.
- The **implementation** (a.k.a. *logic* contract) holds the actual functions — `registerUser`, `getUser`, etc. — but **keeps no permanent state of its own.**
- To **upgrade**, you deploy a new implementation and tell the proxy to point at it. The address and all stored data stay exactly the same; only the behavior changes.

The magic word is **`delegatecall`**. When the proxy receives a call, it `delegatecall`s into the implementation. `delegatecall` runs the implementation's *code* but in the *proxy's* storage context — so `msg.sender`, `msg.value`, and crucially **all storage reads and writes happen on the proxy.** The logic contract is just a borrowed brain operating on the proxy's memory.

## Why constructors don't work behind a proxy

This is the concept everything else hangs on, so read carefully.

A `constructor` runs **exactly once, at deployment, in the context of the contract being deployed.** Its side effects (setting the owner, minting initial supply) land in **that contract's** storage.

When you deploy the **implementation**, its constructor runs in the **implementation's** storage — which the proxy never uses. When users later call the proxy and it `delegatecall`s in, the constructor has *already run and is gone*; it does **not** run again in the proxy's context. **Result: any state a constructor would have set (owner, initial values) is missing from the proxy.** The proxy thinks it has no owner, no initial supply, nothing.

**The fix: replace the constructor with a regular `initialize()` function that the proxy calls once, right after deployment.** Because `initialize()` is a normal function invoked *through the proxy*, its writes land in the proxy's storage — where they belong.

```solidity
// ❌ Never do this in an upgradeable contract — runs in the impl, not the proxy:
constructor(address owner) { _owner = owner; }

// ✅ Do this instead — runs through the proxy via delegatecall:
function initialize(address owner) public initializer {
    __Ownable_init(owner); // initializes inherited OZ modules
}
```

## Doing it for real: `@openzeppelin/contracts-upgradeable`

Standard OpenZeppelin contracts have constructors, so they can't be used behind a proxy. OpenZeppelin ships a **separate package** for this: **`@openzeppelin/contracts-upgradeable`**. Every contract in it replaces its constructor with an `__X_init()` initializer function.

Here is the `UserRegistry` written the production way:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract UserRegistryV1 is Initializable, OwnableUpgradeable {
    mapping(address => string) public userNames;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers(); // lock the implementation so it can't be initialized directly
    }

    function initialize(address initialOwner) public initializer {
        __Ownable_init(initialOwner); // takes the place of Ownable(msg.sender)
    }

    function registerUser(string memory name) public {
        userNames[msg.sender] = name;
    }

    function getUser(address user) public view returns (string memory) {
        return userNames[user];
    }
}
```

Three new pieces, each essential:

- **`Initializable`** provides the **`initializer`** modifier, which guarantees `initialize()` can run **only once**. Without it, an attacker could call `initialize()` again and seize ownership. (Use the **`reinitializer(n)`** modifier for an initializer that runs once per upgrade version.)
- **`__Ownable_init(initialOwner)`** is the initializer-flavored replacement for v5's `Ownable(msg.sender)`. There's an `__X_init` for every upgradeable module you inherit; call each one inside your `initialize()`.
- **`_disableInitializers()` in the constructor** — wait, didn't we just say no constructors? This constructor runs only on the **implementation** contract and does **not** set business state. Its sole job is to **lock the implementation so nobody can initialize it directly.** An un-initialized, un-locked implementation contract is a real attack surface (an attacker initializes *it*, then abuses it — the kind of bug that led to large incidents). `_disableInitializers()` slams that door. The `/// @custom:oz-upgrades-unsafe-allow constructor` comment tells OZ's tooling this empty constructor is intentional and safe.

> **The golden rule:** in an upgradeable contract, **a constructor only ever calls `_disableInitializers()`. All real setup goes in `initialize()`.**

## The deadliest pitfall: storage layout

Because the proxy keeps the storage and the implementation only *interprets* it, **the implementation's variable layout must stay compatible across every upgrade.** Storage slots are assigned in declaration order. If V2 reorders, inserts, or retypes existing variables, it will read V1's data through the *wrong* slots — silently corrupting everything.

**Rules for evolving storage safely:**

- ✅ **Append new variables at the end.** Always safe.
- ❌ **Never reorder, remove, or change the type of existing variables.**
- ❌ **Never insert a new variable in the middle** of the existing ones.

This is the entire reason the *teaching* exercise in this lesson upgrades by **inheritance** — `UserRegistryV2 is UserRegistryV1` — which guarantees V2 keeps every V1 variable in the same order and only *appends*:

```solidity
// The lesson's version-by-inheritance pattern keeps storage append-only:
contract UserRegistryV2 is UserRegistryV1 {
    function updateUser(string memory newName) public {
        userNames[msg.sender] = newName; // reuses V1's storage layout, adds a function
    }
}
```

**Storage gaps.** Older upgradeable code reserved spare slots with `uint256[50] private __gap;` so a base contract could add variables later without shifting child variables. OpenZeppelin v5 instead uses **ERC-7201 namespaced storage** to sidestep the whole problem — but you'll still see `__gap` in v4-era code, and the underlying concern (don't shift slots) is permanent.

## Transparent Proxy vs UUPS — which proxy?

OpenZeppelin offers two production proxy patterns. They differ in *where the upgrade logic lives*:

| | **Transparent Proxy** | **UUPS** (Universal Upgradeable Proxy Standard) |
|---|---|---|
| Upgrade logic lives in… | The proxy (via a separate ProxyAdmin) | **The implementation** itself |
| Implementation must inherit | nothing special | **`UUPSUpgradeable`** + `_authorizeUpgrade` |
| Deploy gas | Higher (heavier proxy) | **Lower (lean proxy)** |
| Risk if you forget | — | Ship an impl *without* upgrade logic → **frozen forever** |
| OZ v5 recommendation | Fine, still supported | **Preferred for most new projects** |

With **UUPS**, the upgrade function is in the implementation, guarded by an `_authorizeUpgrade` hook you must protect:

```solidity
function _authorizeUpgrade(address newImpl) internal override onlyOwner {}
```

**Key gotcha — UUPS's footgun:** if you ever deploy a new implementation that *forgets* to include the upgrade logic, the contract loses the ability to upgrade — **permanently**. Transparent proxies can't be bricked this way because the upgrade machinery lives in the proxy, not the implementation. Pick UUPS for gas efficiency and accept the discipline, or Transparent for safety.

## Security & gas notes

- **Protect the upgrade authority like a treasury key.** Whoever can call `upgradeTo`/`upgradeToAndCall` can replace *all* your logic with anything. Gate it behind `onlyOwner`, a multisig, or a timelock — never an EOA you control loosely.
- **Always `initializer`-guard `initialize()`.** An unprotected initializer is an instant ownership takeover.
- **Never leave an implementation un-disabled.** `_disableInitializers()` in the impl's constructor is mandatory.
- **Use OpenZeppelin's tooling** (the `@openzeppelin/hardhat-upgrades` plugin) to deploy and upgrade — it *statically checks* your storage layout and initializer safety before each upgrade and refuses unsafe ones.
- **Gas:** every call pays a small `delegatecall` overhead versus a non-proxied contract. Worth it for upgradeability; not free.

## Common mistakes to avoid

1. **Using a `constructor` to set state in an upgradeable contract.** It runs in the implementation, never the proxy — your owner/initial values silently vanish. Use `initialize()`.
2. **Forgetting the `initializer` modifier.** Anyone can re-initialize and steal ownership.
3. **Omitting `_disableInitializers()` in the implementation's constructor.** Leaves a live attack surface.
4. **Reordering, removing, retyping, or inserting storage variables across versions.** Corrupts all stored data. Append only.
5. **Importing `@openzeppelin/contracts` instead of `@openzeppelin/contracts-upgradeable`.** The standard package has constructors and is unsafe behind a proxy.
6. **Shipping a UUPS implementation without upgrade logic.** Bricks upgradeability forever.
7. **Leaving the upgrade function ungated.** Equivalent to handing out the keys to your entire contract.

## What's next

This is the capstone of the OpenZeppelin arc. **Lesson 30** brings it all home — combining `Ownable`, `ReentrancyGuard`, and the Checks-Effects-Interactions pattern into a fully hardened contract, the same defensive discipline you'll apply when guarding an upgrade authority. Looking back: **Lesson 24** taught inheritance and v5's `Ownable(msg.sender)` (whose initializer twin `__Ownable_init` you used here), and **Lesson 28** built the multi-asset economies that real projects most often want to make upgradeable.

## References

- OpenZeppelin — Proxy Upgrade Pattern (concepts) — https://docs.openzeppelin.com/contracts/5.x/upgradeable
- OpenZeppelin — Writing Upgradeable Contracts (initializers, storage rules) — https://docs.openzeppelin.com/upgrades-plugins/writing-upgradeable
- OpenZeppelin — `contracts-upgradeable` package — https://docs.openzeppelin.com/contracts/5.x/upgradeable
- OpenZeppelin — UUPS vs Transparent proxies — https://docs.openzeppelin.com/contracts/5.x/api/proxy
- EIP-1967 (standard proxy storage slots) — https://eips.ethereum.org/EIPS/eip-1967
- Solidity docs — `delegatecall` — https://docs.soliditylang.org/en/latest/introduction-to-smart-contracts.html#delegatecall-and-libraries

## Closing

As Hackana morphs into its final form, launching its most destructive attack yet, Neri's adaptive contracts come to life. The proxy address never moves; behind it, her team swaps in fresh logic with every assault — patching, hardening, evolving — while every registered user and every stored record stays perfectly intact.

With each strike, the system upgrades faster than the malware can adapt, nullifying Hackana's every move. The battle isn't just won — Neri's strategy transforms how systems defend themselves, heralding a new era of resilient, evolving digital infrastructure.
