## Dan's Story: The Note in Tita Malou's Notebook

Last lesson the ledger pushed back. From an account holding only 100 WCR, Dan tried to `transfer` a thousand — and instead of a silent corruption, the transaction reverted, clean and loud, with `ERC20InsufficientBalance(sender, 100000000000000000000, 1000000000000000000000)`: what he had, what he asked for, nothing moved. He'd learned the ledger *protects* the numbers. But protection cuts both ways, and it left him stuck — because the reward store he keeps sketching has to take credits *out* of a student's account, and everything he knows so far says a contract simply **can't** reach into someone else's wallet.

Tuesday, mid-afternoon lull at the carinderia. Dan had a receipt flipped blank-side-up and was drawing boxes and arrows on it — the RewardStore, sketched for the tenth time. The loop in his head was simple until it wasn't: Kevin earns 200 WCR, Kevin wants a turon for 100 WCR, so the store... takes 100 WCR from Kevin. Easy. Except it wasn't.

> **Dan:** *(muttering)* `transfer` spends msg.sender's own balance. So if the store calls `transfer`, it spends the *store's* credits — hindi kay Kevin. The store would be paying Kevin to take the turon. Backwards.

He crossed out the box. Drew it again. Same wall.

> **Dan:** So the store has to pull *from* Kevin. Pero a contract can't just grab someone's WCR — kung kaya nun, kahit sinong masamang contract pwedeng ubusin ang balance ko. So how does *any* store ever charge *anyone*?

Tita Malou set a plate of turon down next to the receipt without being asked, reading the specific misery of a boy stuck on a problem.

> **Tita Malou:** Anak, ang lalim ng pagkakasulat mo diyan. Ano ba problema?
>
> **Dan:** I need the store to take credits *from* a student — but only up to a limit the student agrees to. Hindi lahat. And the store can't just reach in and take whatever it wants.

To Dan's surprise, she nodded like this was the most ordinary thing in the world.

> **Tita Malou:** Ay, ginagawa ko na yan. Si Popoy, anak ni Aling Vteng — pinapa-merienda dito after school. Sabi ni Aling Vteng, *"pwede si Popoy kumuha, pero hanggang singkwenta lang sa isang linggo."* Nakasulat sa notebook ko. Kaya pag kumuha si Popoy ng turon, tinsatsak ko, binabawas ko sa singkwenta. Pag naubos na, hindi na siya pwede hangga't hindi nagbabayad si Aling Vteng sa katapusan.

Dan stopped moving.

> **Dan:** Ma. Say that again — slower.
>
> **Tita Malou:** Si Popoy hindi hawak ang pera ko. Hindi ko binibigay sa kaniya ang cash drawer. *Aling Vteng* ang nagsabi kung magkano ang pwede. Ako ang kumukuha para kay Popoy, pero hanggang doon lang sa sinabi ni Aling Vteng. Wala akong kukunin na higit doon.

Three people, and Dan could suddenly see all of them as boxes on his receipt: Aling Vteng, who *owns* the money and *sets the limit*; the carinderia, *authorized to pull* but only up to that limit; and the notebook line — the *permission itself*, written down, checkable, that neither party can quietly change. He texted the whole thing to JM. The voice note came back fast.

> **Kuya JM:** Naks, si Tita Malou pala ang totoong sensei. She just described the **allowance model** — the exact machinery every reward store on Ethereum runs on. May function na `approve`. When Kevin calls `approve(store, 50)`, he's Aling Vteng writing the note: *"this specific spender may pull up to 50 of my WCR."* It moves not a single credit. It just records the permission, on-chain, in public.
>
> **Dan:** So `approve` is the note. Not the payment.
>
> **Kuya JM:** Exactly the note. Later may `transferFrom` — that's the carinderia actually handing Popoy a turon and crossing it off the fifty. Pero that's next week. Today you write the note, watch the ledger record it, and — importante — check na hindi bumaba ang balance ni Kevin kahit isang base unit. Because a note isn't a payment.

---

## The Concept: Permission First, Payment Later

### Why `transfer` alone can't build a store

Everything Dan has moved so far, he moved with `transfer(to, amount)` — and the quiet rule underneath it is that **`transfer` always spends the caller's own balance.** The sender is `msg.sender`, full stop. There is no version of `transfer` where *you* call it and *someone else's* credits move. That rule is a wall for a reward store:

```text
   Kevin wants a turon (100 WCR). The STORE must end up holding 100 WCR pulled from Kevin.

   If the STORE calls  transfer(store, 100)  -> spends the STORE's balance. Wrong direction.
   If KEVIN calls      transfer(store, 100)  -> works, but the store must TRUST Kevin to
                                                 click it, in the right amount, at the right
                                                 moment. A contract can't press a human's button.
```

