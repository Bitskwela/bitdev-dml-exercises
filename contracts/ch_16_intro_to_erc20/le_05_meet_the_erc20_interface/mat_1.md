## Dan's Story: The Six Words Every Token Knows

Last lesson Dan built `HelloToken` — a tiny contract with a `name`, a `totalSupply`, and a `greet()` — deployed it on the Remix VM, and clicked the blue getters to read state from something that "lives" at an address he doesn't own the server for. His first real smart contract. But `HelloToken` was a toy he *invented*. Tonight he finds out that every real token — the ones the whole world already trades — agrees to speak the exact same six words. There's a standard, and before he writes another line, JM wants him to read it.

Sunday-night dorm, two tabs open: the Remix window where `HelloToken` was still deployed, and a page titled **EIP-20: Token Standard** that looked less like a tutorial and more like a legal document. Dan had gone looking for "how do I make a token like the real ones," expecting a recipe. He got a specification. He messaged JM a screenshot: *"bakit ang tuyo nito. walang code, puro function names."*

> **Kuya JM:** Naks, you found the actual EIP. Deep breath — that dry document is the most important thing you'll read this whole course. You know why every token in the world works in MetaMask, in every exchange, in every wallet — kahit gawa ng magkaibang tao na hindi nag-usap? Because they all agreed to the same *shape*. That shape is EIP-20.
>
> **Dan:** Shape?
>
> **Kuya JM:** A list of functions a contract *promises* to have: `totalSupply`, `balanceOf`, `transfer`, `approve`, `transferFrom`, `allowance`. Six functions, two events. If your contract has exactly those — same inputs, same outputs — then MetaMask already knows how to talk to it. You didn't teach it. It just knows, because you spoke the standard.

Dan scrolled the spec again. Now that he had names to hang things on, the dryness started to feel like *precision*.

> **Dan:** So this is like a contract for contracts. "If you call yourself a token, you must answer these six questions."
>
> **Kuya JM:** Exactly yan. And tattoo this somewhere: tonight you learn the **interface**, not the **implementation**. The interface is *what* the functions are called and what they take and return. The implementation is *how* they work inside — the balance math, the checks, the storage. Read the "what" tonight. Next lesson, someone hands you a battle-tested "how" for free. Don't write the how.

Dan thought about the smudged notebook back at the barangay hall. Kevin's disputed credits. Every argument he'd ever had at the merienda table was really about the same three questions: *how many credits exist, who holds how much, and who's allowed to move them.* EIP-20 wasn't a legal document. It was his listahan — written so precisely that nobody could disagree about what a line *meant*.

> **Dan:** JM. This whole spec is just my listahan. Formalized.
>
> **Kuya JM:** Ngayon ka nagsalita ng tama. Now read all six with that lens. Every function maps to something you already do at the workshop with a pen.

---

## The Concept: EIP-20 Is a Shared Shape, Not a Program

### What "interface" means

An **interface** in Solidity is a list of function signatures with **no bodies** — no code inside, just the promise that *some* contract somewhere implements them. It's the menu at Tita Malou's carinderia: the menu lists *what you can order*. It doesn't tell you *how she cooks the sinigang*. Kitchen (implementation) is separate from menu (interface).

**EIP-20** (also written ERC-20 — EIP is the proposal, ERC the finalized standard) is exactly that menu, agreed on by the entire Ethereum world. A contract "is an ERC-20 token" if and only if it offers these items — and so will Workshop Credit, through its own interface `IWorkshopCredit`:

```text
   THE ERC-20 MENU  (what IWorkshopCredit declares)
   ===============================================
   3 VIEWS   (read-only — free, cost no gas)
     - totalSupply()
     - balanceOf(account)
     - allowance(owner, spender)

   3 WRITES  (change state — cost gas, emit events)
     - transfer(to, amount)
     - approve(spender, amount)
     - transferFrom(from, to, amount)

   2 EVENTS  (receipts written to the public ledger)
     - Transfer(from, to, value)
     - Approval(owner, spender, value)

   + OPTIONAL METADATA  (nice-to-have, not required)
     - name(), symbol(), decimals()
   ===============================================
```

Six functions, two events, three optional extras. Every stablecoin, every loyalty point, every in-game currency answers to this same menu.

### The three views — reading the ledger (no gas)

These are questions. They only *read*, so anyone can call them for free. Each maps to a line Dan already keeps:

| ERC-20 view | Signature | The listahan action |
|---|---|---|
| **totalSupply** | `totalSupply() → uint256` | The number at the bottom of the ledger: *how many credits exist in the entire workshop, ever.* |
| **balanceOf** | `balanceOf(address account) → uint256` | *One student's line:* how many credits Kevin holds right now. |
| **allowance** | `allowance(address owner, address spender) → uint256` | The "pwede kunin hanggang ___" note: how much a spender may still pull from someone's balance. |

If Tita Malou ever wants to check Dan didn't secretly inflate the credits, `totalSupply()` is the one number she reads — and no one can fake it, because the ledger computes it, Dan doesn't write it.

### The three writes — moving credits (costs gas, leaves a receipt)

