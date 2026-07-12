## Dan's Story: The Dress Rehearsal Barangay

Last lesson, Dan did something backwards — he broke his own working contract on purpose, planting a wrong pragma, a missing import, and a misspelled `constructor`, then read each red box like a letter until he was back to a clean green check. But a green check only proves one thing: the code is *shaped* correctly. It has never actually run anywhere. Right now WorkshopCredit is nothing but bytecode sitting in a browser tab — a contract that has never drawn a breath. Late afternoon in the computer lab, most of the workshop kids gone home, Dan clicked around Remix looking for the part where it becomes real, and couldn't find it.

He voice-noted JM.

> **Dan:** Okay so it compiles, walang error, `1000 * 10 ** decimals()` and lahat. Pero... saan na? Where does it actually *go*? Feeling ko I built a jeepney and it's just parked.
>
> **Kuya JM:** Naks, good instinct — compiling lang ang ginawa mo. The compiler just checked na tama ang pagkakasulat. It never *ran* it. A contract only becomes a live thing when you **deploy** it — send it to a blockchain, where it gets its own address and starts holding state. Yung 1,000 credits mo? Hindi pa yun nangyari. It's a recipe, hindi pa luto.

That landed. Dan had a recipe. He wanted the dish.

> **Dan:** Sige — anong blockchain? Do I need real ETH? Ma's going to lose it if I have to buy crypto.
>
> **Kuya JM:** Relax. Hindi ka pa lalabas sa Remix. May kasama itong **local blockchain** — tumatakbo lang sa browser mo, walang internet, walang totoong pera. The Remix VM. Isipin mong practice barangay: may mga fake na accounts, each with pretend ETH, at pwede kang mag-deploy nang paulit-ulit. Ide-deploy mo si WorkshopCredit doon — and you can play *every* role yourself. One account is you, the instructor. The others? Gawin mong mga estudyante.

Dan sat up. A whole cast of accounts, and he was all of them — instructor and students, in one browser tab, for free.

Tita Malou passed behind him carrying a stack of clean tabo and caught the word *gas* on his screen.

> **Tita Malou:** Gas? Magbabayad ka ng gas? Anak, sabi ko na nga ba, may bayad pala 'to.
>
> **Dan:** Hindi po totoong bayad, Ma. This is a practice room — the ETH here is pretend, parang play money sa board game. Zero pesos. Gas is just the counter that measures how much work a transaction takes; dito, libre lahat.

She narrowed her eyes at the fake `100 ether` beside each account, unconvinced anything labeled *ether* could be free, but set a bibingka by his elbow and let it go. Dan turned to a dropdown he'd been ignoring all along — **Environment** — and finally understood it was the door to the whole thing.

---

## The Concept: A Whole Blockchain in a Browser Tab

### The Remix VM: a practice barangay

Everything so far — writing, compiling, reading errors — happened *before* the blockchain. **Deploying** is the step where your contract crosses over and becomes a live instance that holds state at an address.

But you don't want your first deploy to be on a real, public network where mistakes are permanent and cost real money. So Remix ships with the **Remix VM** — a complete, simulated Ethereum blockchain that runs **entirely inside your browser tab**.

- **No internet, no wallet, no install.** It's a sandbox — a quiet callback to Rust's Playground, the toolchain that just *opens*.
- **It's disposable.** Reload the page and the whole chain resets — contract, balances, everything, gone. That's a feature: a rehearsal room, not a stage.
- **The ETH is pretend.** No real money is ever involved. This is exactly Tita Malou's answer: *walang totoong pera dito.*

### Test accounts: fifteen wallets, 100 pretend ETH each

The moment you switch to the Remix VM, the **Account** dropdown fills with **15 pre-made accounts**, each preloaded with **100 (fake) ETH**. Whoever is selected becomes the `msg.sender` of the next transaction — so you play the whole cast yourself.

```text
   REMIX VM — Dan's practice barangay (all local, all pretend)
   Account dropdown (each starts with 100 test ETH):

   0x5B38Da6a701c568545dCfcB03FcB875f56beddC4  (100 ether)  <- INSTRUCTOR (Dan)  <- deploy from here
   0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2  (100 ether)  <- STUDENT: Kevin
   0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db  (100 ether)  <- STUDENT: (spare)
   ... 15 accounts total ...
```

