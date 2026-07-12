## Dan's Story: Hope Is Not a Strategy

Last lesson Dan taught the store to *burn*. When a student redeems a turon, `buyItem` pulls 100 WCR with `transferFrom` and then calls `credit.burn(price)` — the credits don't pile up in the store, they leave circulation. He watched `totalSupply` drop from 1,100 to 1,000 in Remix, and Tita Malou nodded at the one part she fully understood: *"Nagamit na, ubos na — kita ko."* Mint, reward, transfer, approve, spend, burn. Every piece exists now. Which is exactly the dangerous moment: a system with every piece built is a system nobody has ever run *all the way through on purpose*.

Tuesday night in the dorm, three days before workshop graduation, Dan was feeling good. Too good. Everything compiled green, deployed on the Remix VM. He typed a message to Ate Rina — the security-minded senior from the audit lesson — with the confidence of a man about to jinx himself.

> **Dan:** Ate, tapos na. Everything works. Kevin earns WCR, approves the store, buys a turon, the credit burns. Ready na for graduation.

The three dots appeared, disappeared, appeared. Then his phone rang instead — she'd rather say it out loud.

> **Ate Rina:** "Everything works." Talaga? Show me the test where a random student rewards themselves 10,000 WCR. Show me the one where somebody buys a turon they didn't pay for. Show me the transfer for more credits than they own.
>
> **Dan:** Well — those *should* fail. May `onlyOwner`, may allowance check, may require...
>
> **Ate Rina:** *"Should."* Bata, "should" is a hope. You are about to compute thirty kids' rewards in public, on a ledger nobody can edit, in front of their parents. Hope is not a strategy. You don't get to *say* the unhappy paths fail. You have to **prove** they fail — every one, with your own eyes.

Dan opened his mouth to argue that he'd *seen* it work. Then he realized: he'd only ever seen the *happy* path work. He'd deployed, minted, rewarded Kevin, bought a turon — the sunny road where everyone behaves. He had never once, on purpose, tried to *break* it and confirmed it broke *cleanly*.

> **Dan:** But the contract *has* the checks. `onlyOwner`. The allowance. The `require`. Nakalagay na sila.
>
> **Ate Rina:** A lock on the door isn't proof the door is locked. You still have to pull the handle. Every check you wrote is a *claim*. Untested, it's just a comment you happen to believe.

> **Ate Rina:** Write a list. Left column: the action. Middle: who does it. Right: what *should* happen — the exact revert, the exact number. Run every row and write down what *actually* happened. Kapag magkatugma, pass. Kapag hindi, you just found the bug before Kevin's mom did.
>
> **Dan:** So... a checklist. Manual. Isa-isa.
>
> **Ate Rina:** Manual, isa-isa, boring, and the reason your ledger is trustworthy. May mga tools na nag-a-automate nito — Foundry, Hardhat — someday, gamitin mo. But before you trust a robot to check your work, *you* check it once, by hand, so you know what a passing test even looks like. Sige. Go prove your unhappy paths. Then maybe — *maybe* — I'll admit you built a ledger as strict as me.

Dan pulled up a fresh Remix tab, opened a blank note beside it, and titled it: **WCR SYSTEM TEST — expected vs actual.** No more "should." Tonight he finds out.

---

## The Concept: Testing Is Proving, Not Hoping

### Three kinds of path

Every function lives on one of three roads. A real test plan walks all three — most beginners only ever walk the first.

- **Happy paths** — the everyday, everything-correct case. The owner rewards a student. A student with enough balance transfers. A buyer who approved first buys an item. These *should* succeed, and you confirm they do.
- **Failure paths** — a correct *user* doing an *incorrect* thing. Transferring more than you own. Buying without approving. These *should* revert cleanly, with a specific reason, and you confirm the ledger refuses instead of doing something silently wrong.
- **Permission paths** — the *wrong person* doing a *real* thing. A non-owner calling `rewardStudent`. These *should* revert with an access-control error, and you confirm the door is actually locked, not just labeled "locked."

A system that passes only its happy paths isn't tested — it's *demonstrated*. A demo shows what happens when everyone cooperates; a test shows what happens when they don't, which on a public ledger with thirty teenagers is a certainty, not a maybe.

Mapped onto WCR's actual functions, the three roads look like this — and notice every one of your contract's methods appears somewhere in the table:

