## Dan's Story: The 1,000 That Wasn't 1,000

Last lesson Dan finally gave Workshop Credit a starting supply — one line inside the constructor, `_mint(msg.sender, 1000);` — and the moment he deployed, `totalSupply` and his own `balanceOf` both answered `1000`. A thousand credits minted out of nothing, sitting in the instructor's account. He screenshotted it with three fire emojis, zero doubt, and went to bed happy. Then Kuya JM looked at that screenshot and asked one quiet question that undid the whole thing.

Sunday night, dorm, lights off except the laptop glow. For the first time all course Dan felt like a person who *owned* a token. `balanceOf` said `1000`. Clean. Round. His. The reply from JM came back as a voice note, and Dan could hear him squinting.

> **Kuya JM:** Okay — good, it minted, the supply exists, perfect yun. Pero Dan, that `1000` on your screen? Kung i-add mo yang token sa kahit anong totoong wallet, hindi 1,000 WCR ang lalabas. Ang lalabas: **0.000000000000001000 WCR.**

Dan sat up.

> **Dan:** ...Ha? That's not even one. That's basically zero WCR. I minted myself almost nothing?
>
> **Kuya JM:** Sort of. You minted 1,000 of the *smallest possible piece* of a WCR — not 1,000 whole ones. Naks, welcome to decimals. Every single person who's ever made a token has tripped on this exact step.

Dan counted the zeros on his screen. Fifteen after the point before the `1000` even started. It looked like a rounding error that had given up.

> **Dan:** I typed one thousand. The contract stored one thousand. Saan galing yung fifteen zeros?
>
> **Kuya JM:** From `decimals`. Your token says it has 18 — di mo man lang sinet, OpenZeppelin did it, default yun. Isipin mo like Ma's cash drawer. Hindi nya nire-ring up ang "fifteen pesos and fifty *centavos*" as some fraction. Sa register, centavos lahat. ₱15.50 is stored as `1550`. Whole number, walang fraction. The dot is just for *showing* the customer.

Dan knew this feeling. He'd met it before — back in the LutoCLI days, JM had made him store Tita Malou's daily kita as a plain whole-peso integer (`u32`, always) instead of a decimal, precisely so the number could never drift.

> **Dan:** Parang yung kita report ko sa Rust. Ayaw mong gumamit ako ng decimal type para sa pesos — whole numbers lang, walang float.
>
> **Kuya JM:** Exact same trick, mas malala lang dito. A peso has 2 decimals — 100 centavos. WCR has **18**. So one whole WCR isn't 100 base units, it's `10 ** 18` of them. When you wrote `_mint(msg.sender, 1000)`, you minted a thousand *base units*. Divide by `10 ** 18` and yeah — a speck. Kung gusto mong makita ng student ang 1,000 WCR, mint `1000 * 10 ** decimals()`. Hayaan mong ang contract ang mag-multiply — wag kang mag-type ng eighteen zeros, mamamatay ka sa bug.

Dan opened the calculator: `1000 / 1000000000000000000`. The screen filled with zeros and confirmed the humiliation. It wasn't a bug. The contract had done *exactly* what he told it. He'd just been speaking centavos and thinking pesos.

---

## The Concept: Base Units, Decimals, and Why Solidity Can't Count in Halves

### `decimals()` is a label, not a calculator

Every ERC-20 can answer three metadata questions: `name()`, `symbol()`, and `decimals()`. You met the first two in Lesson 7. `decimals()` is the sneaky one, because it *looks* like it does math and it does **not**.

It returns one number — for WCR, and the overwhelming majority of tokens, that's **18**. You never wrote it; OpenZeppelin's `ERC20` returns 18 by default. And here's the part that trips everyone: **that number changes nothing on-chain.** It doesn't divide anything, doesn't store fractions. It's a note taped to the token that says *"wallets and websites — when you show my balances to a human, put the decimal point this many places from the right."* A **display instruction for user interfaces**, and nothing more.

### Why integers only: Solidity has no floats

Here's the *why* underneath all of it — the same lesson the Rust compiler taught Dan a course ago.

**Solidity has no floating-point numbers.** No `float`, no `double`, no `0.5`, no `15.50`. You cannot store a fraction in a Solidity variable. Every balance, every transfer amount, every supply figure is a `uint256` — a plain, non-negative **integer**.

Why forbid decimals entirely? Because floats *lie*. On almost every computer, `0.1 + 0.2` does not equal `0.3` — it equals `0.30000000000000004`, because fractions are stored as approximations in binary. That drift is harmless for a weather graph and catastrophic for money: a student's credits would slowly become un-provable, the exact disease this course is curing. So the ecosystem does what every cash register already did:

> **Store everything as big integers in the smallest possible unit. Keep a separate `decimals` number that says where to imagine the decimal point.**

That smallest unit is a **base unit**. On-chain, balances are *always* in base units; `decimals()` is just the shared agreement on how to render those base units back into something a human reads.

