```move
module movestack::user_profile {
    use std::vector;

    // ============================================
    // STRUCT DEFINITIONS
    // ============================================

    /// Reputation information that can be copied and passed around.
    /// Has 'copy' and 'drop' abilities since it's a helper struct,
    /// not a resource that needs strict ownership tracking.
    struct ReputationInfo has copy, drop {
        /// Numeric reputation score
        score: u64,
        /// Level from 1-5 (bronze, silver, gold, platinum, diamond)
        level: u8,
        /// Total number of reviews received
        reviews_count: u64,
    }

    /// A user profile resource that represents a unique user.
    /// Has 'key' ability so it can be stored in global storage.
    /// Does NOT have 'copy' or 'drop' - profiles are unique resources.
    struct UserProfile has key {
        /// Unique identifier for the user
        id: u64,
        /// User's display name as bytes
        name: vector<u8>,
        /// Nested reputation information
        reputation: ReputationInfo,
        /// Unix timestamp when user joined
        joined_at: u64,
        /// Whether the user has been verified
        is_verified: bool,
    }

    // ============================================
    // ERROR CODES
    // ============================================

    const E_INVALID_LEVEL: u64 = 1;
    const E_EMPTY_NAME: u64 = 2;

    // ============================================
    // STRUCT CREATION FUNCTIONS
    // ============================================

    /// Creates a new ReputationInfo struct.
    /// Since ReputationInfo has 'copy' and 'drop', it can be freely copied and discarded.
    public fun create_reputation(score: u64, level: u8, reviews_count: u64): ReputationInfo {
        assert!(level >= 1 && level <= 5, E_INVALID_LEVEL);
        ReputationInfo {
            score,
            level,
            reviews_count,
        }
    }

    /// Creates a new UserProfile struct.
    /// The profile will have 'key' ability for global storage.
    public fun create_profile(
        id: u64,
        name: vector<u8>,
        reputation: ReputationInfo,
        joined_at: u64,
        is_verified: bool
    ): UserProfile {
        assert!(vector::length(&name) > 0, E_EMPTY_NAME);
        UserProfile {
            id,
            name,
            reputation,
            joined_at,
            is_verified,
        }
    }

    /// Creates a new user profile with default reputation.
    /// Convenient helper for new users.
    public fun create_new_user(id: u64, name: vector<u8>, joined_at: u64): UserProfile {
        let default_reputation = create_reputation(0, 1, 0);
        create_profile(id, name, default_reputation, joined_at, false)
    }

    // ============================================
    // FIELD ACCESS (GETTERS)
    // ============================================

    /// Returns a reference to the user's name.
    /// Uses immutable borrow (&) so the profile isn't consumed.
    public fun get_name(profile: &UserProfile): &vector<u8> {
        &profile.name
    }

    /// Returns the user's ID.
    /// Copies the value since u64 has implicit 'copy'.
    public fun get_id(profile: &UserProfile): u64 {
        profile.id
    }

    /// Returns the reputation score from the nested struct.
    /// Demonstrates accessing fields within nested structs.
    public fun get_reputation_score(profile: &UserProfile): u64 {
        profile.reputation.score
    }

    /// Returns the reputation level.
    public fun get_reputation_level(profile: &UserProfile): u8 {
        profile.reputation.level
    }

    /// Returns whether the user is verified.
    public fun is_verified(profile: &UserProfile): bool {
        profile.is_verified
    }

    /// Returns a copy of the reputation info.
    /// Works because ReputationInfo has 'copy' ability.
    public fun get_reputation(profile: &UserProfile): ReputationInfo {
        profile.reputation
    }

    // ============================================
    // FIELD MODIFICATION (SETTERS)
    // ============================================

    /// Updates the user's reputation score.
    /// Takes mutable reference to modify the profile in place.
    public fun update_reputation_score(profile: &mut UserProfile, new_score: u64) {
        profile.reputation.score = new_score;
    }

    /// Increments the reputation score by a given amount.
    public fun add_reputation(profile: &mut UserProfile, amount: u64) {
        profile.reputation.score = profile.reputation.score + amount;
    }

    /// Marks a user as verified.
    public fun verify_user(profile: &mut UserProfile) {
        profile.is_verified = true;
    }

    /// Updates the reputation level.
    public fun update_level(profile: &mut UserProfile, new_level: u8) {
        assert!(new_level >= 1 && new_level <= 5, E_INVALID_LEVEL);
        profile.reputation.level = new_level;
    }

    // ============================================
    // DESTRUCTURING
    // ============================================

    /// Unpacks a ReputationInfo struct into its component values.
    /// This CONSUMES the struct (it's moved and destroyed).
    public fun unpack_reputation(rep: ReputationInfo): (u64, u8, u64) {
        let ReputationInfo { score, level, reviews_count } = rep;
        (score, level, reviews_count)
    }

    /// Unpacks a UserProfile into all its components.
    /// Demonstrates destructuring of a struct with nested struct.
    public fun unpack_profile(profile: UserProfile): (u64, vector<u8>, ReputationInfo, u64, bool) {
        let UserProfile { id, name, reputation, joined_at, is_verified } = profile;
        (id, name, reputation, joined_at, is_verified)
    }

    // ============================================
    // UTILITY FUNCTIONS
    // ============================================

    /// Calculates a level based on reputation score.
    /// Demonstrates business logic using struct data.
    public fun calculate_level_from_score(score: u64): u8 {
        if (score >= 10000) {
            5 // Diamond
        } else if (score >= 5000) {
            4 // Platinum
        } else if (score >= 1000) {
            3 // Gold
        } else if (score >= 100) {
            2 // Silver
        } else {
            1 // Bronze
        }
    }

    /// Creates a formatted summary of user stats.
    /// Returns (name_length, total_score, is_high_level)
    public fun get_user_summary(profile: &UserProfile): (u64, u64, bool) {
        let name_length = vector::length(&profile.name);
        let total_score = profile.reputation.score;
        let is_high_level = profile.reputation.level >= 4;
        (name_length, total_score, is_high_level)
    }

    // ============================================
    // TESTS
    // ============================================

    #[test]
    fun test_create_reputation() {
        let rep = create_reputation(100, 3, 25);
        let (score, level, reviews) = unpack_reputation(rep);
        assert!(score == 100, 0);
        assert!(level == 3, 1);
        assert!(reviews == 25, 2);
    }

    #[test]
    #[expected_failure(abort_code = E_INVALID_LEVEL)]
    fun test_create_reputation_invalid_level() {
        create_reputation(100, 6, 25); // Level 6 is invalid
    }

    #[test]
    fun test_create_profile() {
        let rep = create_reputation(500, 2, 10);
        let profile = create_profile(1, b"Neri", rep, 1704326400, true);
        
        assert!(get_id(&profile) == 1, 0);
        assert!(get_reputation_score(&profile) == 500, 1);
        assert!(is_verified(&profile) == true, 2);
        
        // Clean up - unpack to consume the resource
        let (_, _, _, _, _) = unpack_profile(profile);
    }

    #[test]
    fun test_create_new_user() {
        let profile = create_new_user(42, b"Jaymart", 1704326400);
        
        assert!(get_id(&profile) == 42, 0);
        assert!(get_reputation_score(&profile) == 0, 1);
        assert!(get_reputation_level(&profile) == 1, 2);
        assert!(is_verified(&profile) == false, 3);
        
        let (_, _, _, _, _) = unpack_profile(profile);
    }

    #[test]
    fun test_getters() {
        let rep = create_reputation(1000, 3, 50);
        let profile = create_profile(1, b"Ronnie", rep, 1704326400, false);
        
        assert!(vector::length(get_name(&profile)) == 6, 0); // "Ronnie" is 6 chars
        assert!(get_reputation_score(&profile) == 1000, 1);
        assert!(get_reputation_level(&profile) == 3, 2);
        
        let (_, _, _, _, _) = unpack_profile(profile);
    }

    #[test]
    fun test_update_reputation() {
        let rep = create_reputation(100, 1, 5);
        let mut profile = create_profile(1, b"Test", rep, 1704326400, false);
        
        update_reputation_score(&mut profile, 500);
        assert!(get_reputation_score(&profile) == 500, 0);
        
        add_reputation(&mut profile, 100);
        assert!(get_reputation_score(&profile) == 600, 1);
        
        let (_, _, _, _, _) = unpack_profile(profile);
    }

    #[test]
    fun test_verify_user() {
        let rep = create_reputation(0, 1, 0);
        let mut profile = create_profile(1, b"New User", rep, 1704326400, false);
        
        assert!(is_verified(&profile) == false, 0);
        verify_user(&mut profile);
        assert!(is_verified(&profile) == true, 1);
        
        let (_, _, _, _, _) = unpack_profile(profile);
    }

    #[test]
    fun test_calculate_level() {
        assert!(calculate_level_from_score(50) == 1, 0);
        assert!(calculate_level_from_score(100) == 2, 1);
        assert!(calculate_level_from_score(1000) == 3, 2);
        assert!(calculate_level_from_score(5000) == 4, 3);
        assert!(calculate_level_from_score(10000) == 5, 4);
    }

    #[test]
    fun test_get_user_summary() {
        let rep = create_reputation(5500, 4, 100);
        let profile = create_profile(1, b"Expert", rep, 1704326400, true);
        
        let (name_len, score, is_high) = get_user_summary(&profile);
        assert!(name_len == 6, 0);
        assert!(score == 5500, 1);
        assert!(is_high == true, 2);
        
        let (_, _, _, _, _) = unpack_profile(profile);
    }

    #[test]
    fun test_copy_reputation() {
        let rep1 = create_reputation(100, 2, 10);
        let rep2 = rep1; // This works because ReputationInfo has 'copy'
        
        let (s1, _, _) = unpack_reputation(rep1);
        let (s2, _, _) = unpack_reputation(rep2);
        assert!(s1 == s2, 0);
    }
}

```
