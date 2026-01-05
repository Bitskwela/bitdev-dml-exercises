module inference_exercise::type_practice {
    use std::vector;
    
    struct Account has drop {
        id: u64,
        balance: u64,
        active: bool
    }
    
    // Problem 1: Simplified - removed unnecessary annotations
    public fun over_annotated(): u64 {
        let x = 10u64;
        let y = 20;
        let sum = x + y;
        let result = sum * 2;
        result
    }
    
    // Problem 2: Fixed - added required annotations
    public fun under_annotated() {
        let mut empty_list: vector<u8> = vector[];
        let small_number: u8 = 255;
        let _big_number: u128 = 1000000000000;
        vector::push_back(&mut empty_list, small_number);
    }
    
    // Problem 3: Fixed - specified type parameter
    public fun generic_needs_type(): u64 {
        let value = default_value<u64>();
        value
    }
    
    // Problem 4: Cleaned up - removed unnecessary annotations
    public fun process_account(): bool {
        let account = create_account();
        let balance = account.balance;
        let threshold = 100;
        let is_wealthy = balance > threshold;
        is_wealthy
    }
    
    // Problem 5: Fixed - added annotation for empty vector
    public fun vector_operations() {
        let mut numbers: vector<u64> = vector[];
        vector::push_back(&mut numbers, 1);
        vector::push_back(&mut numbers, 2);
        let first = *vector::borrow(&numbers, 0);
        let _doubled = first * 2;
    }
    
    // Helper functions
    fun default_value<T: drop>(): T { abort 0 }
    
    fun create_account(): Account {
        Account { id: 1, balance: 500, active: true }
    }
    
    // Additional examples demonstrating inference patterns
    
    #[test]
    fun test_inference_examples() {
        // Inference from literals
        let a = 100u64;        // Explicit suffix
        let b = 200;           // Inferred as u64 from context
        let sum = a + b;       // Inferred as u64
        assert!(sum == 300, 0);
        
        // Inference from function returns
        let account = create_account();  // Inferred as Account
        let bal = account.balance;       // Inferred as u64
        assert!(bal == 500, 1);
        
        // Inference from vector elements
        let nums = vector[1u64, 2, 3];   // vector<u64> from first element
        let first = *vector::borrow(&nums, 0);
        assert!(first == 1, 2);
    }
    
    #[test]
    fun test_explicit_annotations() {
        // Empty vector requires annotation
        let mut empty: vector<bool> = vector[];
        vector::push_back(&mut empty, true);
        
        // Specific numeric types require annotation
        let byte: u8 = 255;
        let big: u128 = 340282366920938463463374607431768211455;
        
        assert!(byte == 255, 0);
        assert!(big > 0, 1);
        assert!(vector::length(&empty) == 1, 2);
    }
    
    #[test]
    fun test_over_annotated() {
        let result = over_annotated();
        assert!(result == 60, 0);  // (10 + 20) * 2 = 60
    }
    
    #[test]
    fun test_under_annotated() {
        under_annotated();  // Should compile without errors
    }
    
    #[test]
    fun test_process_account() {
        let is_wealthy = process_account();
        assert!(is_wealthy == true, 0);  // 500 > 100
    }
    
    #[test]
    fun test_vector_operations() {
        vector_operations();  // Should compile and run without errors
    }
}
