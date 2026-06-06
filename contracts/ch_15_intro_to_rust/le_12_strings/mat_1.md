## Dan's Story: Receipt-Printing Day

Mid-morning lull at the carinderia. An office three streets over had placed a catering order — and offices, unlike tricycle drivers, want *receipts*. Dan saw his opening: the program could print them. Clean lines, correct totals, every time. One request from his mom, relayed over the rice cooker: the receipt should show the real peso sign. Not the letter P he'd been typing since Lesson 4. The actual **₱**.

Easy, Dan figured — a receipt is just strings glued together. So he glued: `let receipt = header + line;`. The compiler said no *twice*. First E0369, "cannot add `&str` to `&str`", demanding "an owned `String`" — capital S — as if there were two kinds of string. Then, after `String::from` fixed that, E0382, "borrow of moved value: `header`" — the Lesson 9 ownership error, from a *plus sign*. Dan messaged Kuya JM, who picked up on video call from the Makati office cafeteria.

> **Kuya JM:** You met the two string types. **String is the pot you own.** Bili ka ng sarili mong palayok — sa'yo yan. Lagyan mo, dagdagan mo, palakihin mo, buong araw. **`&str` is looking into someone else's pot.** Tingin ka lang. You can read everything inside, pero hindi mo mapapalakihin ang tinitinginan mo lang.
>
> **Dan:** So my literals — `"Adobo ₱75\n"` — those are... looks? And `String::from` bought me a pot. Then why did the pot disappear?
>
> **Kuya JM:** Because `+` is sneaky. It doesn't cook a new pot — it takes YOUR pot, stirs the right side into it, and hands the same pot back under a new name. Moves the left, borrows the right. What people actually use is `format!` — same syntax as `println!`, pero it hands you a brand-new String, and it only *borrows* its arguments. Walang namamatay. One last thing: type `"Halo-Halo ₱95"` and print `.len()`. Count the characters with your eyes first. Slowly.
>
> **Dan:** H-a-l-o, dash, H-a-l-o, space, peso sign, nine, five... thirteen. ...The terminal says **15**. Kuya, anong dalawang extra?
>
> **Kuya JM:** `.len()` counts bytes. And that peso sign your Ma asked for? *Three bytes*, one character. UTF-8. Welcome to receipt-printing day.

---

## The Concept: The Pot and the Look

### String vs `&str`

| | `String` | `&str` |
|---|---|---|
| Ownership | **Owns** its text | **Borrows** a view of text owned elsewhere |
| Can grow / change? | Yes — `push_str`, `push` | Never |
| Lives where? | Heap — sized at runtime, growable | Wherever the owner's data is (often the binary itself) |
| How you get one | `String::from("...")`, `.to_string()`, `format!` | Literals `"..."`, slices `&s[..n]`, a coerced `&String` |
| The framing | The pot you own | Looking into someone else's pot |

One sentence on what you'll see in error messages: a string literal's full type is `&'static str` — a view into text baked into your compiled binary, valid for the entire run of the program — and that is all `'static` means until Lesson 22.

### Creating and Growing a `String`

```rust
let mut receipt = String::from("** Tita Malou's Carinderia **\n");
receipt.push_str("Adobo ₱75\n");  // push_str appends a &str — a borrowed view
receipt.push('\n');               // push appends ONE char — single quotes
```

`String::from("...")` (or `"...".to_string()` — identical result; this course writes `String::from`) buys you your own pot, with a copy of the text inside. `push_str` borrows its argument, so whatever you append stays alive and usable; `push` is for a single `char`. Both need `mut` — you're changing your pot, and Lesson 4's rules never stopped applying.

### `format!` Is the Workhorse

Everything `println!` can do, `format!` does into a String instead of the screen:

```rust
let line = format!("{:<18} ₱{:>3}\n", "Adobo", 75);
```