### Pesos and centavos — but with 18 zeros

Tita Malou's cash drawer has been doing this your whole life.

```text
   PESOS (decimals = 2)                    WCR (decimals = 18)
   --------------------                    -------------------
   Human sees:  P15.50                     Human sees:  1,000 WCR
   Drawer stores (centavos):               Chain stores (base units):
        1550                                    1000000000000000000000
        = 15.50 x 10 ** 2                       = 1000 x 10 ** 18

   1 peso = 100 base units (centavos)       1 WCR = 1000000000000000000 base units
          = 10 ** 2                               = 10 ** 18
```

A peso splits into 100 centavos, so it has **2** decimals. A WCR splits into a quintillion pieces, so it has **18**. Different number of zeros, *identical idea*. The register never stores "15 and a half pesos" — it stores `1550` centavos and prints the dot for the customer. The blockchain never stores "1,000 WCR" — it stores `1000000000000000000000` base units and lets the wallet print the dot.

Why 18 specifically? Convention. Ether itself works this way: 1 ETH = `10 ** 18` **wei**, where wei is Ether's base unit. OpenZeppelin defaulted tokens to 18 to match, and the ecosystem followed. You *can* override it (a token meant to be indivisible might use 0), but unless you have a reason, 18 is the boring, correct default — and WCR keeps it.

### The formula: human × 10 ** decimals = base units

This is the one equation for the rest of the course:

```text
   base units  =  human amount  x  10 ** decimals()

              (and to read the chain back into human terms)

   human WCR   =  base units    /  10 ** decimals()
```

Run it both directions and Dan's whole confusion evaporates:

| What Dan wrote | Base units on-chain | ÷ 10 ** 18 | What a wallet shows |
|---|---|---|---|
| `_mint(msg.sender, 1000)` | `1000` | a speck | **0.000000000000001000 WCR** |
| `_mint(msg.sender, 1 * 10 ** decimals())` | `1000000000000000000` | 1 | **1 WCR** |
| `_mint(msg.sender, 1000 * 10 ** decimals())` | `1000000000000000000000` | 1000 | **1,000 WCR** |

The naive `1000` wasn't wrong — it was one thousand of the tiniest slivers a WCR can be cut into. To mint a thousand *whole* credits, Dan has to say so in base units: `1000 * 10 ** decimals()`.

One last mercy: notice you write `1000 * 10 ** decimals()`, not `1000` glued to eighteen hand-typed zeros. Let the contract compute the zeros. Typing them yourself is how you mean 100 WCR and accidentally hand out 10,000.

---

## Key Takeaways

- **`decimals()` is display-only.** It defaults to **18** (OpenZeppelin sets it, not you) and changes *nothing* on-chain — a note telling wallets and explorers where to render the decimal point.
- **On-chain, everything is an integer in base units.** Balances, transfers, and supply are all `uint256`. The chain never stores `1,000 WCR`; it stores `1000000000000000000000` base units.
- **Solidity has no floating-point numbers — that's the *why*.** Floats drift (`0.1 + 0.2 ≠ 0.3`), and drifting credits can't be trusted, so the language forbids fractions and the ecosystem counts in tiny whole units instead — the same integer trick Dan used for whole-peso kita in LutoCLI.
- **Pesos:centavos :: WCR:base units.** ₱15.50 is stored as `1550` (2 decimals); 1,000 WCR is stored as `1000 × 10¹⁸` (18 decimals). Identical idea, more zeros.
- **The formula is `base units = human amount × 10 ** decimals()`.** So `1,000 WCR = 1000 * 10 ** decimals()` = `1000000000000000000000`, and Lesson 8's naive `1000` was really `0.000000000000001000 WCR` — a speck.
- **Let the contract compute the zeros.** Write `1000 * 10 ** decimals()`, never a hand-typed string of eighteen zeros — that's how you mint the wrong amount.
- **Remix shows raw base units; a wallet applies the decimals.** Same balance, two readings — learn to convert between them and the ledger stops surprising you.

---

## What's Next?

Act 1 is basically done: WCR now has a name, a symbol, correct decimals, and a real 1,000-credit supply in the instructor's account. The token *exists*, and Dan finally understands every digit of it. But he's been getting a suspiciously smooth ride from the compiler lately — one green check after another — and JM thinks that's made him soft.

So Lesson 10 does something that sounds backwards: Dan is going to **break his own contract on purpose.** Three classic beginner errors, planted one at a time — an invalid pragma, a missing import, a mistyped keyword — each one triggering a real, verbatim Solidity error, each one teaching him to *read* what the compiler is actually saying. It's the full callback to the Rust "compiler as your strictest Ate" beat: the error messages aren't the enemy, they're the mentor with the red pen. Learn to read them calmly now, in the sandbox, and they'll never scare you at the counter.

**Next Lesson: Compile and Debug** — planting three classic Solidity errors and learning to read the compiler like a letter, not an alarm.
