# Lesson 2 Quiz: Setting Up Rust

---
# Quiz 1
## Scenario: The Six-Minute Install

Dan blocked three hours for the Rust install, remembering his pandas/numpy version-conflict nightmare. The whole thing was over in six minutes, and he's suspicious he skipped something.

**Question 1:** What is `rustup`'s job in the toolchain?
A. It compiles `.rs` files into binaries
B. It installs, updates, and manages Rust versions and channels — the supplier, not Rust itself
C. It runs Rust programs
D. It manages project dependencies

**Answer:** B
**Explanation:** rustup is the installer and version manager. It delivers and maintains the toolchain (`rustup update`, `rustup doc`) but never compiles or runs your code itself.

---

**Question 2:** Dan ran one installer but `rustc --version` AND `cargo --version` both work, with matching version numbers. Why?
A. He accidentally installed twice
B. The toolchain ships as one unit — rustup installs rustc, cargo, and companion tools together, versioned as a set
C. cargo is just an alias for rustc
D. Windows pre-installs cargo

**Answer:** B
**Explanation:** One installer delivers the whole toolchain with components versioned together — the design difference that erased Dan's pandas-vs-numpy three lost hours. Nothing was skipped.

---

**Question 3:** Which tool turns a `.rs` source file into a standalone binary?
A. `rustup`
B. `cargo doc`
C. `rustc` — the compiler
D. `clippy`

**Answer:** C
**Explanation:** rustc is the compiler — the strict Ate from Lesson 1. You'll invoke it directly once in Lesson 3 to demystify it; afterwards cargo calls it for you.

---

**Question 4:** This course stays on the **stable** channel. What does that mean?
A. Rust never updates
B. A thoroughly tested release that ships every six weeks — beta and nightly exist for testers and experimenters
C. The version that never gets new features
D. A paid tier of Rust

**Answer:** B
**Explanation:** Stable is the tested menu, beta is the dish in final taste-testing, nightly is the nightly experiment. LutoCLI computes Tita Malou's money — menu items only. `rustup update` brings stable current.

---
# Quiz 2
## Scenario: A New Terminal and a Brownout

Dan's flatmate installs Rust, then types `rustc --version` in the terminal window that was already open — "command not found." That night the dorm Wi-Fi dies, and Dan still wants to read the Rust docs.

**Question 5:** Why does the already-open terminal say "command not found"?
A. The install failed
B. Terminals read `PATH` at window startup — a window opened before the install has never heard of `.cargo/bin`; a NEW terminal fixes it
C. rustc only works in administrator mode
D. The flatmate must reboot Windows

**Answer:** B
**Explanation:** The installer adds `~/.cargo/bin` (Windows: `C:\Users\<you>\.cargo\bin`) to `PATH`, but only newly opened terminals re-read it. First troubleshooting step: close every terminal, open a fresh one.

---

**Question 6:** With zero internet, how does Dan open the full standard library reference and The Rust Book?
A. He can't — docs are online only
B. `rustup doc` — complete documentation ships with the toolchain and opens from disk (`file://`, not `https://`)
C. `cargo download docs`
D. He must reinstall Rust with a docs flag

**Answer:** B
**Explanation:** The docs are offline-first: `rustup doc` (or `rustup doc --book`) serves them from your own disk. Works in a brownout, works on the carinderia desktop with no internet at all.

---

**Question 7:** From Lesson 4 onward, which tool will you type every single day, and why?
A. `rustup`, because Rust updates daily
B. `rustc`, because you must compile each file by hand
C. `cargo`, because it creates, builds, runs, and tests projects and manages dependencies — quietly calling rustc behind the scenes
D. `rustfmt`, because formatting is mandatory

**Answer:** C
**Explanation:** cargo is the daily driver. You'll meet rustc once to see what it does, then work through cargo — the way Tita Malou cooks daily without calling her gas supplier every morning.

---
**Next:** Proceed to Lesson 2 exercises.
