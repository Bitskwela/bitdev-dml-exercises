## Dan's Story: The Notebook That Couldn't Prove Anything

Three courses in, Dan Santos isn't the student anymore. Somewhere between shipping **Luto v1** (AI), **Luto v2** (ML), and **LutoCLI** (a compiled binary that runs on the carinderia's dead offline desktop), he started a free weekend coding workshop for barangay teens — teaching the same basics he once learned. Four kids and one shared laptop became thirty-plus. And this Saturday, for the first time, someone else's trust is riding on Dan's record-keeping.

Saturday, 3 PM, merienda break at the barangay hall. The workshop runs on a simple deal: show up, earn credits; finish an exercise, earn more; spend them on turon, a secondhand USB stick, or an hour of one-on-one help. Dan tracks every credit in a spiral notebook in his bag. The notebook is the problem — he just doesn't know it yet.

> **Kevin:** Kuya Dan, tapos ko na yung linked-list exercise last week. Bakit wala akong credits?

Dan flips to last Saturday's page. His own handwriting, smudged where his hand dragged the ink. Kevin's name is there. The number beside it is... a 40? A 10? He wrote it fast, between debugging two other kids' `for` loops.

> **Dan:** Hmm. Ito o — forty... o ten ba 'to? Hindi ko na rin masyado—
>
> **Kevin:** Forty dapat, Kuya. Tapos ko lahat ng four parts.
>
> **Dan:** Naalala ko naman... pero wala akong ibang record. Ito lang.

And there it is. There's no other record — just Dan's memory and Dan's handwriting, both tired. Kevin isn't lying; Dan genuinely *thinks* he remembers forty. But thinking he remembers isn't proof. If a classmate also claimed forty, Dan would have the exact same non-answer. The credits are worth only as much as Dan's word, and the kids are old enough to know it.

Three seats over, earbuds in, is Jasper — Dan's CS-major friend, dropping by because Dan mentioned "a token system."

> **Jasper:** Bro. Credits in a notebook? Analog. If you're doing tokens, mint a PFP collection — cool art, wen moon. Fungible tokens are so 2017.
>
> **Dan:** Jasper, the kids want turon. Nobody wants your JPEG.

That night, Dan dumps the whole thing into Messenger. Kuya JM — quietly learning Solidity at his BPO for a remittance-settlement pilot — replies with a voice note before Dan finishes typing.

> **Kuya JM:** Dan, ang problema hindi na the notebook is bad. The problem is *ikaw lang* ang may hawak. Ikaw lang ang makakabasa, ikaw lang ang makaka-edit, ikaw lang ang pinagkakatiwalaan. Kaya pag may nag-dispute, wala kang maipakita.
>
> **Dan:** So I need a better notebook.
>
> **Kuya JM:** Hindi. You need a notebook na kaya basahin ng *buong* barangay — pero walang makaka-bura, kahit ikaw. That, pare, is an ERC-20 token. Parang utang listahan ng sari-sari store — pero nasa gitna ng plaza, at lahat pwedeng tumingin.

The next morning at the carinderia, Dan makes the mistake of saying the word out loud.

> **Tita Malou:** *(not looking up from the rice cooker)* Token? Anak, scam yan. Nakita ko sa Facebook. May kapitbahay tayo, nawalan ng pera sa "coin."
>
> **Dan:** Ma, hindi 'to binibili-benta. Walang bibili ng credits ng workshop. Turon lang ang mabibili.
>
> **Tita Malou:** Sabi mo. Patunayan mo.

*Patunayan mo.* Prove it. Fair — that's the assignment now: not just build the thing, but prove to the one person most sure it's a scam that it isn't.

---

## The Concept: A Token Is Just a Shared Ledger

### What "ERC-20 token" actually means

Strip away the hype and a **token** is one boring, powerful thing: **a ledger of who holds how much.** It's the sari-sari store's *utang listahan* — a list of names and numbers — turned into code.

- **ERC-20** is a *standard*: an agreed-upon shape thousands of tokens follow, so wallets and apps talk to any of them the same way. ("ERC" = Ethereum Request for Comments; "20" was the proposal number.) You'll meet its exact functions in Lesson 5.
- The **token** is the ledger itself — the balances — living inside a program on a blockchain.

Dan's credits are a perfect fit, because credits were never more than a ledger of who-holds-how-much. He just kept that ledger in a notebook only he could read. Moving it to an ERC-20 doesn't change *what* the credits are — it changes *who can see them* and *who can change them.*

