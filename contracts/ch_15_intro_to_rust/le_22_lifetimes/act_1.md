# Describe the Borrow

E0106 walked into LutoCLI at eleven-forty PM and turned out to be a question, not a monster. Now answer it three times: annotate the canonical `longest<'a>`, predict a scope puzzle before the compiler grades you, and write the course's one borrowed-field struct. Open `act_1.rs` and work through the TODOs in order — the file compiles as shipped, and every TODO you finish should keep it green.

## Task 1: Annotate `longest<'a>` (TODO 1, TODO 3)

Dan's three-liner sits at the top of the file, commented out, exactly as it met `error[E0106]: missing lifetime specifier`: the return type borrows, but the signature never says from whom. Add the four annotations the `help:` line suggested — `<'a>` after the function name, `'a` on both inputs, `'a` on the return — and uncomment the function. You are not extending anything; the four `'a`s record one promise: *the result is borrowed from an input, so it expires when the shorter-lived input dies.* Then uncomment Part 1 in `main` and confirm the headline prints — both owners live to the end of `main`, so the promise holds trivially.

## Task 2: The Scope Puzzle — Predict, Then Prove (TODO 4)

Part 2's first block squeezes `longest` into a tighter spot: `merienda` lives inside inner braces, and the `println!` sits inside them too. PREDICT first — compiles or not? Write your answer into the `My prediction:` comment, then uncomment and let `cargo check` grade you. (Lesson 10's rule decides it: a borrow lives to its *last use*, not to the closing brace.) The second block is the same code with the `println!` moved one brace down — past `merienda`'s funeral. It stays permanently commented with its verdict attached: `error[E0597]: merienda does not live long enough`. Uncomment it once to meet E0597 in person, do the ritual on its four labeled arrows — born, borrowed, dropped while still borrowed, used anyway — then re-comment it and go green.

## Task 3: `BestSeller<'a>` — the Borrowed-Plate Struct (TODO 2, TODO 5)

A struct field holding a reference owes the compiler a schedule — which is exactly why every other struct in this course owns `String`. Tonight, write the exception on purpose: declare `<'a>` on `BestSeller`, label the field `&'a str`, uncomment the struct, then uncomment Part 3. It compiles because `top_dish` is created before `poster` and dies after it — the struct's `'a` is exactly that promise, written down. The poster cannot outlive the dish.

## Sample Output

```
=== LutoCLI: Specials Board ===

Headline dish: Sinigang na Baboy
Featured this week: Lechon Kawali

Best-seller poster: Kare-Kare
```

"Sinigang na Baboy" beats "Adobo", "Lechon Kawali" beats "Turon" — Tita Malou's longer-name rule, enforced by a function whose signature now tells the whole truth about its borrows.

## Reflection Questions

1. The annotated `longest<'a>` and Dan's unannotated original have *identical bodies*. What exactly did the four `'a`s change — and what did they NOT change about when any value dies?
2. In the failing scope puzzle, the program *might* have been fine at runtime — "Lechon Kawali" is longer than "Turon", so `featured` would have pointed at the outer string. Why does the compiler reject it anyway, on every run including the lucky ones?
3. Lesson 11's `first_word(s: &str) -> &str` never needed an `'a`. Which elision rule covered it, and why do the rules come up empty for `longest`?

## Challenge: First Longer Than

Tita Malou's headline rule, generalized: find the first dish name longer than `n` characters — if any. Finish this function and wire it into your `main`:

```rust
fn first_longer_than<'a>(names: &'a [String], n: usize) -> Option<&'a str> {
    // TODO: .iter().find(...) hands you an Option<&String>;
    // .map(|s| s.as_str()) turns it into the Option<&str> you promised.
    todo!()
}
```

Call it on the menu `["Adobo", "Sinigang na Baboy", "Kare-Kare"]` with `n = 8` and the `Some` arm should print `Board headline: Sinigang na Baboy`; call it again with `n = 30` and confirm the `None` arm fires. Then read your signature out loud — it's three lessons in one line: `&'a [String]` is a Lesson 11 slice, `Option<&'a str>` is Lesson 14's honesty about absence, and the two `'a`s record tonight's promise: whatever name comes back is borrowed from inside that slice, so it expires when the slice's owner does. Note what has no lifetime at all: `n: usize` is a plain owned `Copy` value — schedules are for borrowed plates, not for rice you were handed outright.

## What You've Learned

- E0106 is a question, not a rejection: the elision rules came up empty, and the signature needs you to say which input the returned borrow comes from
- Lifetime annotations describe relationships, never extend them — `longest<'a>` promises the result dies with the shorter-lived input, and E0597 enforces that promise at every call site, tracking last *uses* rather than closing braces
- A struct holding a reference needs `<'a>` (`BestSeller` may not outlive the `String` it borrows from) — and owning `String` is why every other struct in this course never needed one
