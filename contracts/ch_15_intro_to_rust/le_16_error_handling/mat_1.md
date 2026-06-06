## Dan's Story: The Ghost on Row 113

Saturday night, Marikina. Dan scrolled months back through Messenger for a screenshot he had never deleted — *kept*, actually, the way you keep a scar:

```text
Traceback (most recent call last):
  File "sales_report.py", line 42, in <module>
    rainy_bonus = WEATHER_BONUS[row["weather"]]
KeyError: ''
```

Row 113. One blank weather cell out of eight months of digitized notebook data, and Python died mid-Sunday-rush, in front of Tita Malou. The reason this entire course exists. Fifteen lessons later, Dan was finally ready to look it in the eye — but not alone. He hit the Discord call button. Two rings, then the familiar deadpan of Ate Rina: data analyst, sari-sari co-op, survivor of a thousand dirty spreadsheets.

> **Ate Rina:** One question, bata. *Before* it crashed — what did your code do about the possibility that the cell was blank?
>
> **Dan:** ...Nothing. It indexed the dictionary and assumed the key would be there.
>
> **Ate Rina:** So the plan was *sana okay lahat*. Handle every case, bata. Hope is not a strategy.

This time Dan had something to show her. Same job — parsing a number from the notebook — written the Python way:

```rust
let total: u32 = "120".parse::<u32>();
// error[E0308]: expected `u32`, found `Result<u32, ParseIntError>`
```

> **Dan:** It won't even hand me the number. It hands me a box — could be the number, could be the *reason* it's not a number. And it refuses to compile until I write down what happens in both cases. In Python, the blank cell waited until row 113, at runtime, with my mom watching. In Rust, the decision happens here, tonight, at my desk, before the program exists.
>
> **Ate Rina:** ...Finally, a computer as strict as me.

---

## The Concept: Errors Are Values You Must Open

### `panic!` vs Recoverable

Rust splits all failure into two categories, and choosing the right one is the whole skill. **Unrecoverable failures** are programmer bugs — states so broken that continuing would make things worse. Rust's answer is **`panic!`**: print a message, unwind, die.

```rust
panic!("cash drawer is negative — the math itself is broken");
```

**Recoverable failures** are everything else — a blank cell, garbage in a price column, a missing file. Not bugs. They are *Tuesday*. In Python, both kinds arrived the same way: a runtime traceback, whenever it felt like it, in front of whoever was watching. Rust makes you sort them at compile time. Bugs panic. Bad input returns a value you are forced to deal with.

### `Option<T>` vs `Result<T, E>` — Both Are Just Enums

Surprise: you already learned error handling last lesson. Both are plain enums from the standard library, with the full force of `match` exhaustiveness behind them:

| | `Option<T>` | `Result<T, E>` |
|---|---|---|
| Variants | `Some(T)` / `None` | `Ok(T)` / `Err(E)` |
| The question | "Is there a value at all?" | "Did it work — and if not, *why*?" |
| What failure carries | Nothing. Absence is the whole story. | An error value `E` holding the reason |
| Carinderia version | "May sinigang pa ba?" — meron o wala | "Na-balanse ba ang kaha?" — oo, o *bakit hindi* |

Rule of thumb: if "it's just not there" is a complete answer, use `Option`. The moment the caller would ask *"okay, but bakit?"* — use `Result` and put the answer in the `Err`.

### The Gateway: `.parse::<u32>()` Returns `Result`

```rust
let n = "120".parse::<u32>();
// n is NOT a u32. n is a Result<u32, ParseIntError>.
```

`.parse()` *cannot* promise a number — the string might be `"abc"`, or `""`, or row 113. The blank cell that ambushed Dan at runtime in Python is, in Rust, a compile error *until you've answered for it*. That is the entire trade in one method call.

### Opening the Box: `match` / `unwrap_or` / `unwrap_or_else`

**Full `match`** — maximum control, both arms visible, exhaustiveness enforced:

```rust
let price: u32 = match raw.trim().parse::<u32>() {
    Ok(n) => n,
    Err(_) => 0, // or log it, or skip the row — YOUR decision, written down
};
```

**`unwrap_or(default)`** — the tolerant one-liner, for when a sensible default genuinely exists: `raw_tip.trim().parse::<u32>().unwrap_or(0)` — blank tip means walang tip. **`unwrap_or_else`** is the lazier sibling: it takes a function that *builds* the default, and that function only runs on the `Err` path.

### The `?` Operator

```rust
fn parse_price(s: &str) -> Result<u32, std::num::ParseIntError> {
    let price = s.trim().parse::<u32>()?;
    Ok(price)
}
```

What `?` desugars to, no mystery: if the value is `Ok(v)`, unwrap it to `v` and keep going; if it's `Err(e)`, **stop and return that `Err` from the enclosing function right now** — an early return that hands the error to the caller unopened. It only compiles inside functions whose return type can receive the error, which is why `parse_price` returns `Result` and why slapping `?` in a bare `main` earns a compile error instead of a surprise.

### The Unwrap Policy

`unwrap()` rips the box open and panics on `Err`; `expect("message")` does the same but lets you write the panic message. They have a legitimate place — quick experiments, where a crash costs you nothing. So here is the house rule for the rest of this course, and it is not negotiable: **`unwrap()` and `expect()` are fine in prototypes — label them `// PROTOTYPE:` — and BANNED from LutoCLI's final code (Lessons 24-25).**

```rust
// PROTOTYPE: tanggalin bago ang Lesson 24
let quick: u32 = "120".parse::<u32>().unwrap();
```

The label is the point. Every `unwrap()` is a small bet that the input is clean — and Dan has personally watched that bet lose, on a Sunday, in front of the one user who matters. When LutoCLI reaches its final lessons, you will grep for `unwrap` and the count must be zero.

---

## Key Takeaways

- **Rust splits failure into two kinds and makes you choose.** `panic!` is for unrecoverable programmer bugs. Expected bad input is not a bug; it gets a `Result` and a decision.
- **`Option<T>` answers "is there a value?"; `Result<T, E>` answers "did it work, and if not, why?"** Both are plain enums — `match` exhaustiveness guards every error in the language.
- **`.parse::<u32>()` returns `Result<u32, ParseIntError>`, never a bare number.** The failure Python delivered at runtime with an audience, Rust delivers at compile time, at your desk.
- **Openers, by situation:** full `match` when both arms deserve real handling; `unwrap_or(default)` when a sensible default exists; `unwrap_or_else` when the default must be computed; `?` to early-return the `Err` to a caller with better context.
- **`?` is an early return, nothing more.** `Ok(v)` unwraps and continues; `Err(e)` returns from the enclosing function immediately — which is why that function must itself return a `Result`.
- **The unwrap policy:** fine in prototypes labeled `// PROTOTYPE:`, BANNED from LutoCLI's final code. Every unlabeled `unwrap` is hope wearing a disguise, and hope is not a strategy.

---

## What's Next?

The call ended near midnight, but Dan sat there a while longer. *Dalawang sirang row, zero crash.* The ghost that started this course finally had a tombstone, and the tombstone was a `match` statement. That closes Act 2 — no more excuses. The training arc is over, and the actual job is still sitting in the corner of the carinderia: **LutoCLI**, the tool Tita Malou will run with her own two hands. And immediately, the first hard question: a lunch rush is not five strings in an array. It's dozens of orders, growing by the minute. Where does all of that *live*?

**Next Lesson: Collections** — Act 3 begins: `Vec<T>` for lists that grow, `String` for text you own, `HashMap` for looking up prices by dish name, and the day Dan's data finally gets a proper home.
