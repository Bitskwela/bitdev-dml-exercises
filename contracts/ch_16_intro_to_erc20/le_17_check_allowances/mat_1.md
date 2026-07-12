## Dan's Story: "Sabi Mo Lang"

Last lesson, from a student's account, Dan called `approve(spender, 50 * 10**18)` — telling the token *"the future RewardStore may spend up to 50 of my WCR."* An `Approval` event fired. But the thing that nagged him on the walk home was that nothing actually *moved*: Kevin's balance still read 100 WCR. The approval was a permission slip, not a payment — a promise written into the ledger. And a promise you can't check is exactly the smudged-notebook problem all over again. So the obvious next question: how does *anyone* — Kevin, Dan, Tita Malou — actually *read* that 50?

Monday, computer lab, the morning after the approval. Dan had the Remix tab open and was feeling good about himself. The allowance was set. The store mechanic was one step closer. He was practically humming — until Kevin dropped his bag on the next chair. Kevin: the same student who, three Saturdays ago, swore he'd finished an exercise while the notebook said otherwise. The whole reason any of this existed.

> **Kevin:** Kuya Dan, sabi mo may na-set ka na na approval para sa akin? Yung 50 credits na pwedeng kunin ng store?
>
> **Dan:** Oo! Tapos na. I approved it last night. Fifty WCR, ready.
>
> **Kevin:** ...Okay. Pero paano ko malalaman? *Sabi mo lang, e.*

And there it was. *Sabi mo lang.* You just said so. Dan opened his mouth to say *trust me, I did it* — and stopped. Because "trust me" was the entire thing they were trying to kill. Last month "trust me" was a notebook only Dan could read. If the answer to *paano ko malalaman* was still *because I said so*, then he'd built nothing. He turned the laptop so Kevin could see the screen.

> **Dan:** You know what — don't trust me. Check it yourself. The token has a function exactly for this. It's called `allowance`. You give it two things — whose credits, and who's allowed to spend them — and it reads you back the number.
>
> **Kevin:** Kahit ako? Hindi lang ikaw?
>
> **Dan:** Kahit sino, Kevin. It's a read. Libre. Wala kang kailangan sa akin.

He typed Kevin's address into the `owner` box, the store's address into the `spender` box, and clicked. `50000000000000000000` came back. Fifty WCR, on the nose. Kevin leaned in, squinted at the wall of digits, and did the mental math with the decimals Dan had taught him last week.

> **Kevin:** ...Ay. Fifty nga. Kita ko mismo.

That night JM's voice note landed while Dan was writing it up.

> **Kuya JM:** Naks, ayan na ang buong punto. `approve` is you *writing* the number into the ledger — costs gas, it's a transaction. `allowance` is *reading* it back — free, open to everyone. Isulat mo 'to: the number that `approve` sets is the same number `allowance` shows, and the same number `transferFrom` will spend down later. One number, three verbs. Master `allowance` first — it's the one that keeps everybody honest.

Trust, but verify. And the quiet miracle of the ledger: *anyone* can verify.

---

## The Concept: One Number, Read by Anyone

### `allowance` is a view — the third of ERC-20's three read functions

Back in Lesson 5 you annotated the ERC-20 interface and found three read-only (`view`) functions. You've used two — `totalSupply()` and `balanceOf(account)`. This is the third:

```solidity
function allowance(address owner, address spender) public view returns (uint256);
```

Because it's a `view`, calling it **costs no gas** (it changes nothing, it only reports), **can be called by anyone** (Kevin, Dan, Tita Malou, a stranger), and shows up as a **blue button** in Remix (blue = read, orange = write). It answers exactly one question: *"How much of `owner`'s tokens is `spender` still allowed to spend?"*

### It takes TWO addresses, and the pair is the whole point

`balanceOf` needs one address — *whose balance?* `allowance` needs two, because an allowance is not a property of a person. It's a property of a **relationship**:

```text
  allowance( OWNER , SPENDER )
             |        |
             |        +-- who is allowed to spend
             +----------- whose credits get spent
```

Kevin might approve the store for 50, a friend for 5, and nobody else at all — three separate numbers, each keyed by the *pair*. Under the hood the token stores them in a nested mapping, a listahan of listahans:

```text
  allowances[ Kevin ][ RewardStore  ] = 50 WCR
  allowances[ Kevin ][ Friend       ] =  5 WCR
  allowances[ Kevin ][ everyone else] =  0 WCR   <-- the default
```

