# Run Rust Without Installing Anything

No toolchain yet — that's Lesson 2. Today you run real Rust in the browser, then deliberately try to compile the *kind* of bug that crashed Dan's Python demo, just to watch the compiler refuse.

---

## Task 1: Run the Reliability Promise

1. Open **https://play.rust-lang.org** in any browser. Delete the pre-filled hello-world.
2. Paste in the contents of `act_1.rs` and complete the `// TODO:` lines (they're all `println!` calls — the exact text to print is in the comments).
3. Leave the three commented-out lines at the bottom alone for now.
4. Click **Run**. The program compiles cleanly and prints the banner below. *If it compiles, it runs.*

---

## Task 2: Read the Refusal

Now the main event. The task is **not** to fix the bug — the task is to *read the error*.

1. Remove the `// ` from the three buggy lines near the bottom (the `let order`, `let moved`, and last `println!` lines — leave the explanation comments above them alone).
2. Click **Run** again. This time there is no program. The compiler sees a `String` being used *after its ownership moved to another variable* and refuses to build. No binary is produced. Nothing exists to crash.
3. Read the output top to bottom, like a letter, not an alarm:
   - Find the **error code** in the first line (`error[E0382]`). Write it down — you will meet it again in the ownership lessons, and it will not be this gentle a meeting.
   - Find the **`help:` line** and write down, in your own words, what fix the compiler suggests. *(Check yourself: it suggests calling `.clone()` on `order` — making a copy of the String — so `moved` gets its own copy and `order` stays usable, with a note that cloning has a performance cost.)*
   - Bonus: in the Playground, the error code is a clickable link to the full explanation of E0382. Click it. You've just used `rustc --explain` without installing anything.

---

## Sample Output

```
====================================================
   LutoCLI: THE RELIABILITY PROMISE
====================================================

Last Sunday, in Python:
   - 40 seconds just to start on the old laptop
   - 1 blank cell in the digitized notebook
   - KeyError: 'weather' -- crashed mid-demo

The Rust deal:
   - One compiled file. No Python. No internet.
   - Starts in milliseconds on the old desktop
   - Whole bug families REFUSED at compile time

Sample report line (the future LutoCLI):
   Best-seller: Sinigang
   Kita today:  P4250

Promise to Tita Malou: if it compiles, it runs.
```

---

## Reflection Questions

1. Why did the Python `KeyError` only surface on Sunday, in front of Tita Malou, instead of while Dan was writing the code?
2. In Task 2 the compiler refused before any runnable program existed. Who "got" the error this time, and why is that the better deal for a tool Tita Malou runs daily without Dan around?
3. The E0382 output doesn't just refuse — it points at the exact line, explains *why* (`String` doesn't implement `Copy`), and suggests a fix under `help:`. What does that tell you about how the Rust compiler treats the programmer?

---

## Challenge: Which Rust Reason Is Tita Malou's Reason?

Research three real products built with Rust (Firefox, AWS Firecracker, Discord, Android, and the Linux kernel are good starting points — or find your own). For each, identify *why* that team chose Rust: raw **speed**, memory **safety**, or **no runtime needed** (a standalone binary with no GC and no interpreter).

Then write 2-3 sentences: which product's reason most closely matches Tita Malou's offline-desktop, no-Dan-on-call situation, and why? There's no single right answer — but "no runtime, predictable, runs unattended" is the angle of the person who has to keep it running.

---

## What You've Learned

- How to write and run Rust in the browser with the Rust Playground — no installation required
- What a compile-time refusal looks like: the bug never became a program, so nothing existed to crash
- How to read a real `rustc` error calmly: error code, exact span, explanation, and the `help:` suggested fix
