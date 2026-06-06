# Lesson 17 Quiz: Collections

---
# Quiz 1
## Scenario: The Order Spike

Dan loads a lunch rush into a `Vec<String>` named `sales` — 15 orders in arrival order. He loops over it with `for dish in sales { ... }`, then prints `sales.len()` afterward — and the compiler rejects the program with E0382: *borrow of moved value*.

**Question 1:** Why did the compiler reject Dan's program?
A. A `Vec` can only be iterated once per program
B. A bare `for dish in sales` implicitly calls `.into_iter()` and MOVES the whole Vec into the loop — after the loop, `sales` is gone, so `sales.len()` uses a moved value
C. `.len()` requires the Vec to be declared `mut`
D. The Vec was empty when `.len()` was called

**Answer:** B
**Explanation:** The bare loop consumes the Vec. The fix is one character: `for dish in &sales` borrows instead, and the Vec is still usable afterward. Default to the `&`.

---

**Question 2:** `sales` has 15 elements. What is the difference between `sales[100]` and `sales.get(100)`?
A. Both return `None`
B. `sales[100]` PANICS at runtime ("index out of bounds: the len is 15 but the index is 100"); `sales.get(100)` returns `Option<&T>` — here `None`, a value you `match` instead of a crash you apologize for
C. Both panic — there is no safe way to index a Vec
D. `sales[100]` returns an empty String; `sales.get(100)` returns an error code

**Answer:** B
**Explanation:** Square brackets are the panicky read; `.get(i)` asks politely and answers with an `Option`. A missing index becomes a handled arm, not a crash in front of Tita Malou.

---

**Question 3:** One last customer slides in at 12:58 PM. Which line records the sale, and what does it require?
A. `sales.push(String::from("Adobo"));` — and it only compiles because `sales` was declared with `mut`, since pushing mutates the Vec
B. `sales.append("Adobo");` — no `mut` needed, appending is read-only
C. `sales[15] = String::from("Adobo");` — square brackets grow the Vec automatically
D. Vecs are fixed-size; Dan must create a new one

**Answer:** A
**Explanation:** `.push()` grows the Vec, growth is mutation, and mutation needs `mut`. No `mut`, no push.

---

**Question 4:** When is `v[i]` square-bracket indexing acceptable at all?
A. Never — it is deprecated
B. Only when the index is provably in range, like a loop counter you control; use `.get(i)` whenever the index came from anywhere else
C. Always — it is faster and the panics are rare
D. Only on Vecs with fewer than 100 elements

**Answer:** B
**Explanation:** `sales[0]` right after building a non-empty Vec is provably safe. An index from user input, a file, or arithmetic is not — that's `.get()` territory.

---

# Quiz 2
## Scenario: The Tally Board

Dan tallies the rush with `*tally.entry(dish.clone()).or_insert(0) += 1;` inside `for dish in &sales`. It works — same counts every run. But when he prints the `HashMap` directly, the dishes come out in a different order every time he runs the program.

**Question 5:** What does `.entry(dish.clone()).or_insert(0)` hand back, making the `*... += 1` possible?
A. A copy of the count — incrementing it changes nothing in the map
B. A mutable reference (`&mut u32`) to the value in that key's slot — inserting `0` first if the slot was vacant — so the `*` dereferences it and bumps the count in place
C. An `Option<u32>` that must be matched before incrementing
D. A brand-new HashMap containing only that key

**Answer:** B
**Explanation:** One motion, no double lookup: get the slot, default it to 0 if vacant, and hand back `&mut u32`. The `*` follows the reference; `+= 1` bumps the count. THE LutoCLI idiom.

---

**Question 6:** Why does the idiom say `dish.clone()` instead of just `dish`?
A. Style preference — both compile
B. The map takes OWNERSHIP of its keys on insert, but `dish` is only *borrowed* from the Vec (the loop is `for dish in &sales`) — you can't hand the map something you don't own, so you hand it a copy
C. `.clone()` makes lookups faster later
D. HashMap keys must always be cloned, even when you own them

**Answer:** B
**Explanation:** Inserting a `String` moves it into the map — the same E0382 move rule from the Vec. Borrowed data can't be moved, so the tally clones each key. (The `u32` values are `Copy` — no ceremony needed.)

---

**Question 7:** The shuffled print order — bug or feature? And how should Dan display the tally?
A. A bug — Dan should file an issue against the standard library
B. By design: HashMaps are unordered (that's how they buy instant lookups). To display, collect the pairs into a Vec — `tally.iter().collect()` — and sort it, e.g. `.sort_by(|a, b| b.1.cmp(a.1))` for descending by count
C. A bug in Dan's `entry` line — the counts are also random
D. Dan should call `tally.sort()` to sort the HashMap in place

**Answer:** B
**Explanation:** No order is the price of instant lookup, and `HashMap` has no `.sort()`. Tally in the map, display from a sorted Vec — that division of labor is permanent. `b.1.cmp(a.1)` reads backwards on purpose: that's descending.

---
**Next:** Proceed to Lesson 17 exercises.
