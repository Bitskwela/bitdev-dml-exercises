## Dan's Story: The Borrowed Plate

Eleven-forty PM, Marikina. Dan was deep in LutoCLI's specials-board feature — compare the two best-seller candidates and headline the longer name, because Tita Malou's rule says *mas mahabang pangalan, mas mukhang espesyal*. Three lines, `first_word`'s younger sibling: borrow two strings, return one of the borrows.

```rust
fn longest_dish_name(a: &str, b: &str) -> &str {
    if a.len() > b.len() { a } else { b }
}
```

`cargo check` said no — `error[E0106]: missing lifetime specifier` — and the `help:` line offered a fix full of *apostrophes*: `<'a>`, `&'a str`. Then a memory surfaced. Dan scrolled the barkada group chat months back, to the night E0382 ate his evening:

> **Jasper:** and bro kung ma-survive mo pa yung borrow checker, I peeked at what comes after. LIFETIMES. apostrophes all over the code like it's haunted. NOBODY understands lifetimes bro. uninstall na.

The haunted apostrophes had finally come for him. He called Kuya JM, who picked up on the second ring.

> **Dan:** Kuya, the compiler just asked me to specify a *lifetime*. E0106. Jasper warned the GC about this exact thing — he said *nobody* understands lifetimes.
>
> **Kuya JM:** Jasper quit before ever meeting one, so let's not take exit interviews from the guy at the exit. Pero totoo, hindi ako magyayabang dito: lifetimes took me *weeks* at work. I read the borrows chapter five times, and may mga corner cases pa rin akong dine-deadma. So here's the version I wish someone gave me on week one. Mga plato ni Tita — may suki ba na nagpapa-takeout pero hiram yung plato?
>
> **Dan:** Mang Ben. Lugaw every morning, hiram na plato, sinasauli before lunch.
>
> **Kuya JM:** And when Tita lends that plate, isa lang ang tanong niya: *hanggang kailan?* That's E0106, Dan. The compiler is just asking *hanggang kailan valid ang borrow*. You're not CHANGING lifetimes — you're DESCRIBING them. Walang plato na tumatagal nang mas matagal dahil sumagot ka. You're writing the return time on the chalkboard, that's all. And it has to ask *you*, because when it checks the code that *calls* your function, it reads the signature lang — the contract — never the body. "Returns a borrowed plate" without saying kaninong plato gives the borrow checker downstream nothing to verify against.

Dan applied the `help:` line's fix, character for character. Green in eleven minutes — he checked, because Lesson 9 took sixty-eight. Then he reread the error and noticed what it had actually done: not rejected his code, but asked a *question*, waited for his answer, and co-signed it. He opened his notes: *The compiler used to be a wall. Then a bodyguard. Tonight it interviewed me like a mentor. Jasper, you quit before the best part.*

---

## The Concept: Lifetimes — Describing How Long Borrows Live

### Why Lifetimes Exist

Rewind to Lesson 10's quiet superpower: **a reference must never outlive the value it points to.** Dangling references — C's time-bomb pointers into freed memory — are not caught at runtime in Rust, or handled, or debugged. They are *never compiled*. For that promise to hold, the compiler must **prove**, before the binary exists, that every reference's owner is still alive at every use. Inside one function the proof is easy — every scope is visible. But across a function boundary the compiler deliberately doesn't look: when checking a *caller*, it reads only the *signature*, never the body. And `longest_dish_name`'s signature returns a borrow without saying whether it comes from `a` or `b` — the body can't settle it either, because which input comes back depends on `.len()`, which is runtime data. The proof has a hole in it.

### Annotations Describe Relationships — They Never Extend Them

E0106 is the compiler refusing to guess, verbatim:

```text
error[E0106]: missing lifetime specifier
 --> src\main.rs:1:43
  |
1 | fn longest_dish_name(a: &str, b: &str) -> &str {
  |                         ----     ----     ^ expected named lifetime parameter
  |
  = help: this function's return type contains a borrowed value, but the signature does not say whether it is borrowed from `a` or `b`
help: consider introducing a named lifetime parameter
  |
1 | fn longest_dish_name<'a>(a: &'a str, b: &'a str) -> &'a str {
  |                     ++++     ++          ++          ++

For more information about this error, try `rustc --explain E0106`.
error: could not compile `specials_board` (bin "specials_board") due to 1 previous error
```

The `help:` line typed the fix — and the fix is not new code. It is a *schedule*, attached to code that already existed. Say the rule with the chalkboard, because every lifetime confusion ever traces back to forgetting it: **lifetime annotations describe relationships, never extend lifetimes.** No `'a` keeps a value alive one nanosecond longer. Every value still dies at the end of its owner's scope, exactly as Lesson 9 taught. Writing "back by lunch" doesn't make Mang Ben keep the plate longer — it lets Tita Malou *plan around the truth*. If your code fails a lifetime check, the borrow really was unsound; the annotation is just where the compiler caught the lie.

### The Canonical `longest<'a>` — Every Apostrophe Accounted For

Every Rust learner writes this function. Tonight it's yours:

```rust
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() { x } else { y }
}
```

Four appearances of `'a`, four jobs:

