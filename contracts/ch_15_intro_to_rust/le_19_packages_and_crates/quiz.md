# Lesson 19 Quiz: Packages & Crates

---
# Quiz 1
## Scenario: The Twenty-Third Floor

Kuya JM shows Dan his team's repo: a `pesocore` library crate sitting beside three binary services, each one borrowing it through a single line in its `Cargo.toml`.

**Question 1:** What is the difference between a package and a crate?
A. They are the same thing, and the compiler treats the words interchangeably
B. A crate is one compilation unit — binary or library; a package is what `cargo new` creates — a `Cargo.toml` plus the crate(s) it owns: at most one library, any number of binaries
C. A package is the compiled output; a crate is the source folder it came from
D. A crate is a Cargo-only concept; packages belong to rustc

**Answer:** B
**Explanation:** A crate is the thing `rustc` compiles in one go. A package is `Cargo.toml` plus its crates. In practice one package usually wraps one crate, so people swap the words at the kape machine — but the compiler never confuses them.

---

**Question 2:** Dan runs `cargo run` inside `lutolib` and gets `error: a bin target must be available for 'cargo run'`. Why?
A. The path dependency in its Cargo.toml is broken
B. `lutolib` is a library crate — its root is `src/lib.rs`, it has no `fn main()`, and it produces nothing you can run; its job is to offer `pub` items for other crates to borrow
C. He forgot to run `cargo build` first
D. The edition in `Cargo.toml` is set to the wrong year

**Answer:** B
**Explanation:** `cargo new lutolib --lib` creates a library: no `main`, nothing runnable. A library is the commissary, not the meal — the error is cargo agreeing with the metaphor. You run the *binary* crate that depends on it.

---

**Question 3:** In `kita-checker`'s manifest, which pairing of section to purpose is correct?
A. `[package]` lists the crates you borrow; `[dependencies]` holds the name and version
B. `[package]` holds identity — name, semver version, edition; `[dependencies]` lists every crate this one borrows, one line each
C. Both sections are decoration; cargo infers everything from `src/`
D. `[package]` is only required when publishing to crates.io

**Answer:** B
**Explanation:** `name` (dashes become underscores in code: `kita-checker` is the crate `kita_checker`), `version` (MAJOR.MINOR.PATCH), and `edition` live under `[package]`. The borrowing happens in `[dependencies]` — the whole reason Lesson 19 exists.

---

**Question 4:** `kita-checker/Cargo.toml` says `lutolib = { path = "../lutolib" }`. Dan types `cargo run` inside `kita-checker`, on a desktop with no internet. What happens?
A. The build fails — dependencies require a connection to crates.io
B. Cargo reads the path, walks to the sibling folder, compiles `lutolib` first, then builds the binary against it — the full dependency mechanism with zero network
C. Cargo copy-pastes lutolib's source files into `kita-checker/src`
D. The build works, but only because lutolib was already published

**Answer:** B
**Explanation:** A path dependency says "the crate lives one folder up and over — go compile it yourself." No registry, no download, no account. The two `Compiling` lines, library first, are the mechanism made visible.

---
