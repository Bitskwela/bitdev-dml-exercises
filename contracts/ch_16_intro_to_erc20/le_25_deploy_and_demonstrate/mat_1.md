## Dan's Story: The Graduation

Last lesson ended in the dorm with Ate Rina reading over Dan's shoulder as he ran the full test checklist — deploy both, `rewardStudent` as owner (pass), as a stranger (revert `OwnableUnauthorizedAccount`), transfer, over-transfer (`ERC20InsufficientBalance`), approve, `buyItem` after approving (supply drops), `buyItem` without approving (`ERC20InsufficientAllowance`). Every row green. *"Finally,"* she said, *"a ledger as strict as me."* But every one of those green rows lived on the **Remix VM** — a sandbox that exists only inside Dan's browser tab and disappears the moment he closes it. Kevin can't open it. Tita Malou can't open it. The graduation was Saturday, and the whole point was a ledger the barangay could read *without Dan in the room*.

The barangay hall smelled like turon and floor wax. Thirty-plus kids, some parents on the plastic chairs, a tarpaulin misspelling `WORKSHOP GRADUATION`. On the wall, a piece of bond paper in Dan's neatest print:

```text
WORKSHOP CREDIT (WCR) — GRADUATION DEMO
  1. Kevin earns 200 WCR  (natapos ang final exercise)
  2. Kevin approves the store to take 100
  3. Kevin buys 1 turon (100 WCR) — sinusunog ng store ang credit
  Lahat ito, makikita sa telepono. Live. Sepolia.
```

Dan had done the scary part the night before — deployed both contracts to Sepolia, gas paid in free test ETH, MetaMask asking "are you sure" four times. Today was just the loop, in public. He called up Kevin — the same Kevin who, twenty-four lessons ago, stood at this table and said *"Kuya Dan, tapos ko na, bakit wala akong credits?"* about a notebook nobody could check.

> **Dan:** Kevin. Finished the final exercise?
>
> **Kevin:** Opo, kuya. Yung buong CSV parser.

From the instructor account Dan called `rewardStudent(kevin, 200 WCR, "Finished final exercise")`. MetaMask slid up; he hit Confirm. Fifteen seconds — a lifetime with a room watching — and the terminal went green. Kevin already had MetaMask open on his own phone; his WCR balance ticked from 0 to 200. He laughed. Then, because it only mattered if it could be *spent*, Kevin approved the store for 100 WCR and bought a turon. `buyItem(0)`. Confirm. The store pulled his 100 credits and **burned** them on the spot — gone, ubos, `totalSupply` down by exactly one turon.

Tita Malou handed over the turon. But she didn't let go right away.

> **Tita Malou:** Sandali. Yung sabi mo, nakikita ng lahat. Patingin.

Dan pulled up `sepolia.etherscan.io`, typed the WCR contract address, and turned the screen to face her. There it was — not his handwriting, not his memory, not his say-so. Kevin's reward, timestamped. Kevin's purchase, timestamped. The burn, a transfer to `0x0000...0000`, timestamped. A public webpage Dan did not own and could not edit, showing every credit that had ever moved, to anyone on Earth with the link. She scrolled it herself, one finger, and found Kevin's address, the word `Transfer`, and the number `100`.

> **Tita Malou:** Ito ba lahat totoo? Hindi mo mababago?
>
> **Dan:** Hindi ko na po mababago, Ma. Kahit gusto ko. Yun ang buong punto.

She looked a moment longer. Then she handed Kevin his turon.

> **Tita Malou:** Nakikita ko lahat. Okay. Pwede.

Three courses of skepticism — *"scam yan, nakita ko sa Facebook"* — closed on one word. *Pwede.* Jasper had come for the free food and stayed for the demo. In Lesson 1 he'd called this whole thing *"so 2017, mint a PFP collection."* Now he watched a fourteen-year-old check his own balance on a phone, spend it on a real snack, and verify the whole thing on a public explorer — no floor price, no roadmap.