Keep one thing straight from lesson one, because Tita Malou will keep checking: **WCR (Workshop Credit) is a transparent points system, not an investment.** Nobody buys it, sells it, or "invests." You earn it by showing up and spend it on turon. It's a loyalty-points ledger that happens to be tamper-proof.

### Fungible: why 1 WCR is always 1 WCR

The "20" standard is for **fungible** tokens — a fancy word for a simple idea: **every unit is identical and interchangeable.**

- A **20-peso bill** is fungible: your 20 and my 20 are worth the same; swap them and nothing changed.
- Kevin's **40 WCR** are fungible: any 40 WCR equal any other 40 WCR. Credit #17 or #932 — a credit is a credit.

The opposite is **non-fungible**: each unit is unique. Jasper's PFP token #7 is a different picture from #8, and you'd care which you got — that's an **NFT** (ERC-*721*, another course). It's why "mint a PFP" was useless advice: workshop credits are meant to be interchangeable and splittable.

```text
  FUNGIBLE (ERC-20 / WCR)              NON-FUNGIBLE (ERC-721 / NFT)
  -----------------------              ----------------------------
  every unit identical                 every unit unique
  40 WCR == any other 40 WCR           token #7 != token #8
  interchangeable & divisible          one-of-a-kind, indivisible
  = loyalty points, money, credits     = collectible art, tickets, deeds
```

### The notebook vs. the ledger

Here's the whole lesson in one table — same names and numbers, two places to keep them:

```text
                    | PAPER NOTEBOOK (today)        | TOKEN LEDGER (the plan)
--------------------|-------------------------------|--------------------------------
Who can READ it     | Only Dan                      | Everyone — Kevin, parents, Ma
Who can EDIT it     | Only Dan, by hand, anytime    | Only by the token's own rules,
                    |                               |   recorded as a transaction
Can a line be erased| Yes — smudge, scribble, rip   | No — history is permanent
Proof of a change   | Dan's word / Dan's memory     | A transaction anyone can inspect
When two disagree   | Dan decides. No appeal.       | The ledger already shows it.
```

Read the "Who can EDIT it" and "When two disagree" rows together — that's why this course exists. The notebook makes Dan the **single source of truth**, which also makes him the *single point of failure*: every dispute becomes "trust Dan's memory." The token ledger doesn't ask anyone to trust Dan — it removes the question. Kevin can *see* his 40 WCR, and so can his mom and Tita Malou. This is **tiwala** — trust — rebuilt so it doesn't depend on one person's word, the same instinct behind a **paluwagan** where everyone sees the running total precisely *because* no single person is trusted to hold it.

Dan doesn't need a better notebook. He needs a notebook that makes "trust me" unnecessary.

---

## Key Takeaways

- **A token is just a shared ledger of who-holds-how-much** — the sari-sari utang listahan, turned into code on a blockchain.
- **ERC-20 is a standard shape** thousands of fungible tokens follow so any wallet can read them the same way; its exact functions come in Lesson 5.
- **Fungible means interchangeable and divisible:** any 40 WCR equals any other, unlike an NFT where each unit is unique — which is exactly why credits fit ERC-20, not Jasper's PFPs.
- **The notebook's flaw isn't paper — it's that only Dan can read and edit it.** He's the single source of truth, so every dispute is a matter of trusting his memory.
- **The token ledger removes the need to trust Dan:** everyone reads it, no one secretly edits it, history is permanent. That's **tiwala** rebuilt to not depend on one person.
- **WCR is a transparent points system, not a speculative coin** — earned by showing up, spent on turon. Tita Malou's "scam yan" is answered with *transparency*, never *profit*.

---

## What's Next?

Dan now knows *what* he's building: a shared, unerasable ledger for workshop credits. What he lacks is a **design** — and coding without one is how you build the wrong thing perfectly. Before any Solidity, WCR needs decisions: name and symbol? How many credits exist at the start, and who holds them? Who is allowed to create new ones?

Next lesson, Dan borrows a napkin and designs Workshop Credit properly — while Tita Malou, wiping the table beside him, asks the sharpest non-technical question in the whole course: *"Kung kaya mong dagdagan ng credits kahit kailan, walang kwenta 'yan, di ba?"* She's right, and answering her is the entire design.

**Next Lesson: Design the Token** — name, symbol, supply, and the rules that make a credit worth earning.
