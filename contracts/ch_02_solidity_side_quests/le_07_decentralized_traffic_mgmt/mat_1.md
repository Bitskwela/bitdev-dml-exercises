# Side Quest 7: Decentralized Traffic Management — State Machines, Enums & Access Control

![Decentralized Traffic Management](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_2/C2+7.0+-+COVER.png)

## Scene

Hackana's digital warfare has spilled into the streets. The Metro Manila traffic system is in shambles. Traffic lights across the city are stuck on red, turning intersections into warzones of honking cars and gridlock madness.

The MMDA has no idea how to fix this. They turn to Neri — the only person in the Philippines with enough technical mastery to reprogram the entire decentralized traffic system.

![Neri the Blockchain Defender](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_2/C2+7.1.png)

Her mission: deploy smart contract logic that manages traffic lights per intersection, but only allows valid states to prevent chaos. Time is critical.

## Why this matters

A traffic light has exactly three legal states: red, yellow, green. Not "blue," not "Red ", not an empty string. The entire safety of the system rests on one guarantee: **the light can only ever be in a state you explicitly allowed.** If Hackana's botnet can push an intersection into an undefined state, cars stop trusting the signal and intersections become warzones.

This is a **state-management** problem, and it shows up everywhere in smart contracts: an auction is `Open`, `Closed`, or `Settled`; an escrow is `Funded`, `Released`, or `Refunded`; a proposal is `Pending`, `Active`, `Passed`, or `Rejected`. The naive instinct is to store these as strings and compare them. This lesson shows you why that's fragile and expensive, and teaches the tool built for exactly this job: the **`enum`**. You'll also learn that "who is allowed to flip the switch" is just as important as "what states are legal" — that's **access control**.

## 1. The string approach — and why comparing strings is awkward

The activity stores light states as strings. The first thing newcomers discover is that **you can't compare strings with `==` in Solidity.** Strings are dynamic arrays of bytes, and `==` simply isn't defined for them. The standard workaround is to hash both strings and compare the hashes:

```solidity
mapping(string => string) public lightState;

function changeLight(string memory intersection, string memory newState) public {
    require(
        keccak256(bytes(newState)) == keccak256(bytes("red")) ||
        keccak256(bytes(newState)) == keccak256(bytes("yellow")) ||
        keccak256(bytes(newState)) == keccak256(bytes("green")),
        "Invalid state! State must be 'red', 'green', or 'yellow'."
    );
    lightState[intersection] = newState;
}
```

This *works*, and you should understand it because you'll see it in the wild. (`keccak256(bytes(s))` and `keccak256(abi.encodePacked(s))` are equivalent for a single string — both hash the raw UTF-8 bytes.) But look at everything that can still go wrong:

- `"Red"`, `"RED"`, `"red "` are all *different strings* and all rejected — case and whitespace are silent landmines.
- Nothing stops a caller from passing `"blue"`; you only catch it at **runtime**, with a revert, after paying gas.
- Every comparison hashes a string — needless computation and storage cost.
- The set of valid values lives inside a `require` chain; add a fourth state and you must remember to edit the validation by hand.

Strings are for *human-readable text*, not for a fixed, closed set of machine states. There's a better tool.

## 2. The right tool — `enum`

An **`enum`** defines a custom type with a small, fixed set of named values. The compiler assigns each a number internally (`Red = 0`, `Yellow = 1`, `Green = 2`) and — crucially — **makes it impossible to assign a value outside the set.** Invalid states stop being a runtime check and become a *compile-time and type-level* guarantee.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract TrafficLightManager is Ownable {
    enum Light { Red, Yellow, Green }

    mapping(string => Light) public lightState;

    constructor() Ownable(msg.sender) {
        // enums default to their first member (Red = 0), so intersections
        // start safely on red even before any explicit assignment
    }

    function changeLight(string memory intersection, Light newState) public onlyOwner {
        // No keccak256, no require chain — the type system already guarantees
        // newState is one of Red, Yellow, or Green. Anything else won't compile/encode.
        lightState[intersection] = newState;
    }
}
```

What just disappeared:

- **The entire `require` validation chain** — the parameter type `Light` *cannot hold* an invalid value. There is no `"blue"`, no case-sensitivity bug, no trailing-space bug.
- **The hashing cost** — comparing/storing an enum is comparing/storing a tiny integer.

What you gained: self-documenting code (`Light.Green` reads better than `"green"`), and a single source of truth for the valid set (add `Flashing` to the enum, and every function that uses `Light` sees it).

### `enum` vs. validated strings

| | `string` + `keccak256` validation | `enum Light { Red, Yellow, Green }` |
|---|---|---|
| Invalid value possible? | Yes — caught only at runtime via `require` | No — rejected by the type system before it runs |
| Case/whitespace bugs | `"Red"`, `"red "` silently rejected | Impossible — there's no text to mistype |
| Gas cost | Hash + store a dynamic string | Store/compare a single byte-sized integer |
| Readability | A magic string in a `require` chain | `Light.Green`, self-documenting |
| Adding a state | Edit every `require` by hand | Add one enum member; all usages stay valid |

> The activity intentionally uses the string-comparison approach so you learn *why* string comparison is awkward in Solidity. Now that you've felt the friction, reach for an `enum` whenever the set of valid values is small, fixed, and known at compile time.

## 3. Access control — who is allowed to change state?

A validated state is only half the safety story. The other half: **who** can call `changeLight`? In the string version, *anyone* can — Hackana's botnet could flip every intersection to green simultaneously. A state-changing function on a public system needs a gate.

The standard gate is **`onlyOwner`** from OpenZeppelin's `Ownable`. In OpenZeppelin **v5**, the constructor takes the initial owner explicitly:

```solidity
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract TrafficLightManager is Ownable {
    constructor() Ownable(msg.sender) {}   // deployer becomes the owner

    function changeLight(string memory intersection, Light newState) public onlyOwner {
        lightState[intersection] = newState;   // only the owner reaches this line
    }
}
```

`onlyOwner` reverts any call from a non-owner before the function body runs. For a system controlling more than one operator (say, per-district MMDA accounts), graduate to **role-based access control** with OpenZeppelin's `AccessControl` and a `TRAFFIC_OPERATOR_ROLE`. Either way, the principle is the same: **a function that mutates shared state must check the caller's authority.**

> Never gate access with `tx.origin` — it's phishable. Always authorize against `msg.sender`.

## 4. Putting it together — a clean state machine

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract TrafficLightManager is Ownable {
    enum Light { Red, Yellow, Green }

    mapping(string => Light) public lightState;

    event LightChanged(string indexed intersection, Light newState);

    constructor() Ownable(msg.sender) {}

    function changeLight(string memory intersection, Light newState) public onlyOwner {
        lightState[intersection] = newState;
        emit LightChanged(intersection, newState);
    }
}
```

