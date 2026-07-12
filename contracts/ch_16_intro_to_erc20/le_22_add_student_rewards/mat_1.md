## Dan's Story: The Number Without the Reason

Last lesson Ate Rina asked the question that made WCR worth something — *"Who can mint, bata?"* Dan made WorkshopCredit `is ERC20, Ownable`, added `Ownable(msg.sender)`, and wrapped minting in `onlyOwner`. From the instructor account `mint` works; from a student account the ledger refuses with `OwnableUnauthorizedAccount`. Nobody but Dan can print credits now. But there's a gap he's about to notice: `mint` records that 200 WCR appeared in Kevin's balance. It does **not** record *why* — and the why was the whole reason the notebook existed.

Tuesday night, lab empty except for the aircon's hum and Dan's secondhand laptop. He'd just run `mint(kevin, 200 * 10**18)`, watched Kevin's balance jump to 200 WCR, and felt good about it for exactly four seconds. Then he opened the transaction log to admire his work, and the good feeling curdled.

> **Dan:** Wait. This just says 200 WCR moved to Kevin. It doesn't say it was for the final exercise. It looks *exactly* like if I'd minted him 200 for no reason at all. Or for a bribe. Or by accident.

He scrolled back through his old paper notebook — the smudged one this whole course was meant to replace. There, in his own handwriting next to Kevin's name: *"+50 attendance Jan 18. +100 finished ex 3. +200 final exercise."* The paper notebook was a disaster in every way except one. It always said **why**.

> **Dan:** Naku. I built a ledger nobody can erase, and the first thing I did was throw away the one column that mattered.

He voice-noted JM, half-embarrassed.

> **Dan:** Kuya, my mint works, onlyOwner and everything. But the log just shows a number. Kevin can prove he *got* 200 WCR. He can't prove it was for the final exercise. It's a number floating with no story.
>
> **Kuya JM:** Ay, good catch, Dan — and it's a real thing we hit at work. A transfer of value with no *memo* is auditable but not *understandable*. Yung magagaling na sari-sari listahan, hindi lang "utang 50" — "utang 50, Nescafe at pandesal, Lunes." The reason is half the trust. Pag may dispute, the reason is what settles it.
>
> **Dan:** So I need a memo column. On-chain.
>
> **Kuya JM:** Exactly. And here's the beautiful part — you're already emitting events. Every transfer drops a `Transfer` log. You can write your *own* event, with your own fields, including a plain-text reason. Then the reason lives in the log forever, public, next to the amount. The notebook column becomes part of the ledger.

Dan sat back. He'd spent Act 2 learning to *read* the ledger's events. It hadn't occurred to him he was allowed to *write* one.

> **Dan:** I can make my own event? With whatever fields I want?
>
> **Kuya JM:** It's your contract, Dan. ERC-20 gives you `Transfer` and `Approval` for free. Nothing stops you from adding `StudentRewarded(who, how much, why)` on top. That's the difference between *using* a token and *building* an application. The turon is ERC-20. The *reason you earned the turon* — that's yours to design.

---

## The Concept: Application Events as an Audit Trail

### ERC-20 gives you the money. You add the meaning.

An ERC-20 token knows about balances and transfers. That's it. It's deliberately generic — the same standard runs stablecoins, game gold, and workshop credits, so it can't know that *this* particular mint was for finishing exercise 3. That meaning is **application-specific**, and it's your job to add it, two ways:

1. **A custom function** — `rewardStudent(...)` — that says what your app actually does, in your app's own words, instead of a bare, generic `mint`.
2. **A custom event** — `StudentRewarded(...)` — that writes the *reason* into the permanent, public log alongside the amount.

```text
  GENERIC ERC-20 LAYER          <- OpenZeppelin gives you this
  --------------------
  balances, transfer, approve
  Transfer / Approval events
        |
        |  you build ON TOP
        v
  YOUR APPLICATION LAYER        <- you write this
  --------------------
  rewardStudent(student, amount, reason)
  StudentRewarded(student, amount, reason) event
```

### What an event actually is

