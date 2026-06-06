## Dan's Story: The Twenty-Third Floor

Modules organize code *inside* one program — Lesson 18 settled that. But staring at his LutoCLI roadmap, Dan saw the limit: his peso formatting and his discount math will be needed in the kita checker he's building now, in LutoCLI at the capstone, in every Luto tool after that. Was he really going to copy-paste his own functions between projects forever? He sent the question to Kuya JM and got back: *"Hatid mo na lang dito sa office bukas."* So: LRT-2 from Santolan, MRT down to Ayala, a VISITOR badge at the lobby turnstile, and an elevator to the twenty-third floor.

> **Dan:** Kuya, ang lamig dito. Parang meat locker na may free coffee.
>
> **Kuya JM:** That's the BPO experience, paps. Halika — fifteen minutes before my standup, may ipapakita ako.

JM pulled a second chair to his desk and opened the team's repository: payment reconciliation, six months into the Rust rewrite.

```text
recon/
├── pesocore/        <- shared library crate
├── matcher/         <- service: pairs payments with invoices
├── reporter/        <- service: end-of-day summaries
└── alerts/          <- service: yells when money goes missing
```

> **Kuya JM:** Lahat ng currency math namin — rounding rules, formatting, tolerances — minsan lang sinulat, minsan lang tine-test. Pag may bug sa pera, isang lugar lang ang hahanapan. A module shares code inside ONE program. `pesocore` is a **crate** — a whole separate project whose only job is to be borrowed by other programs.

JM clicked into `matcher`'s `Cargo.toml` and pointed at one line — `pesocore = { path = "../pesocore" }`. Isang linya, the entire relationship.

> **Dan:** Kuya. My peso formatting. My senior discount function. I was literally planning to copy-paste myself.
>
> **Kuya JM:** And then one copy gets the bug fix and the other doesn't, and two tools print different sukli for the same order. Gawin mong library: `cargo new lutolib --lib`. Yung serde at rand na nakikita mo sa forums? Galing sa crates.io — ang **palengke ng code**, more than a hundred thousand stalls, isang `cargo add` ang layo. Pero palengke nga siya: check mo muna ang tindahan bago ka bumili.
>
> **Dan:** Pero Kuya, the carinderia desktop has no internet. Kung dependent ako sa palengke...
>
> **Kuya JM:** Good instinct, wrong worry. Dependencies are a build-time thing — pag na-compile mo na, buo na ang binary. For LutoCLI? Standard library muna. Master your own kitchen first.

*Lutolib.* Dan wrote it on his palm with his finger and spent the whole ride home sketching two folders, side by side.

---

## The Concept: Packages, Crates, and the Palengke

### A Package vs a Crate

A **crate** is one compilation unit — the thing `rustc` compiles in one go. Every program you've built in this course was a crate and nobody told you. A **package** is what `cargo new` actually creates: a `Cargo.toml` plus the crate (or crates) it owns — at most one library crate, any number of binary crates. In practice, one package wraps exactly one crate, so people use the words interchangeably at the kape machine. The compiler never confuses them, and now neither will you.

| Term | What it is | In today's project |
|---|---|---|
| **Crate** | One compilation unit: binary (runnable) or library (borrowable) | `lutolib` is a library crate; `kita-checker` is a binary crate |
| **Package** | `Cargo.toml` + the crates it owns; the folder `cargo new` makes | the `lutolib/` folder; the `kita-checker/` folder |

### Binary vs Library Crates

A **binary crate** has a `fn main()` and compiles to an executable; its root file is `src/main.rs`, and it's every project you've made so far. A **library crate** — created with `cargo new lutolib --lib` — has *no* `main` and produces nothing you can run; its root file is `src/lib.rs`, and its entire job is to offer `pub` items for other crates to use. Kitchen translation: a binary crate is a finished ulam, a library crate is the commissary that supplies the sauce base. Nobody orders a plate of sauce, but every dish in the house depends on it. Try `cargo run` inside a library and cargo agrees with the metaphor: `error: a bin target must be available for 'cargo run'`.

### Cargo.toml Anatomy

You've been generating this file since Lesson 4 and politely ignoring it. Time to read one for real:

```toml
[package]
name = "kita-checker"
version = "0.1.0"
edition = "2024"

[dependencies]
lutolib = { path = "../lutolib" }
```