| Where | What it records |
|---|---|
| `<'a>` | Declares a lifetime parameter — Lesson 21's angle brackets, but `'a` stands for a *region of code where a borrow is valid*, not a type |
| `x: &'a str` | "`x` is a borrow that must be valid for at least the region `'a`" |
| `y: &'a str` | Same label — so `'a` can only be a region where *both* inputs are valid: their overlap |
| `-> &'a str` | "The returned borrow is only usable inside `'a` — past that, it's expired" |

At each call site, the compiler solves for `'a`: the overlap of the two input lifetimes — concretely, the *shorter-lived* one wins. The promise the signature records: *the value I return is borrowed from one of these inputs, so treat it as dead the moment the shorter-lived input dies.* Use the result while both owners are alive → compiles. Use it after the shorter one is dropped → E0597, no exceptions. And the Lesson 21 punchline applies even harder: lifetimes are checked at compile time, then **erased** — they don't even generate per-type copies like `<T>` does. Zero bytes, zero instructions, zero runtime cost.

### Elision — Why `first_word` Never Owed You This

Back in Lesson 11, Dan wrote `fn first_word(s: &str) -> &str` — borrow in, borrow out — and E0106 never appeared. Why does `longest` pay a tax `first_word` skipped? Because the compiler infers the obvious cases using three mechanical **elision rules**:

1. **Each input reference gets its own lifetime parameter.** (`first_word` gets one; `longest` gets two.)
2. **If there is exactly ONE input lifetime, it is assigned to every output reference.** One borrow in, so the borrow out *must* come from it — case closed, no annotation needed.
3. **In methods, if `&self` or `&mut self` is a parameter, `self`'s lifetime goes to all outputs.**

`first_word` sails through rule 2. `longest` has two input lifetimes and isn't a method — both rules whiff, the output lifetime stays unknown, and the compiler hands the question to you. That's all E0106 ever is: *the elision rules came up empty; your turn.* Honest framing, because Jasper's ghost is listening: the compiler infers MOST lifetimes. You can write Rust for weeks without typing `'a` — everything in Lessons 1 through 21 compiled without one. Explicit lifetimes show up in exactly two everyday places: functions returning a borrow tied to one of *several* inputs, and the next section.

### Structs That Borrow: `BestSeller<'a>`

A struct can hold a reference instead of owning a `String` — but then the struct itself contains a borrowed plate, and the chalkboard demands a schedule:

```rust
struct BestSeller<'a> {
    name: &'a str,
}
```

The `'a` records: **no `BestSeller` value may outlive the string its `name` borrows from.** The poster cannot outlive the dish. Now exhale, because you've been protected from this for ten lessons. Lesson 12's sticky note — *functions take `&str`, structs own `String`* — was guarding exactly this door: every struct in this course owns its `String`, which is why none of them ever needed an `'a`. Tomorrow, LutoCLI's structs go right back to owning, because a tool on Tita Malou's desktop wants data that owns itself. Borrowing structs earn their keep in zero-copy, short-lived-view code — know the door exists, keep it closed by default.

### `'static`, in One Sentence

A string literal's type is `&'static str` — a borrow of text baked into the compiled binary itself, valid for the entire run of the program — which is the whole story Lesson 12 promised to finish here.

---

## Key Takeaways

- **Lifetimes exist to keep Lesson 10's promise across function boundaries:** a reference must never outlive its owner, and the compiler proves it from *signatures*, not bodies. E0106 means your signature has a borrow with no story.
- **Lifetime annotations describe relationships, never extend lifetimes.** Nothing lives longer because you wrote `'a`; values die exactly where Lesson 9 said. The annotation just writes the schedule where the compiler can enforce it.
- **The canonical `fn longest<'a>(x: &'a str, y: &'a str) -> &'a str`** records one promise: the result is borrowed from an input, so it expires when the *shorter-lived* input dies. After that point: E0597, every run, even the lucky ones.
- **Elision covers the everyday cases** — each input ref gets a lifetime; a single input lifetime flows to all outputs; `&self`'s lifetime flows to method outputs. That's why `first_word` never needed `'a`, and why explicit lifetimes are *rare* in real code.
- **Structs holding references need `<'a>`** — `BestSeller<'a>` may not outlive the `String` it borrows from. This course's structs own `String` instead; Lesson 12's sticky note was this lesson's bodyguard all along.
- **`'static` means borrowed from the binary itself** — string literals, alive for the whole program. And lifetimes, like Lesson 21's generics, are erased after checking: zero runtime cost.

---

## What's Next?

Dan closed the laptop at half past midnight with a green check and a strange new feeling about the compiler — it asked a fair question, politely worded, with the fix attached, and accepted his answer like a colleague reviewing a contract. Which is good, because tomorrow the *human* reviewer arrives. Ate Rina is coming by the carinderia, and Dan made the mistake of telling her LutoCLI's summary math is "basically done." Her reply was eleven words: *"LutoCLI computes Tita Malou's money. PROVE it works. I'll wait."* The borrow checker proves Dan's references are sound; it has no opinion on whether his sukli math is *right*. For that, Rust ships a second examiner — one Dan summons himself, on purpose, with `cargo test`.

**Next Lesson: Testing** — `#[test]` functions, `assert_eq!` and friends, organizing a test module, and the day Dan's arithmetic faces an auditor that doesn't accept *basically*.