That last line matters: **any pair you never approved reads back `0`.** No approval, no allowance — no "oops, it defaulted to something." The ledger's silence is a hard zero.

> **Kuya JM's analogy:** It's the pautang na budget you leave with the tindera. You tell her, *"si Kevin, pwede kumuha hanggang 50."* `approve` is you writing that on her note. `allowance` is anyone walking up and reading the note. And unlike the sari-sari store's note — which only the tindera holds — this one is nailed to the wall of the barangay hall. Kahit sino, pwedeng basahin.

### One number, three verbs

Here is the mental model to carry into the next lesson. One number lives in the ledger; three actions touch it:

```text
  approve(spender, x)          ->  SETS the number to x     (write, costs gas)
  allowance(owner, spender)    ->  READS the number         (view, free, anyone)
  transferFrom(owner, to, y)   ->  SPENDS y, shrinks it      (write, Lesson 18)
```

`approve` writes it, `allowance` reads it, `transferFrom` spends against it and the number *drops*. So an allowance is best understood as a **remaining budget**: it starts at whatever you approved, and every `transferFrom` subtracts from it until it hits zero.

### `approve` OVERWRITES — it does not add

This is the one rule beginners get wrong, so read it twice. Calling `approve` a second time does **not** stack. It **replaces** — an assignment (`=`), not an addition (`+=`):

| Step | Call | Allowance after |
|------|------|-----------------|
| 1 | `approve(store, 50)` | **50** |
| 2 | `approve(store, 30)` | **30**  ← not 80 |
| 3 | `approve(store, 0)`  | **0**   ← revoked entirely |

Want to revoke? `approve(spender, 0)` and the spender can't touch a thing. (A footnote for the curious: older OpenZeppelin had `increaseAllowance` / `decreaseAllowance`. **OZ v5 removed them.** The one true way to change an allowance now is a fresh `approve` with the new total.)

### Why this is the transparency win, not just a getter

`allowance` isn't only for curious students. When Dan finally builds the RewardStore, its `buyItem` will, in effect, ask the token *"has this student approved me for at least the price?"* before it dares pull anything — the same read Kevin used to reassure himself. One function, serving a nervous teenager and an automated store the exact same honest answer. With the paper notebook, "did Dan really set aside 50?" had one answer: *ask Dan, and trust him.* `allowance` deletes that bottleneck — the permission is a public number, and reading it needs no permission of its own. **The ledger doesn't ask who you are before it answers.**

---

## Key Takeaways

- **`allowance(owner, spender)` returns the amount a spender may still spend of an owner's tokens** — the third of ERC-20's three `view` functions, alongside `totalSupply` and `balanceOf`.
- **It's a free, public read.** No gas, no transaction, no permission required — *anyone* can verify an approval, which is the whole tiwala upgrade over a private notebook.
- **An allowance is keyed by the `(owner, spender)` pair.** Every pair is its own number, and any pair you never approved reads a clean **`0`**.
- **`approve` OVERWRITES — it does not add.** `approve(spender, 30)` after `approve(spender, 50)` leaves **30**, not 80. To revoke, `approve(spender, 0)`.
- **One number, three verbs:** `approve` writes it, `allowance` reads it, `transferFrom` spends it down. An allowance is a *remaining budget*.
- **Reading an allowance moves no tokens** — the owner's and spender's balances are untouched. A permission, not a payment.
- **OZ v5 removed `increaseAllowance`/`decreaseAllowance`** — the only way to change an allowance now is a fresh `approve` with the new total.

---

## What's Next?

Kevin can now read his 50-WCR permission with his own eyes — but so far it's a permission nobody has used. The number just sits there, full and untouched. Next lesson, someone finally *acts* on it: a second account, playing the RewardStore, calls **`transferFrom`** and actually pulls the approved credits out of Kevin's balance.

And here's the moment to watch for — the reason you built the tracker table this lesson. After that `transferFrom`, you'll call `allowance` again and the number will have **dropped**: fifty becomes twenty. That shrinking number is the proof that `approve` (permission) and `transferFrom` (the pull) are two different things — the exact machinery the reward store will run on when a student redeems a turon.

**Next Lesson: Spend with transferFrom** — a spender moves someone else's credits within their allowance, and the allowance drops to prove it.