```text
   ROAD          THE CALL                         EXPECTED
   ----          --------                         --------
   happy    owner rewardStudent(Kevin, 200)       success, supply 1000 -> 1200
   happy    Kevin approve(store, 100)             Approval event, no balance moves
   happy    Kevin buyItem(0) after approve        supply 1200 -> 1100 (burn)
   failure  Ana transfer(more than she owns)      revert ERC20InsufficientBalance
   failure  Ana buyItem(0) without approving      revert ERC20InsufficientAllowance
   permission  Ana rewardStudent(...)             revert OwnableUnauthorizedAccount
```

A green run isn't "all six succeeded" — it's "the three that should succeed did, and the three that should refuse refused, each with the exact error I predicted."

### Expected vs actual — the whole discipline in two columns

Testing is not "click around and see if it looks fine." Testing is a claim and a check:

```text
   BEFORE you run it        AFTER you run it
   ----------------         ----------------
   EXPECTED  <-- you        ACTUAL   <-- the ledger
   commit to the exact      tells you the truth,
   result IN WRITING        verbatim, no mercy
              \             /
               \           /
                MATCH?  -> PASS
                DIFFER? -> you found something
```

The trick that makes it real: **write the expected result down *before* you run the row.** If you peek at the actual output first and then decide "yeah, that's what I expected," you've proven nothing — you've just agreed with the computer. When actual matches your written prediction, that's a pass you can trust. When it doesn't, you've caught either a contract bug or a hole in your own understanding — both worth catching three days early instead of during graduation.

### A checklist is a repeatable promise

Why a numbered table instead of testing from memory? Because you will run this list more than once — tonight, again after any change, and one final time on the real testnet in Lesson 25. A checklist means every run tests *the same things the same way*, so "it passed" means the same thing every time. That repeatability is what lets you change code later without silently breaking something you fixed weeks ago.

There's a second reason to write it down: memory quietly drops the boring rows. Test from your head and you'll re-run the fun happy path ten times and forget the "non-owner can't mint" row entirely — which is precisely the row an attacker is counting on you to skip. A written list has no favorites.

### "But don't real teams automate this?"

Yes. Professional Solidity teams write **automated tests** — in **Foundry** (tests in Solidity, run with `forge test`) or **Hardhat** (tests in JavaScript). One command re-runs hundreds of checks in seconds; Kuya JM's BPO gates every merge on a green suite. This course tests **by hand, in Remix**, on purpose: before you trust a framework to tell you "47 passing," you should run a system yourself, once, slowly, and *watch* each unhappy path refuse — so you know exactly what a passing test feels like and what a real revert looks like. The manual checklist you build today is the same list you'd hand a framework tomorrow.

---

## Key Takeaways

- **Testing is proving, not hoping.** "It should fail" is a wish; "it reverted with `OwnableUnauthorizedAccount` and I watched it" is a fact. Ate Rina's rule: prove the unhappy paths.
- **Walk all three roads:** happy paths (correct action succeeds), failure paths (a good user's bad action reverts cleanly), and permission paths (the wrong person is refused). Demoing only the happy path tests nothing.
- **Commit to *expected* before you read *actual*.** A checklist with the result written down first turns each row into a real check instead of you nodding along with the computer.
- **A checklist is repeatable.** The same rows, the same way, every run — so "it passed" means the same thing tonight, after your next change, and on the testnet next lesson.
- **Read reverts as data.** OZ v5 custom errors carry fields: `ERC20InsufficientBalance(sender, balance, needed)` tells you who tried, how much they had, and how much they needed. A `Transfer` to/from the zero address is a mint or a burn.
- **Actual sometimes surprises expected — and that's the win.** When a row reverts with a different error than you predicted, catching that gap is exactly why manual testing exists.
- **A revert leaves the ledger untouched.** Every failure and permission row must end with balances and `totalSupply` exactly as they were before — a clean refusal changes nothing, which is the whole reason the ledger can be trusted.

---

## What's Next?

Everything works, and now Dan can *prove* it works — happy, unhappy, and forbidden paths, all recorded, all reproducible. But every one of those tests ran on the **Remix VM**: a private sandbox that lives inside Dan's browser tab and vanishes when he closes it. Kevin can't check his balance on it; Tita Malou can't pull it up on her phone. A ledger nobody outside the room can read isn't a public ledger yet — it's a very well-tested rehearsal.

In the finale, Dan installs MetaMask, switches to the **Sepolia** public testnet, gets free test ETH from a faucet, and deploys the *exact* contracts he just tested — this time to a chain the whole world can read on `sepolia.etherscan.io`. Then he runs the earn → approve → redeem loop live at graduation, and finds out whether four courses of work end where they started: with his mom deciding whether to trust it.

**Next Lesson: Deploy and Demonstrate** — Sepolia, MetaMask, Etherscan, and the graduation demo where the ledger finally belongs to everyone.
