## Dan's Story: Break It on Purpose

Last lesson, Dan finally won a fight he'd been losing for four lessons straight. His naive `_mint(msg.sender, 1000)` had really minted `0.000000000000001000` WCR — a speck — because on-chain everything counts in base units. One multiplication cured it: `_mint(msg.sender, 1000 * 10 ** decimals())`, and `balanceOf` at last read a clean **1,000 WCR**. Name, symbol, decimals, supply — all correct, all green. Four lessons of nothing but green checks. Which is exactly when Kuya JM got suspicious.

> **Kuya JM:** Dan, be honest — kailan ka huling nakakita ng *pula* sa Remix?
>
> **Dan:** ...Never? Everything's been compiling. I thought that was the goal.
>
> **Kuya JM:** It IS. Pero it also means you've never actually *read* a Solidity error. And I promise you, mga alas-dos ng umaga bago ang graduation demo, may lalabas na pula — at hindi mo gustong doon mo pa matutunang basahin 'yon.

Dan knew that feeling from somewhere. A whole course ago — LutoCLI, the Rust compiler, `error[E0382]: borrow of moved value` — a red wall he'd stared at for an hour before it finally clicked. JM had called that compiler his "strictest Ate."

> **Dan:** So I just... wait for an error to happen?
>
> **Kuya JM:** No. Ginawan na kita. *(a file drops into the chat)* Yan ang WorkshopCredit mo — pero nilagyan ko ng tatlong klasikong bug. Read exactly what the compiler says each time, tapos ayusin mo. The error is a letter, Dan — hindi alarm.

Dan opened the file. Three bugs he couldn't see yet, waiting.

> **Kuya JM:** Tatlong klasiko. Una, mali ang version pragma — humihingi ng compiler na hindi natin ginagamit. Pangalawa, binura ko ang `import` line, kaya estranghero na si `ERC20` sa compiler. Pangatlo, mali-baybay ko ang `constructor`. Ayusin mo mula sa taas pababa — isa-isa.

Before the ledger could ever be trusted — before Kevin could open his phone and check his own WCR — the code had to *compile* first. The compiler was the gate before the ledger; the strictest Ate before the strict notebook.

> **Dan:** Sige. Let's read some letters.

---

## The Concept: The Compiler Is the First Gate (and It Writes You Letters)

### Red stops you; yellow just nags

The Solidity compiler gives you two kinds of feedback, and telling them apart is the whole game:

| | **Error** (red) | **Warning** (yellow) |
|---|---|---|
| What happens | Compilation **fails** | Compilation **succeeds** |
| Bytecode produced? | **No** — nothing to deploy | Yes — it's deployable |
| What it means | "I refuse to build this" | "I built it, pero amoy may mali" |
| Carinderia version | Tindera won't sell what you can't pay for | Tindera sells it, but asks *"sigurado ka?"* |

An **error** means there is no contract. Full stop — you cannot deploy nothing. A **warning** means the compiler built your contract but noticed something suspicious and told you before it bites. Warnings are advice, not refusals — but on a contract that tracks kids' credits, you treat yellow like red and clean it up anyway.

### Every Solidity error is a letter with four parts

A course ago, Rust taught Dan that a good error is a letter, not an alarm. Solidity writes the same kind of letter. Every error has **four parts** — here's the one Dan meets when the import goes missing:

```text
DeclarationError: Identifier not found or not unique.
 --> WorkshopCredit.sol:32:28:
   |
32 | contract WorkshopCredit is ERC20 {
   |                            ^^^^^
```

1. **The category word** — `DeclarationError`. The *family* of rule you broke. (Rust numbers its errors `E0382`; Solidity names the category instead — almost as useful once you know the families.)
2. **The message** — the plain-English explanation: it found a name it doesn't know.
3. **The location** — `file:line:column`. Exactly where — here, line 32, column 28.
4. **The underline** — the `^^^^` drawing arrows under the *exact* span it's complaining about: the word `ERC20`.

Read it top to bottom, calmly. The category says *what kind* of mistake; the underline says *where*; the message says *why*.

### The compiler works in stages — so it hides its own clues

