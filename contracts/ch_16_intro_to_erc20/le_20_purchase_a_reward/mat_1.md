## Dan's Story: The Menu With No Cashier

Last lesson Dan built RewardStore v1 — a *second* contract, deployed beside the WCR token, wired to it by passing the token's address into the store's constructor. He added a "Turon" item for 100 WCR with `addItem` and watched `itemCount()` return `1`. The store had a menu. What it did *not* have was a cashier: no way for a student to actually hand over credits and walk out with a turon. `items(0)` proudly returned `("Turon", 100000000000000000000, true)` and could do absolutely nothing with that information, because a menu is not a transaction.

Dan cracked his knuckles and typed the obvious thing.

> **Dan:** Okay, so `buyItem` just reaches in and takes the 100 WCR from the student. Something like `credit.transfer(address(this), item.price)` and—
>
> **Kuya JM:** Sandali, sandali. Whose tokens does `transfer` move, Dan? Balikan mo Lesson 13. When *you* call `transfer`, whose balance goes down?

Dan's hand hovered over the keyboard. Lesson 13. `transfer` always spends `msg.sender`'s own balance. And inside `buyItem`, `msg.sender` from the *token's* point of view would be the store — whose WCR balance was exactly zero.

> **Dan:** ...The store's own balance. Which is empty. So `transfer` would just send the store's zero WCR to itself. Useless.
>
> **Kuya JM:** Exactly. A contract can't reach into somebody's wallet and grab their tokens. Kung kaya nun, walang WCR na ligtas — any contract could drain you. So the token makes it a two-step handshake. The student says *"I allow the store to take up to 100."* Then the store *pulls*. That's `approve`, tapos `transferFrom`. Yung dalawang natutunan mo last week — that wasn't practice for nothing. That was practice for *this*.

The allowance model hadn't been an abstract exercise. It was the store's payment rail the whole time.

At the counter, Tita Malou was refilling the turon tray, half-listening the way she always does.

> **Tita Malou:** So itong store mo, kukunin niya lang basta ang credits ng bata? Parang magnanakaw?
>
> **Dan:** Hindi, Ma. Yun nga ang point. Hindi niya pwedeng kunin kung hindi muna sinabi ng estudyante kung magkano ang *pwede* niyang kunin. Una, papayag muna sila — `approve`. Saka pa lang makakakuha ang store. Nakalog lahat — makikita mo pa sa ledger kung sino, magkano, kailan.

Tita Malou grunted, which from her is a passing grade. Dan turned back to the screen — time to give the store a cashier, the honest kind that can't take a single credit the student didn't hand it.

---

## The Concept: `approve` → `transferFrom`, End to End

### Why a store can't just take your tokens

Here's the rule that makes ERC-20 safe, and it's the same reason JM stopped Dan:

> **A contract can never move tokens out of your balance on its own.** The only account that can spend *your* WCR with `transfer` is *you*. Anyone else — a person, a store contract — must be *granted permission first*, and can take only up to the amount you granted.

If it worked any other way, every token you held would be one malicious contract call away from gone. So ERC-20 splits payment into two deliberate steps.

| Step | Who calls it | What it does | Tokens move? |
|------|--------------|--------------|:------------:|
| 1. `approve(store, 100)` | the **student** (on the token) | Sets `allowance[student][store] = 100` — a signed promise: *"the store may take up to 100 of my WCR."* | No — just a permission |
| 2. `transferFrom(student, store, 100)` | the **store** (on the token) | Checks the allowance, moves 100 WCR student → store, lowers the allowance by 100. | Yes — the actual pull |

JM's palengke version: *`approve` is leaving a "pwede kang kumuha hanggang 100" note with the tindera. `transferFrom` is the tindera actually taking it — and never more than the note allows.*

### The twist: this time the spender is a *contract*

In Lesson 18 you played the spender with a second *account* — you switched the Remix account dropdown and called `transferFrom` yourself. Today the spender is the **RewardStore contract**. When the store runs this line inside `buyItem`:

```solidity
credit.transferFrom(msg.sender, address(this), item.price);
```

...it's calling the *token's* `transferFrom`. From the token's point of view, the caller — the spender whose allowance gets checked — is the **store's address**, not the student's. That's the detail that trips everyone once:

> The student must `approve` **the store's address**. Not their own, not Dan's — the exact address the RewardStore was deployed to.

Inside `buyItem`, `msg.sender` is the student (they clicked buy) and `address(this)` is the store itself — the destination the WCR flows *into*.