> **Jasper:** ...Okay. That's more real than my whole portfolio. Teach me pala.

---

## The Concept: Off the Sandbox — a Real Public Ledger

### From a sandbox to a public square

The Remix VM was training wheels: a fake blockchain inside your browser tab, with fake accounts and instant, free transactions. Perfect for learning — and completely private. Close the tab and it's gone. **Sepolia** is a real, public, shared Ethereum network. The same machinery — accounts, gas, transactions, events — except now the ledger is one that thousands of computers worldwide hold a copy of, and anyone can read. Nothing about your Solidity changes; the contract that passed every test on the VM is the *exact* contract you ship. Only the stage changes — from a private tab to a public square.

```text
   REMIX VM (Lessons 11-24)              SEPOLIA (Lesson 25)
   ------------------------              -------------------
   lives in YOUR browser tab             lives on thousands of nodes worldwide
   fake accounts, fake ETH               a real account (MetaMask) + free test ETH
   instant, private                      ~12-second blocks, fully public
   gone when you close the tab           permanent, at a public URL
   only YOU can see it                   Kevin, Tita Malou, ANYONE can read it
```

### Mainnet vs testnet — and why WCR belongs on a testnet

Ethereum has a **mainnet** (the real one, where ETH costs real money) and several **testnets**. Sepolia is a testnet: identical rules and tooling, but its ETH is **free test ETH with no monetary value.** You get it from a faucet, spend it on gas, and nobody buys or sells it. That's exactly right for WCR, which was never money — it's a transparent points ledger you earn for finishing exercises and spend on turon. A testnet gives Dan everything he wants — public, permanent, verifiable — and **none** of what Tita Malou feared: nothing to invest in, nothing to "moon." If WCR were on mainnet, gas would cost real pesos and the word "token" would attract exactly the wrong crowd. A testnet keeps it honest.

### The tools that get you there

| Tool | What it is | Its job here |
|---|---|---|
| **MetaMask** | A browser-extension crypto wallet | Holds your account (address + private key) and **signs** transactions. The bridge from Remix to Sepolia. |
| **A faucet** | A free tap that drips test ETH | Sends you Sepolia ETH so you can pay gas. Paste your address, wait a minute. |
| **Test ETH (gas)** | Free Sepolia ETH | Pays for every state-changing transaction (deploy, mint, transfer, buy). Reading is free. |
| **Injected Provider – MetaMask** | A Remix environment | Routes your deploys and calls **through MetaMask onto Sepolia** instead of the local VM. |
| **Sepolia Etherscan** | A public explorer at `sepolia.etherscan.io` | The webpage where anyone reads the ledger — transactions, addresses, holders, events. |

### Gas, in one honest paragraph

