---
title: "Course 15: Intro to Rust Programming"
description: "Dan Santos' third course — from a Python script that crashed one Sunday to LutoCLI, a compiled binary Tita Malou runs herself on an offline desktop. Learn ownership, borrowing, and a compiler that mentors you like your strictest Ate — all through Filipino-themed stories and scenarios."

# This is the date the document was last updated.  Format: YYYY-MM-DD.
date: "2026-06-07"

# For SEO purposes
tags:
  [
    "rust",
    "systems programming",
    "ownership",
    "borrowing",
    "memory safety",
    "cargo",
    "rustc",
    "rustup",
    "cli",
    "structs",
    "enums",
    "pattern matching",
    "error handling",
    "traits",
    "bitskwela",
  ]

# Note: Permanames are unique and immutable. Once set, they cannot be changed.  You may change the filename but not this.
permaname: "course-15-intro-to-rust"

# Can be the same as permaname but can be changed if needed.
slug: "course-15-intro-to-rust"
---

# Prologue: The Sunday the Script Crashed 🦀

It's fiesta season — the carinderia's busiest stretch — and two things break on the same Sunday. First, Dan's Python sales-report script dies mid-demo, a `KeyError` traceback scrolling in front of Tita Malou, all because one row in the digitized notebook had a blank weather cell. Forty seconds to start, one second to die. Second, Tita Malou makes a request no `pip install` can solve: _"Anak, gusto ko yung makikita ko ang kita for the day. Ako mismo. Kahit wala ka."_ The carinderia's hand-me-down desktop has no Python, no internet, and no patience for either.

That night, Kuya JM — six months into rewriting a payment-reconciliation service in Rust at his BPO — makes his pitch over Messenger: _"You need a compiled language, Dan. One file. Copy it on a USB, double-click, tapos. And Rust won't even let you compile the bug that crashed you last Sunday. It's the language where the compiler is your strictest Ate."_

This is **Dan Santos'** third course. In Intro to AI he built **Luto v1**, a rule-based chatbot for the carinderia. In Intro to ML he upgraded it into **Luto v2**, predicting best-sellers from sales data. Now he learns Rust — and ships **LutoCLI**, a single compiled binary that Tita Malou runs herself.

---

## Course Structure: 25 Lessons Across 3 Acts

### **Act 1: A Sharper Knife (Lessons 1-8)**

_Setup, basics, and the speed promise_

- L01: What is Rust?
- L02: Setting Up Rust
- L03: Hello, World!
- L04: Variables & Mutability
- L05: Data Types
- L06: Functions
- L07: Control Flow
- L08: Loops

**Master:** Why Rust exists (safety + performance, compile-time vs runtime errors), the rustup/rustc/cargo toolchain trio, compiled binaries that run with nothing installed, immutable-by-default variables, types that refuse to mix (and why money is `u32`), functions, branches, and loops — capped by the Python-vs-`--release` speed race

---

### **Act 2: The Compiler is Your Strictest Ate (Lessons 9-16)**

_Ownership, borrowing, and the types that cannot lie_

- L09: Ownership
- L10: Borrowing
- L11: Slices
- L12: Strings
- L13: Structs
- L14: Enums
- L15: Pattern Matching
- L16: Error Handling

**Master:** The three rules of ownership and reading E0382 calmly, `&` and `&mut` (many readers XOR one writer), slices as views without copies, `String` vs `&str` and UTF-8 honesty, structs with `impl` methods, enums with data and `Option<T>` instead of null, exhaustive `match`, and `Result` + `?` — the lesson where the Sunday crash becomes a compile-time impossibility

---

### **Act 3: Building LutoCLI (Lessons 17-25)**

_Collections, abstraction, and shipping a real tool_

- L17: Collections
- L18: Modules
- L19: Packages & Crates
- L20: Traits
- L21: Generics
- L22: Lifetimes
- L23: Testing
- L24: File I/O
- L25: Mini Project: LutoCLI

**Master:** `Vec` and `HashMap` (the `entry().or_insert()` tally idiom), splitting code into modules like kitchen stations, Cargo packages and your first library crate, traits and generics with zero-cost monomorphization, what `'a` actually means, `cargo test` proving the math, reading the sales CSV — and shipping a compiled CLI to the carinderia counter

---

## What You'll Build

Across the chapter you'll build progressively richer Rust programs:

1. **First compiled binary** (L03) — walks across the carinderia on a USB and runs on the ancient desktop, nothing installed
2. **Sukli calculator** (L05–L06) — money math in `u32`, immune to centavo float bugs
3. **Mini Luto v1 reborn** (L07) — the rainy-day → sinigang decision logic, now in Rust
4. **The speed race** (L08) — the same 10-million-iteration sum in Python vs `cargo run --release`
5. **Typed menu and payment drawer** (L13–L15) — structs, enums, and `match` that cannot lie
6. **Crash-proof parser** (L16) — `Result` and `?` make the Sunday bug impossible
7. **`lutolib`** (L18–L19) — Dan's first reusable library crate, wired in as a path dependency
8. **Tested report engine** (L23–L24) — `cargo test` catches a real centavo bug; the sales CSV comes home to Rust
9. **LutoCLI** (L25) — the capstone: one `--release` binary on the carinderia desktop, run by Tita Malou herself

---

## Learning Approach

Each lesson features:

