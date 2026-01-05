# Comments and Documentation

## Scene: The Mystery Module

Lenard, MoveStack's documentation lead, pulls up a module on the shared screen. The room falls silent as everyone stares at three hundred lines of uncommented code.

"Who wrote this?" Lenard asks, eyebrows raised.

Jaymart sheepishly raises his hand. "It was a hackathon. I was moving fast."

"And now?" Lenard gestures at the screen. "Even you don't remember what `calc_x` does. Or why there's a magic number 42 on line 87."

Det leans forward. "Documentation isn't just for others—it's for future you. Move has built-in support for doc comments. They become part of the module's public interface."

Neri opens the Move documentation. "I've seen the `///` syntax but never really used it properly."

"Today we fix that," Lenard says. "We're going to document every public function, every constant, every struct. When someone imports our module, they should understand exactly what they're getting without reading the implementation."

"Comments are code that explains code," Det adds. "And in Move, doc comments generate actual documentation."

Jaymart sighs. "I'll rewrite `calc_x` as `calculate_weighted_average` while I'm at it."

---

## 📚 Topics & Deep Lessons

### 1️⃣ **Line Comments: Quick Explanations**

Use `//` for single-line comments that explain implementation details:

```move
module movestack::math_utils {
    public fun calculate_fee(amount: u64, rate: u64): u64 {
        // Rate is in basis points (100 = 1%)
        // Example: 250 basis points = 2.5%
        let fee = (amount * rate) / 10000;

        // Round up to avoid dust amounts
        if ((amount * rate) % 10000 > 0) {
            fee = fee + 1;
        };

        fee
    }
}
```

**When to use line comments:**

- Explain _why_, not _what_ (the code shows what)
- Clarify complex calculations
- Note edge cases and assumptions
- Mark TODOs and FIXMEs

### 2️⃣ **Block Comments: Larger Explanations**

Use `/* */` for multi-line comments:

```move
module movestack::auction {
    /*
     * Auction State Machine:
     *
     * PENDING -> ACTIVE -> ENDED
     *    |         |
     *    v         v
     * CANCELLED  SETTLED
     *
     * Transitions are one-way only.
     */

    const STATE_PENDING: u8 = 0;
    const STATE_ACTIVE: u8 = 1;
    const STATE_ENDED: u8 = 2;
    const STATE_CANCELLED: u8 = 3;
    const STATE_SETTLED: u8 = 4;
}
```

### 3️⃣ **Doc Comments: Public Interface Documentation**

Doc comments (`///`) generate documentation for your module's public API:

```move
module movestack::token {
    /// A fungible token that can be transferred between accounts.
    ///
    /// Tokens are created with a fixed supply and cannot be minted
    /// after initialization.
    struct Token has store {
        /// The number of tokens held
        amount: u64,
    }

    /// Creates a new token with the specified amount.
    ///
    /// # Arguments
    /// * `amount` - The initial token amount (must be > 0)
    ///
    /// # Returns
    /// A new Token struct with the specified amount
    ///
    /// # Aborts
    /// * `EINVALID_AMOUNT` - If amount is 0
    public fun create(amount: u64): Token {
        assert!(amount > 0, 1);
        Token { amount }
    }

    /// Returns the balance of the token.
    ///
    /// # Arguments
    /// * `token` - Reference to the token to check
    ///
    /// # Returns
    /// The token's current amount
    public fun balance(token: &Token): u64 {
        token.amount
    }
}
```

### 4️⃣ **Documenting Constants**

Always explain what constants represent:

```move
module movestack::constants {
    /// Maximum number of tokens that can ever exist.
    /// Set to 1 billion to match common token economics.
    const MAX_SUPPLY: u64 = 1_000_000_000;

    /// Minimum stake required to become a validator.
    /// Set to 100 tokens to prevent spam validators.
    const MIN_STAKE: u64 = 100;

    /// Error: The provided amount is invalid (zero or negative).
    const EINVALID_AMOUNT: u64 = 1;

    /// Error: Caller is not authorized to perform this action.
    const EUNAUTHORIZED: u64 = 2;

    /// Error: Operation would exceed system limits.
    const ELIMIT_EXCEEDED: u64 = 3;
}
```

