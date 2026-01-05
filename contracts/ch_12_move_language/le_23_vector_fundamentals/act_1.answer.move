module fiesta::tournament {
    use std::vector;

    // ============================================
    // Task 1: PlayerScore struct with copy, drop, store abilities
    // ============================================
    
    /// A player's score entry with their ID and points earned.
    struct PlayerScore has copy, drop, store {
        player_id: u64,
        points: u64
    }

    /// Creates a new player score entry
    public fun create_player_score(player_id: u64, points: u64): PlayerScore {
        PlayerScore { player_id, points }
    }

    /// Gets the player ID from a score entry
    public fun get_player_id(score: &PlayerScore): u64 {
        score.player_id
    }

    /// Gets the points from a score entry
    public fun get_points(score: &PlayerScore): u64 {
        score.points
    }

    // ============================================
    // Task 2: create_scoreboard function
    // ============================================
    
    /// Creates an empty scoreboard to track player scores.
    public fun create_scoreboard(): vector<PlayerScore> {
        vector::empty<PlayerScore>()
    }

    // ============================================
    // Task 3: add_player_score function
    // ============================================
    
    /// Adds a new player score entry to the scoreboard.
    public fun add_player_score(
        scoreboard: &mut vector<PlayerScore>,
        player_id: u64,
        points: u64
    ) {
        let entry = create_player_score(player_id, points);
        vector::push_back(scoreboard, entry);
    }

    // ============================================
    // Task 4: remove_last_entry function
    // ============================================
    
    /// Removes and returns the last player score entry.
    /// Aborts if the scoreboard is empty.
    public fun remove_last_entry(scoreboard: &mut vector<PlayerScore>): PlayerScore {
        vector::pop_back(scoreboard)
    }

    // ============================================
    // Task 5: get_player_count function
    // ============================================
    
    /// Returns the number of players on the scoreboard.
    public fun get_player_count(scoreboard: &vector<PlayerScore>): u64 {
        vector::length(scoreboard)
    }

    // ============================================
    // Task 6: is_scoreboard_empty function
    // ============================================
    
    /// Returns true if the scoreboard has no entries.
    public fun is_scoreboard_empty(scoreboard: &vector<PlayerScore>): bool {
        vector::length(scoreboard) == 0
    }

    // ============================================
    // Task 7: has_minimum_players function
    // ============================================
    
    /// Returns true if there are at least 5 players.
    /// Tournaments require a minimum number of participants.
    public fun has_minimum_players(scoreboard: &vector<PlayerScore>): bool {
        vector::length(scoreboard) >= 5
    }

    // ============================================
    // Unit Tests
    // ============================================

    #[test]
    fun test_create_scoreboard() {
        let scoreboard = create_scoreboard();
        assert!(vector::length(&scoreboard) == 0, 0);
    }

    #[test]
    fun test_add_player_score() {
        let scoreboard = create_scoreboard();
        add_player_score(&mut scoreboard, 1001, 25);
        add_player_score(&mut scoreboard, 1002, 30);
        
        assert!(vector::length(&scoreboard) == 2, 0);
    }

    #[test]
    fun test_remove_last_entry() {
        let scoreboard = create_scoreboard();
        add_player_score(&mut scoreboard, 1001, 25);
        add_player_score(&mut scoreboard, 1002, 30);
        
        let last = remove_last_entry(&mut scoreboard);
        assert!(get_player_id(&last) == 1002, 0);
        assert!(get_points(&last) == 30, 1);
        assert!(vector::length(&scoreboard) == 1, 2);
    }

    #[test]
    fun test_get_player_count() {
        let scoreboard = create_scoreboard();
        assert!(get_player_count(&scoreboard) == 0, 0);
        
        add_player_score(&mut scoreboard, 1001, 10);
        add_player_score(&mut scoreboard, 1002, 20);
        add_player_score(&mut scoreboard, 1003, 30);
        
        assert!(get_player_count(&scoreboard) == 3, 1);
    }

    #[test]
    fun test_is_scoreboard_empty() {
        let scoreboard = create_scoreboard();
        assert!(is_scoreboard_empty(&scoreboard) == true, 0);
        
        add_player_score(&mut scoreboard, 1001, 10);
        assert!(is_scoreboard_empty(&scoreboard) == false, 1);
    }

    #[test]
    fun test_has_minimum_players() {
        let scoreboard = create_scoreboard();
        
        // Add 4 players - not enough
        add_player_score(&mut scoreboard, 1001, 10);
        add_player_score(&mut scoreboard, 1002, 20);
        add_player_score(&mut scoreboard, 1003, 30);
        add_player_score(&mut scoreboard, 1004, 40);
        assert!(has_minimum_players(&scoreboard) == false, 0);
        
        // Add 5th player - now enough
        add_player_score(&mut scoreboard, 1005, 50);
        assert!(has_minimum_players(&scoreboard) == true, 1);
    }
}
