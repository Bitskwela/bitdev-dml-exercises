# Read the Ledger, Then Bundle the Reads

Today you press only blue buttons — no gas, no confirmations, no writes. First you'll read all five pieces of public info off your deployed WCR the way any student could. Then you'll add ONE small `view` function, `creditSummary()`, that returns the token's whole identity card in a single call. Open `act_1.sol`: the base WCR is done since Lesson 9; your only job is the summary method's body.

## Task 1: Press the Five Blue Buttons

Deploy the contract on **Remix VM (Cancun)**, expand it under **Deployed Contracts**, and click each blue button one at a time. None will open a wallet or charge gas — each is a `call`, not a `transact`:

- `name` → the full name
- `symbol` → the ticker
- `decimals` → note the type is `uint8`
- `totalSupply` → a `uint256` in **base units**
- `balanceOf` → paste the deployer address `0x5B38Da6a701c568545dCfcB03FcB875f56beddC4`, then click. Try a fresh account too, e.g. `0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2`.

## Task 2: Bundle Them Into `creditSummary()`

The starter has a `creditSummary()` function whose body is a placeholder. Make it return the token's identity card as a **tuple** of four values, in this order: `name()`, `symbol()`, `decimals()`, `totalSupply()`. All four are inherited reads you already used in Task 1 — you're just calling them from inside your own function and returning their results together.

Keep the function `external view`: it only reads, so it must stay gasless and callable by anyone. Do **not** add `_mint`, a `require`, or any state change — a summary that writes would defeat the whole point of a read.

## Task 3: Redeploy and Call the Summary

Recompile (green check) and redeploy. Click the new blue `creditSummary` button. One click should return all four values at once — the same answers as the five individual buttons, gathered into one gasless `call`.

## Sample Output

```text
-- the five individual reads --
name()                    ->  0: string: Workshop Credit
symbol()                  ->  0: string: WCR
decimals()                ->  0: uint8: 18
totalSupply()             ->  0: uint256: 1000000000000000000000
balanceOf(0x5B38...ddC4)  ->  0: uint256: 1000000000000000000000
balanceOf(0xAb84...5cb2)  ->  0: uint256: 0

-- creditSummary() : one call, four answers --
0: string: Workshop Credit
1: string: WCR
2: uint8: 18
3: uint256: 1000000000000000000000
```

Every line above is a `call` — no transaction hash, no gas, no block. The instructor holds the entire 1,000 WCR (all minted to the deployer); the fresh account holds 0. The two balances sum to `totalSupply`, and they always will.

## Reflection Questions

1. `creditSummary()` calls four other functions but the terminal still logs it as a plain `call` with no gas. What is it about those four functions that keeps the whole bundle free?
2. `totalSupply()` returns `1000000000000000000000`, not `1000`. Where did the extra eighteen zeros come from, and what would a wallet display to a student?
3. Anyone with the contract address can call `creditSummary()` and get identical answers to yours. Why is that a *feature* for a workshop credit system, and which row of Lesson 1's "notebook vs. ledger" table does it deliver?

## Challenge: Prove It Without Trusting Dan

**Challenge A — Add a personal summary.** Write a second `view` function, `myBalance()`, that returns `balanceOf(msg.sender)` — the caller's own balance, no address to paste. Deploy, switch the Account dropdown between two accounts, and click it from each. Note in one sentence why the answer changes even though you passed no argument.

**Challenge B — Explain it to Tita Malou.** She's at the counter, arms crossed: *"Anak, paano ko malalaman kung ilan talaga ang credits? Ikaw ang gumawa niyan."* Write a short plain-language paragraph — no jargon, pretend she's never seen Remix — explaining how she could check the total number of credits *herself*, without trusting your word or your notebook. Name the one thing she needs (the address) and the one thing she does (read the total, which changes and costs nothing).

## What You've Learned

- **Read (`view`) functions cost nothing and change nothing** — they log as a `call`, never a `transact`, and anyone can call them.
- **The five ERC-20 reads** — `name`, `symbol`, `decimals`, `totalSupply`, `balanceOf` — come free from OpenZeppelin; you can call them from your own `view` functions.
- **A tuple-returning `view` like `creditSummary()`** bundles several reads into one gasless call without touching state.
- **`totalSupply` and `balanceOf` speak base units** — `1000000000000000000000` is 1,000 WCR; divide by `10^18` for the human number.