### The full flow, one picture

```text
  STEP 1 — APPROVE                          STEP 2 — BUY
  (student signs a permission)              (student clicks buy; the store pulls)

  student                                   student
     |                                         |
     | approve(store, 100 WCR)                 | buyItem(0)
     v                                         v
  WCR token                                 RewardStore
     |                                         |  require(item.active)  <-- the door guard
     | allowance[student][store] = 100         |
     |  (NO tokens moved yet —                 | credit.transferFrom(
     |   just a written promise)               |     msg.sender,    <- student
     |                                         |     address(this), <- the store
                                               |     item.price )   <- 100 WCR
                                               v
                                            WCR token
                                               |  allowance[student][store] >= 100 ? YES
                                               |  move 100 WCR: student -> store
                                               |  allowance[student][store] -> 0
                                               |  emit Transfer(student, store, 100)
                                               v
                                            back in RewardStore
                                               |  emit ItemPurchased(0, student, 100)
```

Two contracts, one transaction. The student calls **one** function on the store — `buyItem` — and the store reaches over to the token to do the pull. When it's done, *two* events sit in the log: a `Transfer` from the token and an `ItemPurchased` from the store. Anyone can read both.

### `require`: the guard at the door

Before the store pulls a single credit, it checks the item is real and for sale:

```solidity
Item storage item = items[id];
require(item.active, "RewardStore: item not available");
```

`require(condition, "message")` is Solidity's bouncer. If the condition is **true**, execution continues; if **false**, the whole transaction *reverts* — every state change is undone and the reason string comes back to the caller. Same "clean refusal, not a crash" as Lesson 15, except *you* wrote this one. Two revert styles show up in one purchase, and it's worth knowing which is which:

| Revert | Comes from | Looks like |
|--------|-----------|------------|
| `require(item.active, "...")` | **your** store code | a plain reason string: `RewardStore: item not available` |
| insufficient allowance | **OpenZeppelin's** token | a custom error: `ERC20InsufficientAllowance(spender, allowance, needed)` |

`Item storage item = items[id]` grabs a *reference* to the item in the contract's storage, so reading `item.active` and `item.price` reads the real stored values — no copy.

One thing this store does **not** do yet: it *keeps* the WCR it collects. After a purchase, 100 WCR really is sitting in the store contract's balance — the store is a piggy bank for now. Making a redeemed credit actually *leave circulation* (burning) is Lesson 23. One idea at a time.

---

## Key Takeaways

- **Paying a contract in ERC-20 is a two-step handshake:** the buyer `approve`s the contract for an amount, then the contract pulls with `transferFrom`. A contract can never move your tokens on its own.
- **When a contract calls `transferFrom`, the contract is the spender.** Students must `approve` the **store's deployed address** — that's the account whose allowance the token checks.
- **`buyItem` uses `credit.transferFrom(msg.sender, address(this), item.price)`** — `msg.sender` is the buyer, `address(this)` is the store the WCR flows into.
- **`require(item.active, "...")` is your own guard clause:** true continues, false reverts the whole transaction with a reason string and undoes every change.
- **Two revert styles appear in one purchase:** your `require` returns a plain string; the token returns a custom error like `ERC20InsufficientAllowance(spender, allowance, needed)`. Skipping `approve` triggers the latter.
- **One `buyItem` call, two events:** a `Transfer` from the token and an `ItemPurchased` from the store — the ledger records the exchange twice over, both public.
- **At this stage the store *holds* the WCR it collects** — a piggy bank. Removing spent credits from circulation (burning) comes in Lesson 23.

---

## What's Next?

The register works. But step back and ask the uncomfortable question: where did the student's WCR come from in the first place? Dan minted 1,000 to himself at deployment and handed some out. Fine for a demo — but if Dan can conjure credits whenever he likes, and so can anyone who copies the pattern, then what exactly is a credit *worth*? A currency anyone can print is a currency no one should trust.

Ate Rina is about to walk into the carinderia and ask Dan the one question he's been avoiding: *"Who can mint, bata? If anyone can print credits, wala nang halaga ang credits."* The next lesson locks credit creation to a single authority — the instructor — using OpenZeppelin's `Ownable` and the `onlyOwner` guard, and shows you *exactly* how the ledger refuses a stranger's attempt to mint, custom error and all.

**Next Lesson: Add Controlled Minting** — `Ownable`, `onlyOwner`, and proving that only Dan can create WCR.
