## Dan's Story: The Ledger Refuses

Last lesson Dan stopped being scared of the ledger and started *reading* it. He opened the receipt of his 100 WCR transfer to Kevin, expanded the `logs`, and there it was — a decoded `Transfer` event with `from`, `to`, and `value` spelled out in plain fields. *"I can read this. So can Kevin. So can Ma."* The ledger had turned from a black box into a receipt anyone could audit. But reading a transfer that *worked* only proves the happy path. Dan still had a nagging question — the same one Tita Malou would ask if she sat beside him: what stops a student from spending credits they don't actually have?

Wednesday afternoon, computer lab, empty except for Dan and the hum of the aircon. His WorkshopCredit was still deployed from last time — instructor at 900 WCR, Kevin's account holding exactly 100.

> **Dan:** What if it goes the other way? What if somebody tries to spend a hundred credits when they only have ten? Sa notebook... honestly, I'd probably just not notice. Or I'd cross something out. Naks, the numbers would just... stop adding up.

That was the thing about the paper listahan. Nothing *enforced* it. It trusted Dan's arithmetic, and Dan's arithmetic ran on merienda and four hours of sleep. So he decided to attack his own contract. He switched the Remix account dropdown to Kevin's address — the one holding 100 WCR — and typed a transfer he *knew* was a lie: send 1,000 WCR to a third account. Ten times more than Kevin had. He hit `transact`, half-expecting the balances to just go weird.

Instead the terminal flashed red and stopped him cold.

```text
transact to WorkshopCredit.transfer errored: Error occurred: revert.
Error provided by the contract:
ERC20InsufficientBalance
```

Nothing moved. Kevin's balance: still exactly 100 WCR. The recipient: still 0. Total supply: unchanged. The bad transfer hadn't half-happened, hadn't left a mess, hadn't quietly gone negative. It had been *refused* — and the ledger looked exactly as it did one second before he pressed the button. He messaged JM a screenshot. The voice note came back fast.

> **Kuya JM:** Ayan! That, Dan, is a *revert*. Ganito isipin mo — parang GCash. Try mong mag-send ng five thousand kung tatlong daan lang ang laman. Hindi ka nito bibigyan ng "partial send," diba? It just says insufficient balance and *walang gumagalaw*. Zero pesos leave your wallet. All-or-nothing.
>
> **Dan:** So it's like the compiler in LutoCLI. Rust refused to build the bug before it could crash Ma. This... refused to move the numbers before they could go wrong.
>
> **Kuya JM:** Exactly the same instinct, iba lang ang lugar. Doon, the compiler refuses at your desk. Dito, *the ledger refuses* — on-chain, every time. You don't have to remember to check. The token checks for you, forever, kahit tulog ka.

Dan stared at Kevin's unchanged 100. In the notebook, protecting that number was *his* job, and he was bad at it. Here it was the ledger's job, and the ledger never got tired.

> **Dan:** Okay. So how does it know? And bakit red pa rin — parang may mali kahit walang nasira?

That was the right question. Something *did* happen. It just wasn't what he expected.

---

## The Concept: What a Revert Actually Does

### A refusal, not a crash

When Dan's Python report hit a blank cell back in the Rust course, it *crashed* — died mid-run, leaving half its output on the screen. A revert is the opposite. A revert is the token looking at what you asked for, deciding it breaks the rules, and **cleanly undoing everything as if you never asked.**

```text
   THE NOTEBOOK (no enforcement)        THE LEDGER (revert)
   ----------------------------         -------------------
   Kevin has 100. Sends 1000.           Kevin has 100. Sends 1000.
        |                                    |
        v                                    v
   Dan crosses out, guesses,            check: 100 < 1000 ?  YES
   writes "-900"?? or forgets           => REVERT
        |                                    |
        v                                    v
   ledger now LIES                      Kevin still has 100.
   (or silently wrong)                  Nothing changed. No lie told.
```

### Revert = all-or-nothing (atomicity)

The key word is **atomic**: a transaction either completes *entirely* or has *no effect at all*. There is no in-between where half the work got done — exactly JM's GCash point. Picture a transfer as steps the token runs internally:

```text
  transfer(recipient, 1000 WCR) from Kevin (balance 100):

   step 1:  check Kevin's balance >= 1000    <-- FAILS HERE (100 < 1000)
   step 2:  subtract 1000 from Kevin         <-- never runs
   step 3:  add 1000 to recipient            <-- never runs
   step 4:  emit Transfer event              <-- never runs

  Because step 1 failed, the whole transaction REVERTS.
  Even if step 2 had already run, it would be UNDONE.
  Final state = the state before the transaction. Byte for byte.
```

That "even if it already ran, it gets undone" is the powerful part: a revert rolls *all* storage changes back to the pre-transaction snapshot. The ledger is never left half-finished — which is why it can be trusted without Dan double-checking.

### The check that fires it — inherited, not written

Dan asked *how does it know?* He wrote no balance-checking code — he inherited OpenZeppelin's ERC20. The check lives **inside** the inherited `transfer`, deep in OZ's internal `_update`, essentially:

