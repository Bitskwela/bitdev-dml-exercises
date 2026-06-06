## Dan's Story: The Ten-Meter Deployment

8:40 PM, carinderia closed, chairs flipped up on the tables. Dan sat at his corner table with the laptop and Kuya JM's pitch replaying in his head: *"One file. Copy it on a USB, double-click, tapos."* Two courses of `pip install` muscle memory said that was impossible. Tonight he tested it.

He created `main.rs` and typed the smallest Rust program that exists:

```rust
fn main() {
    println!("Kamusta, Carinderia ni Tita Malou!");
}
```

Then `rustc main.rs`. The laptop fan whirred for a second, and a new file appeared next to the source: `main.exe`. He ran it — instant. He dressed the program up with a banner and today's three dishes with prices, recompiled, and copied **only `main.exe`** onto his battered USB stick. Not the source. Not a folder of dependencies. One file.

Ten meters away sat the ancient counter desktop — no Python, no internet, a machine that had never once run anything Dan built. He plugged in the USB, ran the binary, and the banner appeared: the greeting, the menu, Adobo at 75, Sinigang at 95, Halo-Halo at 60.

> **Tita Malou:** *(reading slowly)* "Kamusta, Carinderia ni Tita Malou!" ... Anak, bakit kilala ako ng computer na 'to?
>
> **Dan:** Sinulat ko po yan sa laptop ko, tapos I copied one file lang dito sa USB. That's the entire program, Ma. Walang install, walang internet.
>
> **Tita Malou:** Walang internet. Walang Python. Isang file lang... sige, anak. Ituloy mo 'yan.

The shortest deployment of Dan's life — and the first one that didn't need him to come along with it.

---

## The Concept: One File In, One Binary Out

### `fn main()` — the front door

Every Rust program begins executing at `fn main()` — no exceptions. `fn` declares a function (full treatment in Lesson 6), `main` is the one reserved name `rustc` looks for, `()` means it takes no inputs, and the curly braces `{ }` hold the body. Python happily runs any `.py` file from the top line down; Rust insists on one official entrance — like the carinderia: many tables, one front door. Delete `main` and the program doesn't crash; it refuses to *compile*.

### `println!` is a macro — what the `!` signals

`println!` is **not a function**. It is a **macro**, and the `!` is how Rust marks every macro call. A macro runs *at compile time* and writes the real code for you: when `rustc` meets `println!`, it reads your format string, counts the `{}` placeholders, checks them against the arguments you passed, and only then expands into the actual printing instructions. A placeholder/argument mismatch is therefore a *compile error* — the broken program never gets built — while the equivalent typo in a Python format call detonates at runtime, possibly in front of your mom. Rule of thumb: **see a `!`, think "compile-time helper."**

### Compile, then run

Rust is always two steps. Step one, translate: `rustc main.rs` reads your source and produces a binary — `main.exe` on Windows, `main` on Linux/macOS. Step two, execute: run that binary directly. Translate once, run as many times as you want, on as many machines as you want.

```
  DAN'S LAPTOP (has the Rust toolchain)      ANY machine (has NOTHING installed)

  +----------------+                         +------------------------+
  |    main.rs     |      rustc main.rs      |   main.exe  /  main    |
  |  source code,  |  -------------------->  |  machine code the CPU  |
  |  for humans    |     (translate ONCE)    |  executes directly     |
  +----------------+                         +------------------------+
   needs: rustc installed                     needs: nothing
```

One honesty footnote: "runs anywhere" means anywhere in the *same OS family* — a Windows binary runs on Windows machines, a Linux binary on Linux. (Building across families is cross-compilation, signposted at the very end of this course.)

### Standalone — the whole reason we're here

Tita Malou's requirement was: a tool **she** can run **herself**, on an offline desktop, with no Python and no Dan on call. That is *impossible* for a plain Python script — a script is just a recipe, and a recipe is useless in a kitchen with no stove. A compiled Rust binary isn't the recipe; it's the cooked ulam, packed in its own container. Rust bakes the standard library straight into the binary, which is why three lines of source become a file of a few hundred kilobytes: the program carries its own kitchen. **This is exactly why Kuya JM said Rust** — and LutoCLI, the tool this course builds toward, is tonight's trick with 22 lessons of muscle behind it.

### `{}` — placeholder formatting

```rust
let price: u32 = 75;
println!("Adobo costs {} pesos today.", price);
```

Each `{}` in a `println!` format string is a placeholder. Arguments after the string fill them **in order, left to right** — `println!("{} costs {} pesos.", "Sinigang na Baboy", 95)` prints `Sinigang na Baboy costs 95 pesos.` Too many placeholders, too few arguments — or the reverse — and the compiler stops you on the spot, exactly as the macro section promised. House style notes: money lives in `u32` whole pesos (the war story behind that is Lesson 5), and we print `PHP` instead of the `₱` symbol because some ancient console windows garble it on display.

---

## Key Takeaways

- **`fn main()` is the entry point.** Exactly one front door per program; `rustc` refuses to build without it.
- **`println!` is a macro, and `!` is the giveaway.** The format string is checked against the arguments at compile time — mismatches never reach runtime.
- **The workflow is compile-then-run.** `rustc main.rs` produces `main` / `main.exe`; translate once, run forever.
- **The binary is standalone.** The standard library is baked in — no interpreter, no runtime, no internet on the target machine. Tita Malou's requirement, met. (Same-OS caveat: Windows binaries for Windows, Linux for Linux.)
- **`{}` placeholders fill in order, left to right,** and the compiler counts them for you.
- **This is the only bare-`rustc` lesson.** From Lesson 4 onward, `cargo run` does the compiling, running, and housekeeping.

---

## What's Next?

The deployment story works. Now Dan has to write programs that actually *do* something — starting with the most ordinary task in the carinderia: tracking the rice. He writes the obvious code — make a variable, update it as orders land — the kind of thing he's done in Python a thousand times. And the compiler says no. Not a crash. A flat, confident refusal to build, pointing at a line Dan was *sure* was innocent. His first real lesson in how Rust thinks about change itself.

**Next Lesson: Variables & Mutability** — `let`, `mut`, shadowing, and `const`. Why Rust makes everything immutable until you say otherwise, and why Dan ends the day thanking the compiler through gritted teeth.
