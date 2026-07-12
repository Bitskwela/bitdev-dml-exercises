## Dan's Story: The Pull

Last lesson Dan stopped trusting his own memory and asked the ledger directly: `allowance(Kevin, store)` answered `50000000000000000000` — 50 WCR, the exact cap he'd approved, sitting there in black and white. He felt organized. Then JM put a splinter in it: *"Okay, the permission's there. Pero, Dan — walang gumalaw. Fifty WCR na pwedeng kunin, pero wala pang kinuha. A promise isn't a payment yet."* Not a single credit had actually moved.

Lab, past ten, everyone else gone home. Dan had two things on his screen and a gap between them he couldn't close. Thing one: Kevin's account held 100 WCR. Thing two: Kevin had `approve`d a second account — the one Dan was mentally labeling *"the store"* — to spend up to 50 of them. The `allowance` read `50`. Everything was staged. And yet if Dan just sat there, nothing would ever happen. Approving hadn't moved money. It had only unlocked a door.

> **Dan:** So I approved. The store is *allowed* to take fifty. But... how does it actually *take* it? `approve` didn't move anything — Kevin still has all hundred.

He voice-noted JM, half-expecting to be told he'd missed a step.

> **Kuya JM:** You didn't miss anything, that's the design. Two different actions, dalawang tao. `approve` is Kevin saying "pwede kang kumuha, up to fifty." That's *permission*. `transferFrom` is the *store* reaching in and actually pulling the credits — up to whatever Kevin allowed, hindi lahat. Kevin grants; the store pulls. Iba yung nag-a-approve sa nag-transferFrom.

Dan sat back. It landed like a coin dropping.

> **Dan:** So the person who *owns* the credits isn't the one who moves them this time. The *store* moves them — out of Kevin's balance — because Kevin said it could.
>
> **Kuya JM:** Ayan. Alam mo yung budget na iniiwan mo sa tindera? "Kuya, kung kulang ako, kunin mo na lang sa deposit ko, hanggang fifty lang ha." The tindera doesn't ask you again each time — she just takes it, up to fifty, and your deposit goes down. Sobra sa fifty? Hindi niya pwede. That cap is the allowance. `transferFrom` is her hand reaching into the jar.

Tita Malou was wiping the last table, close enough to catch the word *kunin*.

> **Tita Malou:** Kunin? So pwede na palang kunin ng iba ang pera ni Kevin? Anak, ayan na naman — mananakawan lang kayo diyan.
>
> **Dan:** Hindi basta-basta, Ma. Only up to the fifty Kevin himself approved — hindi kayang lampasan. And every credit na kinuha, nakasulat sa ledger kung sino kumuha, kanino, magkano. Kung may kinuhang hindi dapat, kita agad. That's the opposite of nakawan — it's *nakikita*.

She grunted, not convinced, but she stayed to watch — which by now Dan knew was her version of *sige, patunayan mo*. He switched the Remix account dropdown away from Kevin, over to the store account, cracked his knuckles, and got ready to reach into the jar.

---

## The Concept: transferFrom — Permission Becomes Payment

### Two ways credits move: `transfer` vs `transferFrom`

You met `transfer` in Lesson 13: it moves **your own** credits. `msg.sender` — the caller — is always the one whose balance drops. There is no way to make `transfer` spend someone *else's* balance. That's the safety rule the whole ERC-20 rests on: **nobody can reach into your account.**

But a reward store *needs* to reach into a buyer's account — that's how it collects payment. The allowance model is the escape hatch, and `transferFrom` is the move that uses it.

