## Dan's Story: The Setup That Wasn't

Last time, in the closed carinderia, Dan turned Workshop Credit from a vibe into a *spec* — on a napkin, the same ritual he'd used to sketch a neuron a course ago. **Name:** Workshop Credit. **Symbol:** WCR. **Decimals:** 18. **Initial supply:** 1,000, to the instructor. **Who can make more:** only the instructor — the rule that finally made Tita Malou stop squinting. On paper, WCR makes sense. But a napkin can't compile, can't deploy, and the barangay can't read it. To turn the sketch into a real thing, Dan needs somewhere to actually *write Solidity* — and that's the part he's been quietly dreading.

Saturday, 4:40 PM. The last workshop teen had filed out clutching turon, the plastic chairs were stacked, and the barangay hall was empty except for Dan and one tired ceiling fan. He had the place and a whole evening — and a specific, familiar dread sitting in his stomach.

He'd been here twice. *Intro to AI*, when getting Python and pandas onto his secondhand laptop ate a whole Sunday. *Intro to Rust*, when he'd budgeted an evening and one minor breakdown for the toolchain — before `rustup` finished in minutes and embarrassed him. Every new build, the first enemy was the same: **the install.** The PATH problems. The wrong version of *something*. That one Stack Overflow answer from 2019. So before a single line of Solidity, he opened Messenger and braced JM for the worst.

> **Dan:** Okay Kuya, before I start — anong i-install ko? Compiler, some CLI, a package manager? Anong version? I have the whole night, sabihin mo na lahat.

The reply came as a voice note, and Dan could *hear* JM grinning.

> **Kuya JM:** Dan. Dan. Relax. Wala kang i-install. Zero. Buksan mo lang ang browser mo.
>
> **Dan:** ...Browser lang? Kuya, I'm writing a smart contract. That's real blockchain stuff. There has to be a toolchain.
>
> **Kuya JM:** May toolchain — nasa loob lang ng website. Tinatawag na **Remix**, sa remix.ethereum.org. Editor, compiler, at pati fake blockchain para mag-deploy — nandoon lahat, sa tab mo lang. Same energy as that Rust Playground na binigay ko sa'yo noon, pero mas malaki.

Dan typed the URL, half-expecting a login wall, a "download the desktop app" popup, *something* to justify the dread. Instead the page just... loaded. An editor on the right. A little file tree on the left. Some example contracts already sitting there. No account. No installer. Nothing to configure.

> **Dan:** Naks. It just opened. Ganito lang talaga?
>
> **Kuya JM:** Ganyan lang talaga. Ngayon, gawa ka ng bagong file, pangalanan mong `HelloToken.sol`, tapos lagyan mo ng pinakaliit na contract na *sumasagot* — isang function lang na nagsasabing "kumusta." Wala pang token, walang balances. I-compile mo nang malinis — green check. Kapag na-green mo yung maliit, alam mong tama ang setup mo. *Tapos* tayo mag-token.

The smallest contract that answers back — a single function, the blockchain's "Hello World." Prove the setup works before there's anything real to break. Dan recognized the move; it was exactly how JM taught him everything. Get the boring plumbing green first, so when the interesting part breaks later, you *know* it's the interesting part.

> **Dan:** Sige. Hello muna. I can do that much.

---

## The Concept: One Browser Tab, the Whole Workshop

### Remix is an IDE that lives in a browser tab

An **IDE** — Integrated Development Environment — is just the workshop where you write, check, and run code, all in one place. Most languages want you to install theirs. Solidity has one that runs entirely inside a website: **Remix**, at **remix.ethereum.org**. That's not a toy version — it's the tool a huge number of real Solidity developers reach for first, for learning, for quick experiments, and for deploying real contracts. Everything WCR needs for the next twenty-two lessons is in there: an editor, the Solidity **compiler**, a sandbox **blockchain** to deploy onto, and a panel to click your contract's functions like buttons.

### No install (the Playground promise, again)

Remember the deal from the Rust course? The **Rust Playground** let Dan write and compile Rust in the browser before he ever touched `rustup`. Remix is that same relief, turned up:

| | Rust Playground | Remix |
|---|---|---|
| Where it runs | Browser tab | Browser tab |
| Install anything? | No | No |
| Account needed? | No | No |
| Compile? | Yes | Yes |
| **Run / deploy?** | Runs the program | **Deploys to a sandbox blockchain** |

The heavy machinery — the compiler, the fake blockchain — runs for you. You bring the typing. For a guy on a secondhand laptop who has lost real weekends to installers, *iyan ang regalo.*

### The four panels you'll actually use

Remix looks busy on day one. Ignore most of it. A thin **icon bar** on the far left switches between panels — you only need four this whole course:

```text
  ICON BAR   what it opens
  --------   ------------------------------------------------
   [files]   File Explorer     - your files & folders
   [sol ]    Solidity Compiler - turns .sol into something
                                 the blockchain can run
   [run ]    Deploy & Run      - put a contract on a chain
                                 and click its functions (Lesson 11)
```