These *change* the ledger, so they cost gas and each leaves a permanent receipt (an event):

| ERC-20 write | Signature | The listahan action |
|---|---|---|
| **transfer** | `transfer(address to, uint256 amount) → bool` | *Dan hands credits straight to a student.* Moves **your own** balance to someone else. |
| **approve** | `approve(address spender, uint256 amount) → bool` | *Pre-authorize* the reward store: "you may pull up to 100 WCR from me." No credits move yet — just permission. |
| **transferFrom** | `transferFrom(address from, address to, uint256 amount) → bool` | *The store collects at checkout.* A spender moves someone else's credits — but only up to the amount they were `approve`d for. |

Here's the pattern JM calls the **allowance model** — the single most confusing-then-obvious idea in ERC-20:

```text
   THE ALLOWANCE MODEL  (approve -> transferFrom)

   Kevin holds his own credits the whole time. The
   store never "reaches in" and grabs them uninvited.

   STEP 1  Kevin: approve(storeAddress, 100 WCR)
           -> leaves a note: "store, pwede hanggang 100"
           -> balances DON'T change. Just a permission.

   STEP 2  Store: transferFrom(kevin, store, 100 WCR)
           -> the store pulls exactly what it was allowed
           -> NOW 100 WCR moves; allowance drops to 0
```

Why the two-step dance instead of the store just taking the credits? Because on a public ledger **no contract can touch your balance without your say-so.** `transfer` spends *your own* money; `transferFrom` spends *someone else's* money *within a limit they set first*. JM's version: *"parang pautang na budget with the tindera — she can only take up to what you approved, hindi lahat ng pera mo."* You'll live inside this model for all of Act 2.

### The two events — the receipts that make it a ledger

An **event** is a line written into the blockchain's public log every time state changes. This is the transparency the whole course is about — the reason a token beats a notebook:

| ERC-20 event | Signature | What it records |
|---|---|---|
| **Transfer** | `Transfer(address indexed from, address indexed to, uint256 value)` | *Every* credit movement — mints, transfers, redemptions. The receipt for "credits moved." |
| **Approval** | `Approval(address indexed owner, address indexed spender, uint256 value)` | Every permission granted. The receipt for "someone was allowed to spend." |

`indexed` marks the fields block explorers let you *search and filter* by — so anyone can pull up "every Transfer involving Kevin's address" without trusting Dan. When Dan sends Kevin 100 WCR in Lesson 13, a `Transfer` event is what Kevin, his parents, and Tita Malou can all read to *prove* it happened. A smudged notebook can be disputed. A `Transfer` event cannot.

### The optional metadata, and the one thing to hold onto

`name()`, `symbol()`, `decimals()` aren't strictly required by EIP-20 (a token is valid without them), but essentially every real token includes them, and MetaMask uses them to display nicely: for WCR, `"Workshop Credit"`, `"WCR"`, and `18` (Dan gets very confused by that number in Lesson 9). Above all: tonight you read a **standard**, not an implementation. Your file will have **no function bodies** — it only declares the shape. Next lesson you inherit a hardened, audited *implementation* of this exact shape in one import line, instead of hand-writing the balance math. Learn the menu tonight. Let the barangay cook.

---

## Key Takeaways

- **ERC-20 is an interface — a shared shape, not a program.** A contract is a token if it offers the standard menu: 3 views, 3 writes, 2 events (metadata optional). `IWorkshopCredit` declares exactly that shape for WCR.
- **The 3 views read the ledger for free:** `totalSupply` (all credits that exist), `balanceOf(account)` (one holder's line), `allowance(owner, spender)` (how much a spender may still pull).
- **The 3 writes cost gas and leave receipts:** `transfer` moves *your own* credits; `approve` grants permission without moving anything; `transferFrom` lets a spender move *someone else's* credits within their allowance.
- **The allowance model (`approve` → `transferFrom`) is the reward store's engine** — no contract can touch your balance until you approve it first. This is Act 2's backbone.
- **The 2 events are the transparency payoff:** `Transfer` and `Approval` write permanent, searchable receipts to the public ledger — the reason a token beats a smudgeable notebook.
- **Learn the interface, not the implementation.** Tonight's file has no function bodies on purpose. You read *what* a token promises; next lesson you inherit a hardened *how* for free.

---

## What's Next?

Dan can now read the menu — six promises and two receipts — and he finally gets that a "token" isn't a magic object but a *shape you agree to*. So the obvious question hits him at 1 a.m.: *do I have to write all six function bodies myself? The balance math, the allowance checks, the event emissions — all correct, all safe?*

He does not. Tomorrow JM gets on a lab video call and shows him the single most relieving line of the course — one `import` that inherits a fully-audited, battle-tested implementation of this exact interface, written and hardened by OpenZeppelin and used in production by thousands of real tokens. It's the coding equivalent of **bayanihan**: don't rebuild what the barangay already built and made safe. Dan's job stops being "invent a token" and becomes "stand on the shoulders of one that already works."

**Next Lesson: Import OpenZeppelin's ERC20** — one line of inheritance, a deliberate compiler error, and the lesson of not rebuilding what the community already hardened.
