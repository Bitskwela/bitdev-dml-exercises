# Lesson 3 Quiz: Hello, World!

---
# Quiz 1
## Scenario: The Ten-Meter Deployment

Dan writes his first Rust program on the laptop, compiles it with `rustc main.rs`, and walks the resulting binary on a USB stick to the carinderia's old counter desktop.

**Question 1:** Where does every Rust program begin executing?
A. At the first line of the file, top to bottom, like a Python script
B. At `fn main()` — the one entry point `rustc` requires; delete it and the program won't even compile
C. At whichever function is declared first in the file
D. At a function named `start()`

**Answer:** B
**Explanation:** Rust insists on one official entrance per program: `fn main()`. Without it the program doesn't crash — it refuses to compile. Many tables, one front door.

---

**Question 2:** What does the `!` in `println!` signal?
A. That the statement is urgent or high priority
B. That `println!` is a macro — a compile-time helper that expands into the real printing code after checking your format string against your arguments
C. That the output is negated
D. That the line can fail at runtime

**Answer:** B
**Explanation:** The `!` marks every macro call in Rust. A macro runs at compile time and writes code for you — which is how `println!` can validate `{}` placeholders before a binary even exists. See a `!`, think "compile-time helper."

---

**Question 3:** Dan runs `rustc main.rs` and the terminal prints nothing at all. What happened?
A. The compile failed silently
B. Success — compilers are quiet when happy; a new binary (`main.exe` / `main`) appeared next to the source file, ready to run
C. The program ran but produced no output
D. `rustc` is still waiting for input

**Answer:** B
**Explanation:** Compilation is step one of Rust's two-step workflow: translate, then execute. A silent `rustc` means it built the binary with no errors. Running the program is a separate step.

---

**Question 4:** Dan writes `println!("Adobo: {} pesos, Sinigang: {} pesos", 75);` — two placeholders, one argument. What happens?
A. It prints "Adobo: 75 pesos, Sinigang: pesos"
B. It fails to compile — the macro counts placeholders against arguments at compile time, so the broken program never gets built
C. It compiles but crashes at runtime when it reaches that line
D. It prints "null" for the missing value

**Answer:** B
**Explanation:** Because `println!` is a macro, the placeholder/argument check happens before a binary exists. The equivalent typo in a Python format call detonates at runtime — possibly mid-demo.

---

# Quiz 2
## Scenario: Walang Install, Isang File Lang

Tita Malou watches the binary run on the offline counter desktop — no Python, no internet, nothing installed — and asks how that's possible.

**Question 5:** Why does the compiled binary run on a machine with nothing installed?
A. It secretly downloads what it needs from the internet
B. `rustc` translated the source into machine code and baked the standard library straight into the binary — it carries its own kitchen, needing no interpreter or runtime on the target
C. Windows ships with Rust pre-installed
D. The USB stick contains a hidden copy of the Rust toolchain

**Answer:** B
**Explanation:** A compiled Rust binary is standalone: the standard library is baked in, which is why three lines of source become a few hundred kilobytes. This is Tita Malou's requirement met — and the exact reason Kuya JM pitched Rust.

---

**Question 6:** After compiling once, Dan wants to run the menu program a second, tenth, hundredth time. What must he do before each run?
A. Recompile with `rustc main.rs` every time
B. Nothing — translate once, run forever; he only recompiles when the source code changes
C. Reinstall the Rust toolchain
D. Keep `main.rs` next to the binary at all times

**Answer:** B
**Explanation:** Compile-then-run means translation happens once. The binary is self-contained machine code — it doesn't need the source file, the toolchain, or a re-translation on every run, unlike a Python script the interpreter re-reads every time.

---

**Question 7:** Thrilled, Dan emails his Windows `main.exe` to a friend who runs Linux. What should he expect?
A. It runs fine — Rust binaries run anywhere
B. It won't run — a binary is machine code for one OS family; Windows binaries run on Windows, Linux binaries on Linux. Building across families is cross-compilation, covered at the end of the course
C. Linux converts it automatically
D. It runs, but only the banner prints

**Answer:** B
**Explanation:** "Runs anywhere" comes with an honesty footnote: anywhere in the *same OS family*. Dan's laptop and the carinderia desktop are both Windows, so the USB trick worked — a Linux friend needs a Linux build.

---
**Next:** Proceed to Lesson 3 exercises.