**File Explorer** lists your files, exactly like folders on your laptop (Remix ships a few example contracts — ignore them; you'll add your own). The **editor** is the big pane where you type Solidity. The **Solidity Compiler** checks and compiles your code on one button; a **green check** on its icon means success, red errors mean it didn't. **Deploy & Run** holds the sandbox chain and the function buttons — not touched until Lesson 11, but good to know it's already there, waiting.

### A `.sol` file and the two lines it starts with

A **`.sol` file** is plain text holding Solidity source — the way `.rs` holds Rust or `.py` holds Python. The convention is to name it after the main `contract` inside. Ours is `HelloToken`, so the file is **`HelloToken.sol`**. Before the `contract` keyword, real Solidity files begin with two working lines. They look like boilerplate; they're not — and both matter *precisely because this whole course is a ledger anybody can read:*

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
```

**Line 1 — the license.** A machine-readable stamp of the license this code is published under. Contracts are meant to be **public** — in Lesson 25, WCR's source gets published on a block explorer for the whole barangay (and the whole internet) to read — so this line tells any reader the terms. Leave it off and the compiler still works, but it *nags* with a yellow warning. `MIT` is a common, permissive open-source license; we include it for a clean, honest compile.

**Line 2 — the `pragma`.** An instruction to the compiler, not the blockchain. It says: *"compile me with Solidity 0.8.20 — or any newer 0.8.x, but not 0.9 and up."* That's what the caret means:

```text
   ^0.8.20   means   >= 0.8.20   AND   < 0.9.0
             (0.8.20, 0.8.21, 0.8.26 ... all OK;  0.9.0 is NOT)
```

Pinning it means the same source compiles the *same way* for everyone — for Dan, for JM, for a student on a different laptop, for the block explorer verifying it years from now. It's the code's way of refusing to be misread.

### The smallest contract that answers back

Here's the part that trips up beginners: **an empty `contract HelloToken { }` is completely legal Solidity** — it compiles and does absolutely nothing. We go one micro-step further, to a contract with a single **`pure`** function that returns a greeting:

```solidity
contract HelloToken {
    function greet() public pure returns (string memory) {
        return "Kumusta, blockchain!";
    }
}
```

No balances, no token, nothing to break — but unlike an empty shell, there's something to *watch answer* once it deploys. `public` means anyone can call it; `pure` means it reads and writes no on-chain data (it just hands back a fixed string); `returns (string memory)` declares it gives back text. If this greens, you've proven your file name, your SPDX line, your pragma, and your compiler version are all correct — *before* a single interesting feature exists to hide a bug. Get the boring green first. JM's move.

---

## Key Takeaways

- **Remix (remix.ethereum.org) is a full Solidity IDE in a browser tab** — editor, compiler, and a sandbox blockchain — with **no install and no account**, the same relief the Rust Playground gave Dan a course ago.
- **You'll use four panels this whole course:** File Explorer, the editor, the **Solidity Compiler**, and **Deploy & Run** (not until Lesson 11). Everything else on screen you can ignore for now.
- **A `.sol` file holds Solidity source**, and it's named after its main `contract` by convention — hence `HelloToken.sol`.
- **Every Solidity file starts with two working lines:** `// SPDX-License-Identifier: MIT` (declares the license, because contracts are meant to be read in public) and `pragma solidity ^0.8.20;` (pins the compiler so the same code compiles the same way for everyone).
- **`^0.8.20` means 0.8.20 up to — but not including — 0.9.0.** Pick a matching compiler in Remix, or you'll meet a real `ParserError` about a version mismatch.
- **The smallest useful contract is one `pure` function that returns a greeting** — `greet()`. `pure` means it reads and writes no state; greening it proves your file, SPDX, pragma, and compiler are all correct before any real feature can hide a bug.
- **In Remix, the green check IS the success message** — there's no verbose banner; the compiler icon simply goes green and the Contract dropdown fills in.

---

## What's Next?

Dan has a green check on a contract that barely does anything — and that's a genuine win, because now the setup is proven and out of the way. But `HelloToken` raises the obvious question he's been circling since Lesson 1: *what actually IS a smart contract?* Not the metaphor — the real thing. Code and data that live at an address on a blockchain, that anyone can call, that nobody can quietly edit.

Next lesson, Dan grows `HelloToken` into his first contract that truly *lives* somewhere — he gives it a name and a total supply it remembers, deploys it onto Remix's sandbox blockchain, and clicks its buttons to watch it answer from an address. For the first time his code won't just compile — it'll *run*, waiting for anyone to ask it a question. The ledger character is about to introduce itself.

**Next Lesson: Understand a Smart Contract** — state, functions, and deploying `HelloToken` so it lives on-chain and answers back.
