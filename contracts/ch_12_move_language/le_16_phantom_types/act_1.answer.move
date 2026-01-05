module movestack::currency {
    // ============================================
    // ERROR CODES
    // ============================================

    /// Cannot split more than token contains
    const E_INSUFFICIENT_AMOUNT: u64 = 1;

    // ============================================
    // MARKER TYPES (Type Tags)
    // Empty structs that serve as compile-time markers
    // ============================================

    /// Marker for Gold currency
    struct Gold {}

    /// Marker for Silver currency
    struct Silver {}

    /// Marker for Gem currency
    struct Gem {}

    // ============================================
    // TOKEN STRUCT WITH PHANTOM TYPE
    // ============================================

    /// Generic token that can represent any currency.
    /// The Currency parameter is phantom - it exists only for type safety.
    /// At runtime, Token<Gold> and Token<Silver> are identical structs.
    struct Token<phantom Currency> has store, drop, copy {
        amount: u64
    }

    // ============================================
    // CREATION FUNCTIONS
    // ============================================

    /// Create a new Gold token.
    /// 
    /// # Arguments
    /// * `amount` - The amount of gold
    /// 
    /// # Returns
    /// A Token<Gold> with the specified amount
    public fun create_gold(amount: u64): Token<Gold> {
        Token<Gold> { amount }
    }

    /// Create a new Silver token.
    /// 
    /// # Arguments
    /// * `amount` - The amount of silver
    /// 
    /// # Returns
    /// A Token<Silver> with the specified amount
    public fun create_silver(amount: u64): Token<Silver> {
        Token<Silver> { amount }
    }

    /// Create a new Gem token.
    /// 
    /// # Arguments
    /// * `amount` - The amount of gems
    /// 
    /// # Returns
    /// A Token<Gem> with the specified amount
    public fun create_gem(amount: u64): Token<Gem> {
        Token<Gem> { amount }
    }

    /// Generic creation function for any currency type.
    /// 
    /// # Type Parameters
    /// * `Currency` - The phantom type marker for the currency
    /// 
    /// # Arguments
    /// * `amount` - The amount to create
    /// 
    /// # Returns
    /// A Token<Currency> with the specified amount
    public fun create<Currency>(amount: u64): Token<Currency> {
        Token<Currency> { amount }
    }

    // ============================================
    // VIEW FUNCTIONS
    // ============================================

    /// Get the amount from any token type.
    /// 
    /// # Type Parameters
    /// * `Currency` - Inferred from the token
    /// 
    /// # Arguments
    /// * `token` - Reference to the token
    /// 
    /// # Returns
    /// The token's amount
    public fun get_amount<Currency>(token: &Token<Currency>): u64 {
        token.amount
    }

    /// Check if a token is empty (zero amount).
    /// 
    /// # Type Parameters
    /// * `Currency` - Inferred from the token
    /// 
    /// # Arguments
    /// * `token` - Reference to the token
    /// 
    /// # Returns
    /// True if amount is zero
    public fun is_empty<Currency>(token: &Token<Currency>): bool {
        token.amount == 0
    }

    // ============================================
    // TOKEN OPERATIONS
    // ============================================

    /// Merge two tokens of the SAME currency type.
    /// The compiler enforces that both tokens have the same Currency type.
    /// 
    /// # Type Parameters
    /// * `Currency` - The currency type (must match for both tokens)
    /// 
    /// # Arguments
    /// * `a` - First token (consumed)
    /// * `b` - Second token (consumed)
    /// 
    /// # Returns
    /// A new token with the combined amount
    public fun merge<Currency>(
        a: Token<Currency>, 
        b: Token<Currency>
    ): Token<Currency> {
        let combined_amount = a.amount + b.amount;
        Token<Currency> { amount: combined_amount }
    }

    /// Split a token into two parts.
    /// 
    /// # Type Parameters
    /// * `Currency` - The currency type
    /// 
    /// # Arguments
    /// * `token` - The token to split (consumed)
    /// * `split_amount` - Amount for the first returned token
    /// 
    /// # Returns
    /// Tuple of (token with split_amount, token with remainder)
    /// 
    /// # Aborts
    /// * `E_INSUFFICIENT_AMOUNT` - If split_amount > token amount
    public fun split<Currency>(
        token: Token<Currency>,
        split_amount: u64
    ): (Token<Currency>, Token<Currency>) {
        assert!(split_amount <= token.amount, E_INSUFFICIENT_AMOUNT);
        
        let remainder = token.amount - split_amount;
        (
            Token<Currency> { amount: split_amount },
            Token<Currency> { amount: remainder }
        )
    }

    /// Extract all value from a token, returning the amount.
    /// The token is consumed (dropped).
    /// 
    /// # Type Parameters
    /// * `Currency` - The currency type
    /// 
    /// # Arguments
    /// * `token` - The token to consume
    /// 
    /// # Returns
    /// The amount that was in the token
    public fun destroy<Currency>(token: Token<Currency>): u64 {
        let Token { amount } = token;
        amount
    }

    /// Create an empty token (zero amount).
    /// 
    /// # Type Parameters
    /// * `Currency` - The currency type for the empty token
    /// 
    /// # Returns
    /// A token with zero amount
    public fun zero<Currency>(): Token<Currency> {
        Token<Currency> { amount: 0 }
    }

    // ============================================
    // TESTS
    // ============================================

    #[test]
    fun test_create_different_currencies() {
        let gold = create_gold(100);
        let silver = create_silver(200);
        let gem = create_gem(50);
        
        assert!(get_amount(&gold) == 100, 0);
        assert!(get_amount(&silver) == 200, 1);
        assert!(get_amount(&gem) == 50, 2);
    }

    #[test]
    fun test_generic_create() {
        let gold: Token<Gold> = create<Gold>(100);
        let silver: Token<Silver> = create<Silver>(200);
        
        assert!(get_amount(&gold) == 100, 0);
        assert!(get_amount(&silver) == 200, 1);
    }

    #[test]
    fun test_merge_same_type() {
        let gold1 = create_gold(100);
        let gold2 = create_gold(50);
        
        let combined = merge(gold1, gold2);
        assert!(get_amount(&combined) == 150, 0);
    }

    #[test]
    fun test_merge_silver() {
        let s1 = create_silver(30);
        let s2 = create_silver(70);
        
        let combined = merge(s1, s2);
        assert!(get_amount(&combined) == 100, 0);
    }

    // This test demonstrates compile-time type safety
    // Uncommenting would cause a compile error:
    // #[test]
    // fun test_cannot_merge_different_types() {
    //     let gold = create_gold(100);
    //     let silver = create_silver(50);
    //     
    //     // This would be a COMPILE ERROR - types don't match!
    //     let mixed = merge(gold, silver);
    // }

    #[test]
    fun test_split() {
        let gold = create_gold(100);
        let (part1, part2) = split(gold, 30);
        
        assert!(get_amount(&part1) == 30, 0);
        assert!(get_amount(&part2) == 70, 1);
    }

    #[test]
    fun test_split_all() {
        let silver = create_silver(50);
        let (all, empty) = split(silver, 50);
        
        assert!(get_amount(&all) == 50, 0);
        assert!(get_amount(&empty) == 0, 1);
        assert!(is_empty(&empty), 2);
    }

    #[test]
    #[expected_failure(abort_code = E_INSUFFICIENT_AMOUNT)]
    fun test_split_too_much_fails() {
        let gold = create_gold(100);
        let (_part1, _part2) = split(gold, 150);  // Can't split 150 from 100
    }

    #[test]
    fun test_is_empty() {
        let empty_gold = create_gold(0);
        let some_gold = create_gold(1);
        
        assert!(is_empty(&empty_gold), 0);
        assert!(!is_empty(&some_gold), 1);
    }

    #[test]
    fun test_zero() {
        let zero_gem: Token<Gem> = zero<Gem>();
        assert!(is_empty(&zero_gem), 0);
        assert!(get_amount(&zero_gem) == 0, 1);
    }

    #[test]
    fun test_destroy() {
        let gold = create_gold(100);
        let amount = destroy(gold);
        assert!(amount == 100, 0);
    }

    #[test]
    fun test_complex_operations() {
        // Create initial tokens
        let g1 = create_gold(100);
        let g2 = create_gold(50);
        let g3 = create_gold(25);
        
        // Merge first two
        let combined = merge(g1, g2);
        assert!(get_amount(&combined) == 150, 0);
        
        // Merge with third
        let total = merge(combined, g3);
        assert!(get_amount(&total) == 175, 1);
        
        // Split off 100
        let (spent, remaining) = split(total, 100);
        assert!(get_amount(&spent) == 100, 2);
        assert!(get_amount(&remaining) == 75, 3);
    }

    #[test]
    fun test_token_is_copyable() {
        let gold = create_gold(100);
        
        // Because Token has 'copy' ability, we can copy it
        let gold_copy = gold;
        
        // Both still valid
        assert!(get_amount(&gold) == 100, 0);
        assert!(get_amount(&gold_copy) == 100, 1);
    }

    #[test]
    fun test_phantom_doesnt_affect_abilities() {
        // Gold marker has no abilities
        // But Token<Gold> still has copy, drop, store
        // because Gold is a phantom parameter
        
        let gold = create_gold(100);
        let _copy = gold;        // copy works
        let _ = gold;            // drop works (implicit)
    }
}
