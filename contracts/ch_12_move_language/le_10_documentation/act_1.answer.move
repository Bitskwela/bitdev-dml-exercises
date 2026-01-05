````move
```move
/// Math Utilities Module
/// 
/// This module provides safe arithmetic operations and common utility
/// functions for the MoveStack ecosystem. All functions are designed
/// to be safe by default, aborting on error conditions rather than
/// producing incorrect results.
/// 
/// # Usage
/// Use these functions when you need guaranteed safety for arithmetic
/// operations, especially when working with user-provided values.
/// 
/// # Safety
/// All arithmetic functions check for overflow/underflow conditions
/// and abort with descriptive error codes rather than wrapping.
module movestack::math_utils {

    // ============================================
    // CONSTANTS
    // ============================================

    /// The maximum value a u64 can hold.
    /// Useful for overflow checking: if MAX_U64 - a < b, then a + b overflows.
    const MAX_U64: u64 = 18446744073709551615;

    /// Error code: Division by zero attempted.
    /// Raised when the divisor in a division operation is zero.
    const EDIVISION_BY_ZERO: u64 = 1;

    /// Error code: Arithmetic overflow or underflow.
    /// Raised when an operation would exceed type bounds.
    const EOVERFLOW: u64 = 2;

    // ============================================
    // SAFE ARITHMETIC FUNCTIONS
    // ============================================

    /// Safely adds two u64 values with overflow protection.
    /// 
    /// # Parameters
    /// * `a` - The first operand
    /// * `b` - The second operand
    /// 
    /// # Returns
    /// The sum of `a` and `b`
    /// 
    /// # Aborts
    /// * `EOVERFLOW` - If the sum would exceed MAX_U64
    public fun safe_add(a: u64, b: u64): u64 {
        /*
         * Overflow check strategy:
         * If MAX_U64 - a < b, then a + b would overflow.
         * We perform this check before the addition to prevent
         * the overflow from ever occurring.
         */
        assert!(MAX_U64 - a >= b, EOVERFLOW);
        a + b
    }

    /// Safely subtracts b from a with underflow protection.
    /// 
    /// # Parameters
    /// * `a` - The value to subtract from
    /// * `b` - The value to subtract
    /// 
    /// # Returns
    /// The difference: a - b
    /// 
    /// # Aborts
    /// * `EOVERFLOW` - If `b` is greater than `a` (would underflow)
    public fun safe_sub(a: u64, b: u64): u64 {
        // Underflow check: ensure a >= b before subtraction
        assert!(a >= b, EOVERFLOW);
        a - b
    }

    /// Safely divides a by b with division-by-zero protection.
    /// 
    /// # Parameters
    /// * `a` - The dividend (number being divided)
    /// * `b` - The divisor (number to divide by)
    /// 
    /// # Returns
    /// The quotient: a / b (integer division, truncates toward zero)
    /// 
    /// # Aborts
    /// * `EDIVISION_BY_ZERO` - If `b` is zero
    /// 
    /// # Note
    /// This performs integer division. For example, safe_div(7, 2) returns 3.
    public fun safe_div(a: u64, b: u64): u64 {
        // Division by zero is undefined - abort immediately
        assert!(b != 0, EDIVISION_BY_ZERO);
        a / b
    }

    /// Safely multiplies two u64 values with overflow protection.
    /// 
    /// # Parameters
    /// * `a` - The first factor
    /// * `b` - The second factor
    /// 
    /// # Returns
    /// The product: a * b
    /// 
    /// # Aborts
    /// * `EOVERFLOW` - If the product would exceed MAX_U64
    public fun safe_mul(a: u64, b: u64): u64 {
        // Special case: multiplication by zero never overflows
        if (a == 0 || b == 0) {
            return 0
        };
        // Overflow check: if a > MAX_U64 / b, then a * b overflows
        assert!(a <= MAX_U64 / b, EOVERFLOW);
        a * b
    }

    // ============================================
    // UTILITY FUNCTIONS
    // ============================================

    /// Returns the larger of two u64 values.
    /// 
    /// # Parameters
    /// * `a` - First value to compare
    /// * `b` - Second value to compare
    /// 
    /// # Returns
    /// The larger of `a` and `b`. If equal, returns `a`.
    public fun max(a: u64, b: u64): u64 {
        if (a >= b) { a } else { b }
    }

    /// Returns the smaller of two u64 values.
    /// 
    /// # Parameters
    /// * `a` - First value to compare
    /// * `b` - Second value to compare
    /// 
    /// # Returns
    /// The smaller of `a` and `b`. If equal, returns `a`.
    public fun min(a: u64, b: u64): u64 {
        if (a <= b) { a } else { b }
    }

    /// Checks if a number is even.
    /// 
    /// # Parameters
    /// * `n` - The number to check
    /// 
    /// # Returns
    /// `true` if `n` is divisible by 2, `false` otherwise
    public fun is_even(n: u64): bool {
        // Use modulo operator: even numbers have remainder 0 when divided by 2
        n % 2 == 0
    }

    /// Checks if a number is odd.
    /// 
    /// # Parameters
    /// * `n` - The number to check
    /// 
    /// # Returns
    /// `true` if `n` is not divisible by 2, `false` otherwise
    public fun is_odd(n: u64): bool {
        n % 2 != 0
    }

    /// Calculates the absolute difference between two values.
    /// 
    /// # Parameters
    /// * `a` - First value
    /// * `b` - Second value
    /// 
    /// # Returns
    /// |a - b| - the positive difference between the values
    /// 
    /// # Note
    /// This never underflows since it always subtracts the smaller from larger.
    public fun abs_diff(a: u64, b: u64): u64 {
        if (a >= b) { a - b } else { b - a }
    }

    // ============================================
    // TESTS
    // ============================================

    #[test]
    fun test_safe_add_normal() {
        assert!(safe_add(5, 3) == 8, 0);
        assert!(safe_add(0, 0) == 0, 1);
        assert!(safe_add(100, 200) == 300, 2);
    }

    #[test]
    #[expected_failure(abort_code = EOVERFLOW)]
    fun test_safe_add_overflow() {
        // This should overflow and abort
        safe_add(MAX_U64, 1);
    }

    #[test]
    fun test_safe_sub_normal() {
        assert!(safe_sub(10, 3) == 7, 0);
        assert!(safe_sub(100, 100) == 0, 1);
        assert!(safe_sub(5, 0) == 5, 2);
    }

    #[test]
    #[expected_failure(abort_code = EOVERFLOW)]
    fun test_safe_sub_underflow() {
        // This should underflow and abort
        safe_sub(3, 10);
    }

    #[test]
    fun test_safe_div_normal() {
        assert!(safe_div(10, 2) == 5, 0);
        assert!(safe_div(7, 2) == 3, 1); // Integer division truncates
        assert!(safe_div(0, 5) == 0, 2);
    }

    #[test]
    #[expected_failure(abort_code = EDIVISION_BY_ZERO)]
    fun test_safe_div_by_zero() {
        // This should abort with division by zero
        safe_div(10, 0);
    }

    #[test]
    fun test_safe_mul_normal() {
        assert!(safe_mul(5, 3) == 15, 0);
        assert!(safe_mul(0, 1000) == 0, 1);
        assert!(safe_mul(1000, 0) == 0, 2);
    }

    #[test]
    #[expected_failure(abort_code = EOVERFLOW)]
    fun test_safe_mul_overflow() {
        // This should overflow: MAX_U64 * 2
        safe_mul(MAX_U64, 2);
    }

    #[test]
    fun test_max() {
        assert!(max(5, 10) == 10, 0);
        assert!(max(10, 5) == 10, 1);
        assert!(max(7, 7) == 7, 2);
    }

    #[test]
    fun test_min() {
        assert!(min(5, 10) == 5, 0);
        assert!(min(10, 5) == 5, 1);
        assert!(min(7, 7) == 7, 2);
    }

    #[test]
    fun test_is_even() {
        assert!(is_even(0) == true, 0);
        assert!(is_even(2) == true, 1);
        assert!(is_even(4) == true, 2);
        assert!(is_even(100) == true, 3);
        assert!(is_even(1) == false, 4);
        assert!(is_even(7) == false, 5);
    }

    #[test]
    fun test_is_odd() {
        assert!(is_odd(1) == true, 0);
        assert!(is_odd(7) == true, 1);
        assert!(is_odd(0) == false, 2);
        assert!(is_odd(4) == false, 3);
    }

    #[test]
    fun test_abs_diff() {
        assert!(abs_diff(10, 3) == 7, 0);
        assert!(abs_diff(3, 10) == 7, 1);
        assert!(abs_diff(5, 5) == 0, 2);
    }
}

```

````
