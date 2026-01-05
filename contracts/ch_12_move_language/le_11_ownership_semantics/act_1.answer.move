module movestack::ownership_practice {
    // ============================================
    // STRUCT DEFINITIONS
    // ============================================
    
    /// A token that represents value - cannot be copied!
    /// Without the 'copy' ability, this struct MOVES when assigned.
    /// Without the 'drop' ability, it must be explicitly consumed.
    struct Token { amount: u64 }

    /// A counter that CAN be copied.
    /// With 'copy', assignments create duplicates.
    /// With 'drop', the value can be silently discarded.
    struct Counter has copy, drop { value: u64 }

    // ============================================
    // OWNERSHIP TRANSFER FUNCTIONS
    // ============================================

    /// Creates a new Token with the specified amount.
    /// The caller receives ownership of the returned Token.
    public fun create_token(amount: u64): Token {
        Token { amount }
    }

    /// Consumes a Token and returns its amount.
    /// The Token is destroyed through destructuring.
    /// After this function, the Token no longer exists.
    public fun consume_token(token: Token): u64 {
        let Token { amount } = token;
        amount
    }

    /// Transfers a Token by taking and returning ownership.
    /// Demonstrates that ownership can pass through functions.
    public fun transfer_token(token: Token): Token {
        // Simply return the token - ownership transfers to caller
        token
    }

    // ============================================
    // VALUE MANIPULATION
    // ============================================

    /// Splits one Token into two Tokens.
    /// The original token is consumed (destroyed).
    /// Two new tokens are created with the split amounts.
    public fun split_token(token: Token, split_amount: u64): (Token, Token) {
        let Token { amount } = token;
        assert!(split_amount <= amount, 0);
        
        let remaining = Token { amount: amount - split_amount };
        let split = Token { amount: split_amount };
        
        (remaining, split)
    }

    /// Merges two Tokens into one Token.
    /// Both input tokens are consumed (destroyed).
    /// A new token with the combined amount is created.
    public fun merge_tokens(token1: Token, token2: Token): Token {
        let Token { amount: amount1 } = token1;
        let Token { amount: amount2 } = token2;
        
        Token { amount: amount1 + amount2 }
    }

    // ============================================
    // COPY VS MOVE DEMONSTRATION
    // ============================================

    /// Demonstrates copy behavior with Counter.
    /// Because Counter has 'copy', assignment duplicates the value.
    /// Both variables remain valid after assignment.
    public fun demonstrate_copy(): u64 {
        let counter = Counter { value: 10 };
        let copied = counter;  // COPIES! counter is still valid
        
        // Both counter and copied exist independently
        counter.value + copied.value  // Returns 20
    }

    /// Demonstrates move behavior with Token.
    /// Because Token lacks 'copy', assignment moves the value.
    /// The original variable becomes invalid after assignment.
    public fun demonstrate_move(): u64 {
        let token = Token { amount: 100 };
        let moved = token;  // MOVES! token is now invalid
        
        // We can only use 'moved', not 'token'
        let Token { amount } = moved;
        amount  // Returns 100
    }

    // ============================================
    // BONUS: Advanced ownership patterns
    // ============================================

    /// Adds a bonus to a token, returning a new token.
    /// Demonstrates the transform-and-return pattern.
    public fun add_bonus(token: Token, bonus: u64): Token {
        let Token { amount } = token;
        Token { amount: amount + bonus }
    }

    /// Checks if a token has enough balance.
    /// Note: We must return the token since we can't drop it!
    public fun check_balance(token: Token, required: u64): (Token, bool) {
        let has_enough = token.amount >= required;
        (token, has_enough)
    }

    // ============================================
    // TESTS
    // ============================================

    #[test]
    fun test_create_token() {
        let token = create_token(100);
        let amount = consume_token(token);
        assert!(amount == 100, 0);
    }

    #[test]
    fun test_consume_token() {
        let token = create_token(50);
        let result = consume_token(token);
        assert!(result == 50, 0);
    }

    #[test]
    fun test_transfer_token() {
        let original = create_token(75);
        let transferred = transfer_token(original);
        let amount = consume_token(transferred);
        assert!(amount == 75, 0);
    }

    #[test]
    fun test_split_token() {
        let token = create_token(100);
        let (remaining, split) = split_token(token, 30);
        
        let remaining_amount = consume_token(remaining);
        let split_amount = consume_token(split);
        
        assert!(remaining_amount == 70, 0);
        assert!(split_amount == 30, 1);
    }

    #[test]
    fun test_merge_tokens() {
        let token1 = create_token(40);
        let token2 = create_token(60);
        let merged = merge_tokens(token1, token2);
        
        let amount = consume_token(merged);
        assert!(amount == 100, 0);
    }

    #[test]
    fun test_demonstrate_copy() {
        let result = demonstrate_copy();
        assert!(result == 20, 0);
    }

    #[test]
    fun test_demonstrate_move() {
        let result = demonstrate_move();
        assert!(result == 100, 0);
    }

    #[test]
    fun test_add_bonus() {
        let token = create_token(100);
        let boosted = add_bonus(token, 25);
        let amount = consume_token(boosted);
        assert!(amount == 125, 0);
    }

    #[test]
    fun test_check_balance() {
        let token = create_token(100);
        let (returned_token, has_enough) = check_balance(token, 50);
        assert!(has_enough == true, 0);
        
        let (returned_token2, not_enough) = check_balance(returned_token, 200);
        assert!(not_enough == false, 1);
        
        // Consume the token to satisfy the compiler
        let _ = consume_token(returned_token2);
    }

    #[test]
    #[expected_failure]
    fun test_split_token_fails_on_overflow() {
        let token = create_token(50);
        let (_remaining, _split) = split_token(token, 100);  // Should fail!
    }
}