The compiler doesn't check everything at once. It works in **stages**, in this order:

```text
   1. PARSE            2. RESOLVE NAMES        3. CHECK TYPES
   "Can I even read     "Is every name         "Do the data types
    this grammar?"       something I know?"      actually fit?"
        |                     |                      |
   ParserError          DeclarationError         TypeError
```

Because it's staged, an early error **hides** the later ones — if the compiler can't even *parse* your file, it never reaches name resolution or type-checking. That's why you fix errors **top-down, one at a time**: fix the topmost red, recompile, and the next real problem surfaces. It's not the compiler being stingy; it genuinely can't see past the first wall.

| Family | Roughly means | Classic beginner cause |
|---|---|---|
| **ParserError** | "I can't even read this — your grammar is broken." | Missing `;`, a stray token, a misspelled keyword |
| **DeclarationError** | "You used a name I was never introduced to." | A typo'd identifier, or a missing/mistyped import |
| **TypeError** | "I read it fine — but these data types don't fit." | Putting a string like `"1000"` where a `uint256` goes |

### The three bugs waiting in the file

JM planted exactly three, and they'll reveal themselves one at a time as you fix down the stack:

- **A wrong version pragma** (`^0.7.0`). The file asks for a compiler this project doesn't use. Compile and the very first red box is a letter about *versions*:

```text
ParserError: Source file requires different compiler version (current
compiler is 0.8.20+commit.a1b79de6.Emscripten.clang) ...
 --> WorkshopCredit.sol:2:1:
```

- **A missing `import`** — with the OpenZeppelin line deleted, the name `ERC20` is a stranger (the `DeclarationError` above). Grammar's fine; the compiler just can't find where `ERC20` came from.
- **A misspelled keyword** — `constructr` instead of `constructor`. The parser expects a real declaration keyword and trips on the typo, a `ParserError`.

Fix the pragma and the typo surfaces; fix the typo and the missing import surfaces; restore the import and you're home — green, 1,000 WCR intact. Three letters, read in order.

---

## Key Takeaways

- **Errors (red) block compilation** — no bytecode, nothing to deploy. **Warnings (yellow) let it through** but flag a smell. On a contract handling real credits, treat warnings like errors and clean them up.
- **Every Solidity error is a letter with four parts:** the category word (`ParserError` / `DeclarationError` / `TypeError`), the message, the `file:line:column`, and the `^^^` underline of the exact span. Read it top to bottom, not as an alarm.
- **The compiler runs in stages** — parse, then resolve names, then check types — so an early error **hides** the later ones. Fix red **top-down, one at a time**, and the next real bug surfaces.
- **ParserError = broken grammar** — a missing `;`, a stray token, or a misspelled keyword like `constructr`. The compiler literally cannot read the file.
- **DeclarationError = a name that was never declared or imported** — deleting the `import` line makes `ERC20` an undeclared stranger, even though the grammar is perfect.
- **A wrong version pragma** (`^0.7.0` on a 0.8.20 compiler) is its own classic red — "Source file requires different compiler version" — and the fix is to match the pragma to the compiler you actually run.
- **The compiler is a mentor, not an alarm** — the same lesson `E0382` taught in LutoCLI. Meeting these bugs on purpose in the sandbox means they won't scare you at 2 a.m. before graduation.

---

## What's Next?

Dan can now read the compiler like a letter — versions, names, grammar, and the difference between red and yellow. WorkshopCredit sits there again, green and clean, exactly as it should. But a compiling contract is still just a design on a screen. It has never actually *lived* anywhere. No account holds it, no address points to it, no transaction can find it. It's a blueprint, not a building.

Next, that changes. Dan opens Remix's **Deploy & Run** tab and pushes WorkshopCredit onto the **Remix VM** — a sandbox blockchain running right inside the browser, complete with test accounts each holding fake ETH. For the first time, his token gets a real **contract address**: a spot on a ledger where it exists, where accounts hold balances, where transactions land. The file stops being a file and becomes a resident of a chain.

**Next Lesson: Deploy Locally** — putting WorkshopCredit on the Remix VM and getting its first real contract address.
