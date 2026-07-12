# Fix the Sabotaged Contract, One Red Box at a Time

`act_1.sol` is JM's sabotaged copy of WorkshopCredit — the clean Lesson 9 token with **three classic bugs planted**. As shipped, it **does not compile**, and that's the point. Your job is to compile it in Remix, read each real red box like a letter, and fix the bugs **one at a time, top-down** — never all at once. Because the compiler works in stages, each fix reveals the next problem. You end exactly where Lesson 9 ended: a clean green check, 1,000 WCR intact.

> A note on line numbers: the numbers below match `act_1.sol` exactly as shipped. If you retyped or reformatted the file, your numbers may differ by a few — the **category word**, the **message**, and the **`^^^` caret** are what you read, not the line number alone.

## Task 1: Compile the Wreck and Read the First Letter

Paste `act_1.sol` into a `WorkshopCredit.sol` in Remix, open the **Solidity Compiler** tab, pick a **0.8.20-or-newer** compiler, and press **Compile**. You get a red box — the first of three. Do not touch anything else yet; read this one:

```text
ParserError: Source file requires different compiler version (current
compiler is 0.8.20+commit.a1b79de6.Emscripten.clang) - note that nightly
builds are considered to be strictly less than the released version
 --> WorkshopCredit.sol:2:1:
  |
2 | pragma solidity ^0.7.0;
  | ^^^^^^^^^^^^^^^^^^^^^^^
```

That's **BUG 1**. The file's pragma asks for a `0.7`-era compiler, but you're running `0.8.20`, and the two don't overlap. The caret underlines the whole `pragma` line, and the message spells out the mismatch. **The fix is a one-liner:** change the version on line 2 from `^0.7.0` to `^0.8.20` so it matches the compiler this project actually uses (the same version OpenZeppelin 5.0.2 requires). Recompile.

## Task 2: The Grammar Bug Surfaces

The pragma is gone, but a new red box appears — one the compiler could not even *see* until the pragma stopped blocking it:

```text
ParserError: Expected identifier but got '('
  --> WorkshopCredit.sol:36:15:
   |
36 |     constructr() ERC20("Workshop Credit", "WCR") {
   |               ^
```

That's **BUG 2**. `constructr` is a misspelling of the keyword `constructor`. Solidity doesn't recognize `constructr` as a declaration keyword, so when it reaches the `(`, it complains it `Expected identifier but got '('`. This is a **ParserError** — pure grammar; the compiler can't read the line. **The fix:** correct the spelling to `constructor`. Recompile.

## Task 3: The Missing Name Surfaces

Grammar's clean now, so the compiler advances to the next stage — resolving names — and immediately trips:

```text
DeclarationError: Identifier not found or not unique.
  --> WorkshopCredit.sol:32:28:
   |
32 | contract WorkshopCredit is ERC20 {
   |                            ^^^^^
```

That's **BUG 3**, and notice *where* it points: line 32, at the word `ERC20` — even though the bug is really a **missing line near the top of the file**. The `import` that introduces `ERC20` was deleted, so the name is an undeclared stranger. This is a **DeclarationError**, not a `ParserError`: the grammar was perfectly readable; the compiler just can't find where `ERC20` came from. **The fix:** paste the import line back on the blank line under the header:

```solidity
import "@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol";
```

Recompile.

## Task 4: Land on Green and Look Back

This time: a **green check**, no red, no yellow. You're home — the same 10-line WorkshopCredit from Lesson 9, minting 1,000 WCR. Now look back at what just happened: you fixed **three** bugs but only ever saw **one** red box at a time. That's the whole lesson — the compiler parses before it resolves names, so an early error hides the ones beneath it. Fix top-down, recompile, repeat.

## Sample Output

The three letters, in the order they surfaced, then the finish:

```text
1) ParserError: Source file requires different compiler version ...   (line 2)   -> fix the pragma
2) ParserError: Expected identifier but got '('                       (line 36)  -> fix "constructr"
3) DeclarationError: Identifier not found or not unique.              (line 32)  -> restore the import
--------------------------------------------------------------------------------
✓ compilation successful — WorkshopCredit, 1,000 WCR, zero warnings
```

Three bugs, three families, one green check — and never more than one red box on screen at once.

## Reflection Questions

1. BUG 3 (the missing import) sits *above* BUG 2 (the misspelled constructor) in the file, yet the compiler reported BUG 2 first and BUG 3 only after. What does that ordering tell you about the difference between reading grammar and resolving names?
2. The DeclarationError caret pointed at line 32 (`is ERC20`), but the actual mistake was a *deleted* line near the top. Why does a compiler so often point at where a name is *used* rather than where it should have been *introduced*?
3. Reframe this whole exercise in Tita Malou's terms: how is meeting three red boxes at your own desk, on a contract nobody has deployed, cheaper than the smudged-notebook dispute from Lesson 1?

## Challenge: Complete the Family Set

**Challenge A — Meet the TypeError you didn't hit.** The three planted bugs covered a version mismatch, a `ParserError`, and a `DeclarationError` — but never a `TypeError`. Starting from your now-clean contract, wrap the amount in quotes like an old Python reflex: change the mint to `_mint(msg.sender, "1000" * 10 ** decimals());` and compile. Write down the **category word** and the **line:column** of the red box, and one sentence explaining why quoting a number makes the compiler refuse it. Then undo the change and confirm you're green again.

**Challenge B — Meet the yellow.** Add an unused line to the constructor — `uint256 note = 42;` above the `_mint` — and compile. This time you get a **green check** *and* a yellow box. Write down: does this contract deploy as-is or not? What is the compiler warning you about? Delete the line and confirm you're back to a clean green with zero warnings.

## What You've Learned

- **A red error is a letter, not an alarm** — category word, message, `file:line:column`, and a `^^^` caret under the exact span. Read it top to bottom.
- **The compiler works in stages** — parse, then resolve names, then check types — so an early error **hides** the later ones. Fix top-down, one at a time, recompiling between fixes.
- **The families are distinct:** a misspelled keyword is a `ParserError` (broken grammar); a deleted `import` is a `DeclarationError` (an unknown name); a wrong pragma is its own "requires different compiler version" red.
- **A caret points where a name is *used*, not always where the fix lives** — the missing-import error underlined `ERC20` far from the deleted line, exactly as the missing-semicolon caret lands one line past the real problem.