This is a minimal **state machine**: a defined set of states (`Light`), guarded transitions (`onlyOwner`), and an event so off-chain dashboards can react. If you needed to forbid certain transitions (e.g. red must go to green before yellow), you'd add a `require` comparing the *current* state to the *requested* one — but even then, the states themselves are still safely constrained by the enum.

## Common mistakes to avoid

1. **Comparing strings with `==`.** It doesn't compile. If you must compare strings, hash them with `keccak256(bytes(a)) == keccak256(bytes(b))` — but first ask whether an `enum` fits.
2. **Using strings for a fixed, closed set of states.** Strings invite case/whitespace bugs and push validation to runtime. Use an `enum` so invalid states can't exist.
3. **Leaving state-changing functions ungated.** Any `public`/`external` function that writes shared state needs access control (`onlyOwner` or a role). An open `changeLight` is an open invitation.
4. **Authorizing with `tx.origin`.** It's vulnerable to phishing through intermediary contracts. Always check `msg.sender`.
5. **Forgetting enums default to their first member.** `Light` defaults to `Red` (value `0`). Order your enum so the safest/default state comes first — here, that's exactly what we want.
6. **Old OpenZeppelin patterns.** Use `Ownable(msg.sender)` (v5 requires the explicit owner argument); the zero-argument `Ownable()` no longer compiles.

## Gas & design notes

- **Enums are cheap.** An enum value fits in a single byte and is stored/compared like a small integer — far cheaper than hashing and storing dynamic strings on every call.
- **`mapping(string => ...)` keys are fine for human-readable IDs** like `"intersection1"`, but for large-scale systems a `mapping(uint256 => Light)` (intersection by numeric ID) is cheaper and avoids string-handling overhead entirely.
- **Emit an event on every transition.** Events are the cheap, standard way for off-chain monitors (traffic dashboards, MMDA control rooms) to observe state changes without polling storage.

## What's next

You've built a guarded state machine — the backbone of auctions, escrows, governance, and any contract whose behavior depends on "what phase are we in." You now have the core Solidity vocabulary from this side-quest chapter: exact on-chain math, safe value transfers, standardized royalties, and constrained state with access control. Next you'll combine these into larger mini-projects where multiple state machines and value flows interact.

## References

- Solidity docs — Enums — https://docs.soliditylang.org/en/latest/types.html#enums
- Solidity docs — Members of address types / string comparison notes — https://docs.soliditylang.org/en/latest/types.html
- OpenZeppelin v5 — `Ownable` — https://docs.openzeppelin.com/contracts/5.x/api/access#Ownable
- OpenZeppelin v5 — `AccessControl` (role-based authorization) — https://docs.openzeppelin.com/contracts/5.x/access-control
- Solidity by Example — Enum — https://solidity-by-example.org/enum/

## Closing

Neri pushes the new logic to the city's nodes. One by one the intersections of Metro Manila blink back to life — red holding firm at safe defaults, then cycling cleanly through yellow and green as her dashboard lights up with `LightChanged` events. Hackana's botnet hammers `changeLight` with garbage states and stolen calls; every one bounces off the type system or the `onlyOwner` gate. "Hindi pwedeng 'blue' ang ilaw," she says with a tired grin — the light can never be "blue." The honking fades. Order, by design.
