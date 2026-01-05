module community::aid_classifier {

    // ============================================
    // STRUCT DEFINITIONS
    // ============================================

    /// Beneficiary record with multiple eligibility fields
    struct Beneficiary has copy, drop {
        age: u64,
        income: u64,
        family_size: u64,
        is_pwd: bool
    }

    /// Address information for a resident
    struct Address has copy, drop {
        barangay_code: u64,
        zone: u64
    }

    /// Full resident record with nested address
    struct Resident has copy, drop {
        id: u64,
        age: u64,
        address: Address
    }

    // ============================================
    // HELPER FUNCTIONS
    // ============================================

    /// Creates a new beneficiary record
    public fun create_beneficiary(age: u64, income: u64, family_size: u64, is_pwd: bool): Beneficiary {
        Beneficiary { age, income, family_size, is_pwd }
    }

    /// Creates a new address record
    public fun create_address(barangay_code: u64, zone: u64): Address {
        Address { barangay_code, zone }
    }

    /// Creates a new resident record
    public fun create_resident(id: u64, age: u64, address: Address): Resident {
        Resident { id, age, address }
    }

    // ============================================
    // TASK 1: classify_beneficiary
    // Using basic destructuring to extract fields
    // ============================================

    /// Classifies a beneficiary into a category based on their characteristics
    ///
    /// # Arguments
    /// * `b` - The beneficiary to classify
    ///
    /// # Returns
    /// Category code:
    /// - 1: Senior (age >= 60)
    /// - 2: PWD
    /// - 3: Large family (family_size > 5)
    /// - 4: Low income (income < 15000)
    /// - 5: Standard
    public fun classify_beneficiary(b: Beneficiary): u8 {
        // Destructure the struct into individual variables
        let Beneficiary { age, income, family_size, is_pwd } = b;

        // Use the extracted fields for classification
        if (age >= 60) {
            1  // Senior citizen
        } else if (is_pwd) {
            2  // Person with disability
        } else if (family_size > 5) {
            3  // Large family
        } else if (income < 15000) {
            4  // Low income
        } else {
            5  // Standard category
        }
    }

    // ============================================
    // TASK 2: calculate_aid_amount
    // Using destructuring with renamed fields
    // ============================================

    /// Calculates the aid amount for a beneficiary
    ///
    /// # Arguments
    /// * `b` - The beneficiary to calculate aid for
    ///
    /// # Returns
    /// Total aid amount based on:
    /// - Base: 1000
    /// - Senior bonus: +500 if age >= 60
    /// - PWD bonus: +500 if is_pwd
    /// - Family bonus: +200 per member above 4
    public fun calculate_aid_amount(b: Beneficiary): u64 {
        // Destructure with renamed fields for clarity
        let Beneficiary {
            age: beneficiary_age,
            income: _,  // Not needed for calculation
            family_size: members,
            is_pwd: has_disability
        } = b;

        // Start with base amount
        let mut amount = 1000;

        // Add senior bonus
        if (beneficiary_age >= 60) {
            amount = amount + 500;
        };

        // Add disability bonus
        if (has_disability) {
            amount = amount + 500;
        };

        // Add family size bonus for members above 4
        if (members > 4) {
            amount = amount + ((members - 4) * 200);
        };

        amount
    }

    // ============================================
    // TASK 3: is_local_senior
    // Using nested struct destructuring
    // ============================================

    /// Checks if a resident is a local senior citizen
    ///
    /// # Arguments
    /// * `resident` - The resident to check
    ///
    /// # Returns
    /// true if age >= 60 AND from barangay 101
    public fun is_local_senior(resident: Resident): bool {
        // Destructure nested structs in one pattern
        let Resident {
            id: _,
            age,
            address: Address { barangay_code, zone: _ }
        } = resident;

        // Check both conditions
        age >= 60 && barangay_code == 101
    }

    // ============================================
    // TASK 4: get_zone_priority
    // Using destructuring in function parameter
    // ============================================

    /// Gets the priority level for a zone based on zone number and population
    ///
    /// # Arguments
    /// * `address` - The address (destructured in parameter)
    /// * `population` - The zone population
    ///
    /// # Returns
    /// Priority level:
    /// - 1: Zone 1 with population > 1000
    /// - 2: Zone 1 with lower population
    /// - 3: Zone 2
    /// - 4: Other zones
    public fun get_zone_priority(Address { barangay_code: _, zone }: Address, population: u64): u8 {
        if (zone == 1) {
            if (population > 1000) {
                1  // High priority zone 1
            } else {
                2  // Standard zone 1
            }
        } else if (zone == 2) {
            3  // Zone 2 priority
        } else {
            4  // Other zones
        }
    }

    // ============================================
    // UNIT TESTS
    // ============================================

    #[test]
    fun test_classify_senior() {
        let senior = create_beneficiary(65, 20000, 2, false);
        assert!(classify_beneficiary(senior) == 1, 0);
    }

    #[test]
    fun test_classify_pwd() {
        let pwd = create_beneficiary(30, 20000, 2, true);
        assert!(classify_beneficiary(pwd) == 2, 0);
    }

    #[test]
    fun test_classify_large_family() {
        let large_family = create_beneficiary(35, 25000, 7, false);
        assert!(classify_beneficiary(large_family) == 3, 0);
    }

    #[test]
    fun test_classify_low_income() {
        let low_income = create_beneficiary(25, 10000, 3, false);
        assert!(classify_beneficiary(low_income) == 4, 0);
    }

    #[test]
    fun test_classify_standard() {
        let standard = create_beneficiary(30, 25000, 3, false);
        assert!(classify_beneficiary(standard) == 5, 0);
    }

    #[test]
    fun test_calculate_aid_base() {
        let standard = create_beneficiary(30, 20000, 3, false);
        assert!(calculate_aid_amount(standard) == 1000, 0);
    }

    #[test]
    fun test_calculate_aid_senior() {
        let senior = create_beneficiary(65, 20000, 3, false);
        assert!(calculate_aid_amount(senior) == 1500, 0);
    }

    #[test]
    fun test_calculate_aid_pwd() {
        let pwd = create_beneficiary(30, 20000, 3, true);
        assert!(calculate_aid_amount(pwd) == 1500, 0);
    }

    #[test]
    fun test_calculate_aid_senior_pwd_large_family() {
        // Senior + PWD + 3 extra family members (7 - 4 = 3 * 200 = 600)
        let complex = create_beneficiary(65, 20000, 7, true);
        // 1000 + 500 + 500 + 600 = 2600
        assert!(calculate_aid_amount(complex) == 2600, 0);
    }

    #[test]
    fun test_is_local_senior_true() {
        let addr = create_address(101, 1);
        let resident = create_resident(1, 65, addr);
        assert!(is_local_senior(resident) == true, 0);
    }

    #[test]
    fun test_is_local_senior_wrong_barangay() {
        let addr = create_address(102, 1);
        let resident = create_resident(1, 65, addr);
        assert!(is_local_senior(resident) == false, 0);
    }

    #[test]
    fun test_is_local_senior_not_senior() {
        let addr = create_address(101, 1);
        let resident = create_resident(1, 50, addr);
        assert!(is_local_senior(resident) == false, 0);
    }

    #[test]
    fun test_zone_priority_zone1_high_pop() {
        let addr = create_address(101, 1);
        assert!(get_zone_priority(addr, 1500) == 1, 0);
    }

    #[test]
    fun test_zone_priority_zone1_low_pop() {
        let addr = create_address(101, 1);
        assert!(get_zone_priority(addr, 500) == 2, 0);
    }

    #[test]
    fun test_zone_priority_zone2() {
        let addr = create_address(101, 2);
        assert!(get_zone_priority(addr, 1500) == 3, 0);
    }

    #[test]
    fun test_zone_priority_other() {
        let addr = create_address(101, 5);
        assert!(get_zone_priority(addr, 1500) == 4, 0);
    }
}