- **Story-driven content** — follow Dan Santos through relatable Filipino Rust scenarios
- **Locally-themed examples** — sukli math, the utang notebook, GCash-vs-cash drawers, quincena paydays, rainy-day sinigang
- **REAL compiler errors shown on purpose** — when Dan hits `error[E0382]: borrow of moved value`, you see the full message and learn to read it as mentorship, not rejection
- **Hands-on Rust practice** — every lesson ships a complete, runnable program plus challenges to modify and extend it
- **Self-check quizzes** — short knowledge checks per lesson
- **Runs locally via cargo** — Rust compiles on your own machine, not in the browser sandbox; Lesson 2 sets up the toolchain, and everything after works offline

---

## Who Is This For?

**Perfect for:**

- Programmers curious about Rust but intimidated by the borrow checker's reputation
- Python or JavaScript learners who want to understand what compiled, systems-level code feels like
- Builders who need to ship tools that run anywhere — no interpreter, no internet, no excuses
- Anyone who's heard "the compiler fights you" and wants to discover it's actually coaching you

**Prerequisites:**

- Basic programming literacy (variables, loops, functions in any language)
- No prior Rust — and the AI/ML courses are not required; this course re-introduces everything it borrows
- A computer from the last decade and internet for the one-time toolchain install

---

## Your Learning Companion

**Dan Santos** — an IT student from Marikina on his third journey, this time against the strictest teacher he's ever met: the Rust compiler. He loses a full hour to E0382, learns to read errors calmly, and ships anyway.

He's not alone:

- **Kuya JM** — the primary mentor, a BPO engineer rewriting payment systems in Rust; supplies the cash-drawer-key analogy and the "strictest Ate" pitch
- **Tita Malou** — the end user; LutoCLI exists so she can check the day's kita herself, kahit wala si Dan
- **Ate Rina** — cameo mentor from the co-op who demands tests: _"Prove it works, bata."_
- **Jasper** — the friend who rage-quit Rust in a weekend, which is exactly why Dan won't

---

## Technologies You'll Touch

**Core:**

- `rustup` — the toolchain installer and version manager
- `rustc` — the Rust compiler
- `cargo` — build tool, project manager, package manager — your daily driver

**Language:**

- Ownership, borrowing, slices, and lifetimes
- Structs, enums, `Option<T>`, `Result`, and exhaustive `match`
- Traits, generics, modules, and crates

**Concepts:**

- Compile-time vs runtime errors — and why the compiler is a mentor
- Memory safety without a garbage collector
- Testing with `cargo test`, file I/O, and command-line arguments

Everything uses **only the Rust standard library** — by design — except one optional `rand` crate challenge in Lesson 19. The carinderia desktop is offline, and so is most of this course.

---

## Learning Path

```
Lessons 1-3    → Meet Rust, install the toolchain, ship your first binary
Lessons 4-8    → Variables, types, functions, control flow, and the speed race
Lessons 9-12   → Survive ownership; master borrowing, slices, and strings
Lessons 13-16  → Structs, enums, match — and the crash that becomes impossible
Lessons 17-22  → Collections, modules, crates, traits, generics, lifetimes
Lessons 23-25  → Test it, read the data, ship LutoCLI
```

---

## What Makes This Course Different?

- **Filipino context throughout** — sukli, utang notebooks, quincena paydays, palengke-as-crates.io
- **Story-driven** — Dan Santos' journey, not dry textbook prose
- **Real compiler errors, on purpose** — Rust's error messages are among the best teachers in the ecosystem, so we read them in full instead of hiding them
- **The compiler is a character** — Dan's arc from enemy → wall → bodyguard → mentor is the actual learning arc of every Rust beginner
- **From hello world to shipped binary** — start with "what is Rust?", end with a compiled CLI taped with a cheat sheet to a carinderia monitor

---

## Time Commitment

- **25 lessons** → ~8-12 minutes reading each = 4-5 hours of instruction
- Hands-on compiling, challenges, and the mini project: 10-15 hours
- **Total estimated time:** 14-20 hours to complete
- **Recommended pace:** 3-5 lessons per week = 5-8 weeks (or roughly 25 evenings at one lesson per sitting)

---

## After This Course

You'll be able to:

- ✅ Explain why Rust exists and what memory safety without a garbage collector means
- ✅ Install and use rustup, rustc, and cargo confidently
- ✅ Compile standalone binaries that run on machines with nothing installed
- ✅ Read compiler errors calmly and treat them as mentorship
- ✅ Reason about ownership, borrowing, and lifetimes — and fix E0382 without panic
- ✅ Model real-world data with structs, enums, `Option<T>`, and exhaustive `match`
- ✅ Replace crash-prone code with `Result` and the `?` operator
- ✅ Organize a growing codebase into modules and reusable library crates
- ✅ Write generic, trait-based code with zero runtime cost
- ✅ Prove your code works with `cargo test`
- ✅ Read and write files, parse real-world data, and ship a complete CLI tool

---

## Let's Begin Your Journey

From a Sunday crash to a binary Tita Malou runs herself in 25 lessons. Are you ready?

It starts with one question: **"Bakit ayaw gumana sa lumang desktop?"** (Why won't it run on the old desktop?)

And it ends with **LutoCLI** on the carinderia counter — `lutocli summary`, typed by Tita Malou, one finger at a time.

**Simulan natin!** (Let's start!) 🦀
