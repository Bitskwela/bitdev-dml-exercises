## Dan's Story: The Receipt Nobody Wrote

Last lesson Dan finally did the thing the smudged notebook never could: from the instructor account he called `transfer`, typed `100000000000000000000` base units — 100 WCR once you count the 18 decimals — and watched the balances snap into place. Instructor down to 900, Kevin up to 100. Remix flashed a green check. But that green check was something *Dan* saw, on *Dan's* screen. Kevin wasn't in the room. Tita Malou still filed the whole project under "scam yan, nakita ko sa Facebook." A balance only the teacher can see is just the notebook with extra steps.

Almost midnight in the dorm, Dan was re-running that transfer for the fourth time, chasing the small satisfaction of a thing that just *works*. Around the fourth run, the satisfaction curdled into a question.

> **Dan:** Okay, pero... paano malalaman ni Kevin? He's not sitting here. If I tell him "you have 100 WCR," that's just me saying a number again. Same as the notebook.

He looked harder at the Remix terminal. Under the green check, the receipt had a little caret he'd been ignoring for two lessons. He clicked it. The receipt unfolded — `status`, `from`, `to`, `gas` — and near the bottom, a field he'd never read: `logs`. Inside it, decoded and sitting in plain text:

```text
"event": "Transfer",
"from":  0x5B38Da6a...beddC4   (instructor)
"to":    0xAb8483F6...835cb2   (Kevin)
"value": "100000000000000000000"
```

Dan stopped moving. The contract had *announced* the transfer — not to him, to the whole log. He hadn't written that line. OpenZeppelin's `transfer` emitted it automatically, and the chain wrote it where no one can un-write it.

> **Dan:** Wait. I can *read* this. Kevin's address, my address, the amount. This isn't me telling Kevin a number. This is Kevin being able to *check*.

He fired a voice note to Kuya JM, who was — of course — awake.

> **Kuya JM:** Naks, you found the logs. That's the whole game, Dan. State is the balances — that's what changed. But an *event* is the contract shouting "here's exactly what I just did" into a public record. My team? We don't watch balances, we watch the `Transfer` events streaming in. The event *is* the receipt.
>
> **Dan:** And nobody can edit the receipt after?
>
> **Kuya JM:** It's baked into the transaction, and the transaction's baked into the block. Reading these calmly — same skill you built reading Rust errors in LutoCLI. Except this time the ledger isn't scolding you. It's *testifying* for you.

Dan thought about Tita Malou at the counter, arms crossed, certain this was a scam. He'd been dreading having to *convince* her. Now he realized he didn't have to. He just had to show her where to look.

> **Dan:** So when Ma asks "paano ko malalaman totoo yan" — I don't argue. I point at the log.

---

## The Concept: Events Are the Ledger's Receipts

### State changes; an event announces the change

Your balances moving is one thing. *Announcing* that they moved is another — that announcement is an **event**, written into the transaction's **log**.

| | Contract **state** (balances) | Event **logs** |
|---|---|---|
| Readable by anyone off-chain | Yes, via a `view` call | Yes, via the transaction log |
| Readable *from inside another contract* | Yes | **No** — logs are for off-chain readers only |
| Cost to write | Expensive (storage) | Cheap (logs) |
| Main purpose | The current truth | The **history** of how we got here |

`balanceOf(Kevin)` tells you Kevin has 100 WCR *right now*. The `Transfer` event tells you *how* he got it, *when*, and *from whom* — permanently.

### The Transfer event, line by line

Dan never wrote this event. He inherited it from OpenZeppelin's `ERC20`, which declares exactly what EIP-20 requires:

```solidity
event Transfer(address indexed from, address indexed to, uint256 value);
```

| Part | What it holds | `indexed`? |
|------|---------------|-----------|
| `from` | The address credits left | **Yes** |
| `to` | The address credits arrived at | **Yes** |
| `value` | How many base units moved | No |

Every `transfer`, `transferFrom`, mint, and burn on *any* ERC-20 emits this same shape. Learn to read one, you can read them all.

### `indexed` vs not: topics and data

Under the hood a log entry has two compartments. **Topics** are up to 4 slots of 32 bytes each — `topic[0]` is *always* the event's signature hash, and each `indexed` parameter takes another slot. **Data** is a blob holding every *non-indexed* parameter.

