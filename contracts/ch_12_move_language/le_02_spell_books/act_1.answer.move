module movestack::spell_book {
    use std::vector;

    // ============================================
    // PRIVATE HELPER FUNCTIONS
    // ============================================

    /// Calculates the final power of a spell by multiplying base power with a multiplier.
    /// This is a private function - only accessible within this module.
    fun calculate_power(base_power: u64, multiplier: u64): u64 {
        base_power * multiplier
    }

    // ============================================
    // PUBLIC FUNCTIONS
    // ============================================

    /// Creates a spell with enhanced power (base × 2).
    /// This is a public function - can be called from outside the module.
    public fun create_spell(base_power: u64): u64 {
        calculate_power(base_power, 2)
    }

    /// Returns a predefined list of spell power levels.
    /// Demonstrates vector creation and manipulation.
    public fun get_spell_list(): vector<u64> {
        let mut spells = vector::empty<u64>();
        vector::push_back(&mut spells, 10);
        vector::push_back(&mut spells, 20);
        vector::push_back(&mut spells, 30);
        spells
    }

    // ============================================
    // TESTS
    // ============================================

    #[test]
    fun test_create_spell() {
        let power = create_spell(50);
        assert!(power == 100, 0);

        let power2 = create_spell(25);
        assert!(power2 == 50, 1);
    }

    #[test]
    fun test_get_spell_list() {
        let spells = get_spell_list();
        assert!(vector::length(&spells) == 3, 0);
        assert!(*vector::borrow(&spells, 0) == 10, 1);
        assert!(*vector::borrow(&spells, 1) == 20, 2);
        assert!(*vector::borrow(&spells, 2) == 30, 3);
    }

    #[test]
    fun test_calculate_power_via_create_spell() {
        // We can't test calculate_power directly from outside,
        // but we can verify it works through create_spell
        assert!(create_spell(0) == 0, 0);   // 0 × 2 = 0
        assert!(create_spell(1) == 2, 1);   // 1 × 2 = 2
        assert!(create_spell(100) == 200, 2); // 100 × 2 = 200
    }
}