An **event** is a log entry a transaction leaves behind on-chain. It changes no balance and no other contract can read it back — it exists purely to be **read by humans and off-chain tools** (block explorers, dashboards, Kevin's phone). It's the ledger's receipt drawer. You've met two already: `Transfer(from, to, value)` and `Approval(owner, spender, value)`. Now you declare your own:

```solidity
event StudentRewarded(address indexed student, uint256 amount, string reason);
```

Read it left to right: *"a student was rewarded — here is who, here is how much, and here is why."*

### `indexed`: the searchable columns vs the readable columns

That `indexed` keyword on `student` matters. Every event parameter is stored one of two ways:

| | `indexed` params | non-`indexed` params |
|---|---|---|
| Stored as | **topics** — a searchable index | **data** — the log body |
| Max per event | 3 | unlimited |
| Superpower | you can *filter* by them | carried along, not filterable |
| Example use | "every reward to **this** student" | the amount, the reason text |

Marking `student` as `indexed` lets a block explorer answer *"list every `StudentRewarded` where student = Kevin"* instantly — like a database index on the `student` column. `amount` and `reason` ride along in the data section: you read them, but you don't search by them.

**A trap worth knowing now:** you *can* mark a `string` as `indexed`, but you almost never should. Solidity can't fit an arbitrary-length string into a fixed-size topic, so it stores the **keccak256 hash** of the string instead of the string itself. You'd be able to check "does this equal that exact reason?" but you could **never read the reason back** — the plain text is gone, replaced by a 32-byte fingerprint. Since the entire point of `reason` is to be *read by a human*, it must stay **non-indexed**. Index what you search; leave readable what you read.

### `string calldata`: why not `memory`?

The reason arrives as a function argument, and `string` is variable-length, so Solidity needs to know *where* it lives. Two choices matter here:

- **`calldata`** — the read-only region where a transaction's incoming arguments already sit. The function reads `reason` straight from there. No copy, cheaper gas.
- **`memory`** — a scratch space the function can write to. Using it would force Solidity to **copy** the string in from calldata first, for no benefit — we never modify `reason`, we only read it and emit it.

Rule of thumb: **for an external function argument you only read, use `calldata`.** It's the cheaper, honest choice, and it signals "I will not mutate this." (This should feel familiar from Rust's borrow-vs-own instinct — take a reference when you're only looking.)

### Why a reason on-chain beats a note in a spreadsheet

Dan's paper notebook had the reason column and no trust. A private spreadsheet would be the same thing with cleaner handwriting — Dan could still edit any cell after the fact, and no student could check it. Put the reason in an **event** and three things change at once:

```text
  SPREADSHEET NOTE                 ON-CHAIN EVENT (StudentRewarded)
  ----------------                 --------------------------------
  Dan can edit it later            written by the transaction, immutable
  only Dan can see it              anyone can read it — Kevin, his parents, Ma
  lives on Dan's machine           lives on every node, forever
  "trust my handwriting"           "trust the ledger, not me"
```

The reason is emitted *by the same transaction* that mints the credits — welded together in one permanent record. When Kevin says *"tapos ko na yung final exercise, bakit—"* the answer isn't Dan's memory or Dan's notebook. It's a public log entry that says `200 WCR — "Finished final exercise"`, and nobody, not even Dan, can quietly change it. That is **tiwala** you can point at.

---

## Key Takeaways

- **ERC-20 gives you value; you add meaning.** Application functions like `rewardStudent` and custom events like `StudentRewarded` are the layer *you* build on top of the generic token.
- **Events are the ledger's permanent, public receipt drawer.** They change no balances and no contract reads them back — they exist to be read by humans and explorers, immutably, forever.
- **`indexed` = searchable; non-`indexed` = readable.** Up to 3 indexed params become filterable topics; index what you'll search by (the `student`), leave readable what you read (the `reason`).
- **Never `indexed` a string you want to read** — it's stored as a keccak256 hash, so the plain text is lost. `reason` stays non-indexed on purpose.
- **`string calldata` for read-only arguments** avoids an unnecessary copy into `memory` — cheaper gas, and it signals "I only read this."
- **`_mint` emits a `Transfer` from the zero address**, and your `StudentRewarded` rides alongside it in the same transaction — two receipts, one call.
- **An on-chain reason beats a spreadsheet note for tiwala:** it's immutable, public, and welded to the same transaction that moved the credits. Trust the ledger, not Dan's handwriting.

---

## What's Next?

Dan can now *create* credits with a reason attached, and the ledger tells the truth about why every WCR exists. But the story only runs one way so far — credits are minted into the world and they stay there. What happens when Kevin actually walks up to Tita Malou's counter and redeems 100 WCR for a turon?

Right now: nothing leaves. The RewardStore would just *hold* the WCR it collects, and `totalSupply` would keep climbing forever, even as credits get "spent." That's a lie the ledger shouldn't tell — a claimed turon should mean those 100 credits are *gone, ubos na*. Next lesson Dan learns the mirror image of minting: **burning**. `_burn` reduces a balance *and* shrinks `totalSupply`, so a claimed reward genuinely leaves circulation — and the supply number finally tells the true story of how many credits are still live.

**Next Lesson: Add Token Burning** — `_burn`, redemption, and making `totalSupply` honest when credits are spent.
