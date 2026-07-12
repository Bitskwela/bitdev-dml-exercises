# Lesson 8 Quiz: Create the Initial Supply

---
# Quiz 1
## Scenario: The First Line in the Ledger

Dan's token compiles and knows its name, but `totalSupply` reads `0` — a blank notebook. Tita Malou's whole diagnosis is one sentence: *"Eh di sulatan mo. Anong silbi ng notebook na blanko?"* Dan adds one line to the constructor to write that first entry.

**Question 1:** What does a single call to `_mint(account, amount)` change?
A. Only the recipient's `balanceOf`, leaving `totalSupply` untouched
B. Both `balanceOf(account)` and `totalSupply`, raising each by `amount` atomically
C. Only `totalSupply`, which is later split among holders automatically
D. Nothing on-chain — it just prints a message to the Remix console

**Answer:** B
**Explanation:** `_mint` is the only honest way credits appear: it adds to that account's balance *and* raises the grand total by the same amount, together. The books always balance — you can't inflate one balance without the total showing exactly that many new credits.

---

**Question 2:** Why is the function named `_mint` (with an underscore) instead of `mint`?
A. The underscore is required by Solidity syntax for all constructors
B. It marks the function as `internal` — callable only from inside the contract, so no outside wallet can print credits
C. It means the function is deprecated and should be avoided
D. The underscore makes the function run faster

**Answer:** B
**Explanation:** The leading underscore is an OpenZeppelin convention for **internal**. There's no Remix button and no random caller — deliberate, because if anyone could mint, credits would be worthless. Today the only place it runs is the constructor.

---

**Question 3:** Inside the constructor, who is `msg.sender` when you write `_mint(msg.sender, 1000)`?
A. The zero address, `0x0000...0000`
B. The account that **deployed** the contract — the one selected in Remix's Deploy & Run
C. The OpenZeppelin ERC20 contract itself
D. Whichever account later calls `transfer`

**Answer:** B
**Explanation:** A constructor call *is* the deployment transaction, so `msg.sender` is the deployer. (In a normal function later, `msg.sender` is whoever called *that* function — same keyword, different account.)

---

# Quiz 2
## Scenario: The Sliver

Dan deploys, clicks `totalSupply` and `balanceOf(deployer)` — both read `1000` and it feels right. Then JM warns that any real wallet would render that balance as `0.000000000000001000 WCR`.

**Question 4:** Right after minting, why do `totalSupply` and `balanceOf(deployer)` both read the same `1000`?
A. Remix accidentally shows the same number in two places
B. Because the deployer currently holds *every* credit that exists, so the sum-of-all-balances collapses onto one account
C. `balanceOf` always equals `totalSupply` for every account
D. Because the token has 18 decimals

**Answer:** B
**Explanation:** `totalSupply` always equals the sum of every balance. Right now every credit sits with the deployer, so the two numbers coincide. Send some to a student and they part ways — the total holds while the deployer's balance drops.

---

**Question 5:** Why would a wallet display Dan's raw `1000` as `0.000000000000001000 WCR`?
A. The mint failed and only a fraction went through
B. WCR declares 18 decimals, so a wallet slides the point 18 places left — `1000 / 10^18` is a microscopic fraction of one credit
C. The token lost value between deploy and reading
D. `balanceOf` rounds every number down to near zero

**Answer:** B
**Explanation:** The raw integer `1000` is correct; the *unit* is wrong. On an 18-decimal token, `1000` base units is `0.000000000000001000` of a whole WCR. The number is right, the place value is off — which is exactly what Lesson 9 fixes.

---

**Question 6:** Why can't Dan just write `_mint(msg.sender, 1000.5)` to mint a fractional amount?
A. Solidity has no decimals or floats — `amount` is a `uint256`, a whole-number count of the smallest unit, so `1000.5` won't compile
B. OpenZeppelin blocks any amount that isn't a round thousand
C. Fractions are allowed, but only up to two decimal places
D. `_mint` only accepts negative numbers

**Answer:** A
**Explanation:** Solidity forbids fractions entirely; every amount is an integer count of base units. "Where the decimal point goes for a human" is a separate display question handled by `decimals()` — the subject of the next lesson.

---
**Next:** Proceed to Lesson 8 exercises.
