# Compile and Ship Your First Binary

Build the exact program Dan walked across the carinderia: a welcome banner plus today's three-dish menu, with every price flowing through a `{}` placeholder from a variable.

---

## Task 1: Complete the Banner Program

Open `act_1.rs`. The banner and the price variables are done for you. Complete the TODOs: print the three menu lines, each price flowing through a `{}` placeholder from its `u32` variable.

---

## Task 2: Compile It

Save your finished file as `main.rs` in a fresh folder, then:

```
rustc main.rs
```

If nothing prints, that's success — compilers are quiet when happy. A new binary appears next to your source: `main.exe` on Windows, `main` on Linux/macOS.

> **Heads-up:** this is the **only lesson in the entire course where you call `rustc` directly.** From Lesson 4 onward, `cargo run` compiles *and* runs in one command. You meet bare `rustc` today on purpose — so you know exactly what `cargo` is automating.

---

## Task 3: Run It

```
./main        # Linux / macOS
.\main.exe    # Windows PowerShell (or just main.exe in cmd)
```

---

## Task 4: The Field Test (do not skip — it's the whole point)

Copy **only the binary** — not `main.rs` — onto a USB stick, into a shared folder, or to another computer of the same OS. A machine with no Rust, no editor, nothing installed. Run it. It works. That's the Tita Malou guarantee, demonstrated on day three.

---

## Sample Output

```
=============================================
    Kamusta, Carinderia ni Tita Malou!
    Lutong bahay since 2010. Tuloy po kayo!
=============================================

    ULAM NGAYON
    ---------------------------------
    Adobo ..................... PHP 75
    Sinigang na Baboy ......... PHP 95
    Halo-Halo ................. PHP 60
    ---------------------------------

    Bukas araw-araw, 6AM hanggang 8PM.
    Salamat sa lahat ng suki!
```

---

## Reflection Questions

1. The binary ran on a machine with no Rust installed. What is baked into it that a Python script doesn't carry?
2. `println!` has a `!` and `fn main()` doesn't. What does that `!` tell you about *when* the format string gets checked?
3. If you write three `{}` placeholders but pass only two arguments, what happens — and at what moment do you find out?

---

## Challenge: The One-Liner Menu Board

Print this five-line menu board using a **single `println!` call**:

```
Adobo - PHP 75
Sinigang na Baboy - PHP 95
Bistek - PHP 85
Tinola - PHP 70
Halo-Halo - PHP 60
```

Two tools make it possible: `\n` inside a format string means "new line," and `{}` placeholders fill from the argument list in order. Put the **dish names in variables too** and feed all ten values (five names, five prices) through ten placeholders:

```rust
println!(
    "{} - PHP {}\n{} - PHP {}\n...",
    dish1, price1, dish2, price2, /* ...and so on */
);
```

If you accidentally pass nine arguments to ten placeholders, don't panic — read what the compiler tells you. It points at the exact placeholder that's starving. That message-reading habit is the real exercise.

---

## What You've Learned

- The compile-then-run workflow: `rustc main.rs` translates once, and the binary runs forever
- `println!` is a compile-time macro that validates every `{}` placeholder against your arguments before a binary even exists
- A Rust binary is standalone — copy one file to any same-OS machine and it just runs, no install required
