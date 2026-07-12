## Dan's Story: A Box That Lives Somewhere You Don't Own

Last lesson braced Dan for a toolchain ordeal — the Python-install flashbacks, the LutoCLI `rustup` PTSD — and instead **remix.ethereum.org** just *opened* in his browser. No install, no PATH, walang kailangan. He made `WorkshopCredit.sol`, pasted an empty skeleton (`// SPDX...`, `pragma solidity ^0.8.20;`, `contract WorkshopCredit { }`), picked a 0.8.20 compiler, and got a green check. Success. Except the contract is completely empty — it holds nothing, does nothing, remembers nothing. A green check on a blank exam.

Late afternoon in the computer lab, the aircon losing to the Marikina heat. Dan typed the question into Messenger the way he always did — half to JM, half to himself.

> **Dan:** Okay Kuya, it compiled. Pero ano ba talaga ito? An empty `contract`. Parang gumawa ako ng variable na walang laman. Where does this even *go* when I "deploy" it?
>
> **Kuya JM:** Naks, finally the real question. Remember LutoCLI? You compiled it to one `.exe`, copied it to a USB, and it ran on Tita Malou's desktop. Whose computer was that program living on?
>
> **Dan:** Ma's desktop. The old one sa loob.
>
> **Kuya JM:** Right — a machine *you controlled*. Gusto mong palitan? You walk over, swap the USB, done. A smart contract is the opposite. When you deploy, your code goes and lives on the blockchain — thousands of computers, none of them yours. And once it's there, you can't sneak in and edit it. Nobody can.

Dan re-read that twice.

> **Dan:** Wait. So I upload my code to a computer I don't own, and then I *can't take it back or change it*? Bakit ko gagawin yun? That sounds worse.
>
> **Kuya JM:** For a to-do app, mas worse nga. But think about your notebook. The reason Kevin can't trust your credit count is that *you* hold the notebook and you *can* edit it — even by accident, even with a smudge. Now imagine the credit rules living somewhere you can't secretly touch, that Kevin can read himself, anytime.

There it was again — the same ghost from three courses back: *kahit wala ka*, "even when you're not there." With Luto v1 and v2 it meant the report should run without Dan babysitting Python. With LutoCLI, one binary on an offline desktop. Now JM was pointing at a stranger version: a program that keeps working *and stays honest* precisely because Dan can't reach in and change it.

> **Dan:** So the blockchain is like a hard drive I upload to — pero read-only, and the whole barangay can see it.
>
> **Kuya JM:** Close enough for today. Bago mo i-token si WorkshopCredit, gawa ka muna ng maliit na laruan — one contract that actually *holds* something and *does* something, para makita mo kung ano ang "state" at "function" talaga. Tawagin nating `HelloToken`. Throwaway lang.

A throwaway. Something small enough to understand completely before the real thing. Dan had learned that the hard way in every course so far: understand the toy before you trust the tool.

---

## The Concept: Code + State, Living at an Address

### A smart contract is two things at one address

Forget "smart" and forget "crypto" for a second. A **smart contract** is just a small program deployed to a blockchain. Once it's there, it has two parts, and it lives at a single **address**:

- **State** — the data the contract *remembers*. Stored on-chain and it **persists**: it survives after your call ends, after you close the browser, after you sleep. It's the notebook's actual contents.
- **Code** — the **functions**: the rules for reading that state and (later) changing it. The part that *does* things.

An **address** is a unique on-chain location — a 42-character string like `0xd9145CCE...F39138`. After you deploy, that address *is* your contract. Anyone who has it can read the state and call the functions — no permission, no login, no asking Dan.

```text
      AN ADDRESS ON THE BLOCKCHAIN
      0xd9145CCE52D386f254917e481eB44e9943F39138
      +--------------------------------------------+
      |  contract HelloToken                       |
      |                                            |
      |  STATE (remembered, persists forever):     |
      |     name        = "Hello Token"            |
      |     totalSupply = 100                      |
      |                                            |
      |  CODE (the rules / functions):             |
      |     greet()  ->  "Kumusta, blockchain!"    |
      +--------------------------------------------+
        ^ lives on thousands of computers, none of
          them Dan's. Readable by anyone. Not
          secretly editable by anyone -- including Dan.
```

That last line is the whole reason this course exists. Dan's notebook fails because Dan owns it. A contract's ledger works *because* nobody owns the server it lives on.

### State variables: the part that remembers

```solidity
string public name = "Hello Token";
uint256 public totalSupply = 100;
```