### 5️⃣ **Function Documentation Best Practices**

Complete function documentation includes:

````move
module movestack::staking {
    /// Stakes tokens for the caller, locking them for the specified duration.
    ///
    /// This function transfers tokens from the caller's account to the
    /// staking pool and records the stake with a lock period. Staked
    /// tokens earn rewards proportional to the stake amount and duration.
    ///
    /// # Type Parameters
    /// * `CoinType` - The type of coin being staked
    ///
    /// # Arguments
    /// * `staker` - Signer of the account staking tokens
    /// * `amount` - Number of tokens to stake (must be >= MIN_STAKE)
    /// * `duration_days` - Lock period in days (7, 30, 90, or 365)
    ///
    /// # Returns
    /// A StakeReceipt that can be used to unstake after the lock period
    ///
    /// # Aborts
    /// * `EINVALID_AMOUNT` - If amount < MIN_STAKE
    /// * `EINVALID_DURATION` - If duration is not a valid option
    /// * `EINSUFFICIENT_BALANCE` - If staker doesn't have enough tokens
    ///
    /// # Example
    /// ```move
    /// let receipt = stake<APT>(&staker, 1000, 30);
    /// // After 30 days, call unstake(receipt) to retrieve tokens + rewards
    /// ```
    public fun stake<CoinType>(
        staker: &signer,
        amount: u64,
        duration_days: u64
    ): StakeReceipt {
        // Implementation
    }
}
````

### 6️⃣ **Struct and Field Documentation**

Document what each struct represents and its fields:

```move
module movestack::auction {
    /// Represents an active auction for a single item.
    ///
    /// Auctions progress through states: PENDING -> ACTIVE -> ENDED -> SETTLED.
    /// Bids can only be placed while the auction is ACTIVE.
    struct Auction has key, store {
        /// Unique identifier for this auction
        id: u64,

        /// Address of the account that created the auction
        seller: address,

        /// Minimum acceptable bid amount
        reserve_price: u64,

        /// Current highest bid (0 if no bids yet)
        highest_bid: u64,

        /// Address of the current highest bidder (seller if no bids)
        highest_bidder: address,

        /// Unix timestamp when the auction ends
        end_time: u64,

        /// Current state of the auction (see STATE_* constants)
        state: u8,
    }
}
```

### 7️⃣ **Module-Level Documentation**

Start each module with an overview:

````move
/// # MoveStack Token Module
///
/// This module implements a basic fungible token with the following features:
/// - Fixed supply set at initialization
/// - Transfer between accounts
/// - Balance queries
/// - Burn functionality (permanent supply reduction)
///
/// ## Security Considerations
/// - Only the token creator can mint initial supply
/// - Transfers require sender signature
/// - Overflow checks on all arithmetic operations
///
/// ## Usage Example
/// ```move
/// use movestack::token;
///
/// // Create a new token
/// let my_token = token::create(1000);
///
/// // Check balance
/// let bal = token::balance(&my_token);
///
/// // Transfer to another account
/// token::transfer(&mut my_token, recipient, 100);
/// ```
module movestack::token {
    // Implementation
}
````

---

## Closing Scene

Jaymart's refactored module now has proper documentation. Every function explains its purpose, parameters, and error conditions.

"Pull request approved," Lenard says. "This is how professional code looks."

Neri scrolls through the documented functions. "When I hover over `stake` in my editor, I see all the documentation. I don't have to read the implementation."

"That's the power of doc comments," Det says. "They integrate with tooling. IDEs, documentation generators, even AI assistants can use them."

Jaymart grins. "I'll never write `calc_x` again."

"Save us all the archaeology," Lenard laughs.

---

## Summary

- **Line comments** (`//`) explain implementation details—focus on _why_
- **Block comments** (`/* */`) document larger concepts or ASCII diagrams
- **Doc comments** (`///`) generate public API documentation
- Document **constants** with their purpose and valid values
- Document **functions** with arguments, returns, aborts, and examples
- Document **structs** with field-by-field explanations
- Start modules with **overview documentation**
- Good documentation saves time for you and your team
