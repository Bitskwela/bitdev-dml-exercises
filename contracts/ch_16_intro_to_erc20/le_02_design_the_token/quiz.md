# Lesson 2 Quiz: Design the Token

---
# Quiz 1
## Scenario: The Napkin at the Closed Carinderia

Before opening Remix, Dan sketches WCR on a napkin. Kuya JM insists he answer six questions on paper first — name, symbol, how many at the start and to whom, who can make more, how you earn, how you spend — because "kapag mali ang design, perfect mong nako-code ang maling bagay."

**Question 1:** Why does JM tell Dan to design the token on paper *before* touching Remix?
A. Because Solidity can only be written on paper first, then typed in
B. Because the code is the easy part — the *decisions* baked into it are what earn trust, and a wrong design coded perfectly is still wrong
C. Because Remix charges by the hour, so planning saves money
D. Because paper contracts are legally binding and code isn't

**Answer:** B
**Explanation:** A working token is about ten lines of code. The hard, trust-defining part is the set of decisions — get them right on paper and the code is just transcription; get them wrong and you'll flawlessly build the wrong thing.

---

**Question 2:** WCR's **symbol** is `WCR`. What convention is Dan following, and does the compiler require it?
A. Symbols must be lowercase and at least 8 characters; the compiler enforces it
B. Symbols are short (3–5 chars) and UPPERCASE by convention — like `USDC` or `JFC` — because humans expect a ticker to look like one, though the compiler doesn't care
C. The symbol must exactly equal the full name
D. Symbols are chosen randomly and have no convention

**Answer:** B
**Explanation:** Name and symbol are human-readable labels a wallet shows first. The short-uppercase ticker convention exists for people, not the compiler — it makes `WCR` read like the ticker it is.

---

**Question 3:** WCR keeps the ERC-20 default of **18 decimals**. What does `decimals` actually control?
A. How many credits can ever exist
B. Only how a balance is *displayed* — where wallets put the decimal point — while changing nothing about the real on-chain count
C. Who is allowed to create new credits
D. The peso value of one credit

**Answer:** B
**Explanation:** `decimals` is a display instruction. The real count is always a whole number of tiny base units; keeping the default 18 means every standard wallet handles WCR with no surprises. The deep dive is Lesson 9.

---

# Quiz 2
## Scenario: "Sino ang pwedeng gumawa ng bagong credits?"

Mid-wipe at the counter, Tita Malou asks the one question that stops Dan cold: who can make new credits, and how many? If the answer is "Dan, anytime, any amount," she says, "walang kwenta 'yan" — worthless, like money you can print at home.

**Question 4:** Tita Malou's question points at which design decision, and why is it the one that decides a credit's value?
A. Identity (name/symbol) — because a bad name scares people off
B. Precision (decimals) — because too many decimals confuse wallets
C. Supply, specifically *who can mint* — because a token anyone can inflate at will is worthless no matter how transparent the ledger is
D. Roles — because admins get paid more

**Answer:** C
**Explanation:** "Who can create more" is the make-or-break decision. A ledger that faithfully records unlimited printing is a faithfully-recorded scam — so the supply rule, not the labels, is what a credit's value rests on.

---

**Question 5:** Among the options for who can mint, which does WCR choose, and why not the others?
A. "Anyone can mint" — it's the most decentralized and therefore safest
B. "Fixed forever" — so no new credits can ever be created
C. "Owner only, by a public rule" — because "anyone" makes credits worthless and "fixed forever" can't reward new work; the middle path grows supply only for real effort, by a rule everyone can see
D. "No one, including the owner" — so the token is guaranteed scarce

**Answer:** C
**Explanation:** "Anyone" is Tita Malou's nightmare (infinite supply, zero value); "fixed forever" is safe but can never reward Kevin for next week's work. WCR picks controlled, public, owner-only minting — the honest middle.

---

**Question 6:** In the WCR loop, what happens to a credit when a student spends it on a reward (REDEEM)?
A. It's transferred to Dan's personal wallet and re-used next week
B. It's **burned** — permanently removed from circulation — so it can't be quietly re-spent and the total supply always tells the truth
C. It's converted into pesos and paid out
D. It's frozen but stays in the student's balance forever

**Answer:** B
**Explanation:** Redeeming burns the credit. Removing spent credits keeps the ledger honest — a spent credit can't reappear, and the running total never lies. (The burning is built later; here it's the last box on the napkin.)

---
**Next:** Proceed to Lesson 2 exercises.
