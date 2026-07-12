## Dan's Story: The First Line That Wasn't a Photograph

Last session Dan turned the deployed WorkshopCredit into a *readable* thing. He clicked the blue buttons — `name()`, `symbol()`, `decimals()`, `totalSupply()`, `balanceOf(...)` — and filled a whole worksheet without spending a single unit of gas. The instructor account held 1,000 WCR, a fresh student account held 0, and the ledger answered honestly. But every one of those calls was a *read*. Nothing moved. The worksheet was a photograph of a ledger that had never had a second entry.

Late afternoon in the computer lab, everyone else gone for merienda, that worksheet taped to the side of the monitor:

```text
WCR worksheet
  name .......... Workshop Credit
  symbol ........ WCR
  decimals ...... 18
  totalSupply ... 1000 WCR
  instructor .... 1000 WCR   (0x5B38...ddC4)
  student ....... 0 WCR      (0xAb84...5cb2)
```

Clean, correct, and completely, uselessly frozen. Every number was something he'd *looked at*, never something he'd *done*. It was the notebook all over again, just prettier — a record of a workshop where nobody had earned anything yet.

Then he remembered why he started this. Lesson 1. Kevin at the front of the barangay hall, insisting he'd finished the exercise, owed his credits — and the smudged notebook unable to prove him right *or* wrong. That was the fight that sent Dan to Kuya JM in the first place.

> **Dan:** Okay. So teach me the part that would have settled it. If Kevin's owed 100 credits... how do I actually *give* them to him? Where I can't take them back with an eraser?
>
> **Kuya JM:** Aba, finally the good part. Sa utang notebook, you'd cross out 100 from your line and write 100 on Kevin's line, diba? Two strokes of a pen. The token has exactly one function for that — `transfer`. You say who gets it and how much, tapos yun na, the ledger moves it from your balance to his. Pero ang difference: walang eraser. The move becomes a permanent line na kahit ikaw, hindi mo na mababago.

> **Dan:** So I'm the one holding the 1,000. I call transfer, Kevin's balance goes up, mine goes down.
>
> **Kuya JM:** Exactly. And dito ka mag-ingat: `transfer` always spends the credits of whoever's *calling* it. There's no "from" to fill in. The sender is just... you, kasi ikaw ang pumipirma. Tandaan mo yun — susubukan kang lituhin ng detalye na yun.

Dan looked at the account dropdown — instructor selected, 1,000 WCR sitting in it — and at the second account he'd mentally labeled *Kevin*. For the first time in this whole course, he wasn't about to read a number. He was about to move one.

> **Dan:** *(under his breath)* It's just two strokes of a pen. Except this pen tells the truth.

---

## The Concept: Moving Credits Nobody Can Un-Move

### `transfer` moves the CALLER's own tokens

The core write in ERC-20 is one line:

```solidity
function transfer(address to, uint256 amount) public returns (bool)
```

Read it slowly, because the most important part is the part that *isn't there*: **there is no `from` parameter.** You tell `transfer` two things — *who* receives (`to`) and *how much* (`amount`). You never tell it who sends. It already knows.

