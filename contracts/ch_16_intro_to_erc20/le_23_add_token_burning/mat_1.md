## Dan's Story: Nagamit Na, Ubos Na

Last Saturday's lesson taught the ledger to remember *why*: Dan's `rewardStudent(student, amount, reason)` mints credits and, in the same transaction, emits a `StudentRewarded` event carrying the reason string — `"Finished final exercise"` — public and permanent. But that only covers the *earning* half of a credit's life. Today Dan faces the other half: what happens the moment a student actually *spends* one.

Saturday, past merienda. The lab had emptied out except for Dan and the hum of the aircon. He was running last week's numbers in Remix, and something felt off.

Kevin had earned 200 WCR, approved the store, and bought a turon for 100 — the whole approve-then-`buyItem` loop from Lesson 20 worked. Kevin's balance dropped to 100. The turon was eaten. Everyone was happy. But when Dan read `balanceOf(storeAddress)`, the store sat on 100 WCR — and `totalSupply` still said 1,200.

> **Dan:** Wait. The turon is *gone*. Kevin ate it. So why does the ledger still count those 100 credits like they exist?

The store had become a hoarder. Every redeemed credit stayed on the books, still counted in `totalSupply`, meaning nothing. Read the total and it told you how many credits were ever *created*, not how many were still *live*. That number was already lying, just a little.

That night he brought it to the carinderia. Tita Malou was wiping the counter, half-listening, fully judging.

> **Dan:** Ma, pag nag-redeem ng turon si student, pumupunta yung credit sa store. Pero patay na yung credit — nagamit na. Dapat ba may bilang pa siya?
>
> **Tita Malou:** Anak, yung load. Pag na-load mo na, saan napupunta yung pin sa scratch card?
>
> **Dan:** ...Wala na. Ubos. Ginasgas mo na, one-time use.
>
> **Tita Malou:** Ayun. Hindi mo itatabi sa drawer para bilangin ulit. Nagamit na, ubos na.

A prepaid load pin: used exactly once, then destroyed — because a used pin that still exists is a pin someone could try to use again. The store keeping the WCR wasn't just untidy; it was numbers hanging around meaning nothing, waiting to confuse someone.

He messaged Kuya JM the shape of the idea. The voice note came back fast.

> **Kuya JM:** Naks, you found burning on your own. There's a `_burn`, and it's the exact mirror of `_mint`. Mint pulls a credit into existence and bumps `totalSupply` up; burn destroys one and drops it down. If a redeemed credit is truly spent, burn it — then `totalSupply` stops meaning "credits I ever printed" and becomes "credits still out there, still owed." Mas totoo yung number.
>
> **Dan:** So the store pulls the WCR from Kevin, then immediately destroys it. Kevin −100, store net zero, and the total drops by 100.
>
> **Kuya JM:** Exactly zero net for the store. It's a pass-through na naglalaho sa dulo. That's what makes the supply honest, Dan — nobody's hoarding dead credits.

Two small edits, Dan figured. One to teach the token how to burn, one to make the store actually do it when a reward is claimed.

---

## The Concept: Burn Is Mint, Run Backwards

### Two operations move `totalSupply` — only two

Everything a token does falls into three buckets:

| Operation | Whose balance changes | `totalSupply` | Emits |
|-----------|----------------------|---------------|-------|
| `transfer` / `transferFrom` | one down, another up | **unchanged** | `Transfer(from, to, value)` |
| `_mint(to, amt)` | `to` goes **up** | **+ amt** | `Transfer(0x0, to, value)` |
| `_burn(from, amt)` | `from` goes **down** | **− amt** | `Transfer(from, 0x0, value)` |

Transfers only *shuffle* credits between accounts — the pile never grows or shrinks, like passing coins around a table. Only **mint** and **burn** change the size of the pile itself. That's the invariant the whole ledger rests on:

```text
        totalSupply  ==  sum of every account's balance      (always)

  _mint  --->  balance up,   totalSupply up     (credit is born)
  _burn  --->  balance down, totalSupply down   (credit dies)
  transfer -->  moves between balances, total UNCHANGED
```

### The zero address is the door

Minting emits a `Transfer` **from** `0x0000...0000` — an address nobody holds the keys to. Burning emits a `Transfer` **to** `0x0000...0000`. Back in Lesson 14, Dan saw the constructor's `_mint` show up as a transfer *from* zero; that's the convention, not a bug. The zero address is the doorway credits walk through on the way in and on the way out. A burn is a one-way trip *out* that door — and `_burn` actually *subtracts* from `totalSupply`. The credit is deleted, not parked.

