# Install and Verify the Rust Toolchain

**This lesson is the course's one format exception: the activity is a terminal session, not a Rust program.** There is nothing to compile today — you're installing the thing that will compile everything else. (The tiny `act_1.rs` victory lap is your reward for after the install.)

---

## Task 1: Install via rustup.rs

**Windows:** Go to <https://rustup.rs>, download `rustup-init.exe`, run it. If Windows asks for the *Visual Studio C++ Build Tools*, let the installer set them up — one-time prerequisite. At the menu, press **Enter** for the standard installation. That's the entire decision.

**macOS / Linux:** One line in the terminal, then press **Enter** at the same menu:

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Either way, wait for the last line: `Rust is installed now. Great!`

---

## Task 2: Verify the Compiler and the Daily Driver

Close your terminal and open a **new** one — `PATH` is read at window startup. Then run `rustc --version`, `cargo --version`, and `rustup show`.

## Task 3: Explore the Toolbox

List what one install actually gave you:

- **Windows (PowerShell):** `ls $env:USERPROFILE\.cargo\bin`
- **macOS / Linux:** `ls ~/.cargo/bin`

Count the executables. Find `cargo` itself. Notice the free bonuses: `rustfmt` (formatter), `clippy` (linter), `rustdoc` (doc builder) — the supplier stocked the kitchen completely on day one.

---

## Sample Output

```text
$ rustc --version
rustc 1.95.0 (59807616e 2026-04-14)

$ cargo --version
cargo 1.95.0 (f2d3ce0bd 2026-03-21)

$ rustup show
Default host: x86_64-pc-windows-msvc
...
stable-x86_64-pc-windows-msvc (active, default)
```

Your version may be newer than 1.95.0 — stable ships every six weeks; newer is fine. The long name is your *host triple* (architecture-vendor-OS); an Apple Silicon Mac shows `aarch64-apple-darwin`. Different triple, same Rust.

---

## Reflection Questions

1. Why did Kuya JM insist on a **new** terminal before running `rustc --version`?
2. You installed once but got `rustc` *and* `cargo` with matching versions. What does that tell you about how the toolchain is versioned, compared to Dan's pandas/numpy nightmare?
3. Of the three tools — `rustup`, `rustc`, `cargo` — which will you type the most from Lesson 4 onward, and why?

---

## Challenge: Bookmark Chapter 4

Run `rustup doc --book`. Your browser opens *The Rust Programming Language* served straight from your disk — check the address bar: `file://`, not `https://`. Zero internet.

Navigate to **Chapter 4: "Understanding Ownership"** and bookmark it. Don't read it yet. In Lesson 9, Dan is going to need that chapter *badly* — and so will you.

---

## What You've Learned

- How to install the entire Rust toolchain with one installer and one Enter key
- How to verify an install with `rustc --version`, `cargo --version`, and `rustup show` — and that everything lives in `~/.cargo/bin`
- How to open the full offline docs with `rustup doc`, ready for brownouts and offline desktops
