---
title: "Course 16: Intro to ERC-20 Tokens"
description: "Dan Santos' fourth course — from a smudged, disputed credits notebook to Workshop Credit (WCR), a real ERC-20 token and reward store deployed on a public testnet that his students trust because they can verify it themselves. Learn fungible tokens, the ERC-20 interface, OpenZeppelin, the allowance model, minting, and burning — all through Filipino-themed stories and scenarios."

# This is the date the document was last updated.  Format: YYYY-MM-DD.
date: "2026-07-12"

# For SEO purposes
tags:
  [
    "erc20",
    "ethereum",
    "solidity",
    "smart contracts",
    "tokens",
    "fungible tokens",
    "openzeppelin",
    "remix",
    "metamask",
    "sepolia",
    "allowance",
    "transferfrom",
    "minting",
    "burning",
    "bitskwela",
  ]

# Note: Permanames are unique and immutable. Once set, they cannot be changed.  You may change the filename but not this.
permaname: "course-16-intro-to-erc20"

# Can be the same as permaname but can be changed if needed.
slug: "course-16-intro-to-erc20"
---

# Prologue: The Notebook Nobody Could Trust 📒

Three courses ago, Dan Santos didn't know what AI was. Now he *teaches* — a free weekend coding workshop for barangay teens in Marikina, run out of the barangay hall with Tita Malou's carinderia catering the merienda. It started with four kids and one shared laptop. It's thirty-plus now.

To keep them coming back, Dan gives out **credits**: earn them for showing up and finishing exercises, spend them on turon, secondhand USB sticks, hand-me-down books, or an hour of one-on-one help. He tracks it all in a notebook. And the notebook is the problem — it's smudged, it's disputed, it can be edited, and *Dan* is the only one who holds it. So when a student swears he finished an exercise and the notebook says otherwise, there is no way to prove anything to anyone. The credits are only as trustworthy as Dan's handwriting and Dan's memory, and the students know it.

Kuya JM — whose BPO team is piloting a blockchain settlement layer — hears the whole story over Messenger and says the thing that starts this course: _"Dan, you don't need a better notebook. You need a notebook the whole barangay can read and nobody can erase. That's an ERC-20 token."_

This is **Dan Santos'** fourth course. In Intro to AI he built **Luto v1**, a rule-based chatbot. In Intro to ML he upgraded it into **Luto v2**. In Intro to Rust he shipped **LutoCLI**, a compiled binary Tita Malou runs herself. Now he learns Solidity — and ships **Workshop Credit (WCR)**, a token and a reward store his students can trust *without* having to trust him.

---

## Course Structure: 25 Lessons Across 3 Acts

### **Act 1: Understanding Tokens (Lessons 1-9)**

_"So a token is just... a shared notebook?"_

- L01: What Is an ERC-20 Token?
- L02: Design the Token
- L03: Set Up Remix
- L04: Understand a Smart Contract
- L05: Meet the ERC-20 Interface
- L06: Import OpenZeppelin ERC20
- L07: Add Token Metadata
- L08: Create the Initial Supply
- L09: Understand Token Decimals

**Master:** What a fungible token actually is (a listahan of who holds how much), how to design one on paper — name, symbol, supply, who's admin, who's a student — the Remix IDE with zero install, the anatomy of a smart contract, the six ERC-20 functions and two events, inheriting OpenZeppelin's battle-tested ERC20 (bayanihan: don't rebuild what the barangay already built), the constructor that names the token, `_mint` for the initial supply, and the day the balance reads `0.000000000000001000` and decimals finally make sense.

---

### **Act 2: Bringing WCR to Life (Lessons 10-18)**

_"Wait — I can watch every peso move?"_

- L10: Compile and Debug
- L11: Deploy Locally
- L12: Read Token Information
- L13: Transfer Tokens
- L14: Inspect Transfer Events
- L15: Test Failed Transfers
- L16: Approve a Spender
- L17: Check Allowances
- L18: Spend With transferFrom

**Master:** Reading real compiler errors as mentorship, deploying a live contract to Remix's local chain, free read-only calls (`name`, `symbol`, `decimals`, `totalSupply`, `balanceOf`), sending your first `transfer`, finding it in the `Transfer` event log, meeting your first revert (`ERC20InsufficientBalance` — a stop, not a crash), and the allowance model end to end: `approve`, `allowance`, `transferFrom` — the exact machinery the reward store will run on.

---

