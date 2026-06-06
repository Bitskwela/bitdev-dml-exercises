## Dan's Story: The Chalkboard Window

Five-fifty in the morning, the carinderia still dark except for the kitchen bulb. Tita Malou was at the menu board with chalk in hand, doing her Monday rewrite.

> **Tita Malou:** Anak, "Sinigang na Baboy" — hindi kasya kung isusulat ko pa ang presyo sa tabi. "Sinigang" na lang sa board.
>
> **Dan:** Sige, Ma. I'll shorten it in the program too, so they match —
>
> **Tita Malou:** Teka, hindi. Sa board lang. Sa records mo, buong pangalan pa rin. Ayokong may dalawang spelling na aalagaan.

Dan's first instinct was pure muscle memory: make a second `String`, copy the first word into it, done. Then Lesson 10 tapped him on the shoulder — a copy means two strings to keep in sync, the exact thing his mother just said she refuses to do, in fifteen years of running this place.

> **Dan:** So the board isn't a second list. It's... a view of the real one.
>
> **Tita Malou:** Bahala ka sa terms mo. Basta isa lang ang totoo, at ang board ay sulyap lang doon.

*A glance at the real thing.* His mom had just defined a slice in one sentence — and added a requirement: she's hiring a weekend helper, so show her the weekend kita versus Lunes-to-Biyernes before she promises a sweldo. Old Dan would have copied the week's seven revenues into `weekday_revs` and `weekend_revs` and prayed they stayed in sync. New Dan wanted what the chalkboard had: two windows onto one array. The Rust book answered in ten minutes — **slices**: `&dish[0..8]` to view the first word, `&revenues[0..5]` to view the weekdays. Borrowed windows, just like yesterday's `&`, but with a start and an end drawn on.

Then, because the morning was going *too* well, Dan decided his mother deserved the real peso sign. He typed `"₱95"`, tried to peel off the first character with `&price_tag[0..1]`, and ran it. The program *compiled*. Green. And then it crashed anyway — his first runtime crash since switching languages, with the most precise crash report he'd ever read: *it is inside '₱'*. Inside? Since when does a character have an inside?

---

## The Concept: Slices Are Borrowed Views

### A Window, Not a Copy (`&str`, `&[T]`)

A **slice** is a borrow of a *contiguous chunk* of data someone else owns. Under the hood it is exactly two things: a pointer to where the chunk starts, and a length. No data is copied — ever.

```rust
let dish = String::from("Sinigang na Baboy");
let label = &dish[0..8]; // "Sinigang" — a view, not a new String
```

Two slice types matter today: **`&str`**, a view into string data, and **`&[T]`**, a view into an array or `Vec` (for us, `&[u32]`). And because a slice *is* a borrow, every Lesson 10 rule applies unchanged: while `label` is alive it's a registered reader, so nobody can take a `&mut dish` and rewrite the string out from under the window. Many readers XOR one writer — slices are readers with edges.

### Range Syntax

Ranges in slice brackets are **half-open**: the start is included, the end is not. `[0..5]` means indices 0, 1, 2, 3, 4 — five elements, end minus start. Rust lets you drop the obvious parts:

| You write | It means |
|---|---|
| `&revenues[0..5]` | indices 0 through 4 — "from 0 up to (not including) 5" |
| `&revenues[..5]` | same as `[0..5]` — "from the start to 5" |
| `&revenues[5..]` | indices 5 to the end |
| `&revenues[..]` | the whole thing, as a slice |

### Bytes, Not Characters

The morning's hard lesson: **string slice ranges count bytes, not characters.** Rust strings are UTF-8, and the peso sign `₱` is **three bytes**. That's why `"₱95".len()` is 5, not 3, and why `&price_tag[0..1]` tried to cut the `₱` into pieces:

```text
thread 'main' (101888) panicked at src\main.rs:3:26:
end byte index 1 is not a char boundary; it is inside '₱' (bytes 0..3) of `₱95`
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
```

The compiler can't catch this, because the *content* of a string is a runtime fact — so this one bug class survives to runtime, and Rust handles it the honest way: an immediate, loud, precisely-worded panic instead of silently serving garbled bytes. The practical rule that keeps you safe: **don't invent string slice numbers — let string methods hand them to you.** `.find(' ')` returns the byte index of a space, and a space is always a valid boundary — indices that come from `.find()` are safe by construction. (Array slices have no such drama: `&[u32]` indices count elements, and a `u32` can't be half-cut.)
