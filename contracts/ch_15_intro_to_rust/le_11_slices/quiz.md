# Lesson 11 Quiz: Slices

---
# Quiz 1
## Scenario: The Chalkboard Window

Tita Malou wants "Sinigang" on the menu board but "Sinigang na Baboy" in the records — one source of truth, with the board as a glance at it. Dan reaches for slices.

**Question 1:** What IS a slice, under the hood?
A. A new, smaller copy of the original data
B. A pointer to where the chunk starts plus a length — a borrowed view into data someone else owns, with nothing copied
C. A special kind of `String` that auto-shrinks
D. An index number stored in the original array

**Answer:** B
**Explanation:** A slice is exactly two things: a pointer and a length. `&dish[0..8]` copies nothing — it's a window drawn onto data that `dish` still owns. Tita Malou's chalkboard, not a second ledger.

---

**Question 2:** `revenues` holds seven days, Mon..Sun. What does `&revenues[0..5]` view?
A. Indices 0 through 5 — six elements, Mon..Sat
B. Indices 0 through 4 — five elements, Mon..Fri, because ranges are half-open: start included, end excluded
C. Five random elements
D. It does not compile — you must write `&revenues[0..=5]` instead

**Answer:** B
**Explanation:** Slice ranges are half-open: `[0..5]` means indices 0, 1, 2, 3, 4 — end minus start elements. The shorthands `&revenues[..5]` and `&revenues[5..]` mean "from the start" and "to the end."

---

**Question 3:** Given `fn first_word(s: &str) -> &str { match s.find(' ') { Some(space_at) => &s[..space_at], None => s } }`, what does `first_word("Adobo")` return?
A. An empty string — there is no space to cut at
B. It panics — `.find()` fails on strings without spaces
C. The whole string `"Adobo"` — the `None` arm says "no space? the word IS the string," and it's still a window into the caller's data, not a copy
D. `Some("Adobo")` — the caller must unwrap it

**Answer:** C
**Explanation:** `.find(' ')` returns `None` when there's no space anywhere, and the `None` arm hands back `s` itself. Either arm returns a borrowed view into the caller's string — no copy, no second spelling to maintain.

---

**Question 4:** Dan writes his label helper as `fn shorten(s: &String) -> &str`. Which callers break that would have worked with `s: &str`?
A. None — `&String` and `&str` are interchangeable
B. String literals like `"Lechon Kawali"` and slices like `&dish[0..8]` are both rejected; only `&String` fits. With `&str`, all three work, because deref coercion converts `&String` to `&str` at the call site
C. Only `String` values break; literals work fine
D. Everything breaks — `&String` is not a valid parameter type

**Answer:** B
**Explanation:** `&str` is the flexible signature: a `String` (via deref coercion), a literal, or another slice all fit. `&String` accepts only `&String` — and costs you the other two callers for nothing in return.

---

# Quiz 2
## Scenario: The ₱ Panic

Dan types `let price_tag = "₱95";` and tries to peel off the peso sign with `&price_tag[0..1]`. The program compiles green — then dies at runtime: `byte index 1 is not a char boundary; it is inside '₱' (bytes 0..3) of `₱95``.

**Question 5:** Why did this compile but panic at runtime?
A. The compiler had a bug — this should have been caught
B. String slice ranges count BYTES, not characters. `₱` is three bytes in UTF-8, so byte index 1 lands inside the character — and Rust panics rather than silently serving garbled bytes
C. `₱` is not allowed in Rust strings; only ASCII works
D. The range `[0..1]` is always invalid — ranges must contain at least two indices

**Answer:** B
**Explanation:** Rust strings are UTF-8, and `"₱95".len()` is 5, not 3. The compiler can't check this because the content of a string is a runtime fact — so Rust handles it the honest way: an immediate, precisely-worded panic naming the character, its byte range, and the string.

---

**Question 6:** What is the practical rule that keeps string slicing safe from char-boundary panics?
A. Never slice strings — always clone them instead
B. Only use strings without special characters
C. Don't invent slice numbers — get indices from string methods like `.find(' ')`, which return byte indices that always land on valid boundaries
D. Wrap every slice in a `match` to catch the panic

**Answer:** C
**Explanation:** A space is always a valid one-byte boundary, so indices that come from `.find()` are safe by construction. (Array slices have no such drama: `&[u32]` indices count elements, and a `u32` can't be half-cut.)

---

**Question 7:** Dan needs ONE function to total the weekdays (a 5-element view), the weekend (a 2-element view), and the whole 7-element array. Which signature serves all three callers, and why?
A. `fn total(days: [u32; 7]) -> u32` — arrays are the most general type
B. `fn total(days: &Vec<u32>) -> u32` — everything converts to Vec
C. `fn total(days: &[u32]) -> u32` — a slice parameter accepts a view of any length and the whole array (`&revenues` coerces from `[u32; 7]`), with nothing copied or moved on the way in
D. He must write three functions — Rust functions can't accept different lengths

**Answer:** C
**Explanation:** `&[u32]` doesn't care how long the window is or what it was cut from: an array, a `Vec`, or another slice all fit. `[u32; 7]` would reject both windows, and `&Vec<u32>` would reject the array. One function, three calls, zero copies.

---
**Next:** Proceed to Lesson 11 exercises.
