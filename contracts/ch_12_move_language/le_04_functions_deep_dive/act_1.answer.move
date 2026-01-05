```move
module movestack::calculator {

    // ============================================
    // ERROR CODES
    // ============================================
    
    /// Error code for division by zero
    const E_DIVISION_BY_ZERO: u64 = 1;
    
    /// Error code for subtraction underflow (b > a)
    const E_SUBTRACTION_UNDERFLOW: u64 = 2;
    
    /// Error code for invalid operation
    const E_INVALID_OPERATION: u64 = 3;

    // ============================================
    // PRIVATE HELPER FUNCTIONS
    // ============================================

    /// Validates that a divisor is not zero.
    /// Private function - only callable within this module.
    fun validate_divisor(divisor: u64): bool {
        divisor != 0
    }

    /// Validates that subtraction won't underflow.
    /// Private function for internal use.
    fun validate_subtraction(a: u64, b: u64): bool {
        a >= b
    }

    // ============================================
    // PUBLIC FUNCTIONS (callable by other modules)
    // ============================================

    /// Adds two unsigned integers.
    /// Public function - can be called from other modules.
    public fun add(a: u64, b: u64): u64 {
        a + b
    }

    /// Subtracts b from a.
    /// Aborts if b > a since Move uses unsigned integers only.
    public fun subtract(a: u64, b: u64): u64 {
        assert!(validate_subtraction(a, b), E_SUBTRACTION_UNDERFLOW);
        a - b
    }

    /// Multiplies two unsigned integers.
    public fun multiply(a: u64, b: u64): u64 {
        a * b
    }

    /// Divides dividend by divisor (integer division).
    /// Aborts with E_DIVISION_BY_ZERO if divisor is 0.
    public fun divide(dividend: u64, divisor: u64): u64 {
        assert!(validate_divisor(divisor), E_DIVISION_BY_ZERO);
        dividend / divisor
    }

    // ============================================
    // MULTIPLE RETURN VALUES
    // ============================================

    /// Performs division and returns both quotient and remainder.
    /// Demonstrates Move's tuple return syntax.
    public fun divide_with_remainder(dividend: u64, divisor: u64): (u64, u64) {
        assert!(validate_divisor(divisor), E_DIVISION_BY_ZERO);
        let quotient = dividend / divisor;
        let remainder = dividend % divisor;
        (quotient, remainder)
    }

    /// Returns multiple statistics about a number.
    /// Shows returning more than two values.
    public fun number_stats(n: u64): (u64, u64, bool) {
        let doubled = n * 2;
        let halved = n / 2;
        let is_even = n % 2 == 0;
        (doubled, halved, is_even)
    }

    // ============================================
    // ENTRY FUNCTIONS (callable from transactions)
    // ============================================

    /// Entry point for performing calculations from transactions.
    /// operation codes: 0 = add, 1 = subtract, 2 = multiply, 3 = divide
    public entry fun perform_calculation(a: u64, b: u64, operation: u8) {
        let _result = if (operation == 0) {
            add(a, b)
        } else if (operation == 1) {
            subtract(a, b)
        } else if (operation == 2) {
            multiply(a, b)
        } else if (operation == 3) {
            divide(a, b)
        } else {
            abort E_INVALID_OPERATION
        };
        // In a real application, the result would be:
        // - Stored in a resource
        // - Emitted as an event
        // - Returned to be used by another module
    }

    // ============================================
    // BONUS: Power function showing recursion
    // ============================================

    /// Calculates base raised to the power of exponent.
    /// Demonstrates how functions can call themselves or other public functions.
    public fun power(base: u64, exponent: u64): u64 {
        if (exponent == 0) {
            1
        } else {
            let result = 1u64;
            let i = 0u64;
            while (i < exponent) {
                result = multiply(result, base);
                i = i + 1;
            };
            result
        }
    }

    // ============================================
    // TESTS
    // ============================================

    #[test]
    fun test_add() {
        assert!(add(10, 5) == 15, 0);
        assert!(add(0, 0) == 0, 1);
        assert!(add(100, 200) == 300, 2);
    }

    #[test]
    fun test_subtract() {
        assert!(subtract(10, 5) == 5, 0);
        assert!(subtract(100, 100) == 0, 1);
        assert!(subtract(50, 30) == 20, 2);
    }

    #[test]
    #[expected_failure(abort_code = E_SUBTRACTION_UNDERFLOW)]
    fun test_subtract_underflow() {
        subtract(5, 10); // This should abort
    }

    #[test]
    fun test_multiply() {
        assert!(multiply(10, 5) == 50, 0);
        assert!(multiply(0, 100) == 0, 1);
        assert!(multiply(7, 8) == 56, 2);
    }

    #[test]
    fun test_divide() {
        assert!(divide(10, 5) == 2, 0);
        assert!(divide(100, 10) == 10, 1);
        assert!(divide(7, 2) == 3, 2); // Integer division
    }

    #[test]
    #[expected_failure(abort_code = E_DIVISION_BY_ZERO)]
    fun test_divide_by_zero() {
        divide(10, 0); // This should abort
    }

    #[test]
    fun test_divide_with_remainder() {
        let (q, r) = divide_with_remainder(17, 5);
        assert!(q == 3, 0);
        assert!(r == 2, 1);

        let (q2, r2) = divide_with_remainder(20, 4);
        assert!(q2 == 5, 2);
        assert!(r2 == 0, 3);
    }

    #[test]
    fun test_number_stats() {
        let (doubled, halved, is_even) = number_stats(10);
        assert!(doubled == 20, 0);
        assert!(halved == 5, 1);
        assert!(is_even == true, 2);

        let (d2, h2, e2) = number_stats(7);
        assert!(d2 == 14, 3);
        assert!(h2 == 3, 4);
        assert!(e2 == false, 5);
    }

    #[test]
    fun test_power() {
        assert!(power(2, 0) == 1, 0);
        assert!(power(2, 3) == 8, 1);
        assert!(power(10, 2) == 100, 2);
        assert!(power(5, 3) == 125, 3);
    }

    #[test]
    fun test_validate_divisor() {
        // Testing the private function indirectly through divide
        assert!(divide(100, 1) == 100, 0); // divisor 1 is valid
        assert!(divide(100, 50) == 2, 1);  // divisor 50 is valid
    }

    #[test]
    fun test_perform_calculation() {
        // Entry functions can be tested like regular functions
        perform_calculation(10, 5, 0); // add
        perform_calculation(10, 5, 1); // subtract
        perform_calculation(10, 5, 2); // multiply
        perform_calculation(10, 5, 3); // divide
    }

    #[test]
    #[expected_failure(abort_code = E_INVALID_OPERATION)]
    fun test_perform_calculation_invalid_op() {
        perform_calculation(10, 5, 99); // Invalid operation
    }
}

```
