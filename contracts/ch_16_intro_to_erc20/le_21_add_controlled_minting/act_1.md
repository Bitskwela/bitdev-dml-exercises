# Lock the Money Printer

Your WorkshopCredit mints credits — but so far (since Lesson 9) it only ever minted the fixed 1,000 at deploy. Today it grows two powers at once: it becomes `Ownable`, and it gains a `mint` that only the owner can call. Open `act_1.sol`, work the TODOs in order, then prove the lock holds by getting rejected on purpose. The Ownable import is already at the top of the file for you.

## Task 1: Make the Token Ownable

Inheriting `Ownable` is a two-part move — do both or the contract won't compile:

1. Add `, Ownable` to the contract header so it reads `contract WorkshopCredit is ERC20, Ownable`.
2. Add `Ownable(msg.sender)` to the constructor, right after `ERC20("Workshop Credit", "WCR")`. OpenZeppelin v5 *requires* you to name the first owner — `msg.sender` here is whoever deploys, so the deployer (the instructor) becomes the owner. Leave the existing `_mint(msg.sender, 1000 * 10 ** decimals())` exactly as it is.

If you add the inheritance but forget `Ownable(msg.sender)`, the compiler will stop you — that's OZ v5 refusing to guess who's in charge.

## Task 2: Add the Owner-Only Mint

Write a function `mint(address to, uint256 amount)`, marked `external`, that carries the `onlyOwner` modifier and calls `_mint(to, amount)`. The `onlyOwner` modifier is the whole lesson: it runs a gate *before* your function body, so a non-owner caller is turned away before `_mint` is ever reached. One guarded line is the difference between "credits" and "credits worth having."

## Sample Output

Deploy from Account 1 (the instructor/owner). Then, in Remix:

```text
owner()                    -> 0x5B38Da...ddC4            // the deployer — the lock is public
totalSupply()              -> 1000000000000000000000     // 1,000 WCR

// --- as the OWNER (Account 1): mint 500 WCR to Account 2 ---
mint(0xAb84...cb2, 500000000000000000000)   // succeeds
logs:
  Transfer(from: 0x0000...0000, to: 0xAb84...cb2, value: 500000000000000000000)
totalSupply()              -> 1500000000000000000000     // rose by 500 WCR
balanceOf(0xAb84...cb2)    -> 500000000000000000000

// --- now switch to Account 2 (a NON-owner) and try to mint ---
mint(0xAb84...cb2, 500000000000000000000)   // REVERTS:

transact to WorkshopCredit.mint errored: Error occurred: revert.
Error provided by the contract:
OwnableUnauthorizedAccount
Parameters:
{
 "account": {
  "value": "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2"
 }
}

totalSupply()              -> 1500000000000000000000     // UNCHANGED — the revert minted nothing
```

Read the error like a letter, not an alarm: it's `OwnableUnauthorizedAccount`, and its one field `account` is the address that tried and was refused. The gate ran before `_mint`, so nothing happened — the lock held.

## Reflection Questions

1. The `mint` from Account 2 reverted, and `totalSupply` didn't move. Which exact moment stopped it — before or after `_mint` would have run — and how does the unchanged supply prove your answer?
2. `owner()` is a public getter anyone can call. Why is it a *feature*, not a leak, that the whole world can read who holds the minting key?
3. `Ownable(msg.sender)` is evaluated once, in the constructor, at deploy time. If Dan's friend had clicked "Deploy" instead of Dan, who would own the contract — and what would that mean for who can mint?

## Challenge

**Challenge A — Get rejected on purpose.** Deploy from Account 1. Recording `totalSupply` before and after each step: (1) as the owner, `mint` 300 WCR to Account 3 and confirm the supply rose by exactly 300 WCR with a `Transfer` from the zero address; (2) switch to a non-owner account and try to `mint` 300 WCR to yourself — note which address the `account` field of the revert names; (3) read `totalSupply` one last time and confirm the failed call created nothing.

**Challenge B — Who should hold the key, long-term?** Research OpenZeppelin's `transferOwnership(address newOwner)` (also on `Ownable`). In 2-3 sentences, explain why a workshop might eventually want to move ownership from Dan's personal wallet to a **multisig** (a wallet needing, say, 2-of-3 people to approve any action) — even though a multisig is more effort to use. Think about what happens to every WCR holder if a single private key is lost, stolen, or simply walks away.

## What You've Learned

- **`_mint` is `internal`; exposing it needs a guard.** An owner-only `mint` is a *controlled* hole to the printer, not an open one.
- **`Ownable` is a two-part install:** inherit it *and* pass `Ownable(msg.sender)` — OZ v5 won't guess the owner.
- **`onlyOwner` reverts before the body runs**, so a rejected `mint` changes zero state — provable by an unchanged `totalSupply`.
- **The revert is the typed custom error `OwnableUnauthorizedAccount(account)`**, naming the caller who was refused — and `owner()` keeps the lock public.
