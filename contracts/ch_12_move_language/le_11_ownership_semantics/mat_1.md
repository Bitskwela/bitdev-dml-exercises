# Ownership Semantics

## Scene: The Disappearing Variable

Neri stares at her monitor, frustration etched on her face. The MoveStack office hums with the usual afternoon activity, but her focus has narrowed to a single compiler error that refuses to make sense.

"Det, I don't get it." She points at her screen. "I assigned `spell_power` to `backup_power`, and now the compiler says `spell_power` doesn't exist anymore. In JavaScript, this would just... work."

Det rolls his chair over, coffee mug in hand. "Ah, you've hit the heart of Move. What you're seeing isn't a bug—it's the language protecting you."

He gestures at the code. "When you wrote `let backup_power = spell_power`, the value didn't copy. It _moved_. The ownership transferred from `spell_power` to `backup_power`."

"So `spell_power` is just... gone?" Neri asks, incredulous.

"Exactly," Det nods. "Move enforces single ownership. One value, one owner, at any given time. When you assign a value to a new variable, the old variable surrenders its ownership. It's consumed."

Neri leans back, processing. "So every time I pass a value to a function, or assign it somewhere else, I'm giving it away permanently?"

"Unless the type has the `copy` ability," Det confirms. "Primitive types like `u64` and `bool` have `copy` built-in, so they duplicate automatically. But structs? By default, they move. And that's exactly what makes Move secure—you can't accidentally create two references to the same token or asset."

"It's like handing someone a book," Det continues. "Once you give it away, you can't read it anymore unless they give it back."

Neri's eyes widen. "So Move literally enforces that you can't double-spend a token because the original variable stops existing!"

"Now you're getting it."

---

## Topics

### Move Semantics: Values Have One Home

In Move, every value has exactly one owner. When you assign a value to a new variable, the value _moves_ to the new owner, and the original variable becomes invalid.

```move
module movestack::ownership_demo {
    public fun show_move() {
        let original = 42u64;  // 'original' owns 42
        let new_home = original;  // 42 MOVES to 'new_home'

        // 'original' is now invalid!
        // let x = original;  // ❌ ERROR: 'original' was moved

        let _result = new_home;  // ✅ 'new_home' owns the value
    }
}
```

This prevents:

- **Double-spending**: A token can't exist in two places
- **Use-after-free bugs**: You can't access something that's gone
- **Data races**: No two owners can modify the same data simultaneously

### Move vs Copy: When Values Duplicate vs Transfer

Not all types move. Types with the `copy` ability automatically duplicate when assigned:

```move
module movestack::copy_vs_move {
    // Struct WITHOUT copy ability - values MOVE
    struct Token has drop { amount: u64 }

    // Struct WITH copy ability - values COPY
    struct Counter has copy, drop { count: u64 }

    public fun demonstrate_difference() {
        // Token MOVES (no copy ability)
        let token = Token { amount: 100 };
        let moved_token = token;  // token is now INVALID
        // let x = token.amount;  // ❌ ERROR: token was moved

        // Counter COPIES (has copy ability)
        let counter = Counter { count: 5 };
        let copied_counter = counter;  // counter is STILL VALID
        let _x = counter.count;  // ✅ counter still exists!
        let _y = copied_counter.count;  // ✅ copied_counter also exists!
    }
}
```

Key insight: Primitives (`u8`, `u64`, `bool`, `address`) have `copy` by default. Custom structs do NOT unless you add `has copy`.

### Ownership Transfer in Function Calls

When you pass a value to a function, ownership transfers to that function. The caller loses access:

```move
module movestack::function_ownership {
    struct SpellBook has drop { pages: u64 }

    // This function TAKES ownership of the book
    public fun consume_book(book: SpellBook): u64 {
        book.pages  // Function owns 'book', can use it
        // When function ends, 'book' is destroyed
    }

    // This function takes ownership and RETURNS it
    public fun borrow_and_return(book: SpellBook): SpellBook {
        // Use the book...
        book  // Return ownership to caller
    }

    public fun caller_example() {
        let my_book = SpellBook { pages: 100 };

        // Give away the book forever
        let _pages = consume_book(my_book);
        // my_book is now INVALID - consumed by the function

        let another_book = SpellBook { pages: 200 };

        // Give and get back
        let returned_book = borrow_and_return(another_book);
        // another_book is INVALID, but returned_book holds the value
        let _p = returned_book.pages;  // ✅ Works!
    }
}
```

### Destructuring: Consuming Values by Taking Them Apart

One way to "consume" a struct is to destructure it—extracting its fields:

```move
module movestack::destructuring {
    struct Treasure has drop { gold: u64, gems: u64 }

    public fun open_treasure(chest: Treasure): (u64, u64) {
        // Destructure the chest - this consumes it
        let Treasure { gold, gems } = chest;

        // chest no longer exists - it was taken apart
        // But we have its contents!
        (gold, gems)
    }

    public fun selective_extract(chest: Treasure): u64 {
        // Extract only gold, discard gems with _
        let Treasure { gold, gems: _ } = chest;
        gold
    }
}
```

### Practical Patterns: Designing for Ownership

Understanding ownership helps you design safer contracts:

```move
module movestack::safe_patterns {
    struct WalletBalance has drop { amount: u64 }

    // Pattern 1: Transform and return (preserve ownership chain)
    public fun add_bonus(wallet: WalletBalance, bonus: u64): WalletBalance {
        let WalletBalance { amount } = wallet;
        WalletBalance { amount: amount + bonus }
    }

    // Pattern 2: Split value (one becomes two)
    public fun split_balance(
        wallet: WalletBalance,
        split_amount: u64
    ): (WalletBalance, WalletBalance) {
        let WalletBalance { amount } = wallet;
        assert!(split_amount <= amount, 0);

        let remaining = WalletBalance { amount: amount - split_amount };
        let split = WalletBalance { amount: split_amount };

        (remaining, split)
    }

    // Pattern 3: Merge values (two become one)
    public fun merge_balances(
        w1: WalletBalance,
        w2: WalletBalance
    ): WalletBalance {
        let WalletBalance { amount: a1 } = w1;
        let WalletBalance { amount: a2 } = w2;

        WalletBalance { amount: a1 + a2 }
    }
}
```

---

## Closing Scene: The Aha Moment

Neri refactors her code, this time intentionally using the ownership system to her advantage.

"Det, look at this!" She spins her monitor toward him. "I designed my `transfer_token` function to take ownership of the source token and return a new token to the recipient. There's no way to accidentally keep both copies."

Det smiles. "You've internalized the mental model. The compiler isn't fighting you—it's your partner. When you design with ownership in mind, the type system proves your code is correct."

"It felt frustrating at first," Neri admits. "But now I see it. Every time I had to think about where my value went, I was actually thinking about the safety of my program."

"That's the Move philosophy," Det says. "Make the safe path the only path."

---

## Summary

| Concept                | Description                                                       |
| ---------------------- | ----------------------------------------------------------------- |
| **Move Semantics**     | Values transfer ownership when assigned; original becomes invalid |
| **Copy Ability**       | Types with `copy` duplicate automatically instead of moving       |
| **Function Ownership** | Passing to a function transfers ownership to that function        |
| **Destructuring**      | Breaking apart a struct consumes it but yields its fields         |
| **Single Ownership**   | Every value has exactly one owner at any time                     |

Move's ownership model isn't a limitation—it's a safety guarantee. The compiler ensures you can never accidentally duplicate assets, access invalid data, or create the subtle bugs that plague other languages. Embrace the move!