Each of these is a **state variable**. On deploy, `name` is set to `"Hello Token"` and `totalSupply` to `100`, and those values are written **into the blockchain's storage** at the contract's address. Come back tomorrow and read `totalSupply` — still `100`. Not because a program runs in the background keeping it alive, but because it's *recorded*, the way a line in the utang listahan stays written until someone changes it.

| Type | Holds | Example |
|---|---|---|
| `string` | Text | `"Hello Token"` |
| `uint256` | A non-negative whole number (0 up to a huge max) | `100` |

No decimals in `uint256` — no `1.5`, no negatives. Solidity leans on whole numbers on purpose (you find out *why* it matters for money in Lesson 9). For now: `uint256` is the workhorse integer, and every token amount you'll ever handle is one.

### Functions, and the free getter `public` hands you

```solidity
function greet() public pure returns (string memory) {
    return "Kumusta, blockchain!";
}
```

A **function** is a named action. Reading the signature left to right: `greet()` takes no inputs; `public` means anyone can call it; `pure` is a promise about what it touches (next); `returns (string memory)` hands back text (`memory` = temporary scratch space for the call, not permanent storage — don't overthink it today).

Now notice what you *didn't* write: any function to read `name` or `totalSupply`. You didn't have to. The keyword **`public`** on a state variable tells Solidity to *auto-generate a getter with the same name.* Marking `name` public silently creates a `name()` function returning `"Hello Token"` — a clickable button in Remix, for free. This is the shortcut every ERC-20 leans on: `name()`, `symbol()`, `totalSupply()`, `balanceOf()` are all just public getters like this.

### `view`, `pure`, and why reading is free

This distinction you'll use every lesson from here. It's about whether a function *touches state*:

| Modifier | Reads state? | Writes state? | Meaning |
|---|---|---|---|
| `pure` | No | No | Touches no contract data at all — pure computation. `greet()` returns a fixed string. |
| `view` | Yes | No | Reads state but never changes it. A public getter like `name()` is effectively a view. |
| *(neither)* | Maybe | **Yes** | Changes state. A real transaction — it edits the ledger. |

Why care? Because of **gas** — the fee you pay to *change* the blockchain's shared state. The payoff:

> **Reading is free. Changing costs gas.**

Calling `greet()` or `name()` costs **nothing** and is not even a transaction — you're only *looking* at a record every computer already has a copy of. That's why in Remix some buttons are **blue** (free reads: `pure`/`view`/getters) and others would be **orange** (state-changing transactions that cost gas). `HelloToken` is all reads today — a very cheap toy.

### Deploying: source into a live thing

Right now `HelloToken.sol` is just *source code* — text, the way `main.rs` was text before `rustc` made a binary. **Deploying** is the blockchain's version of that step: it takes your compiled contract and creates one **live instance** *at a brand-new address*. Before deploy: a recipe. After deploy: an actual dish at a specific table, `name` and `totalSupply` already filled in, ready for anyone to poke. Compile once, deploy to get an address, then read and call.

---

## Key Takeaways

- **A smart contract = code + state living at an address.** Deploy it and it runs on thousands of computers, none of them yours, none able to secretly edit it. That "server you don't own" is the source of tiwala.
- **State variables persist.** `name` and `totalSupply` are written into on-chain storage and stay between calls — the contract *remembers*, like a line in the utang listahan.
- **`public` on a state variable auto-generates a free getter** with the same name. Every ERC-20 read (`name()`, `symbol()`, `totalSupply()`, `balanceOf()`) is exactly this trick.
- **`view` and `pure` functions only look, so they're free.** `pure` touches no state at all (`greet()`); `view` reads but never writes.
- **Reading is free; changing state costs gas.** In Remix, blue buttons are free reads; orange buttons are transactions that edit the ledger and cost gas.
- **Deploying turns source into one live instance at a new address** — the chain's version of compiling `main.rs` into a binary. Each Deploy is a fresh copy; editing source doesn't touch an already-deployed contract.

---

## What's Next?

Dan has a contract that lives on-chain, remembers a number, and says hello. But `HelloToken` is a toy with a made-up shape — Dan invented `name`, `totalSupply`, and `greet()` out of thin air. A real token can't be improvised like that. For Kevin's wallet to show WCR, for a reward store to accept it, for *any* other program on the chain to know how to talk to it, WorkshopCredit has to follow a shape the whole ecosystem already agreed on.

That shape has a name: **ERC-20** — a short, precise checklist of six functions and two events that every fungible token on Ethereum promises to implement. Next lesson Dan opens the actual EIP-20 spec, reads it line by line, and maps each function back to a plain barangay action from his notebook. *Learn the interface,* JM will tell him, *not the implementation.*

**Next Lesson: Meet the ERC-20 Interface** — the six functions and two events every token shares, mapped to the utang listahan.
