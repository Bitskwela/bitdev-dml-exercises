# Inherit a Token, Then Read the Refusal

Open `act_1.sol`. As shipped, it **intentionally does not compile** — it inherits OpenZeppelin's `ERC20` but never satisfies the base constructor. Your job is to meet that error on purpose, read it top to bottom, and only then hand the base constructor what it's asking for so the red turns green. Do it in Remix, one step at a time.

## Task 1: Compile the Broken Skeleton on Purpose

Paste `act_1.sol` into a `WorkshopCredit.sol` in Remix, open the **Solidity Compiler** tab, pick a **0.8.20 or newer** compiler, and press **Compile**. Give Remix a second the first time — it's fetching the pinned OpenZeppelin source over the network. Instead of a green check you'll get a red box. Do not fix anything yet. Expand it and read every line.

## Task 2: Diagnose the Refusal

Read the error like a letter and answer for yourself, in words, before touching code:

1. What is the **error type** on the first line — a typo, or a rule about how the code fits together?
2. The base constructor wants two arguments. **What are their names and types?** (The `Note: Base constructor parameters:` span points straight at them, inside OpenZeppelin's own file.)
3. The message names **two** ways to satisfy it. Write both down, then decide which one turns WCR into a real, deployable token — and why the other would make it undeployable.

## Task 3: Give the Base Constructor Its Two Arguments

Now finish the job the *first* way the error offered — **specify the arguments**, don't mark the contract abstract. Add a constructor to `WorkshopCredit` that itself takes no parameters, and use a **base constructor call** to forward the token's full name `"Workshop Credit"` and its symbol `"WCR"` up to the inherited `ERC20`. Its body stays empty `{}` for now — there's nothing else to set up this lesson. Recompile: the `No arguments passed to the base constructor` error should be gone and you should get a green check.

## Sample Output

Before the fix, Remix shows the refusal:

```text
TypeError: No arguments passed to the base constructor. Specify the
arguments or mark "WorkshopCredit" as abstract.
  --> WorkshopCredit.sol:18:1:
   |
18 | contract WorkshopCredit is ERC20 {
```

After Task 3, the same file goes green:

```text
✓ compilation successful
```

The exact error is gone because you finally handed the base the name and symbol it demanded.

## Reflection Questions

1. The compiler refused a *nameless* token but never once complained that you didn't write `transfer` or `balanceOf`. What does that silence tell you about where those function bodies came from?
2. The error pointed at two files at once — your line and a line deep inside `@openzeppelin/contracts@5.0.2/.../ERC20.sol`. Why is it a good thing that the second file is code you didn't write and shouldn't edit?
3. This refusal happened at your desk, in three seconds, before a single credit existed. Reframe it in Tita Malou's terms: how is a red compile error *cheaper* than the smudged-notebook dispute from Lesson 1?

## Challenge: Prove You Really Got the Machinery for Free

**Challenge A — Count the house.** When Remix resolved the import, it downloaded OpenZeppelin's source into your workspace. In the **File Explorer**, expand the `.deps` folder and open `@openzeppelin/contracts@5.0.2/token/ERC20/ERC20.sol`. Find `function transfer(...)`, read its body, and notice you wrote none of it — yet `WorkshopCredit` already has it. In 2-3 sentences, describe how much tested token code that one `import` line handed you, and what it would have cost you to write and audit it yourself.

**Challenge B — Try the other exit.** The error offered a second way out: *mark the contract abstract*. Instead of adding a constructor, prefix the contract with `abstract` and compile. Note that the `No arguments` error disappears too — then try to **deploy** it and see what Remix refuses to let you do. Write one sentence explaining why "abstract" was the wrong exit for a token Dan actually wants students to hold.

## What You've Learned

- **`is ERC20` inherits real, working bodies** — `transfer`, `approve`, `balanceOf`, and the rest arrive filled-in from audited code you never typed.
- **A red compile error is a letter, not an alarm** — it names the problem, points at the exact line, and offers concrete ways out.
- **OZ v5's ERC20 refuses to exist without a name and a symbol**, so an inheriting contract must satisfy that base constructor before it can compile.
- **The compiler stops a half-built token at your desk** — the same "errors are cheaper here than at the counter" lesson, now in Solidity.
