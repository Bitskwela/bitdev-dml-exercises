# Read the Note Back — Build an Allowance Reader

Reading an allowance uses `allowance(owner, spender)`, inherited from OpenZeppelin — no gas, no transaction, callable by anyone. You'll wrap it in one tiny helper, `remainingFor`, whose name says what the number *means*: how much a spender may still pull from an owner. Then you'll recreate last lesson's 50-WCR approval, read it back with your own eyes, record it in a tracker table, and confirm the ledger's silence is a hard zero. Open `act_1.sol` and finish the one TODO.

## Task 1: Implement `remainingFor`

The contract already inherits `allowance` from `ERC20`. In the body of `remainingFor(address owner_, address spender)`, return the result of calling `allowance(owner_, spender)`. It's a `view`, so `remainingFor` is a `view` too — it reads the nested `allowances[owner_][spender]` note and hands the number back. No tokens move; nothing is written. (The parameter is `owner_` with a trailing underscore because `owner` collides with names inside some OpenZeppelin contracts — a common Solidity habit.)

## Task 2: Deploy and Recreate the Approval

Open **https://remix.ethereum.org**, compile, and deploy on **Remix VM (Cancun)**. Roles, same as Lesson 16:

- Account **0** `0x5B38Da6a701c568545dCfcB03FcB875f56beddC4` — instructor (deployer, holds the supply).
- Account **1** `0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2` — **Kevin** (owner).
- Account **2** `0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db` — the **RewardStore** stand-in (spender).

With account 0 selected, **Deploy**, then `transfer` 100 WCR to Kevin (`to = 0xAb84…835cb2`, `amount = 100000000000000000000`). Switch the dropdown to **account 1 (Kevin)** and call the inherited orange **`approve`** with `spender = 0x4B20…C02db` and `amount = 50000000000000000000` (50 WCR). The note is now written — exactly the state you ended Lesson 16 in.

## Task 3: Read It Back and Record It

Find the blue **`remainingFor`** button (blue = a free `view`). Paste **Kevin's address** into `owner_` and the **store's address** into `spender`, and click. Remix prints the number instantly — no MetaMask popup, no gas. Slide the decimal point 18 places left: `50000000000000000000` base units = **50 WCR**. Kevin didn't have to trust Dan; he read it himself. Record the row in your **allowance tracker** — the habit the whole reward store depends on:

| Owner (whose WCR) | Spender (who may spend) | Allowance | In base units |
|-------------------|-------------------------|-----------|---------------|
| Kevin `0xAb84…35cb2` | Store `0x4B20…C02db` | **50 WCR** | `50000000000000000000` |

## Task 4: Prove the "No Approval = Zero" Rule

Call `remainingFor` again, but this time put the **instructor's address** (or any address Kevin never approved) in `spender`, keeping Kevin as `owner_`. Click. It reads `0` — a hard zero. The ledger has no record of that pair, so the answer is nothing: not an error, not a guess. **Zero.** Notice what did *not* happen in any of this: no balances moved. `remainingFor` only reports the *permission*.

## Sample Output

```text
-- Task 3: read the approved pair --
remainingFor(0xAb84...35cb2, 0x4B20...C02db)  ->  0: uint256: 50000000000000000000
   50000000000000000000 base units / 10^18  =  50 WCR

-- Task 4: read a pair that was never approved --
remainingFor(0xAb84...35cb2, 0x5B38...ddC4)   ->  0: uint256: 0     // a hard zero

-- balances are untouched — allowance is a permission, not a payment --
balanceOf(0xAb84...35cb2)  ->  100000000000000000000   (Kevin: still 100 WCR)
balanceOf(0x4B20...C02db)  ->  0                        (Store: still 0 WCR)
```

## Reflection Questions

1. `balanceOf` takes one address; `allowance` (and your `remainingFor`) takes two. In one sentence, why does a *balance* need only one name but a *permission* need two?
2. `remainingFor` is a blue button and Kevin's own `approve` was orange. What does that color difference tell you about gas, who can call it, and whether the chain state changes?
3. An un-approved pair reads `0`, and a revoked approval (`approve(spender, 0)`) also reads `0`. From the `allowance` return value alone, can you tell "never approved" apart from "approved then revoked"? What does that imply about reading intent from a bare number?

## Challenge: Read the Note, Then Overwrite It

**Challenge A — Query and log the allowance.** Call `remainingFor(kevin, store)` and confirm it returns `50000000000000000000`. Write the row into your tracker table (owner, spender, allowance in both WCR and base units). Then call it once more for a pair you *never* approved and record what it returns.

**Challenge B — Watch `approve` OVERWRITE, not add.** From **Kevin's account** (switch the dropdown to Kevin — only the owner can change their own allowance), call the inherited `approve(store, 30 * 10**18)` — that is, `approve` with `30000000000000000000`. Now re-read `remainingFor(kevin, store)`. Did it become 80 (50 + 30) or 30? Write down the number you see and state, in one sentence, what it proves about how `approve` changes an allowance. When you're done experimenting, set it back to a clean 50 WCR (`approve(store, 50 * 10**18)`) so your allowance is ready for Lesson 18, and read it one final time to confirm the reset.

## What You've Learned

- **`allowance(owner, spender)` — wrapped here as `remainingFor` — is a free, public `view`** that returns how much a spender may still pull from an owner. No gas, callable by anyone.
- **An allowance is keyed by the `(owner, spender)` pair**, and any pair you never approved reads a clean `0` — the ledger's silence is a hard zero, not an error.
- **`approve` overwrites the number, it does not add to it** — a fresh approve replaces the old cap entirely, which is why re-approving 30 over 50 leaves 30.
- **Reading an allowance moves no tokens** — it reports a permission, so both balances stay exactly where they were. Trust, but verify — and anyone can.
