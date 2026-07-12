# Lesson 3 Quiz: Set Up Remix

---
# Quiz 1
## Scenario: The Setup That Wasn't

Braced for the worst install of his life, Dan asks JM which compiler and CLI to download. JM's answer, delivered as a grinning voice note: "Wala kang i-install. Zero. Buksan mo lang ang browser mo." The tool is Remix, at remix.ethereum.org, and it just... opens.

**Question 1:** What does Dan need to install to start writing and compiling Solidity in Remix?
A. A compiler, a CLI, and a package manager — roughly a full evening of setup
B. Nothing — Remix is a full IDE that runs inside a browser tab, no install and no account
C. A 40-gigabyte blockchain node that syncs overnight
D. A paid desktop application from remix.ethereum.org

**Answer:** B
**Explanation:** Remix runs entirely in a browser tab — editor, compiler, and a sandbox blockchain — with no install and no account. It's the same relief the Rust Playground gave Dan a course ago, turned up.

---

**Question 2:** Which four Remix panels does the course actually use?
A. Only the editor and a terminal
B. Debugger, Git, Plugin Manager, and Settings
C. File Explorer, the editor, the Solidity Compiler, and Deploy & Run
D. Wallet, Marketplace, Faucet, and Explorer

**Answer:** C
**Explanation:** File Explorer holds your files, the editor is where you type, the Solidity Compiler turns `.sol` into runnable code, and Deploy & Run (from Lesson 11) puts a contract on a chain and clicks its functions. Ignore everything else for now.

---

**Question 3:** The file begins with `pragma solidity ^0.8.20;`. What does the caret (`^`) mean?
A. Exactly version 0.8.20 and nothing else
B. Any version from 0.8.20 up to — but not including — 0.9.0
C. Version 0.8.20 or older
D. Any version at all; the caret is decorative

**Answer:** B
**Explanation:** `^0.8.20` means `>= 0.8.20 AND < 0.9.0`. So 0.8.21 and 0.8.26 are fine, but 0.9.0 is not — pinning the compiler so the same code compiles the same way for everyone.

---

# Quiz 2
## Scenario: Compile the Smallest Contract

JM tells Dan to write `HelloToken.sol` with the smallest contract that *answers back* — one `pure` function returning "Kumusta, blockchain!" — and just get it green before building any token. Get the boring plumbing green first.

**Question 4:** What does the `// SPDX-License-Identifier: MIT` line do, and what happens if you delete it?
A. It's required for the code to run at all; without it, compilation fails with an error
B. It declares the source's open-source license (because contracts are read in public); without it the code still compiles, but the compiler nags with a yellow warning
C. It sets the compiler version; without it, Remix picks a random one
D. It's a comment with no effect whatsoever

**Answer:** B
**Explanation:** SPDX is a machine-readable license stamp — contracts are meant to be published and read (WCR's source goes on a block explorer in Lesson 25). Omit it and the contract still compiles, but you get a yellow "license not provided" warning. Include it for a clean compile.

---

**Question 5:** `greet()` is marked `pure`. What does that keyword promise?
A. That the function is the fastest possible version
B. That the function reads and writes no on-chain data — it only returns a fixed value
C. That only the owner may call it
D. That the returned string can never contain special characters

**Answer:** B
**Explanation:** `pure` means the function touches no stored state — no reading balances, no writing them. `greet()` just hands back a constant string, so it qualifies. A function that read a stored balance could not be `pure`.

---

**Question 6:** In Remix, how do you know a compile *succeeded*?
A. A verbose "BUILD SUCCESS" banner prints in the terminal
B. A small green check appears on the Solidity Compiler icon and the Contract dropdown fills in with your contract — the green check *is* the success message
C. The file turns green in the File Explorer
D. A popup asks you to deploy immediately

**Answer:** B
**Explanation:** Remix has no chatty success banner. The compiler icon simply gets a green check and the Contract dropdown lists `HelloToken (HelloToken.sol)`. No red error box, no yellow warnings — that green check is the ledger's first "okay, tama ka so far."

---
**Next:** Proceed to Lesson 3 exercises.
