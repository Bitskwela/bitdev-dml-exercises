# Lesson 18 Quiz: Modules

---
# Quiz 1
## Scenario: The Two-Hundred-Line Kitchen

Refactor weekend. Dan's `main.rs` has hit two hundred lines — menu data, tally code, leaderboard, receipt experiments, lahat nakatambak — and Kuya JM has just explained kitchen stations: one kitchen, many stations, and only Tita Malou touches the cash drawer.

**Question 1:** What is the difference between `mod sales { ... }` and `mod sales;`?
A. The braces version is a real module; the semicolon version is just a comment
B. None to the compiler's module tree: braces attach the contents inline, while the semicolon is a promise that the contents live in `src/sales.rs` — same station, same rules, same `crate::sales::` address
C. `mod sales;` creates a new crate, while `mod sales { ... }` does not
D. The semicolon form makes everything inside automatically `pub`

**Answer:** B
**Explanation:** Both declare the same module. Inline braces carry the contents with them; `mod sales;` tells the compiler "go read `src/sales.rs`." Moving code between the two forms changes where it *lives*, never what it *means* — which is exactly why this lesson's activity can flatten a three-file project into one file.

---

**Question 2:** Dan creates a beautiful `src/sales.rs` full of working tally code, but forgets to add `mod sales;` to `main.rs`. What happens when he builds?
A. The compiler finds the file automatically, like Python imports
B. A compile error: "file sales.rs is not declared"
C. The compiler never reads a single line of it — a file the module tree never declares does not exist. No mod, no file
D. The file compiles but its functions are all private

**Answer:** C
**Explanation:** This is the mental shift coming from Python, where the filesystem *is* the module system. In Rust, only the `mod` lines pull files into the build. `sales.rs` and all its working code are simply invisible until a `mod sales;` declares it.

---

**Question 3:** Inside `mod sales`, Dan writes `fn format_row(...)` with no `pub`, and `pub fn leaderboard(...)` with one. What is the visibility rule at work?
A. Everything in a module is public unless marked `private`
B. Everything is private by default, and `pub` opts in — item by item: functions, structs, constants, child modules, and each struct field individually
C. Functions are public by default; only struct fields are private
D. `pub` is optional documentation; the compiler ignores it

**Answer:** B
**Explanation:** The default is the locked drawer; `pub` is the key, handed out by name, isa-isa, on purpose. Even a `pub struct` keeps its fields locked unless each field gets its own `pub` — a type can be visible while its insides are not.

---

**Question 4:** Why does this course write `use crate::menu::build_menu;` with the `crate::` prefix instead of a relative path?
A. `crate::` makes the function run faster
B. Relative paths are a compile error in `use` statements
C. `crate::` is the absolute address — it starts from the crate root and works identically from any file, so it survives refactors where code moves around; `self::` is the relative form
D. `crate::` automatically makes the item public

**Answer:** C
**Explanation:** Like directions from the building entrance versus directions from the kitchen door. Absolute `crate::` paths don't break when furniture gets rearranged — lift an inline `mod` block into its own file and every `use crate::...` line still works unchanged. And remember: `use` lines never leak between modules; each file does its own imports.

---

# Quiz 2
## Scenario: The Locked Cash Drawer

Dan uncomments `println!("{}", sales::format_row(1, "Adobo", 4));` in `main` and runs `cargo check`. It answers: `error[E0603]: function `format_row` is private`, with `^^^^^` arrows under the call and a `note: the function format_row is defined here` pointing into the sales module.

**Question 5:** How should Dan read this E0603 report?
A. The code is corrupted and the project must be rebuilt
B. The headline names the private item, the `^^^^^` arrows mark the exact illegal reach and label it `private function`, and the `note:` points to where the item is actually defined — even across files
C. `format_row` has a syntax error inside its body
D. The error means `format_row` was never declared anywhere

**Answer:** B
**Explanation:** Same crime-scene-plus-context layout as every Rust error: what went wrong, where you did it, and where the real item lives. E0603 is not a malfunction — it's the locked drawer doing its job, refusing a reach from outside the station.

---

**Question 6:** The very same `format_row` call works perfectly when `leaderboard` makes it. Nothing about the function changed — so why does `main` get E0603 while `leaderboard` does not?
A. `leaderboard` is listed in Cargo.toml as an exception
B. `main` called it with the wrong argument types
C. Privacy is checked by *where the caller stands*: `leaderboard` lives inside `mod sales`, and staff at the same station share freely — `main` is outside, and without `pub` it holds no key
D. Functions can only be called once per module

**Answer:** C
**Explanation:** Visibility is about the address of the call site, not the call itself. Inside the module, `secret_recipe`-style helpers are fair game with no ceremony; from outside, only `pub` items are reachable. That boundary is what makes a module a *station* and not just a folder.

---

**Question 7:** Kuya JM says half his team's code-review comments are just "should this be `pub`?" Why is keeping `format_row` private a *design decision* rather than paperwork?
A. Private functions compile to faster machine code
B. It hides the function from documentation tools only
C. What Dan *doesn't* mark `pub` is a promise that no outside code can depend on it — so tomorrow he can rewrite `format_row`'s formatting completely, certain that only `mod sales` needs to be checked
D. Privacy prevents the function from being unit tested

**Answer:** C
**Explanation:** The cash drawer rule. Every `pub` is a key someone may now rely on forever; everything else stays rewritable for free. Privacy isn't a formality — it's the tool that keeps the blast radius of future changes inside one station.

---
**Next:** Proceed to Lesson 18 exercises.
