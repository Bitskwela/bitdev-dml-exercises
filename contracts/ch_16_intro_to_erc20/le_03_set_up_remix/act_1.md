# Open Remix and Compile Your First Contract

Today you open Remix — no install, no account — create `HelloToken.sol`, and compile the blockchain's "Hello World": one `pure` function that greets. Open `act_1.sol`; the SPDX line, the pragma, and the contract shell are already there. Your job is the one missing line, then a clean green check. No token yet — just the setup, proven.

## Task 1: Open Remix and Create the File

Go to **https://remix.ethereum.org** in any browser. Wait a few seconds for it to load — no login, no download, close any welcome popup. Click the **File Explorer** icon (top-left), then the **Create new file** icon (a page with a `+`), and name it exactly `HelloToken.sol`. Paste in the starter from `act_1.sol`. (This is the fastest setup in the whole course — that's deliberate.)

## Task 2: Make `greet()` Answer

In the starter, `greet()` is declared `public pure returns (string memory)`, but its body is empty. Complete it so it **returns** the exact string `"Kumusta, blockchain!"`. `pure` is a promise that the function touches no on-chain data — it only hands back a fixed piece of text — so a single `return` statement is the entire body. Resist adding anything token-shaped; that's coming, one careful lesson at a time.

## Task 3: Compile to a Green Check

Open the **Solidity Compiler** tab (the Solidity-logo icon in the left bar). In the **Compiler** version dropdown, pick a version that is **0.8.20 or newer** (for example `0.8.20+commit.a1b79de6`, or any later `0.8.x`) so it satisfies your `^0.8.20` pragma. Click the big **Compile HelloToken.sol** button (shortcut: `Ctrl+S`; if **Auto compile** is on, it already compiled). On success, a small **green check** appears on the compiler icon and the **Contract** dropdown lists `HelloToken`. In Remix, that green check *is* the "build succeeded" message — there's no chatty banner.

## Task 4: Break the Pragma on Purpose

In the Compiler dropdown, switch to an *older* version — say `0.8.19` — and compile again. Remix refuses, because your code demands 0.8.20 or newer. Read the error like a letter, the way JM taught with the Rust compiler: it points at **line 2** and underlines the exact `pragma`. Switch back to a 0.8.20+ compiler and the green check returns. That little experiment is the pragma doing its one job — making code and compiler agree before anything ships.

## Sample Output

A clean compile — the green check, and under the button:

```text
CONTRACT
  HelloToken (HelloToken.sol)
```

Picking an *older* `0.8.19` compiler in Task 4 produces the real Remix message, verbatim:

```text
ParserError: Source file requires different compiler version
(current compiler is 0.8.19+commit.7dd6d404.Emscripten.clang) -
note that nightly builds are considered to be strictly less than the released version
 --> contracts/HelloToken.sol:2:1:
  |
2 | pragma solidity ^0.8.20;
  | ^^^^^^^^^^^^^^^^^^^^^^^^^
```

Switch back to 0.8.20+ and recompile — the green check returns. That's the pragma refusing to let mismatched code and compiler slip through.

## Reflection Questions

1. The `pragma` reads `^0.8.20`. Which compiler versions satisfy it, and which nearby version does *not* — and why did choosing `0.8.19` produce a hard `ParserError` instead of a soft warning?
2. `greet()` is marked `pure`. What does that promise about the function, and why can it make that promise while a function that read a stored balance could not?
3. You compiled something that holds no balances and moves no credits. What exactly does a clean green check *prove* here — and why is proving it *now*, before any real feature exists, worth a whole lesson?

## Challenge: Prove Your Setup and Poke the Panel

**Challenge A — Delete the license, read the nag.** With `HelloToken.sol` compiling green, delete just the `// SPDX-License-Identifier: MIT` line and compile again. Read the yellow warning Remix shows, note whether the contract *still compiles at all*, then put the line back. Write one sentence on what SPDX is *for* and whether it's required for the code to *work*.

**Challenge B — Explore the Compiler tab like you own it.** Without breaking anything permanent, find and note three things in the Solidity Compiler tab: (1) the exact **compiler version** you compiled with — write it down, you'll want to match it later; (2) the **Auto compile** checkbox — toggle it on, edit a comment, and watch it recompile with no button press, then set it back to your preference; (3) in one sentence each, what the **SPDX line** and the **`pragma` line** each do.

## What You've Learned

- **Remix is a browser-tab IDE** — editor, compiler, and a sandbox blockchain — that needs no install and no account.
- **Every `.sol` file opens with two working lines:** an SPDX license stamp (because contracts are read in public) and a `pragma` that pins the compiler; `^0.8.20` means 0.8.20 up to, but not including, 0.9.0.
- **A `pure` function reads and writes no on-chain data** — `greet()` just returns a fixed string, the blockchain's "Hello World."
- **The green check is the success message** — greening a tiny contract first proves your file name, SPDX, pragma, and compiler are all correct before any real feature can hide a bug.
