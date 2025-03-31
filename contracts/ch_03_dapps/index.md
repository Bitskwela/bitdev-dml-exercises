---
title: "Course 3: Intro to dApps"
description: "Decentralized Applications (dApps)"

# This is the date the document was last updated.  Format: YYYY-MM-DD.
date: "2025-03-30"

# For SEO purposes
tags: ["markdown", "metadata", "bitskwela", "solidity"]

# Note: Permanames are unique and immutable. Once set, they cannot be changed.  You may change the filename but not this.
permaname: "course-1-basic-solidity"

# Can be the same as permaname but can be changed if needed.
slug: "course-3-dapps"

# Should be in order
lessons: [
    "le_01_ethersjs_metamask", 
    # "02_lesson2"
    ]
---

# Chapter 3 - Mastering DApp Development

## Welcome to the Next Level!

You’ve conquered Solidity. You’ve written smart contracts, deployed them, and even secured them against attacks. **But now comes the real challenge**—bringing them to life in a real-world application.

In this chapter, we’re going beyond smart contract logic. You’re about to learn how to integrate blockchain with frontend applications and create fully functional **Decentralized Applications** (DApps).

### ⚠️ Prerequisites Before You Start

This chapter assumes that you already have knowledge of:

- ✅ Web Development – Basic understanding of HTML, CSS, and JavaScript.
- ✅ React.js – Knowledge of components, props, state, hooks, and handling API calls.
- ✅ JavaScript ES6+ – Understanding of async/await, promises, and object destructuring.
- ✅ Node.js & npm/yarn – For installing dependencies and running the local development server.
- ✅ Basic Terminal/Git Usage – Since we’ll be working with command-line tools.

👉 If you're not yet comfortable with these, take some time to review modern JavaScript and React fundamentals before diving into this chapter.

### 📌 What to Expect in This Chapter

- ✅ Bridging Smart Contracts & Frontend – Learn how to connect your Solidity contracts to a React.js frontend.

- ✅ Interacting with the Blockchain – Send transactions, read contract states, and listen for blockchain events.

- ✅ Building Real-World DApps – Implement wallet authentication, token transactions, NFT minting, DeFi mechanics, and more.

This is where you transition from being a Solidity developer to a full-stack blockchain engineer—someone who doesn’t just write smart contracts but builds products that people can actually use.

## Ways of verifying the learner's progress and accuracy on these activities

### ✅ Manual & Automated Verification Steps

**1️⃣ On-Chain Verification (Smart Contract Deployment & Interaction)**
We need a way to confirm that learners have successfully deployed their smart contracts and executed required transactions.

**Method 1: Submit Contract Address for Validation**

For example, learners submit their deployed ERC20 contract address to a verification system.
The system checks if:

- The contract exists on the local Hardhat/Testnet blockchain.
- The contract follows the correct ERC20 implementation.
- The expected initial token supply was created.
- The learner's wallet address is the contract owner.

**Method 2: Verify Contract Interactions**

Require learners to perform specific transactions and submit transaction hashes for validation:

- Mint new tokens (owner function)
- Send tokens to another address
- Check token balances before and after

**2️⃣ Knowledge-Based Verification using custom AI (Ensure They Understand)**

Even if they complete the coding part, do they truly understand what they built?

**Method 1: Auto-Graded Multiple-Choice Quiz**

Ask key concept questions to confirm understanding:

- What does \_mint() do?
- Why do we use OpenZeppelin’s ERC20?
- What’s the difference between transfer() and approve()?

Or, ask an open-ended question like:

- "How does an ERC20 token solve financial problems in local communities?"

- Responses can be peer-reviewed or checked by AI for key concepts.

_We will let our AI agent to analyze and grade their answers. Learners must pass with 80%+ in order to proceed._

**3️⃣ Off-Chain Verification (Local Setup & Code Accuracy)**

Learners must have followed the correct coding steps, but how do we check without seeing their local machines?

**Method 1: Hash-based Code Submission**

Require learners to submit the hash of their source code.
The platform precomputes hashes of the correct solutions.
The system then checks if the learner’s file hash matches the expected one.

📌 Example:

If the learner’s `PalengkeToken.sol` is correct, their file hash will match:

```sh
shasum -a 256 PalengkeToken.sol  # Learner submits this hash
```

**Method 2: Code Snippet Verification via GitHub**

Ask learners to push their solution to GitHub.
They submit a GitHub repo link for verification.
The platform runs an automated linter and compiler check via GitHub Actions.