Three properties make it the tool you'll reach for daily: it's **readable** (the template looks like the output), it **borrows everything** (every argument survives the call, unmoved), and it **returns a new `String`** — your own pot, ready to keep or grow. Build lines with `format!`, assemble them with `push_str`. That pair builds every receipt, report, and menu board for the rest of this course.

### `+` Moves the Left Side

`+` on strings only accepts `String + &str`, and it **moves the left side** — takes your pot, stirs in the right side, returns the same pot. Reuse the left side afterwards and this is waiting:

```text
error[E0382]: borrow of moved value: `header`
 --> src\main.rs:6:20
  |
2 |     let header = String::from("** Tita Malou's Carinderia **\n");
  |         ------ move occurs because `header` has type `String`, which does not implement the `Copy` trait
3 |     let line = "Adobo ₱75\n";
4 |     let receipt = header + line;
  |                   ------------- `header` moved due to usage in operator
5 |     println!("{}", receipt);
6 |     println!("{}", header);
  |                    ^^^^^^ value borrowed here after move
```

It's not broken; it's a move wearing a math costume, and `format!` does the same job with no casualties. After today, `+` does not appear in this course again.

### No `s[0]` — Bytes vs Characters

Rust strings are UTF-8, where a character takes one to four bytes — `H` is one, `₱` is three. So `s[0]` could honestly mean three different things: the first **byte**, the first **char**, or the first **grapheme cluster** (what a human would circle as "one character"). Rust refuses to guess, so indexing simply doesn't compile. You say what you mean instead: `.as_bytes()` for bytes, `.chars()` to walk characters, and Lesson 11's byte-range slices when you know the boundary is real.

```rust
let halo = "Halo-Halo ₱95";
halo.len();             // 15 — BYTES
halo.chars().count();   // 13 — CHARACTERS
```

`.len()` counts **bytes**; `.chars().count()` counts **characters**. They agree on pure-ASCII text and silently disagree the moment a `₱` walks in — thirteen characters, fifteen bytes, because the peso sign is one char and three bytes. If your receipt-width math uses `.len()`, your columns drift on every line with a peso sign. Count characters when you mean characters.

And memorize the rule that decides 90% of your string choices from now on: **"functions take `&str`, structs own `String`."** A `&str` parameter accepts *everything* — literals, slices, and `&String` too, because Rust quietly coerces `&String` into `&str` at the call site. When data needs to *live* somewhere long-term, the owner holds a `String`. Borrow to read, own to keep.

---

## Key Takeaways

- **`String` is the pot you own** — owned, growable, heap-allocated. **`&str` is looking into someone else's pot** — a borrowed, read-only view. Literals are `&'static str`: views into text baked into your binary.
- **Create with `String::from("...")`; grow with `push_str`** for a `&str` **and `push`** for a single `char`.
- **`format!` is the workhorse:** `println!` syntax, borrows every argument, returns a new `String`. Nothing moves, nothing dies.
- **`+` moves its left side** and only borrows the right — reuse the left and E0382 finds you. Retired today in favor of `format!`.
- **`s[0]` doesn't compile, honestly so:** in UTF-8, "first element" has three competing meanings — byte, char, grapheme cluster. Say which one you mean.
- **`.len()` counts BYTES; `.chars().count()` counts CHARACTERS.** `"Halo-Halo ₱95"` is 15 bytes but 13 characters — the peso sign is one char, three bytes.
- **The course rule: "functions take `&str`, structs own `String`."** `&String` coerces to `&str` at the call site, so a `&str` parameter welcomes everyone.

---

## What's Next?

The receipt printer works, and the peso sign prints proudly in all three of its bytes. But look at today's code with cold eyes: `dish1`, `dish2`, `dish3`, a separate parallel list of prices. Nothing in the code says "this name and this price belong to the same dish" — Dan just has to never, ever mix up an index. Tomorrow, whiteboard night at the dorm: data that belongs together finally *lives* together.

**Next Lesson: Structs** — defining `MenuItem`, fields that travel as one unit, and methods that give Dan's data its own behavior.