### Why burn on redemption keeps the supply honest

Kevin earned 200 WCR; the workshop's total was 1,200. He redeems a turon for 100:

```text
  OPTION A — store KEEPS the WCR (Lesson 20 behavior)
    Kevin:  200 -> 100        store: 0 -> 100
    totalSupply: 1200 -> 1200   (unchanged; store hoards 100 dead credits)
    Reading totalSupply means: "credits ever printed." Grows forever, means nothing.

  OPTION B — store BURNS the WCR on redemption (this lesson)
    Kevin:  200 -> 100        store: 0 -> 100 -> 0   (pass-through, net zero)
    totalSupply: 1200 -> 1100   (the spent credit is gone)
    Reading totalSupply means: "credits still live, still owed." A number worth trusting.
```

Option B is Tita Malou's load pin. A redeemed credit is *used up* — nagamit na, ubos na — so it leaves circulation, and `totalSupply` finally answers a question a workshop actually cares about: *how many credits are still out there that students could still spend on my turon?*

### The two burn functions (mirrors you already know)

- **`burn(uint256 amount)`** — destroy **your own** credits. Mirror of `transfer`: it spends `msg.sender`'s balance, no permission needed because it's yours. Under the hood: `_burn(msg.sender, amount)`.
- **`burnFrom(address account, uint256 amount)`** — destroy **someone else's** credits, up to an allowance they granted you. Mirror of `transferFrom`: it calls `_spendAllowance(account, _msgSender(), amount)` first (checks and deducts the allowance, reverting with `ERC20InsufficientAllowance` if it's short), then `_burn(account, amount)`.

Neither is `onlyOwner`. Burning your own credits is always allowed — they're yours to destroy. Only *minting* is locked to the instructor, because printing credits is the power that needs guarding, not deleting them.

> **Note:** OpenZeppelin actually ships these two exact functions in an extension called `ERC20Burnable`. Dan writes them by hand here so you can *see* the mechanism — `_burn` and `_spendAllowance` are the same internal helpers OZ uses. Bayanihan, but with the lights on.

For the store, Dan uses the simpler path: `buyItem` first pulls the WCR into itself with `transferFrom`, *then* calls `burn(item.price)` to destroy its own freshly-collected credits. Store balance goes up by 100, then straight back to 0 — net zero, supply down 100.

---

## Key Takeaways

- **`_burn(from, amount)` is the exact mirror of `_mint`:** it lowers a balance **and** decreases `totalSupply`. Mint and burn are the *only* two operations that change the size of the pile; transfers just shuffle it.
- **Burning emits `Transfer(from, 0x0, value)`** — a credit walking out the zero-address door, just as minting emits `Transfer(0x0, to, value)`. The invariant `totalSupply == sum of all balances` always holds.
- **`burn` destroys your own credits; `burnFrom` destroys someone else's within an allowance** (`_spendAllowance` then `_burn`) — the mirrors of `transfer` and `transferFrom`. Neither is `onlyOwner`.
- **The store retypes `credit` from `IERC20` to `IWorkshopCredit`** (`is IERC20` plus a `burn` signature) so it can call `burn`. `IERC20` alone won't compile `credit.burn(...)`.
- **Burn on redemption makes `totalSupply` honest:** buyer −100, store net **0**, supply −100. The total stops meaning "credits ever printed" and starts meaning "credits still live and spendable."
- **These two edits finish the contracts.** WorkshopCredit and RewardStore are now feature-complete for the course: metadata, supply, decimals, controlled minting, reasoned rewards, and burning.

---

## What's Next?

The system is *built*. WCR mints under the instructor's control, records why every reward was given, moves through the allowance model, and now burns credits the moment they're spent so the supply never lies. On paper, it all works.

*On paper* is exactly the phrase that makes Ate Rina put down her coffee. Dan is about to compute real rewards for real barangay kids, and "it worked when I tried it once" is a vibe, not proof. Next lesson she drops in with the line she always drops in with — *"You're computing kids' credits, bata. Hope is not a strategy. Prove the unhappy paths."* — and Dan writes a full test checklist, running every single row: the happy paths *and* the reverts (a non-owner minting, a transfer over balance, a `buyItem` with no approval).

**Next Lesson: Test the Complete System** — the checklist that proves every path, so the ledger earns the trust it promises.