Every transaction that **changes state** — deploying, minting, transferring, approving, buying — costs **gas**, paid in ETH. It's the network's fee for executing and permanently recording your transaction across all those nodes. On mainnet that's real money; on Sepolia it's free test ETH, so the *cost* is fake but the *mechanism* is 100% real. Reading the ledger — `balanceOf`, `totalSupply`, `allowance` — is free and always will be. You only pay to write, never to read. (A course-long callback: Rust moved the crash from Tita Malou's counter to Dan's desk. Sepolia moves the *ledger* from Dan's private tab to a public square — same trade, different layer: pay a little now so nobody gets surprised later.)

### Verify your source, and the ledger is fully open

Deploying puts the *bytecode* on-chain, but Etherscan can also show the world your actual Solidity if you **verify** the contract (Etherscan's "Verify & Publish", or Remix's Etherscan plugin — it needs your Etherscan API key, the exact compiler version `0.8.20`, and matching optimization settings). Once verified, a green check appears and a **Read/Write Contract** tab lets anyone call the blue read functions straight from the browser — no Remix, no code. That's the ledger at its most open: the numbers *and* the rules, both public, both auditable by a stranger.

### The block explorer — the sixth character, finally in public

For 24 lessons the public ledger was the sixth character in this story: suspicious in Lesson 1 (*"scam yan"*), readable by Lesson 14 (*"wait, I can read this"*), trustworthy by now. Sepolia Etherscan is where it steps into the open. Paste a **transaction hash** and see exactly what happened. Paste an **address** and see its balance and history. Paste the **token contract** and see the token page: every holder, every transfer, every event, decoded. Dan doesn't have to *promise* Tita Malou the numbers are honest. He just hands her the URL.

---

## Key Takeaways

- **A testnet is a real public ledger with fake-money stakes.** Sepolia gives WCR everything it needs — public, permanent, verifiable — with none of the speculation Tita Malou feared. Free test ETH, real transparency.
- **MetaMask is the bridge; your key is the whole security model.** It signs transactions and lets Remix deploy to Sepolia via "Injected Provider – MetaMask." Nobody moves your credits without your key — so never share your seed phrase, faucet or no faucet.
- **You pay gas to write, never to read.** Deploy, mint, transfer, approve, and buy cost (test) ETH; `balanceOf`, `totalSupply`, and `allowance` stay free forever. The mechanism is identical to mainnet — only the ETH is free.
- **Etherscan is where the sixth character goes public.** A transaction hash, an address, or the token page turns "trust me" into "read it yourself" — holders, transfers, and decoded events, for anyone with the link.
- **A burn shows on-chain as a `Transfer` to `0x0000...0000`.** After Kevin's redemption the supply honestly reads 1,100 WCR — the ledger tells the true story of credits spent.
- **Verifying your source makes the *rules* public too, not just the numbers.** A verified contract shows its Solidity and a Read/Write tab on Etherscan, so a stranger can audit both what happened and the code that allowed it.
- **The demo is the deliverable.** The finale wasn't the code; it was Tita Malou reading Kevin's transaction on a phone and saying *"pwede."* Learn to hand someone the URL and let the ledger speak.

---

## The End — and Your Beginning

There is no Lesson 26. So let's close it properly.

Four courses ago, Dan didn't know what AI was. He built **Luto v1** — a rule-based chatbot — and it worked, when Dan ran it. He built **Luto v2** — a real ML model on his mother's sales notebook — and it worked, on Dan's laptop, with Dan's Python. He built **LutoCLI** in Rust — one binary, no installs — and it worked without him hovering, but someone still had to be handed the file. **Workshop Credit** is the fourth thing, and it finished the journey those three started: it runs on a public network Dan doesn't own, read by strangers he'll never meet, and Kevin can prove he earned 200 credits from his own phone — because the one thing Dan built into WCR is that *even he* can't secretly change it. The smudged notebook from Lesson 1 needed Dan to be trustworthy. The ledger needs nobody to be.

You came the same distance — from *"blockchain? that's the crypto-scam stuff on Facebook"* to writing an OpenZeppelin ERC-20, wiring a second contract through the allowance model, locking minting behind `onlyOwner`, burning on redemption so supply never lies, testing every unhappy path, and deploying to a public testnet anyone can read. And like Dan's, none of your next paths need anyone's permission: **ship your own credit** (your org's volunteer hours, your study group's attendance — change the name and symbol, deploy, hand someone the link); **learn ERC-721** (the non-fungible cousin, Jasper's PFP world, now with the machinery under the hype); or **find your community's notebook problem** — the paluwagan on a smudged page, the dues disputed every quarter — and build the version nobody has to trust at all.

Dan's story ends where it began: a folding table in a Marikina barangay hall, a tray of turon, thirty kids checking their own credit balances on their own phones — trusting a number their kuya can no longer change by hand, even if he wanted to. He didn't need a better notebook. He needed a notebook the whole barangay could read and nobody could erase. He built it. Now you can too.

*— WAKAS NG KURSO. Salamat sa pagsama kay Dan, mula Luto v1 hanggang sa ledger. Ngayon, ikaw naman ang magtayo ng tiwala.*