```solidity
// Simplified from OpenZeppelin's ERC20 internals — you inherit this for free.
if (fromBalance < value) {
    revert ERC20InsufficientBalance(from, fromBalance, value);
}
```

`revert` is the keyword that triggers the all-or-nothing rewind. And notice what it reverts *with*: not a plain sentence, but a structured **custom error** carrying three pieces of data.

### Custom errors, not string messages

Older Solidity (and OpenZeppelin **v4**) wrote failures as `require` with a string:

```solidity
// OLD STYLE (OpenZeppelin v4 and earlier) — you will NOT see this inside WCR.
require(fromBalance >= value, "ERC20: transfer amount exceeds balance");
```

OpenZeppelin **v5** — the version WCR is built on — replaced every one of those strings with a **custom error**, declared like a function signature:

```solidity
// NEW STYLE (OpenZeppelin v5) — what actually protects your WCR.
error ERC20InsufficientBalance(address sender, uint256 balance, uint256 needed);
```

The difference is not cosmetic:

| | String `require` (old) | Custom error (OZ v5) |
|---|---|---|
| What comes back | A hardcoded sentence | A named error + typed data |
| Tells you the numbers? | No — just "exceeds balance" | **Yes** — the exact balance you had *and* the amount you needed |
| Gas to store the message | Higher (whole string ships) | Lower (4-byte selector + values) |
| Machine-readable | Awkward (string-match) | Clean (decode like structured data) |

So the revert isn't just "no." It's **"no, and here's the receipt for the refusal"**: who tried (`sender`), what they actually had (`balance`), what the attempt required (`needed`). For a token whose whole pitch to Tita Malou is *"you can see everything,"* a refusal you can read is as valuable as a transfer you can read.

### A friendly guard on top — and why it's optional

You *can* add your own pre-check with a human-friendly message. This lesson's `sendExactly` does exactly that:

```solidity
function sendExactly(address to, uint256 amount) external {
    require(balanceOf(msg.sender) >= amount, "WCR: not enough credits");
    transfer(to, amount);
}
```

But understand what this `require` really is: a **courtesy**, not the safety net. Even if you deleted it, `transfer` would *still* revert with `ERC20InsufficientBalance` — the protection is inherited and unavoidable. The friendly string just fails one step earlier with a message a beginner reads faster. The real, always-on guard is OZ's custom error underneath.

### The honest caveat: a revert still costs gas

Here's where the ledger and the Rust compiler part ways — *bakit red pa rin?* Rust's refusal was **free**: compile time, at Dan's desk, before any program ran. A revert happens at **runtime, on-chain**. The network received the transaction, ran it far enough to hit the failing check, then rewound. That work isn't free. Two things survive a revert — **the gas is spent** and **the failed attempt is recorded** — but the balances and supply it tried to corrupt stay untouched. On a testnet that gas is free test-ETH, so the toll is basically a lesson fee. The protection is the point.

---

## Key Takeaways

- **A revert is a refusal, not a crash.** The token inspects your request, decides it breaks a rule, and cleanly rewinds — it never limps forward and corrupts the ledger the way paper could.
- **Reverts are atomic — all-or-nothing.** A transaction completes entirely or has *no effect at all*; even changes made partway through are undone to the exact pre-transaction state.
- **Balance validation is inherited, not written by you.** OpenZeppelin's `transfer` checks `fromBalance >= value` internally and reverts if it fails — you get it free by inheriting ERC20.
- **OZ v5 uses CUSTOM ERRORS, not string messages.** Insufficient balance reverts with `ERC20InsufficientBalance(address sender, uint256 balance, uint256 needed)` — carrying the real numbers — instead of an old v4 `require` string. Cheaper on gas and machine-readable.
- **The refusal comes with a receipt.** `sender`, `balance`, and `needed` tell you who tried, what they held, and what the attempt required — a refusal you can audit, like a transfer you can audit.
- **A friendly `require` is optional sugar.** `sendExactly`'s `"WCR: not enough credits"` fails one step earlier with a nicer message, but the inherited custom error is the guard that can't be removed.
- **A revert still costs gas, but never state.** Unlike Rust's free compile-time refusal, an on-chain revert charges for work done before failing and records the failed attempt — the balances it targeted stay untouched.

---

## What's Next?

The ledger now protects credits people *have*. But Dan's reward store has a harder need: he wants a student to spend WCR at a counter Tita Malou runs — which means some *other* address must be allowed to move a student's credits, on their behalf, up to a limit. A plain `transfer` can't do that; it only ever spends the caller's own balance.

The answer is the **allowance model** — the machinery every reward store, DEX, and on-chain checkout runs on. You `approve` a spender to pull *up to* a set amount, without handing over your whole balance. JM already has the analogy: *"parang nag-iwan ka ng 'pwede kunin hanggang 50' na budget sa tindera — hanggang doon lang."* No credits move when you approve — you're just granting permission, logged as an `Approval` event.

**Next Lesson: Approve a Spender** — the allowance model, and letting someone else spend your credits without giving them everything.