- **`name`** — the package name. Dashes are allowed here, but in code dashes become underscores: a package named `kita-checker` is the crate `kita_checker`.
- **`version`** — semantic versioning, `MAJOR.MINOR.PATCH`. Breaking change bumps major; new feature, minor; bug fix, patch. Every fresh package starts at `0.1.0`.
- **`edition`** — which year's ruleset of Rust this crate speaks; keep whatever your cargo generated (`2021` or `2024`).
- **`[dependencies]`** — every crate this one borrows, one line each. The line `lutolib = { path = "../lutolib" }` is a **path dependency**: *the crate lives one folder up and over — go compile it yourself.* Cargo reads it, builds `lutolib` first, then builds your binary against it. No registry, no download, no account, no signal — the complete dependency mechanism running entirely on your hard drive. On the code side the crate's name becomes a root you can path through, just like `crate::` did for your own modules: `use lutolib::format_peso;`.

### The Cargo Verbs

| Verb | What it does |
|---|---|
| `cargo build` | Compile; the binary lands in `target/debug/` |
| `cargo run` | Build if needed, then run the binary |
| `cargo check` | Type-check everything, produce no binary — your fastest feedback loop |
| `cargo test` | Build and run every `#[test]` function (Lesson 23 lives here) |
| `cargo doc --open` | Render `///` doc comments into browsable HTML docs |
| `cargo add <name>` | Write a dependency line into `Cargo.toml` for you |

### crates.io, `cargo add`, and Semver — the Honest Paragraph

[crates.io](https://crates.io) is Rust's public registry — Kuya JM's palengke ng code, over a hundred thousand published crates. `cargo add rand` fetches the newest version and writes a line like `rand = "0.10.1"` into `[dependencies]`, which under semver means *"0.10.1 or any compatible newer 0.10.x"* — cargo may quietly take bug fixes, never breaking changes. Before you depend on a stall, inspect it the way you'd check a new suki-to-be: download count, date of last update, docs, whether the repository looks alive. And know that the palengke churns: by the time you run `cargo add rand` you may fetch something newer than `0.10.1`, and rand has renamed its API across versions before — `0.8` had `thread_rng()` and `gen_range()`, `0.9` renamed them to `rng()` and `random_range()`, and `0.10` moved `random_range` onto the `RngExt` trait. When a blog-post snippet won't compile, `cargo doc --open` renders the docs for the *exact* version you fetched. This course stays std-only — partly the fiction (the carinderia desktop is offline, Dan's laptop runs on phone-load internet), mostly the pedagogy: learn to cook from your own pantry first, and you'll be a better judge of what's worth buying later.

---

## Key Takeaways

- **A crate is one compilation unit.** Binary crates (`src/main.rs`) have a `main` and run; library crates (`src/lib.rs`) have no `main` and exist to be borrowed. `cargo new --lib` makes the second kind.
- **A package is `Cargo.toml` plus the crates it owns** — at most one library, any number of binaries. In this course, one package always wraps one crate.
- **`Cargo.toml` has two sections that matter today:** `[package]` (name, semver version, edition) and `[dependencies]` (every crate you borrow, one line each).
- **A path dependency — `lutolib = { path = "../lutolib" }` — is the full dependency mechanism with zero network.** Cargo builds the library first, automatically, then links your binary against it.
- **One dependency line covers the whole crate, forever.** Add a new `pub fn` to the library and every dependent gets it with no manifest change.
- **crates.io is the palengke ng code** — `cargo add` away, semver keeps upgrades compatible — but check the tindahan first: downloads, freshness, docs. This course stays std-only.

---

## What's Next?

Riding home from Makati, Dan kept scrolling through kita-checker's output, feeling like a man with a commissary. Then he looked at his LutoCLI roadmap and saw the next wall. The daily summary prints itself one way. The receipt for a single order needs another way. The menu board, a third. Three different types, and every one needs the same *ability* — "summarize yourself for the counter." His fingers already itch toward three nearly identical function signatures — the copy-paste itch all over again, except this time it's not code he'd be duplicating. It's *behavior*. Rust has a word for "different types sharing one ability," and it is the biggest idea left in the course.

**Next Lesson: Traits** — one behavior, many types, and the day Dan's receipts, reports, and menu boards all learn to introduce themselves.