Whichever account is selected when you hit **Deploy** becomes the deployer — and because the constructor runs `_mint(msg.sender, ...)`, the holder of all 1,000 starting credits. That's why the first account is the **instructor**; the rest are waiting to be students.

### Gas: every write has a price tag (even a free one)

Every action that *changes* the blockchain — deploying, minting, transferring — is a **transaction**, and every transaction costs **gas**: a measure of computational work, paid in ETH. Here the ETH is fake, so gas is effectively free — but it is still **measured**, and that number is worth watching.

| Kind of action | Example | Transaction? | Costs gas? |
|---|---|---|---|
| **Write** (changes state) | deploy, mint, transfer, approve | Yes | Yes |
| **Read** (just looks) | name, symbol, balanceOf, totalSupply | No | **No** |

Deploying is the biggest write of all — you're writing an entire contract onto the chain — so it's the most gas you'll spend for a while. (Reads are Lesson 12, and they're gloriously free.)

### Deploy is a transaction; the contract gets its own address

When you deploy, Remix packages your bytecode into a transaction, sends it from your selected account, and the chain **mines** it into a block. The result: a brand-new contract, alive at its **own address** — separate from any account address.

```text
   DEPLOY (once)                      CALL (any time after)
   send the bytecode as a tx,         talk to the already-live
   FROM your account                  instance AT its address
        |                                  +--> read  (blue)   = free, no tx
        v                                  +--> write (orange) = a tx, costs gas
   a new contract is BORN at a
   CONTRACT ADDRESS:  0xd914...9138
```

Two kinds of address, and beginners mix them up constantly:

- An **account address** (`0x5B38...eddC4`) belongs to a *person/wallet* — it holds ETH, signs transactions, and can be a `msg.sender`.
- A **contract address** (`0xd914...9138`) belongs to a *deployed contract* — it holds state (all the WCR balances) and is where you send calls.

Dan's WorkshopCredit was born at a contract address. That address is the answer to his question from the story — *"where does it actually go?"* It goes to an address of its very own.

### Deploy vs. call

- **Deploy** = create the instance. Happens **once**. A transaction; it costs gas; it hands you a contract address.
- **Call** = interact with the instance that already exists. Happens **many times**. A *read* call is free; a *write* call is another gas-costing transaction.

Today is purely a **deploy** lesson. Next lesson is all **calls**.

---

## Key Takeaways

- **Compiling is not deploying.** A green check only proves the code is well-formed; the contract doesn't exist on any chain until you **deploy** it — that's the moment it becomes live and starts holding state.
- **The Remix VM is a local sandbox blockchain** running entirely in your browser — no internet, no wallet, no install, no real money. It resets on reload: a rehearsal room, not a stage.
- **You get 15 test accounts, each with 100 pretend ETH.** The selected account is the `msg.sender` of the next transaction, so you can play instructor *and* students yourself.
- **Deploying is a transaction, and it hands the contract its own address.** A *contract address* (where the code and all balances live) is a different thing from an *account address* (a wallet that holds ETH and signs).
- **Gas measures the work of every write** — deploy, mint, transfer — and is paid in ETH. Here it's free but still measured; the deployer account drops just below 100 ETH, proving the deploy really cost something.
- **Deploy vs. call:** deploy once to create the instance, then call it many times — reads free, writes as new gas-costing transactions.
- **The deploy receipt is public and readable** — `status`, `from`, `contract address`, `gas`, `logs` — the first page of the ledger character you'll spend the course learning to read.

---

## What's Next?

WorkshopCredit is live. It has an address, a 1,000-credit supply, and a receipt sitting in the terminal. But Dan hasn't actually *asked* it anything yet — he's been staring at it like a jeepney he just parked, without turning the key.

Next lesson he turns the key, and it's the easiest, cheapest thing in the whole course. Those blue buttons in Remix — `name`, `symbol`, `decimals`, `totalSupply`, `balanceOf` — are **read-only calls**: zero gas, no permission, and they change nothing. Dan will build a little "token info worksheet," click each one, and confirm his contract reports itself honestly. And there's the transparency beat waiting underneath — if reading the ledger is free and needs no permission, then it's not just Dan who can check the numbers. *Anyone* can. Even Tita Malou.

**Next Lesson: Read Token Information** — the free, gasless `view` calls, and the first taste of a ledger anyone can audit.