The sender is **`msg.sender`** — a value Solidity fills in for you: the address that called the function. When the instructor clicks `transfer`, `msg.sender` *is* the instructor; when Kevin clicks it, `msg.sender` *is* Kevin. `transfer` always debits the caller's own balance and nobody else's. This is a safety rule baked into every ERC-20: **you can only move credits that are yours.** (Moving *someone else's* credits is a different, permission-based mechanism — the allowance model — and it waits for Lesson 16.)

| The utang notebook | The `transfer` call |
|---|---|
| Cross out 100 from your own line | `msg.sender`'s balance goes down by `amount` |
| Write 100 on Kevin's line | `to`'s balance goes up by `amount` |
| Total debt in the book unchanged | `totalSupply` unchanged — nothing created, only moved |
| You *could* quietly erase it later | You cannot — the move is a permanent, public line |

### The amount is in base units, not WCR

Remember Lesson 9's centavo lesson, because it's about to bite anyone who forgets it. On-chain, WCR has no decimal point. `decimals()` is 18, so every "1 WCR" a human sees is really `1 * 10**18` = `1000000000000000000` **base units**. `transfer` speaks *only* base units.

So to send Kevin **100 WCR**, you do not type `100` — that would send 100 base units, `0.0000000000000001 WCR`, a speck that rounds to nothing. To send a real 100 WCR you enter:

```text
100 * 10**18  =  100000000000000000000
```

A `1`, two zeros for the hundred, eighteen more for the decimals — **twenty zeros total.** Remix won't compute `100 * 10**18` for you; you paste the final number. Count the zeros twice. This is the single most common beginner mistake with ERC-20.

### What actually changes: two balances, one event

A successful `transfer` does exactly three things and not one thing more:

```text
BEFORE   instructor 0x5B38...ddC4 : 1000 WCR
         Kevin      0xAb84...5cb2 :    0 WCR   |  total 1000

   instructor calls transfer( Kevin , 100000000000000000000 )
        msg.sender = instructor          amount in BASE UNITS
        (the SENDER is whoever signs — never a parameter you pass)

AFTER    instructor 0x5B38...ddC4 :  900 WCR   (-100)
         Kevin      0xAb84...5cb2 :  100 WCR   (+100)  |  total 1000 (UNCHANGED)
```

1. `msg.sender`'s balance decreases by `amount`.
2. `to`'s balance increases by `amount`.
3. The contract **emits a `Transfer(from, to, value)` event** — a permanent line in the transaction log anyone can later read.

Notice what *doesn't* change: `totalSupply`. `transfer` never creates or destroys credits, it only relocates them — the books stay balanced. That third thing, the event, is the ledger's receipt: the tamper-proof proof that would have ended the Kevin argument in one glance. You'll pry it open field by field in Lesson 14; today, just know a successful transfer leaves one behind. And if the caller tries to send more than they hold, `transfer` doesn't do half the job — it **reverts**, undoing everything (that's Lesson 15). Today we stay on the happy path.

### One transfer, or a whole class at once

`transfer` moves credits to one person. But a workshop has thirty students, and clicking `transfer` thirty times is exactly the kind of tedium the ledger was supposed to fix. Because `transfer` is just a function, you can call it in a **loop**: an `awardClass(students, amountEach)` walks a list of addresses and calls `transfer` for each one. Every iteration spends *your* balance (the caller is always `msg.sender`), so a single click can hand the same amount to a whole roster. That's your activity — the same honest, un-erasable move, batched.

---

## Key Takeaways

- **`transfer(to, amount)` moves the caller's OWN tokens** — there is no `from` parameter. The sender is `msg.sender`, the address that signed the call, filled in by Solidity.
- **You can only move credits you actually hold.** Moving someone else's credits requires the separate allowance model (Lessons 16-18), not `transfer`.
- **Amounts are always base units.** With `decimals() == 18`, a real 100 WCR is `100 * 10**18` = `100000000000000000000`. Typing `100` sends a near-invisible speck — count the zeros.
- **A successful transfer changes exactly two balances** — sender down, receiver up — and **leaves `totalSupply` untouched.** Credits are relocated, never created or destroyed.
- **Every transfer emits a `Transfer` event** and returns `bool: true` on success — a permanent, public receipt in the log.
- **`transfer` in a loop batches the move** — an `awardClass` can pay a whole roster from the caller's balance in one click, each iteration still a real, un-erasable transfer.

---

## What's Next?

Dan moved 100 WCR and watched the balances update, but he half-noticed something scroll past in the receipt: `logs: 1`. One event. The contract didn't just move the credits — it *wrote down that it moved them*, in a place Dan didn't put it and can't take out. That log line is the difference between a change and a *provable* change.

In Lesson 14, Dan opens that receipt all the way and reads the `Transfer` event field by field — `from`, `to`, `value` — and realizes the thing that flips this course from scary to trustworthy: *he can read this. So can Kevin. So can Ma.*

**Next Lesson: Inspect Transfer Events** — cracking open the transaction log to find the `Transfer` receipt the ledger just wrote for you.