So the store must pull *from* Kevin, on its own, when he buys. But if any contract could reach into any account, one malicious contract could drain everyone. The ledger's non-negotiable rule is the one Tita Malou lives by: **nobody takes your credits without your explicit, recorded permission.** `approve` is how you grant it.

### `approve(spender, amount)`: the note, not the payment

```solidity
function approve(address spender, uint256 amount) public returns (bool)
```

When you call `approve`, you are the **owner** (`msg.sender`). You name a **spender** and a **cap** in base units, and the function does exactly one thing: it records that the spender may pull *up to* that cap from *your* balance, later, via `transferFrom` (Lesson 18). What it does **not** do is move tokens. Read that twice — `approve` transfers **zero** credits. Your balance after is identical to before. You wrote a note; you paid nothing.

| | `transfer(to, amount)` | `approve(spender, amount)` |
|---|---|---|
| Moves tokens? | **Yes** — right now | **No** — zero tokens move |
| Whose balance changes? | Caller's down, receiver's up | **Nobody's** |
| What it records | A payment that already happened | A *permission* for a future pull |
| Event emitted | `Transfer(from, to, value)` | `Approval(owner, spender, value)` |
| Real-world twin | Handing over the cash | Writing "pwede kunin hanggang 50" in the notebook |

### The allowance is a note with two names on it

The permission lives in a mapping the ERC-20 keeps internally, keyed by **both** the owner and the spender:

```text
   allowance[owner][spender] = amount        (Aling Vteng's notebook line, generalized)

   allowance[ Kevin ][ RewardStore ] = 50 WCR   <-- the store may pull up to 50 from Kevin
   allowance[ Kevin ][ Jasper      ] = 0        <-- Jasper was never authorized; pulls nothing
   allowance[ Rina  ][ RewardStore ] = 0        <-- a note about KEVIN says nothing about Rina
```

Two keys, because a permission only means something as a *pair*: **who is allowing** and **whom they allow**. Kevin approving the store says nothing about Rina's credits and nothing about what Jasper may take. That specificity is the whole security model — you authorize exactly one spender, for exactly one amount.

### `Approval`: the ledger writes the note in public

Just as every `transfer` emits `Transfer`, every successful `approve` emits an **`Approval`** event:

```solidity
event Approval(address indexed owner, address indexed spender, uint256 value);
```

`owner` (the caller who granted it) and `spender` (who was authorized) are both `indexed`, so a block explorer can filter "every approval Kevin ever granted." The note isn't in Dan's private notebook where only he can read it — it's in the public log, where Kevin, the store, Tita Malou, and a stranger in another barangay all read the same line. That's the sixth character — the ledger — doing the one job the smudged paper never could.

### One sharp caveat: `approve` overwrites

Two things to file away, both of which matter next lesson:

1. **`approve` sets, it does not add.** `approve(store, 50)` then `approve(store, 20)` leaves the allowance at **20**, not 70 — the second note replaces the first. (You'll prove this in Lesson 17.)
2. **A large allowance is a large amount of trust.** The cap is the *most* a spender can ever pull across any number of future `transferFrom` calls. Approve 50, worst case you lose 50. Approve the maximum and you've handed a spender standing authorization over your whole balance.

---

## Key Takeaways

- **`transfer` only ever spends the caller's own balance** — which is why a reward store can't charge a student with `transfer`. It needs to pull *from* the student, with permission.
- **`approve(spender, amount)` grants that permission without moving any tokens.** It's the note ("pwede kunin hanggang 50"), not the payment — your balance is byte-for-byte unchanged after you approve.
- **The permission lives in `allowance[owner][spender]`** — keyed by *both* names, because "who is allowing" and "whom they allow" only mean something together.
- **Every successful `approve` emits `Approval(owner, spender, value)`**, both addresses indexed — the note is written in the public log, not a private notebook only Dan holds.
- **`approve` overwrites; it does not add.** A second approve replaces the first — approving 50 then 20 leaves 20.
- **Permission and payment are deliberately two separate acts** (`approve` today, `transferFrom` in Lesson 18) — the ledger keeps them apart so nothing moves without an explicit, recorded, public grant.

---

## What's Next?

Kevin's note is written and the ledger has it logged forever: *the store may pull up to 50 WCR.* But a note is only useful if the people relying on it can **read it back** — Tita Malou doesn't trust her merienda tab because she wrote it once, she trusts it because she can flip to that page any time and see the running number. Dan needs the same: a way to *ask the ledger* how much a spender is still allowed to pull, without trusting anyone's memory.

That's exactly one read-only call — `allowance(owner, spender)` — and Lesson 17 is where Dan queries the 50 WCR he just approved, then discovers this lesson's caveat firsthand: approving a *new* amount doesn't stack on the old one, it *replaces* it. Trust, but verify — and on a public ledger, anyone can.

**Next Lesson: Check Allowances** — reading `allowance(owner, spender)` to see, in a free call, exactly how much a spender may still pull.