| | `transfer(to, amount)` | `transferFrom(from, to, amount)` |
|---|---|---|
| Whose credits move? | `msg.sender`'s own | `from`'s (someone else's) |
| Who may call it? | Anyone (spends their own) | Only a spender **`from` approved** |
| What must be true first? | Caller has the balance | Caller has enough **allowance** *and* `from` has the balance |
| Touches an allowance? | No | **Yes — it decreases it** |
| Event emitted | `Transfer` | `Transfer` |

Same destination, completely different permission story. `transfer` is you handing over your own credits. `transferFrom` is a third party pulling credits *out of someone else's account*, with that someone's prior blessing.

### The three addresses in `transferFrom`

`transfer` has two roles. `transferFrom` has **three**, and keeping them straight is the whole lesson:

```text
   transferFrom( from ,  to ,  amount )
                  |       |
                  |       +--- who RECEIVES the credits
                  +----------- whose account the credits LEAVE (the owner)

   msg.sender  = who CALLS transferFrom (the spender / the store)
                 --> must have been approved by `from`
                 --> is NOT an argument; the chain reads it from
                     whoever sent the transaction
```

The trap: `from` is **not** the caller. In `transfer`, the caller and the sender are the same address. In `transferFrom`, the caller is the *spender* (`msg.sender`), and the sender-of-credits is `from` — a different account. In our case: **the store calls it, but Kevin's balance is the one that drops.**

### What `transferFrom` actually does, in order

When the store calls `transferFrom(Kevin, store, 30)`, OpenZeppelin's inherited code runs these steps — and the *order* matters:

1. **Check the allowance.** Is `allowance(Kevin, store)` at least 30? If not → revert `ERC20InsufficientAllowance`. Allowance is checked **first**.
2. **Spend the allowance.** Subtract 30 from it: `50 − 30 = 20`. The permission is now smaller.
3. **Check the balance.** Does Kevin hold at least 30? If not → revert `ERC20InsufficientBalance` (Lesson 15's error). Permission is not funds.
4. **Move the credits.** Subtract 30 from `balanceOf(Kevin)`, add 30 to `balanceOf(store)`.
5. **Emit `Transfer(Kevin, store, 30)`.** The ledger writes the line.

```text
        BEFORE  transferFrom(Kevin, store, 30)
        --------------------------------------
        balanceOf(Kevin) ............ 100 WCR
        balanceOf(store) ............   0 WCR
        allowance(Kevin -> store) ...  50 WCR   <- permission, still unused

        AFTER   transferFrom(Kevin, store, 30)   (called BY the store)
        --------------------------------------
        balanceOf(Kevin) ............  70 WCR    (-30, credits left)
        balanceOf(store) ............  30 WCR    (+30, credits arrived)
        allowance(Kevin -> store) ...  20 WCR    (-30, permission spent down)
        totalSupply ................. unchanged  (nothing minted or burned)
```

**Three** numbers moved from one call: Kevin's balance down, the store's up, the allowance down. `totalSupply` did *not* move — no credits were created or destroyed, they only changed hands.

### The click: approve = permission, transferFrom = the pull

This is the sentence to tattoo on your brain:

> **`approve` grants permission and moves nothing. `transferFrom` is the actual pull, and it's what moves the credits.**

In Lesson 16, `approve` fired an `Approval` event and left every balance where it was — a promise on paper. Here, `transferFrom` is that promise being *collected*. And notice **who** does each: the **owner** (Kevin) approves; the **spender** (the store) pulls. Different accounts, different transactions, on purpose — the owner never has to be online when the store collects.

One sharp edge: in OpenZeppelin v5, `transferFrom` emits **only** a `Transfer` event — **not** a new `Approval` — even though the allowance dropped. The permission shrinking is real, but it isn't announced as its own log line. To *see* the new allowance, you re-read `allowance(owner, spender)` yourself. (One exception: an allowance set to the maximum `uint256` — an "unlimited" approval — is **not** decreased at all. That's the convenience-vs-safety trade-off from Lesson 16's challenge.)

### This is exactly the RewardStore's engine — so we name it `collectFrom`

Everything above is not a warm-up — it is *the* mechanism the reward store will run on. Rather than click raw `transferFrom` by hand every time, Dan wraps the store's move into one clear method on the token:

```solidity
function collectFrom(address from, uint256 amount) external {
    transferFrom(from, msg.sender, amount); // pull `from`'s credits to whoever calls
}
```

Read it with today's eyes: `from` is the owner, `msg.sender` is the caller doing the pull, so the credits land with **whoever collects**. Call it from the store account and it becomes `transferFrom(Kevin, store, amount)` — the store reaching into Kevin's approved allowance and pulling out exactly what it needs. In a few lessons, `RewardStore`'s purchase function will hold the same line at its heart: `credit.transferFrom(msg.sender, address(this), item.price)`. You're not learning a toy tonight — you're building the engine.

---

## Key Takeaways

- **`transferFrom(from, to, amount)` moves *someone else's* credits** — the caller (`msg.sender`) is the spender, `from` is the owner whose balance drops. It's the only ERC-20 way to move credits you don't hold yourself.
- **It needs prior permission.** The spender must have been `approve`d by `from`, and the pull must fit within the remaining `allowance` — otherwise it reverts before moving anything.
- **One call, three numbers move:** `from`'s balance down, `to`'s up, the allowance down by the amount. `totalSupply` is unchanged — credits just change hands.
- **approve = permission, transferFrom = the pull.** `approve` moves nothing; `transferFrom` is where the credits actually leave. The owner grants once; the spender collects later, on its own.
- **OZ v5 emits only `Transfer` on a `transferFrom`** — not a new `Approval` — so the allowance drop is silent in the log. Re-read `allowance(owner, spender)` to see the new cap.
- **Overreaching reverts with `ERC20InsufficientAllowance(spender, allowance, needed)`** — the library enforces the owner's cap exactly, checking allowance *before* balance. A failed pull changes no state but still costs gas.
- **`collectFrom` is the RewardStore's move by hand.** `transferFrom(from, msg.sender, amount)` is the whole payment mechanism — you just built it into the token.

---

## What's Next?

Dan now has every moving part of a payment in his hands. A student can hold credits, approve a spender for a capped amount, and that spender can pull exactly up to the cap — with the ledger recording who pulled what and refusing anything over the line. But he's still doing it manually: switch accounts, type addresses, click. It works, but it's Dan playing store with a dropdown menu.

Next lesson, the store stops being a role Dan plays and becomes a *thing that exists*. Lesson 19 builds `RewardStore.sol` — a **second contract**, separate from the token, that holds a list of redeemable items (turon, USB sticks, hand-me-down books) and knows how to reach into the WCR token to collect payment. A couple lessons on, its `buyItem` function will run the exact `transferFrom` pull you performed by hand tonight.

**Next Lesson: Build a Reward Store** — a second contract that holds redeemable items and pulls WCR through the very machinery you just learned.
