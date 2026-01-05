## Smart contract activity

```move
module fiesta::tournament {
    use std::vector;

    // TODO: Define PlayerScore struct with copy, drop, store abilities
    // Fields: player_id (u64), points (u64)

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

    // TODO: Implement create_scoreboard - returns an empty vector of PlayerScore

    // TODO: Implement add_player_score - adds a PlayerScore to the scoreboard

    // TODO: Implement remove_last_entry - removes and returns the last PlayerScore

    // TODO: Implement get_player_count - returns the number of players

    // TODO: Implement is_scoreboard_empty - returns true if no players

    // TODO: Implement has_minimum_players - returns true if at least 5 players
}
```

## Tasks for Learners

Complete the tournament scoreboard module by implementing vector fundamentals.

- Define the `PlayerScore` struct with `copy`, `drop`, and `store` abilities:

  ```move
  struct PlayerScore has copy, drop, store {
      player_id: u64,
      points: u64,
  }
  ```

- Implement `create_scoreboard` to create an empty vector:

  ```move
  public fun create_scoreboard(): vector<PlayerScore> {
      vector::empty<PlayerScore>()
  }
  ```

- Implement `add_player_score` to add a new entry to the scoreboard:

  ```move
  public fun add_player_score(
      scoreboard: &mut vector<PlayerScore>,
      player_id: u64,
      points: u64
  ) {
      let entry = create_player_score(player_id, points);
      vector::push_back(scoreboard, entry);
  }
  ```

- Implement `remove_last_entry` to remove and return the last entry:

  ```move
  public fun remove_last_entry(scoreboard: &mut vector<PlayerScore>): PlayerScore {
      vector::pop_back(scoreboard)
  }
  ```

- Implement `get_player_count` to return the number of players:

  ```move
  public fun get_player_count(scoreboard: &vector<PlayerScore>): u64 {
      vector::length(scoreboard)
  }
  ```

- Implement `is_scoreboard_empty` to check if the scoreboard has no entries:

  ```move
  public fun is_scoreboard_empty(scoreboard: &vector<PlayerScore>): bool {
      vector::length(scoreboard) == 0
  }
  ```

- Implement `has_minimum_players` to check if there are at least 5 players:

  ```move
  public fun has_minimum_players(scoreboard: &vector<PlayerScore>): bool {
      vector::length(scoreboard) >= 5
  }
  ```

### Breakdown for learners

**Vector Creation**: Use `vector::empty<T>()` to create an empty vector of type T. The type parameter ensures type safety.

**push_back**: Adds an element to the end of the vector. Requires a mutable reference (`&mut`) since it modifies the vector.

**pop_back**: Removes and returns the last element. Also requires `&mut`. Will abort if the vector is empty.

**length**: Returns the number of elements in the vector. Only needs an immutable reference (`&`) since it doesn't modify anything.

**Best Practice**: Always check `vector::length() > 0` before calling `pop_back` to avoid runtime aborts.