### **Act 3: The Reward Economy (Lessons 19-25)**

_"Okay Ma, watch — he earns it, he spends it, and you can see all of it."_

- L19: Build a Reward Store
- L20: Purchase a Reward
- L21: Add Controlled Minting
- L22: Add Student Rewards
- L23: Add Token Burning
- L24: Test the Complete System
- L25: Deploy and Demonstrate

**Master:** A second contract (`RewardStore`) that lists redeemable items, `buyItem()` pulling WCR via `transferFrom` (the first on-chain purchase), `onlyOwner` minting so not just anyone can print credits, a human-readable `rewardStudent(address, amount, reason)` that logs *why* on-chain forever, burning credits on redemption so supply tells a true story, a full happy-and-unhappy-path test checklist, and a real Sepolia deployment demoed at the workshop graduation.

---

## What You'll Build

Across the chapter you build one real system, piece by piece:

1. **A token-like balance map** (L01) — the barest thing that IS a token: who holds how much
2. **WCR on paper, then in code** (L02–L09) — a full OpenZeppelin ERC-20 with name, symbol, supply, and correct decimals
3. **A live, transferable token** (L10–L15) — deployed locally, moved between accounts, its events read, its reverts understood
4. **The allowance machinery** (L16–L18) — approve, check, `transferFrom` — delegated payment that a store can run on
5. **`RewardStore.sol`** (L19–L20) — a contract that lists turon, USB sticks, and books, and collects WCR to sell them
6. **Instructor-controlled minting + rewards** (L21–L22) — `onlyOwner` mint and a `rewardStudent` that records the reason
7. **Burning on redemption** (L23) — a claimed reward burns its WCR, so `totalSupply` never lies
8. **A tested, deployed system** (L24–L25) — every path checked, both contracts live on Sepolia, verified on Etherscan

---

## Learning Approach

Each lesson features:

- **Story-driven content** — follow Dan Santos through relatable Filipino Solidity scenarios
- **Locally-themed examples** — the utang listahan, paluwagan, suki loyalty, GCash-as-screen-money, turon-for-credits
- **REAL tool output shown on purpose** — real Remix compiler errors, real `Transfer`/`Approval` event logs, real OpenZeppelin v5 custom errors (`ERC20InsufficientBalance`, `OwnableUnauthorizedAccount`), real Sepolia Etherscan pages. Reading the ledger IS the skill.
- **Hands-on Solidity practice** — every lesson ships a real starter contract to complete plus a challenge to extend it
- **Self-check quizzes** — short knowledge checks per lesson
- **Runs in the browser** — everything works in the Remix IDE with zero install until you deploy to a testnet in Lesson 25

---

## Who Is This For?

**Perfect for:**

- Absolute beginners to blockchain who want to understand tokens by *building* one
- Programmers from any language curious what a smart contract actually is
- Anyone who's been told "crypto is a scam" and wants to see the honest, useful side of a public ledger
- Builders who want a real, deployable project — not a toy — by the end

**Prerequisites:**

- A computer with a modern web browser and internet access
- Basic comfort with reading code (any language); **no prior blockchain or Solidity experience needed**
- For Lesson 25 only: the MetaMask browser wallet and some free Sepolia testnet ETH from a faucet
- The AI/ML/Rust courses are **not** required — this course re-introduces everything it borrows

---

## Your Learning Companion

**Dan Santos** — an IT student from Marikina on his fourth journey. This time he isn't the student who might fail; he's the teacher whose numbers other people are trusting. He goes from _"blockchain? That's the crypto-scam stuff Tita Malou saw on Facebook"_ to shipping a token his students verify themselves.

He's not alone:

- **Kuya JM** — the primary mentor, a BPO engineer learning Solidity at work a few months ahead of Dan; supplies the "shared utang notebook" pitch and the pautang-sa-tindera allowance analogy. Honest about what he doesn't know yet.
- **Tita Malou** — the crypto-skeptic _and_ the end user. Her default on anything with "token" in it is _"scam yan."_ She sponsors the turon reward and mans the redemption counter. Winning her over is the finale.
- **Ate Rina** — cameo mentor on the two beats that need a strict voice: access control (L21) and testing (L24). _"Who can mint, bata?"_
- **Jasper** — the friendly rival deep in the NFT/memecoin timeline, who learns why a boring, useful token beats a flashy, speculative one.
- **The Public Ledger** — the sixth character. Not a person, but treated like one: the shared record nobody can secretly edit. Its arc runs suspicious → transparent → trustworthy, exactly like the Rust compiler was Course 15's sixth character.

