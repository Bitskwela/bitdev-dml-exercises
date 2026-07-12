# Lesson 24 Quiz: Test the Complete System

---
# Quiz 1
## Scenario: "Everything Works"

Dan messages Ate Rina three days before graduation: *"Tapos na. Everything works."* Everything compiled green on the Remix VM. Ate Rina replies that "should fail" is a hope, not a proof, and tells him to run a checklist of unhappy paths.

**Question 1:** What is the difference between a system that is *demonstrated* and one that is *tested*?
A. There is no difference; a green demo is a passing test
B. A demo shows the happy path where everyone cooperates; a test also proves the failure and permission paths — that the ledger refuses bad and forbidden actions cleanly
C. A test only checks that the contract compiles
D. A demo is done on a testnet, a test on the Remix VM

**Answer:** B
**Explanation:** Passing only the happy paths isn't testing — it's demonstrating. A real test plan walks all three roads, including the ones where users misbehave or the wrong person acts.

---

**Question 2:** Ate Rina insists Dan writes the **expected** result *before* running each row. Why does peeking at the actual output first ruin the test?
A. Remix caches the first result and won't re-run
B. If you read the actual output and then decide "yeah, that's what I expected," you've proven nothing — you've only agreed with the computer instead of checking it against a commitment
C. The expected column must legally match the actual column
D. Writing expected first makes the transaction cheaper on gas

**Answer:** B
**Explanation:** A test is a claim checked against reality. Committing to the exact revert name and number *first* is what turns a row into a real check rather than a nod of agreement.

---

**Question 3:** A non-owner (Ana) calls `rewardStudent`. Which road is this, and what should happen?
A. A happy path — it should succeed since rewardStudent is public
B. A permission path — it should revert with `OwnableUnauthorizedAccount(Ana)` and leave `totalSupply` unchanged
C. A failure path — it should revert with `ERC20InsufficientBalance`
D. It should silently do nothing and return false

**Answer:** B
**Explanation:** The wrong person doing a real action is a permission path. `onlyOwner` makes the door actually locked; the revert names the account that tried, and no credits are minted.

---

# Quiz 2
## Scenario: Reverts as Receipts

Ana holds 100 WCR and never approved the store. Dan runs three unhappy rows: Ana transfers 1,000 WCR, Ana calls `buyItem(0)`, and Kevin calls `buyItem(1)` when only item 0 exists.

**Question 4:** Ana (balance 100) calls `transfer(Kevin, 1000e18)`. What comes back, and what happens to her balance?
A. It reverts `ERC20InsufficientBalance(Ana, 100e18, 1000e18)` and her balance stays exactly 100 — a revert undoes everything
B. It sends whatever she has (100) and ignores the rest
C. It drives her balance to -900
D. It reverts `ERC20InsufficientAllowance`

**Answer:** A
**Explanation:** The custom error carries the receipt: sender Ana, balance 100, needed 1,000. Because a revert is atomic, nothing moved — her balance is untouched afterward.

---

**Question 5:** Inside `buyItem`, it is the **store** that calls `transferFrom`. So when Ana (who never approved) calls `buyItem(0)`, whose allowance is checked and what fires?
A. Ana's allowance to herself; `ERC20InsufficientBalance`
B. The RewardStore's allowance from Ana, which is 0 → `ERC20InsufficientAllowance(store, 0, 100e18)`
C. Kevin's allowance; no error
D. Nothing — the store can pull tokens without approval

**Answer:** B
**Explanation:** A contract can't just grab your tokens. `buyItem` pulls via `transferFrom`, so the *store* is the spender; with zero allowance from Ana, it reverts `ERC20InsufficientAllowance`. No approval, no pull.

---

**Question 6:** Kevin calls `buyItem(1)` when only item 0 exists. The store has `require(item.active, "RewardStore: item not available")`, yet Dan gets a low-level `Panic (0x32)` instead of that friendly string. Why?
A. The require message was misspelled
B. Reading `items[1]` when there is no item 1 fails on the array bounds *before* the `require` line ever runs, so the panic fires first
C. `buyItem` doesn't have a require at all
D. Panics and reverts are the same error with the same name

**Answer:** B
**Explanation:** The friendly `require` only guards an item that *exists but is inactive*. Indexing a non-existent element trips the array-bounds panic earlier. Both refuse the sale — but they are not the same revert, and only running the row revealed which one you'd actually get.

---

**Question 7:** Why run a written checklist by hand instead of just clicking around, given that Foundry and Hardhat could automate it?
A. Manual testing is more accurate than any framework
B. Running the system once, slowly, by hand teaches you what a passing test actually looks like — and the checklist is repeatable, so "it passed" means the same thing every run and after every future change
C. Frameworks can't test Solidity contracts
D. Clicking around covers more cases than a checklist

**Answer:** B
**Explanation:** Pros do automate — but before trusting a tool that prints "10 passing," you learn what a real revert looks like by watching each unhappy path refuse yourself. A checklist is a repeatable promise: same rows, same way, every time.

---
**Next:** Proceed to Lesson 24 exercises.
