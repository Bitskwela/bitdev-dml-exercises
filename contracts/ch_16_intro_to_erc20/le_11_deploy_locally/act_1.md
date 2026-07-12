# Put WorkshopCredit on a Chain

`act_1.sol` is the clean WorkshopCredit from Lesson 9 with one thing left for you: the starting supply. Set it, then take the contract from a green check to a *living* instance — one Deploy click, a real contract address, and a receipt you can read. Do it all on the **Remix VM**, the sandbox blockchain inside your browser. Nothing real, nothing permanent — a dress rehearsal.

## Task 1: Set the Starting Supply and Compile

Open `act_1.sol`. The constructor currently calls `_mint(msg.sender, 0)` — a stub so the file compiles. Fill in the real amount: mint **1,000 whole credits** to the deployer. Remember Lesson 9 — on-chain amounts are in **base units**, so convert the human amount with `10 ** decimals()` rather than hand-typing zeros. Open the **Solidity Compiler** tab, pick a **0.8.20-or-newer** compiler, and click **Compile**. You want the green check before deploying — you can only deploy something that compiles.

## Task 2: Switch to the Remix VM and Meet Your Cast

Go to the **Deploy & Run Transactions** tab (the Ethereum-logo icon on the left). Open the **Environment** dropdown and select **Remix VM (Cancun)** — this boots the local sandbox chain. (Other "Remix VM (…)" options named after Ethereum upgrades work too; any recent one is fine.) Now look at the **Account** dropdown: it lists **15 accounts**, each showing `(100 ether)`. The one selected — `0x5B38Da6a701c568545dCfcB03FcB875f56beddC4` — is your **instructor** account. Copy that address; you'll want it all course.

## Task 3: Deploy from the Instructor Account

In the **Contract** dropdown, make sure **WorkshopCredit** is selected (not `ERC20` or `IERC20` — those are the imported base files, and you don't deploy those). With the instructor account still selected, click the orange **Deploy** button. Two things happen: a new instance appears under **Deployed Contracts**, and a green transaction lands in the terminal at the bottom.

## Task 4: Read the Deploy Receipt

Click the deploy transaction in the terminal to expand its receipt, and read it like the first page of the ledger. Find four lines and understand each:

- **`contract address`** — the brand-new address where WCR now lives. This is the answer to Dan's whole question: WorkshopCredit *is* somewhere now.
- **`from`** — the instructor account that deployed it. Because the constructor ran `_mint(msg.sender, ...)`, this account now holds all 1,000 WCR.
- **`gas`** — the deploy really cost work (fake ETH here, but measured). Deploying a whole contract is the priciest thing you'll do for a while.
- **`logs  1`** — one log: the mint's `Transfer` from the zero address, written the instant the token was born. (We decode it in Lesson 14.)

Then glance back at the **Account** dropdown: the instructor account no longer reads exactly `(100 ether)` — it's now `(99.99999… ether)`. Every *other* account still reads `(100 ether)`. The deploy spent gas out of the deployer's balance; gas isn't a story, it's a number that actually moved.

## Task 5: Confirm the Initial State

Under **Deployed Contracts**, expand your instance. Click the blue **`totalSupply`** button — it reads `1000000000000000000000` (1,000 WCR in base units). Click **`balanceOf`**, paste the instructor address, and read the same number: the deployer holds the entire supply. Paste the *second* account instead and read `0`. The token has 1,000 credits in existence, and every one of them sits with the instructor — exactly what the constructor minted.

## Sample Output

```text
> WORKSHOPCREDIT AT 0XD914...9138 (MEMORY)

status                 true  Transaction mined and execution succeed
transaction hash       0x3f8e2c9d5a1b7e40f0c2a9b6d1e83f7a4c0b2e91d6a5f38c7b1049e2f6a3b2a1
block number           1
contract address       0xd9145CCE52D386f254917e481eB44e9943F39138
from                   0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
to                     WorkshopCredit.(constructor)
gas                    1160421 gas
transaction cost       1009051 gas
logs                   1

-- reads (free, no gas) --
totalSupply()                      ->  1000000000000000000000
balanceOf(0x5B38...eddC4)  instr.  ->  1000000000000000000000
balanceOf(0xAb84...5cb2)  Kevin    ->  0
```

The contract has an address, a supply, and a holder. Reload the tab and every line above vanishes — that's the rehearsal room resetting, and it's exactly why it's safe to experiment.

## Reflection Questions

1. The deployer ended up holding all 1,000 WCR, and no other account got any. Which single line in the constructor decided that, and what would change if a *different* account had been selected when you clicked Deploy?
2. The receipt showed a **contract address** (`0xd914…9138`) that is different from the **account address** that deployed it (`0x5B38…eddC4`). In your own words, what does each of those two addresses point to, and why is confusing them a classic beginner mistake?
3. Reloading the browser wipes the contract, the balances, and the spent gas. For a first deploy, why is that *disposability* a feature rather than a limitation — and what does it let Dan rehearse before Lesson 25's real network?

## Challenge: Deploy It, Then Meet Your Cast

**Challenge A — Deploy twice and compare.** Deploy WorkshopCredit once and note its contract address under *Deployed Contracts*. Now click **Deploy a second time** without reloading. Watch what appears under *Deployed Contracts* and compare the two addresses. Write two sentences: are these the same contract or two different ones, and how many total WCR now exist across both instances? What does that tell you about whether deploying ever *edits* an old contract?

**Challenge B — Switch accounts and reason about a zero balance.** In the **Account** dropdown, switch from the instructor to the second account (`0xAb84…5cb2` — Kevin's, for later). Then answer in your own words: if you check *that* account's WCR balance right now, it reads **0**, even though the token plainly has a 1,000-credit supply. Why? And separately: does switching the dropdown change *who holds credits*, or only *who you act as* on the next transaction?

## What You've Learned

- **Deploying is the moment a compiled contract becomes live** — it crosses from bytecode in a tab to an instance holding state at a **contract address** of its own.
- **The Remix VM is a disposable sandbox chain** with 15 accounts and 100 pretend ETH each; the selected account is the `msg.sender`, so the deployer receives the full minted supply.
- **A deploy is a gas-costing transaction** — the deployer's balance drops just below 100 ETH — while reads like `balanceOf` and `totalSupply` are free and change nothing.
- **A contract address is not an account address** — one holds a deployed contract's code and state, the other is a wallet that holds ETH and signs; the receipt shows both, `from` and `contract address`, side by side.
