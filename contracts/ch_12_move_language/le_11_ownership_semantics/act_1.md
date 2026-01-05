## Smart contract activity

```move
module movestack::ownership_practice {
    // ============================================
    // STRUCT DEFINITIONS
    // ============================================

    // TODO: Define a struct called 'Token' with:
    //       - amount: u64
    // Do NOT add 'copy' ability - tokens should move, not copy!

    // TODO: Define a struct called 'Counter' with:
    //       - has copy, drop abilities
    //       - value: u64

    // ============================================
    // OWNERSHIP TRANSFER FUNCTIONS
    // ============================================

    // TODO: Create 'create_token'
    // Takes amount: u64, returns Token

    // TODO: Create 'consume_token'
    // Takes Token, returns the amount as u64

    // TODO: Create 'transfer_token'
    // Takes Token, returns Token (pass-through)

    // ============================================
    // VALUE MANIPULATION
    // ============================================

    // TODO: Create 'split_token'
    // Takes Token and split_amount: u64
    // Returns (Token, Token) - remaining and split portions

    // TODO: Create 'merge_tokens'
    // Takes two Tokens, returns one combined Token

    // ============================================
    // COPY VS MOVE DEMONSTRATION
    // ============================================

    // TODO: Create 'demonstrate_copy'
    // Create Counter, assign to another variable (copies!)
    // Return sum of both values (should be 20)

    // TODO: Create 'demonstrate_move'
    // Create Token, transfer to another variable (moves!)
    // Return amount from the new variable only
}
```

## Tasks for Learners

- Define `Token` without the `copy` ability. This ensures tokens move when assigned and cannot be duplicated:

  ```move
  struct Token { amount: u64 }
  ```

- Define `Counter` with `copy` and `drop` abilities. This allows the value to be copied and silently discarded:

  ```move
  struct Counter has copy, drop { value: u64 }
  ```

- Create ownership transfer functions. When a function takes a struct without `copy`, ownership transfers in:

  ```move
  public fun create_token(amount: u64): Token {
      Token { amount }
  }

  public fun consume_token(token: Token): u64 {
      let Token { amount } = token;
      amount
  }

  public fun transfer_token(token: Token): Token {
      token
  }
  ```

- Create `split_token` that consumes one token and produces two. Use destructuring to access the amount:

  ```move
  public fun split_token(token: Token, split_amount: u64): (Token, Token) {
      let Token { amount } = token;
      assert!(split_amount <= amount, 0);

      let remaining = Token { amount: amount - split_amount };
      let split = Token { amount: split_amount };

      (remaining, split)
  }
  ```

- Create `merge_tokens` that consumes two tokens and produces one combined token:

  ```move
  public fun merge_tokens(token1: Token, token2: Token): Token {
      let Token { amount: amount1 } = token1;
      let Token { amount: amount2 } = token2;

      Token { amount: amount1 + amount2 }
  }
  ```

- Demonstrate the difference between copy and move behavior:

  ```move
  public fun demonstrate_copy(): u64 {
      let counter = Counter { value: 10 };
      let copied = counter;  // COPIES! counter is still valid

      counter.value + copied.value  // Returns 20
  }

  public fun demonstrate_move(): u64 {
      let token = create_token(100);
      let moved = token;  // MOVES! token is no longer valid

      let Token { amount } = moved;
      amount  // Returns 100
  }
  ```

### Breakdown for Learners

**Move vs Copy:** In Move, the default behavior for structs is to _move_ (transfer ownership). When you assign a struct to another variable, the original becomes invalid. The `copy` ability changes this to duplicate the value instead.

**Abilities Control Behavior:**

- No abilities: Must be explicitly moved and consumed
- `copy`: Can be duplicated on assignment
- `drop`: Can be silently discarded (otherwise must be destructured)
- `key`, `store`: Related to global storage (covered later)

**Destructuring:** To consume a struct without `drop`, you must destructure it: `let Token { amount } = token;`. This extracts the fields and destroys the struct.

**Why Move Semantics?** Move semantics prevent accidental duplication of valuable resources. A token representing real value should only exist in one place—you can't spend the same money twice. The compiler enforces this automatically.
