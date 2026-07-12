## Dan's Story: The Napkin at the Closed Carinderia

Last Saturday's dispute — Kevin's missing credits, a smudged notebook that couldn't say *40* or *10* — had a fix, and Kuya JM had named it: a notebook the whole barangay can read but nobody can erase, an **ERC-20 token**. Tita Malou, sure from Facebook that anything called a "token" is a scam, turned it into an assignment in two words: *"Patunayan mo."* So Dan knows *what* he's building. Tonight, he has to decide the part nobody handed him — the **design**. And the person who forces him to get it right is the same one who called it a scam.

9:40 PM. The carinderia was closed, chairs up on the tables, the rice cooker ticking as it cooled. Tita Malou wiped down the counter. Dan sat at the one table still down, a bond-paper spec printout abandoned to his left and — some habits outlive a course — a clean napkin pulled from the dispenser in front of him.

He'd sketched on a napkin before. Three courses ago it was a neuron; tonight it was a token. Same dispenser, same feeling of a big idea shrinking into something he could hold. He wrote **WCR** in the middle and boxed it.

> **Dan:** *(muttering)* Okay. Before any code. Ano ba talaga 'to.

His phone buzzed — JM, replying to the napkin photo.

> **Kuya JM:** Ayan, tama. Huwag mong bubuksan ang Remix hangga't hindi mo nasasagot 'to. Sa trabaho namin, design muna sa papel — kasi kapag mali ang design, perfect mong nako-code ang maling bagay. Anim na tanong: Anong pangalan? Anong symbol? Ilan sa simula, at kanino? Sino ang pwedeng gumawa ng bago? Paano nakukuha? Paano nagagastos?
>
> **Dan:** Pangalan: "Workshop Credit." Symbol... WCR, parang ticker.
>
> **Kuya JM:** Perfect. Short, uppercase, parang PLDT o JFC sa stock market. Sagutin mo lahat ng anim bago ka mag-code. Yung mga sagot, 'yun na ang contract mo.

Dan filled in boxes and arrows, feeling good about it. Tita Malou drifted over with her rag, glanced down, and — mid-wipe, no drama, the way she delivers every verdict — asked the question that stopped him cold.

> **Tita Malou:** Sino ang pwedeng gumawa ng bagong credits?
>
> **Dan:** Ako, Ma. Ako ang teacher.
>
> **Tita Malou:** Ikaw lang? At kung gusto mo, pwede kang gumawa ng dagdag kahit kailan, kahit gaano karami?

Dan opened his mouth to say *oo naman* — and heard how it would sound to Kevin.

> **Tita Malou:** Anak, kung kaya mong dagdagan ng credits kahit kailan, kahit ilan, walang kwenta 'yan, di ba? Parang pera na kaya mong i-print sa bahay. Bakit maghihirap si Kevin para sa credit na kaya mong gawin ng libo-libo habang tulog siya?

The napkin looked naive. Dan had been designing *what a credit is*. Tita Malou had pointed at the thing that decides *whether a credit is worth anything at all*: not the name, not the symbol — **the rule about who can make more, and when.** A token you can inflate at will is a scam whether it lives in a notebook or on a blockchain.

> **Dan:** ...You're right, Ma. That's the most important box, and hindi ko pa nailagay.
>
> **Tita Malou:** *(back to wiping)* Basta. Kung gusto mong paniwalaan ka ng mga bata, hindi puwedeng ikaw-ikaw lang ang may alam ng patakaran.

Dan flipped the napkin over and started again — this time with a column in block letters: **RULES**.

---

## The Concept: Designing a Token Before You Code It

### Decisions before syntax

A token is not hard to *write* — by Lesson 7 you'll have a working one in about ten lines. The hard part, the part that decides whether anyone should trust it, is the set of **decisions** baked into those lines. Get them right on paper and the code is transcription. Get them wrong and, as JM said, you'll code the wrong thing flawlessly. Every fungible-token designer answers the same handful of questions — four things a token *is*, plus one thing it must *do*:

```text
   A TOKEN'S DESIGN = 4 PROPERTIES  +  1 RULEBOOK
   ---------------------------------------------------
   1. IDENTITY   ->  name + symbol   (what is it called?)
   2. PRECISION  ->  decimals        (how finely does it split?)
   3. SUPPLY     ->  how many + who holds them + who can make more
   4. ROLES      ->  who's admin, who are the users
   ---------------------------------------------------
   5. RULEBOOK   ->  how you EARN, how you SPEND, what happens on REDEEM
```

### Identity and precision — the labels

**Identity** is two human-readable labels a wallet shows first. **Name** is the full title (`Workshop Credit`) — plain words, so a parent glancing at a balance understands it. **Symbol** is the short ticker (`WCR`), by strong convention **3–5 characters, UPPERCASE**, like `USDC` or `JFC` — not because the compiler cares, but because every human expects a ticker to look like one.

| | Convention | Dan's choice |
|---|---|---|
| Name | readable, descriptive | `Workshop Credit` |
| Symbol | short, uppercase ticker | `WCR` |

