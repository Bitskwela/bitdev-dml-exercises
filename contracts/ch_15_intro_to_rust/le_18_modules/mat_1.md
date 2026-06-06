## Dan's Story: The Two-Hundred-Line Kitchen

Refactor weekend — official, because there's a sticky note on the laptop lid saying so. Step one: find `build_menu`, a function Dan wrote two weeks ago. He scrolled past the tally loop, past the leaderboard sort, past a receipt experiment he forgot existed, past a comment that just said `// TODO: kalimutan muna ito`. Five minutes to find one function *he himself wrote*, in a `main.rs` that had quietly grown to two hundred lines. He called Kuya JM.

> **Dan:** Kuya, gaano kahaba ang main file ng payment service niyo sa work?
>
> **Kuya JM:** Mga thirty lines. It starts things up, tapos delegate na agad. Question: how does Tita Malou cook ten orders at once without the kitchen turning into a riot?
>
> **Dan:** Stations. Prep sa likod, frying sa gilid, cashier sa harap. You don't julienne carrots sa tabi ng kaha.
>
> **Kuya JM:** Exactly. One kitchen, many stations. Rust calls a station a **module** — and here's the part tutorials bury: not everyone gets to touch the cash drawer, diba? Si Tita Malou lang. In Rust, *everything* inside a module is locked by default. `pub` is you handing someone a key — by name, isa-isa, on purpose.

Dan looked at his two hundred lines. *No stations. I've been running a whole carinderia on one chopping board.* He cracked his knuckles. Refactor weekend was on.

---

## The Concept: One Kitchen, Many Stations

### `mod` Declarations — Inline Braces, or a Separate File

A **module** is a named box for code. The simplest form lives inline, right inside one file:

```rust
mod kitchen {
    pub fn serve_adobo() -> String {
        // Same module — the private helper is fair game in here.
        format!("Adobo, plated: {}", secret_recipe())
    }

    fn secret_recipe() -> String {
        String::from("toyo muna bago suka — never both at once")
    }
}

fn main() {
    println!("{}", kitchen::serve_adobo()); // OK — serve_adobo is pub
}
```

Items inside a module are addressed with `::` — `kitchen::serve_adobo()` reads as "the kitchen's serve_adobo." And inside the module, `serve_adobo` calls `secret_recipe` with no ceremony at all: staff at the same station share freely.

Inline modules are fine for small things, but Dan's goal is fewer lines in `main.rs` — so here is the second form. Replace the braces with a semicolon, `mod menu;`, and you've made the compiler a promise: *"May module akong `menu` — its contents are in `src/menu.rs`. Go look."* Same module, same rules — only the contents move out:

```text
lutocli_refactor/
├── Cargo.toml
└── src/
    ├── main.rs     <- the cashier: `mod menu;` and `mod sales;` live here
    ├── menu.rs     <- the prep station: dishes and prices
    └── sales.rs    <- the tally station: counts and the leaderboard
```

One warning for Python instincts: in Python, any `.py` file in the folder is importable — the filesystem *is* the module system. In Rust, **a file the module tree never declares does not exist**. A beautiful `src/sales.rs` full of working code, without a `mod sales;` somewhere, never gets compiled at all. No mod, no file.

### Private by Default — `pub` Hands Out Keys

Now the cash-drawer rule. `serve_adobo` is marked `pub`; `secret_recipe` is not. Add one more line to `main` — reaching straight for the recipe from outside the kitchen, `println!("{}", kitchen::secret_recipe());` — and `cargo check` says exactly what Kuya JM promised:

```text
error[E0603]: function `secret_recipe` is private
  --> src/main.rs:14:29
   |
14 |     println!("{}", kitchen::secret_recipe()); // walang pub, walang access
   |                             ^^^^^^^^^^^^^ private function
   |
note: the function `secret_recipe` is defined here
  --> src/main.rs:7:5
   |
 7 |     fn secret_recipe() -> String {
   |     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For more information about this error, try `rustc --explain E0603`.
error: could not compile `mod_playground` (bin "mod_playground") due to 1 previous error
```

Read it ritual-style: the code is **E0603**, the `^^^^^` arrows mark the illegal reach and label it `private function`, and the `note:` points at where the private item actually lives. The rule behind it is one sentence long: **everything is private by default, and `pub` opts in — item by item.** Functions, structs, constants, child modules — and struct *fields* individually: a `pub struct` whose fields stay private is a real design, the type visible, its insides locked. What you *don't* mark `pub` is a promise that outside code can't depend on it — which means you can rewrite it freely tomorrow.

### Paths — `use crate::` Says the Address Once

Once code lives in modules, every item has a full address: `crate::menu::MenuItem` — this crate, then the `menu` module, then `MenuItem`. Typing full addresses everywhere gets old fast, which is what `use` is for:

```rust
use crate::menu::MenuItem; // full address once; plain `MenuItem` afterwards
```

`crate::` is the **absolute** address — it always starts from the crate root (your `main.rs`) and works identically from any file, which is why it survives refactors and why it's this course's house style. (`self::` is the relative form — "starting from where I'm standing.") One habit to build now: **`use` lines never leak between modules.** If `sales` wants `HashMap`, then `sales` writes its own `use std::collections::HashMap;`, no matter what `main` already imported.

### The Module Tree

Every binary has exactly one module tree, and the root is `main.rs`. Tonight's entire refactor as a floor plan:

```text
crate  (src/main.rs — the root; the whole building)
│
├── mod menu   (src/menu.rs — the prep station)
│   ├── pub struct MenuItem      <- pub: posted on the menu board
│   │     ├── pub name: String
│   │     └── pub price: u32
│   └── pub fn build_menu()      <- pub: anyone may ask for the menu
│
└── mod sales  (src/sales.rs — the tally station)
    ├── pub fn tally()           <- pub
    ├── pub fn leaderboard()     <- pub
    └── fn format_row()          <- PRIVATE: the cash drawer
```

---

## Key Takeaways

- **A module is a named station for code.** Inline form: `mod menu { ... }`. File form: `mod menu;` — a promise that the contents live in `src/menu.rs`. Same module either way.
- **Files the module tree never declares do not exist.** Unlike Python, Rust only compiles what a `mod` line pulls in. No mod, no file.
- **Everything is private by default; `pub` opts in, item by item** — functions, structs, constants, child modules, and each struct field individually.
- **E0603 is the locked drawer doing its job.** Headline names the private item, `^^^^^` marks the illegal reach, the `note:` points to where it's defined — even across files.
- **`use crate::` says the full address once** so the short name works afterwards — per file, because imports never leak between modules. `crate::` is absolute (survives refactors); `self::` is relative.
- **Privacy is a design tool, not a formality.** What you don't mark `pub` is a promise outside code can't depend on it — so you can rewrite it freely tomorrow.

---

## What's Next?

Sunday night, the sticky note came off the laptop lid. `main.rs`: two hundred lines down to sixty, every one legible. Dan sent Kuya JM the before-and-after line counts, and the voice-note reply was already two steps ahead: *"Sa work, may tatlong Rust services ang team, lahat nagco-compute ng pera. Tingin mo tatlong beses naming sinulat yung money math? One shared **crate**, Dan. A library. The services pull it in like an ingredient."* Modules organize code *inside* one program. JM was describing code packaged to be *shared between* programs — written once, versioned like a real ingredient with a label.

**Next Lesson: Packages & Crates** — binary crates vs library crates, what `Cargo.toml` really describes, `lib.rs` meets `main.rs`, and the day LutoCLI's tally logic becomes an ingredient any future tool can cook with.
