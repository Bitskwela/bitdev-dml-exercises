# Compile the Standard Itself

Today you don't build WorkshopCredit — you finish the `IWorkshopCredit` **interface**: the ERC-20 shape, annotated in your own workshop terms, then compiled. Compiling an interface proves the shape is real Solidity even with no code inside. This is *reading the ledger's grammar*, not writing the ledger yet. Open `act_1.sol`: the three read-only views are already declared as worked examples — your job is to add the three writes and two events, then compile. Work the TODOs in order.

## Task 1: Declare `transfer` — Move Your Own Credits

Add the signature `transfer(address to, uint256 amount)` — `external`, `returns (bool)`, no body (interfaces never have bodies). This is Dan handing his **own** credits straight to a student. It's a *write*: it changes the ledger, so it costs gas and emits a receipt.

## Task 2: Declare `approve` — Grant Permission Without Moving Anything

Add `approve(address spender, uint256 amount)` — `external`, `returns (bool)`. This pre-authorizes a spender ("store, pwede kang kumuha hanggang 100"). Crucially, **no credits move** when you call it — it only records a permission. It's step 1 of the allowance model.

## Task 3: Declare `transferFrom` — Spend Someone Else's Credits Within a Limit

Add `transferFrom(address from, address to, uint256 amount)` — `external`, `returns (bool)`. This is the reward store collecting at checkout: a spender moves **someone else's** credits, but only up to the amount they were `approve`d for. It's step 2 of the allowance model — and the reason a store can never touch a balance uninvited.

## Task 4: Declare the `Transfer` Event

Add `event Transfer(address indexed from, address indexed to, uint256 value);`. This is the receipt fired on *every* credit movement. Mark `from` and `to` as `indexed` so block explorers can search and filter by address — that's how anyone audits "every Transfer involving Kevin" without trusting Dan.

## Task 5: Declare the `Approval` Event

Add `event Approval(address indexed owner, address indexed spender, uint256 value);`. This receipt fires whenever a permission is granted via `approve`. Index `owner` and `spender` for the same searchability. With both events in place, your interface declares the full ERC-20 shape.

## Sample Output

Create `IWorkshopCredit.sol` in Remix, paste your finished interface, and compile on the **Solidity Compiler** tab (version satisfying `^0.8.20`):

```text
✓ Compilation successful
Contract: IWorkshopCredit
```

Now switch to **Deploy & Run** and notice you *cannot* deploy it — there's no Deploy for an interface:

```text
Note: interfaces cannot be deployed — they have no code to run.
```

That's the point of tonight. An interface is a *promise*, not a program: nothing to execute, just a shape for other contracts to fill in. You compiled the menu; you did not cook anything.

## Reflection Questions

1. Your interface compiled with zero function bodies. What does compiling an *interface* actually prove, if it can never run or be deployed?
2. `transfer` and `transferFrom` both move credits — yet the material insists they are fundamentally different. In one sentence each, whose balance does each one spend, and why does that difference make the reward store possible?
3. Both events index the address fields (`from`/`to`, `owner`/`spender`) but not the `uint256 value`. Given what `indexed` is *for*, why might a token designer index the addresses but leave the amount un-indexed?

## Challenge: Read the Menu Like Dan Reads the Listahan

**Challenge A — Re-annotate all six in your own words.** Take the six core functions (`totalSupply`, `balanceOf`, `allowance`, `transfer`, `approve`, `transferFrom`) and rewrite each `///` doc comment in *your own* workshop or sari-sari-store analogy — don't copy the ones provided. Recompile to confirm your edited file still builds (comments never break compilation, but proving it to yourself is the point). Make sure your `transfer` note describes spending your **own** balance and your `transferFrom` note describes spending **someone else's** within a limit they approved first — if the two notes read the same, revisit the allowance-model diagram.

**Challenge B — Sort the menu, then trace an audit.** Answer in writing: (1) Which of the six functions are read-only (free, no gas) and which write state (cost gas)? What keyword gives it away? (2) If Tita Malou wanted to audit *every credit that ever moved*, which one event would she watch — and to audit *every permission ever granted to a spender*, which event? (3) `balanceOf` takes an `address` argument but `totalSupply` takes none — explain why that asymmetry makes sense.

## What You've Learned

- An **interface is signatures only, no bodies** — it declares *what* a token can do, not *how*, and compiling it proves the shape is valid Solidity even though it can't be deployed.
- The ERC-20 menu is **3 views + 3 writes + 2 events**: views read for free, writes cost gas and emit receipts, events are the searchable public log.
- The **allowance model** (`approve` → `transferFrom`) lets a spender move someone else's credits only within a limit they set — no contract can touch your balance uninvited.
- **`Transfer` and `Approval` events with `indexed` fields** are the transparency that beats a smudgeable notebook — anyone can search and prove exactly what moved.
