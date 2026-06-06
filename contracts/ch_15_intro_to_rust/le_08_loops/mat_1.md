## Dan's Story: The Midnight Drag Race

Dorm, midnight. Dan was doing something embarrassing: summing the day's carinderia sales *line by line*.

```rust
let total = 120 + 85 + 200 + 150 + 95 + 310 + 180 + 250;
```

Eight transactions, eight numbers typed by hand — and fiesta season could mean two hundred lines in the notebook. Then his phone buzzed. Kuya JM, awake on a deployment night shift, with a dare:

> **Kuya JM:** Rust has three loops — `loop`, `while`, `for`. Learn them tonight. Then sum the numbers from 1 to 10 million — once in Python, once in Rust. Time both. Drag race.

Python answered in **0.512 seconds**. Honestly, not bad. Then Rust with `cargo run`: **81 milliseconds** — six times faster already.

> **Kuya JM:** Naks. But you raced in training mode. `cargo run` builds in *debug* — the compiler optimizes for fast recompiles, not fast code. Run it again with `cargo run --release`.

**11 milliseconds.** Dan ran it again because he didn't believe it. Ten million additions, done in the time it takes a screen to refresh once — roughly fifty times faster than Python, on his SECONDHAND laptop.

> **Dan:** ...then Mama's thirty days of sales data is *nothing*. A rounding error.
>
> **Kuya JM:** Exactly. That's the whole Act 1 promise. The old machine was never the problem. The tools were.

---

## The Concept: Three Loops and Two Gears

### 1. `loop` — repeat forever, and `break` with a value

`loop` has no condition at all. It runs until `break` — and `break` can carry a value out, because `loop` is an *expression*, just like `if` was in Lesson 7:

```rust
let hit_day = loop {
    if daily_totals[day] >= target {
        break day; // the loop ITSELF evaluates to `day`
    }
    day += 1;
};
```

No `found` flag, no "check after the loop" dance. The loop searches; the loop hands you the result. (`while` and `for` cannot do this — only `loop` guarantees you can't fall out the bottom without a `break`, so only `loop` can promise a value.)

### 2. `while` — repeat while a condition holds

```rust
while hour < closing_hour {
    hour += 1;
}
```

The Lesson 7 rule still applies: the condition must be a real `bool`. `while sales` does not compile. `while count != 0` does.

### 3. `for` — repeat over a collection (your daily driver)

```rust
for amount in sales {
    total += amount;
}
```

`for` doesn't count — it *iterates*: it asks the collection "what's next?" until the collection says "wala na." Ranges are collections too:

| Range | Reads as | Yields |
|-------|----------|--------|
| `1..7` | "1 up to, NOT including, 7" | 1, 2, 3, 4, 5, 6 |
| `1..=7` | "1 up to AND including 7" | 1, 2, 3, 4, 5, 6, 7 |

One character (`=`) is the difference between six days and seven. Read ranges out loud until the difference is reflex.

### Why `for` beats manual indexing

The `i = 0; while i < length; i++` habit ships bugs: type `<=` instead of `<` and you read one slot past the end; start at `1` instead of `0` and you silently skip the first sale of the day. Off-by-one errors have been crashing programs since before Dan was born.

Rust's `for` deletes the entire bug category: **there is no index to get wrong.** The collection itself hands each item to the loop, so you can't run past the end — the loop ends exactly when the items do. And because the compiler can *prove* every access is in bounds, it removes the safety checks it would otherwise need. The safe loop is also the fast loop: you don't trade safety for speed, you get both from the same `for`.

### Two gears: debug vs `--release`

| | `cargo run` (debug) | `cargo run --release` |
|---|---|---|
| Compile time | Fast — rebuilds in a blink | Slower — the compiler thinks hard |
| Runtime speed | Slow-ish | Full speed |
| Integer overflow | **Panics loudly** (catches bugs) | Wraps silently (checks removed) |
| Made for | Your edit-compile-test loop | The binary you actually ship |

What does "optimization" actually change? In release mode the compiler inlines small functions into their callers, deletes code it can prove never runs, reorders and unrolls loops, and hands tight numeric loops to the CPU's vector instructions — turning "add one number per step" into "add several per step." Debug mode skips all of that on purpose, so your rebuilds stay instant and overflow bugs panic instead of hiding.

That's why the drag race is **only fair in release mode** — debug-Rust versus Python is Rust racing with the handbrake on. It still won tonight (81ms vs 512ms), but that's not the real car. The real car did it in 11.

---

## Key Takeaways

- **`for item in collection`** is the default loop. No index, no off-by-one, no bounds bugs — and the compiler uses the iterator's proof to delete the safety checks. Safe AND fast, same keyword.
- **Ranges:** `1..7` excludes 7; `1..=7` includes it. One `=` is the difference between six and seven days.
- **`while`** repeats on a condition — which must be a real `bool`, same as Lesson 7.
- **`loop` is an expression:** `let x = loop { ... break value; };` returns a value straight out of the loop. Only `loop` can do this.
- **Debug vs release are different gears.** Develop in debug; ship — and *benchmark* — in release. It's the only fair race.
- **The speed promise is real:** 10 million additions in ~11ms on a secondhand laptop, vs ~0.5s in Python. The old desktop will be MORE than enough.

---

## What's Next?

Act 1 is complete. Dan can declare, type, branch, loop, and compile a binary that embarrasses his Python scripts on his own hardware. He went to bed at 1 AM feeling slightly invincible. That feeling has about one lesson left to live: tomorrow Dan assigns a `String` to a second variable, prints the first one — and the compiler says **no**, with an error code: **E0382, "borrow of moved value."** Jasper, who rage-quit Rust in two days over this exact error, will have *opinions*.

**Next Lesson: Ownership** — Act 2 begins. The compiler stops being a strict teacher and becomes a wall. Then the wall starts making sense.