---

## Technologies You'll Touch

**Core:**

- [Remix IDE](https://remix.ethereum.org) — write, compile, and deploy Solidity in the browser, no install
- [OpenZeppelin Contracts](https://openzeppelin.com/contracts) v5 — audited, reusable ERC-20 and access-control building blocks
- [MetaMask](https://metamask.io) — the browser wallet for signing testnet transactions (Lesson 25)
- [Sepolia testnet](https://sepolia.dev) + [Sepolia Etherscan](https://sepolia.etherscan.io) — a free public Ethereum test network and its block explorer

**Language & concepts:**

- Solidity `^0.8.20` — contracts, state, functions, visibility, events, custom errors
- The ERC-20 standard — `transfer`, `approve`, `transferFrom`, `balanceOf`, `allowance`, `totalSupply`
- Inheritance, the allowance model, controlled minting (`onlyOwner`), decimals and base units, and burning

> All lessons target **Solidity `^0.8.20`** and **OpenZeppelin Contracts v5**. Remix resolves the pinned imports (e.g. `@openzeppelin/contracts@5.0.2/...`) automatically — no `npm install` required.

---

## Learning Path

```
Lessons 1-3    → What a token is, design WCR on paper, open Remix
Lessons 4-9    → First contract, the ERC-20 interface, inherit OpenZeppelin, name + supply + decimals
Lessons 10-15  → Compile, deploy locally, read state, transfer, read events, meet your first revert
Lessons 16-18  → The allowance model: approve, check, transferFrom
Lessons 19-23  → Build the RewardStore, sell items, control minting, reward students, burn on redemption
Lessons 24-25  → Test every path, deploy to Sepolia, demo the loop at graduation
```

---

## What Makes This Course Different?

- **Filipino context throughout** — the utang listahan as a balances mapping, paluwagan as a public ledger, suki loyalty as a token program made tamper-proof
- **Story-driven** — Dan Santos' journey, not dry standard-spec prose
- **Real output, on purpose** — compiler errors, event logs, revert reasons, and Etherscan pages are shown in full, because reading them is the actual skill
- **The ledger is a character** — its arc from "crypto scam?" to "the students trust the ledger, not me" is the real learning arc of every honest token project
- **Honest about what a token is** — WCR is a transparent points system, never a speculative coin. Tita Malou's skepticism gets answered with _transparency_, not _profit_

---

## Time Commitment

- **25 lessons** → ~8-12 minutes reading each = 4-5 hours of instruction
- Hands-on building, challenges, and the final deploy: 10-15 hours
- **Total estimated time:** 14-20 hours to complete
- **Recommended pace:** 3-5 lessons per week = 5-8 weeks (or roughly 25 evenings at one lesson per sitting)

---

## After This Course

You'll be able to:

- ✅ Explain what a fungible token is and why an ERC-20 lives on a public ledger
- ✅ Read the ERC-20 interface — its six functions and two events — and map each to a real action
- ✅ Write, compile, and deploy a Solidity contract in Remix
- ✅ Inherit OpenZeppelin's ERC20 and give it a name, symbol, supply, and correct decimals
- ✅ Transfer tokens, read `Transfer`/`Approval` events, and understand reverts and custom errors
- ✅ Use the allowance model — `approve`, `allowance`, `transferFrom` — for delegated payments
- ✅ Build a second contract that accepts token payments and burns redeemed credits
- ✅ Lock sensitive actions behind `onlyOwner` and reason about who is allowed to do what
- ✅ Test happy and unhappy paths, then deploy and verify a real system on the Sepolia testnet

---

## Let's Begin Your Journey

From a smudged notebook nobody could trust to a token thirty barangay kids check on their own phones — in 25 lessons.

It starts with one question from a student who swears he finished the exercise: **"Kuya Dan, tapos ko na, bakit wala akong credits?"** (I'm done — why don't I have credits?)

And it ends at the workshop graduation, where a first-year named Kevin redeems 100 WCR for a turon, the ledger logs it in public, and Tita Malou — certain in Lesson 1 that this was a scam — pulls up the Etherscan page, sees the transaction sitting there for the whole world to read, and hands over the turon: **"Nakikita ko lahat. Okay. Pwede."**

**Simulan natin!** (Let's start!) 📒