**Precision** is `decimals` — how finely one WCR splits, the way a peso splits into 100 centavos. The ERC-20 default is **18**. It sounds absurd (nobody pays 0.000…001 WCR for turon), but `decimals` is only a *display* instruction — it changes nothing about the real on-chain count — and keeping the default means every standard wallet handles WCR with no surprises. Dan keeps **18**; *why* it matters is a whole lesson on its own (Lesson 9). On the sheet: *default, 18, don't fight it.*

### Supply — the decision that decides value

This is Tita Malou's box, and it has three parts: **how many** exist at birth (Dan mints a starting float of **1,000 WCR**), **who holds them at the start** (the **instructor** — he's the source everyone earns *from*), and the make-or-break part, **who can create more:**

```text
   WHO CAN MINT NEW CREDITS?
   -------------------------------------------------------
   anyone            ->  infinite supply, zero value   (SCAM)
   fixed forever     ->  safe, but can't reward new work
   owner only, by a  ->  supply grows only for real     <-- WCR
     public rule          effort; everyone knows the rule
```

Tita Malou's line — *"kung kaya mong dagdagan kahit kailan, walang kwenta"* — is not a side comment; it's a **design constraint.** It rules out "anyone can mint," and demands that even the owner's minting follow a rule the students can see. A ledger that faithfully records unlimited printing is a faithfully-recorded scam. (How the "owner only" lock is enforced in code — `Ownable`, `onlyOwner` — is Lesson 21. Today it's a decision, not code.)

### Roles and the rulebook

A token has an **admin** and a crowd of **users**, and being clear about who's who *is* the security design:

| Role | Who | What they can do |
|---|---|---|
| **Admin / owner** | The instructor (Dan) | Mint new credits, reward students |
| **Student** | Kevin & thirty others | Hold WCR, spend at the store, read the whole ledger |

Students *cannot* mint (or credits would be worthless) — and they *can* do one thing even Dan can't stop: **read every transaction.** The **rulebook** is the loop those four properties feed:

```text
   THE WCR LOOP (the whole design in one picture)
   -----------------------------------------------------------
   instructor  --EARN-->  student  --SPEND-->  RewardStore
   (mints for              (holds               (burns the
    real work)              WCR)                  redeemed WCR)
   -----------------------------------------------------------
   every arrow above is a transaction anyone can read.
```

**EARN** — students receive WCR from the instructor for real work (attendance, finished exercises). **SPEND** — they pay WCR to a **RewardStore** for turon, a secondhand USB, a hand-me-down book, an hour of help. **REDEEM** — a spent credit is **burned**, permanently removed, so it can't be quietly re-spent and the total always tells the truth. (Store and burning are built in later lessons; today they're just the last two boxes.)

### The Tita Malou test

Here's the thread tying all six decisions together: each is a promise Dan makes to Kevin, and the promise is worth something *only because Dan can't quietly break it later.* A transparent ledger with secret, changeable rules is just a well-lit scam. The design work is choosing rules that are *worth* making public, then making them impossible for even the designer to bend by hand. That's the whole difference between "credits" and "credits worth earning."

---

## Key Takeaways

- **Design the token on paper before you open an editor.** The code is easy; the *decisions* baked into it are what earn trust. Wrong design, perfectly coded, is still wrong.
- **Every fungible token answers the same six questions:** name, symbol, decimals, initial supply (and who holds it), who can mint, and the earn/spend/redeem rules.
- **Identity is labels, not money:** Name `Workshop Credit`, Symbol `WCR` (short, UPPERCASE). Decimals stays at the default **18** — a display setting, deep-dived in Lesson 9.
- **Supply is the value decision.** WCR starts at **1,000** minted to the instructor, and only the **owner** can ever create more — never "anyone."
- **Tita Malou's test is a real constraint:** a token you can inflate at will is a scam even on a transparent ledger. Fixed, public supply rules are non-negotiable.
- **The rulebook is the loop:** instructor mints for real work → student earns and holds → student spends at the RewardStore → the credit is burned. Every arrow is readable.
- **Fixed, public rules are what turn "credits" into "tiwala."** The value of the promise comes from Dan being unable to quietly break it later.

---

## What's Next?

The napkin is full: WCR has a name, a symbol, a supply, an owner, and a rulebook — a complete design that hasn't touched a single line of code. That's exactly the right order. Now comes the part Dan is quietly dreading: every past course made him fight an install — the Python environment, `rustup`, some 40-gigabyte download syncing overnight. Building for a blockchain sounds like it should need the worst toolchain yet.

Spoiler: it opens in the browser. No install, nothing to sync — a quiet echo of the Rust Playground relief. Next lesson, Dan meets **Remix**, creates his first `.sol` file, and compiles his first tiny contract just to prove the tools work before there's anything real to break.

**Next Lesson: Set Up Remix** — the browser IDE, your first `.sol` file, and a green check with zero installs.