```text
   A Transfer log entry
   topics[0]  keccak256("Transfer(address,address,uint256)")   <- which event
              = 0xddf252ad...523b3ef
   topics[1]  from   (indexed, padded to 32 bytes)             <- searchable
   topics[2]  to     (indexed, padded to 32 bytes)             <- searchable
   data       value  (not indexed)                             <- just stored
```

Why index `from` and `to` but not `value`? Because **topics are searchable and data is not.** You filter by *who* ("every Transfer to Kevin"), almost never by *how much*. `topic[0]`, the signature hash `0xddf252ad...523b3ef`, is how a reader knows a raw log is a `Transfer` and not an `Approval` — and it's identical on every ERC-20 ever deployed.

### How explorers (and Remix) read them

On the raw chain that log is just hashes and padded hex. A site like Etherscan **decodes** it using the token's ABI: read `topic[0]` → "this is a Transfer" → slot `topic[1]` into `from`, `topic[2]` into `to`, decode `data` into `value` → render a human row. The "Transfers" tab on any token page is *nothing but* its full `Transfer` event history, decoded. Remix does the exact same decoding locally, which is what Dan stumbled into.

### Emitting your own event

You can also declare and fire your *own* events. `Transfer` records *who* and *how much*; sometimes you want to also record *why*. Dan will add one:

```solidity
event CreditsAwarded(address indexed to, uint256 amount, string note);
```

Then a helper that transfers **and** leaves a human-readable reason on the log:

```solidity
function awardWithNote(address to, uint256 amount, string calldata note) external {
    transfer(to, amount);                     // fires the inherited Transfer event
    emit CreditsAwarded(to, amount, note);    // your extra receipt: the "why"
}
```

One call, two receipts: the automatic `Transfer` (who/how-much) and your `CreditsAwarded` carrying `"linked-list exercise, week 3"`. `emit` is the keyword that writes an event to the log.

### The transparency payoff

Here is the emotional turn of the whole course, and it happens right here. The Lesson 1 notebook was untrustworthy because one person held it and one person could edit it. An event log is the opposite on both counts: **written by the transaction itself**, **as permanent as the block**, **readable by anyone**. So the sentence Dan feared — *"paano ko malalaman na totoo?"* — stops being an argument he has to win. It becomes a place he can point.

---

## Key Takeaways

- **An event is the ledger's receipt.** State records the current truth; the `Transfer` event records the *history* — permanently, publicly, written by the transaction itself, not by the teacher.
- **`Transfer(address indexed from, address indexed to, uint256 value)`** fires on every transfer, transferFrom, mint, and burn of any ERC-20 — inherited from OpenZeppelin, never written by you.
- **`indexed` params become searchable topics; everything else goes in `data`.** `from` and `to` are indexed so you can filter "every transfer to Kevin"; `value` is not, because you search by *who*, not *how much*.
- **`topic[0]` is the event's signature hash** — `0xddf252ad...523b3ef` for Transfer — how explorers identify a raw log before decoding it.
- **Block explorers and Remix just decode** the raw topics+data using the ABI; the "Transfers" tab is literally the token's full `Transfer` event history.
- **You can emit your own events too.** `event` declares the shape, `emit` writes it — `awardWithNote` fires the automatic `Transfer` *and* a custom `CreditsAwarded` carrying the reason.
- **This is the transparency payoff.** The number is no longer something you must be trusted about — it's something anyone can read and verify.

---

## What's Next?

Dan can now read every credit that moves. But a ledger you can trust isn't only one that records what happened — it's one that *refuses* to record what shouldn't. So far every transfer Dan tried has succeeded. What happens when he asks the token to do something it can't allow?

In Lesson 15, Dan gets greedy on purpose: he tries to send more WCR than an account holds. The token won't crash, and it won't quietly let the numbers go negative. It will **revert** — cleanly refuse, undo everything, and hand back a precise reason: `ERC20InsufficientBalance(sender, balance, needed)`, with the real numbers filled in. Learning to read a revert is just as important as learning to read a receipt.

**Next Lesson: Test Failed Transfers** — meeting your first revert, and why a refusal is the ledger doing its job.
