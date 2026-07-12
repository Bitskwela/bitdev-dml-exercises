# Give WCR Its Name, Then Ask the Token Who It Is

Open `act_1.sol`. It compiles as shipped — but it's a token with no identity: its constructor hands ERC20 two *empty* strings. Your job is to fill in the real name and symbol, watch Lesson 6's red error stay gone, then deploy and ask the live contract its own name. You'll finish on a small mystery. Work in Remix.

## Task 1: Fill In the Identity

Find the constructor's base call `ERC20("", "")`. Replace the two empty strings with the token's real metadata: the full human name `"Workshop Credit"` as the first argument and the short ticker `"WCR"` as the second. Leave the constructor's own parameter list empty and its body `{}` — you have nothing else to set up this lesson.

## Task 2: Compile to Green

Go to the **Solidity Compiler** tab, confirm a **0.8.20 or newer** compiler, and press **Compile**. You should get a green check — and, crucially, *no* `No arguments passed to the base constructor` error. Note for yourself: even the empty-string starter compiled. The compiler only insisted that you *pass* two strings, not that they be meaningful — reading the token's own name is what will prove they're real.

## Task 3: Deploy and Interrogate the Token

Switch to **Deploy & Run Transactions**, leave the environment as **Remix VM**, pick `WorkshopCredit` in the dropdown, and press **Deploy**. Under **Deployed Contracts**, expand your instance. Click the blue (read-only, free) **name** button, then **symbol**, and confirm the live contract answers with your two strings. The constructor just ran — once — and will never run again.

## Task 4: Meet the Zero

Now click the blue **totalSupply** button and read what it returns. Sit with the number before moving on — it is *not* a bug, and explaining it is the whole reason Lesson 8 exists.

## Sample Output

After Task 2, the file goes green:

```text
✓ compilation successful
```

After deploying, the blue getters answer instantly (no gas, no confirmation popup):

```text
name        ->  0: string: Workshop Credit
symbol      ->  0: string: WCR
totalSupply ->  0: uint256: 0
```

The token has a name, a symbol, and a real address on the ledger... and not a single credit in existence. `0: string:` just means "the first (and only) return value, of type string."

## Reflection Questions

1. Task 2 compiled even when the strings were `""`, and it compiled again once they were real. What does that tell you about the difference between a rule the *compiler* enforces (you must pass two strings) and a decision only *you* can make (what they should say)?
2. The `name()` and `symbol()` clicks returned instantly with no gas popup, unlike a `transfer` would. What does that "no confirmation" tell you about whether these functions change anything on the ledger?
3. `totalSupply()` says `0` even though the token deployed successfully. In your own words, what is the difference between giving a token an *identity* and giving it a *supply* — and which one did this lesson do?

## Challenge: Rename, Redeploy, Reason

**Challenge A — Change the identity and watch it stick.** Change the base call to a different name and symbol — try `ERC20("Marikina Workshop Credit", "MWC")` — compile, then **deploy a fresh instance**. Click `name()` and `symbol()` on the *new* deployment and confirm the new strings. Now check your *old* deployment from Task 3: it still reports the old name. Write one sentence explaining why editing the source never changed the already-live contract. Then set it back to `"Workshop Credit"` / `"WCR"` and redeploy once more — that's the real WCR you carry forward.

**Challenge B — Explain the zero to Tita Malou.** In one short paragraph, answer her kind of question: *why does `totalSupply()` say 0 right now, and what would Dan have to do to make it something other than 0?* Don't stop at "he has to add tokens" — say *where* in the contract that creation would have to live, and *when* that code would run.

## What You've Learned

- A **constructor** runs once at deployment and never again — the right place to lock in a permanent decision like a token's name.
- **`constructor() ERC20("Workshop Credit", "WCR") {}`** is a base constructor call that forwards the name and symbol up to the inherited ERC20 — the direct fix for Lesson 6's error.
- **`name()` and `symbol()`** are free, read-only metadata getters; blue buttons return instantly because they change nothing on the ledger.
- Naming a token is **not** funding it — a freshly deployed WCR has a public identity but `totalSupply() == 0`, an empty ledger waiting for Lesson 8.
