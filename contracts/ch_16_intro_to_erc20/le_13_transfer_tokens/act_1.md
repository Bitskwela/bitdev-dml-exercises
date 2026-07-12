# Send the First Credits, Then Batch the Whole Class

Today you press your first **orange** button. First you'll move 100 WCR from the instructor account to a student with the inherited `transfer` — a real transaction, with gas and a receipt. Then you'll add ONE method, `awardClass`, that loops `transfer` over a list so a single click can pay a whole roster. Open `act_1.sol`: the base WCR is done since Lesson 9; your only job is the `awardClass` body.

## Task 1: Confirm the Starting Balances

Deploy on **Remix VM (Cancun)**. Under the deployed contract, click blue `balanceOf` for the deployer `0x5B38Da6a701c568545dCfcB03FcB875f56beddC4` (should read the full supply) and for a fresh student `0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2` (should read 0). These are still `call`s — free, no gas.

## Task 2: Make Sure the Instructor Is the Caller

In the **Account** dropdown at the top of the Deploy & Run panel, the *first* account must be selected. Whoever is selected here becomes `msg.sender` — the sender. This is the detail JM warned about: the sender isn't something you type into `transfer`, it's whoever the dropdown points at.

## Task 3: Call `transfer` (One Student)

Expand the orange `transfer` button and fill the two fields:

```text
to      :  0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
amount  :  100000000000000000000
```

That amount is `100 * 10**18` — a real 100 WCR. Count the zeros: twenty. Click **transact**, then re-read both balances (Task 1) and confirm the instructor dropped by 100 and Kevin rose by 100. Call `totalSupply()` — still 1,000 WCR.

## Task 4: Batch It With `awardClass`

The starter has `awardClass(address[] calldata students, uint256 amountEach)` with an empty body. Implement it: **loop over the `students` array** and, for each address, call `transfer(students[i], amountEach)`. That's it — `transfer` is inherited, and each call spends the caller's own balance, so `awardClass` hands `amountEach` to every student on the list from whoever clicked it.

Do not add a `from` argument (there isn't one) and do not add access control yet — "only Dan can award" is Lesson 21's job. Keep the loop simple: index from `0` to `students.length`.

## Task 5: Deploy and Award the Class

Recompile and redeploy. Expand orange `awardClass`. For `students`, paste a JSON array of two addresses; for `amountEach`, paste `50000000000000000000` (50 WCR):

```text
students    :  ["0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2","0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db"]
amountEach  :  50000000000000000000
```

Click **transact**, then re-read each student's balance — both should now hold 50 WCR, and the instructor should be down 100.

## Sample Output

**Single `transfer` — the transaction receipt (expand the green terminal line):**

```text
[vm] from: 0x5B3...ddC4  to: WorkshopCredit.transfer(address,uint256) 0xd91...138  value: 0 wei  logs: 1  hash: 0x5ba...c8f

status                Transaction mined and execution succeed
transaction hash      0x5ba3d1...c8f
from                  0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
to                    WorkshopCredit.transfer(address,uint256) 0xd9145CCE52D386f254917e481eB44e9943F39138
gas                   36543 gas
transaction cost      31776 gas
decoded input         { "address to": "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
                        "uint256 amount": "100000000000000000000" }
decoded output        { "0": "bool: true" }
logs                  1
```

`status: ... execution succeed` — the move happened. `decoded output → bool: true` — `transfer` returns `true` on success. `logs: 1` — one `Transfer` event was emitted (you crack it open in Lesson 14).

**Balances, before and after the single transfer:**

```text
balanceOf(0x5B38...ddC4)  ->  0: uint256: 900000000000000000000   (1000 -> 900)
balanceOf(0xAb84...5cb2)  ->  0: uint256: 100000000000000000000   (0 -> 100)
totalSupply()             ->  0: uint256: 1000000000000000000000   (UNCHANGED)
```

**`awardClass` over two students (`amountEach = 50 WCR`)** — one transaction, two `Transfer` events:

```text
status    Transaction mined and execution succeed
logs      2

balanceOf(0xAb84...5cb2)  ->  0: uint256: 50000000000000000000
balanceOf(0x4B20...02db)  ->  0: uint256: 50000000000000000000
```

Two students paid in a single click, `logs: 2` proving two moves, and `totalSupply` never budges — credits relocated, never created.

## Reflection Questions

1. You never typed the instructor's address into the `transfer` fields, yet the ledger took the 100 WCR from the instructor. How did it know who the sender was?
2. `awardClass` loops `transfer`, and each iteration spends `msg.sender`. If Kevin (not the instructor) called `awardClass`, whose credits would be handed out — and what happens if he doesn't hold enough for the whole list?
3. Before and after every transfer, `totalSupply()` reads the same `1000000000000000000000`. Why does moving credits never change the total, while minting them would?

## Challenge: Prove Both Directions

**Challenge A — The round trip.** From the instructor, transfer 100 WCR to Kevin. Verify the instructor is at 900 WCR and Kevin at 100 WCR, then call `totalSupply()` and confirm it's still 1,000 WCR. Write one sentence stating *why* a transfer never changes the total supply.

**Challenge B — Who is the sender, really?** Switch the **Account** dropdown to Kevin's account and call `transfer` again, sending `50000000000000000000` (50 WCR) *back* to the instructor. Read all three balances. Then explain: you never typed Kevin's address into the `transfer` fields — so how did the ledger know to take the 50 WCR from *him* and not from the instructor?

## What You've Learned

- **`transfer(to, amount)` spends the caller's own balance** — no `from` parameter; the sender is `msg.sender`, whoever signed the call.
- **Amounts are base units** — 100 WCR is `100 * 10**18` = `100000000000000000000`; typing `100` sends a speck.
- **A transfer moves two balances and leaves `totalSupply` untouched**, returning `bool: true` and emitting one `Transfer` event (`logs: 1`).
- **`transfer` in a loop batches the move** — `awardClass` pays a whole roster from the caller's balance in one transaction, one `Transfer` event per student.
