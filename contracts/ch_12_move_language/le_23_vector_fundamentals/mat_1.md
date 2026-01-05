# Vector Fundamentals

## Opening Scene

Joas was hunched over his laptop in the barangay basketball court, trying to track player statistics for the upcoming fiesta tournament. Jaymart walked up, dribbling a ball.

"Kuya Joas, you look stressed," Jaymart observed, sitting down on the bench. "What's the problem?"

Joas groaned. "I'm trying to store all the player scores, but I keep making separate variables for each one. There has to be a better way."

Jaymart grinned. "Ah, you need vectors! They're like dynamic lists that grow and shrink as needed. Let me show you the fundamentals."

---

## Topics

### Creating Vectors

"First, let's learn how to create vectors," Jaymart began, pulling out his own laptop. "There are several ways to make one."

```move
module tournament::players {
    use std::vector;

    /// Creates an empty vector of scores
    public fun create_empty_scores(): vector<u64> {
        vector::empty<u64>()
    }

    /// Creates a vector with initial values using literal syntax
    public fun create_initial_scores(): vector<u64> {
        vector[10, 20, 15, 25, 30]
    }

    /// Creates a vector with a single element
    public fun create_single_score(score: u64): vector<u64> {
        vector::singleton(score)
    }
}
```

Joas nodded. "So `vector<u64>` means a list that only holds `u64` values?"

"Exactly!" Jaymart confirmed. "The type parameter keeps everything type-safe. You can't accidentally mix different types."

### Adding Elements with push_back

"To add elements to a vector, we use `push_back`," Jaymart continued. "It always adds to the end."

```move
module tournament::scoreboard {
    use std::vector;

    /// Builds a scoreboard by adding scores one by one
    public fun build_scoreboard(): vector<u64> {
        let scores = vector::empty<u64>();

        // Add scores to the end of the vector
        vector::push_back(&mut scores, 12);
        vector::push_back(&mut scores, 8);
        vector::push_back(&mut scores, 15);
        vector::push_back(&mut scores, 22);

        scores
    }

    /// Adds a new score to an existing scoreboard
    public fun add_score(scoreboard: &mut vector<u64>, new_score: u64) {
        vector::push_back(scoreboard, new_score);
    }
}
```

"Notice the `&mut`," Jaymart pointed out. "Since we're modifying the vector, we need a mutable reference."

### Removing Elements with pop_back

"To remove the last element, use `pop_back`," Jaymart explained. "It removes AND returns the element."

```move
module tournament::game {
    use std::vector;

    /// Removes and returns the last score
    public fun remove_last_score(scores: &mut vector<u64>): u64 {
        vector::pop_back(scores)
    }

    /// Removes the last N scores from the list
    public fun remove_last_n(scores: &mut vector<u64>, n: u64) {
        let i = 0;
        while (i < n) {
            vector::pop_back(scores);
            i = i + 1;
        };
    }
}
```

Joas raised his hand. "What happens if the vector is empty when I call `pop_back`?"

"Good question! It will abort with an error," Jaymart warned. "Always check the length first if you're unsure."

### Checking Vector Length

"Speaking of length, that's our next topic," Jaymart said. "Use `length` to find out how many elements a vector has."

```move
module tournament::stats {
    use std::vector;

    /// Returns the number of scores in the list
    public fun get_score_count(scores: &vector<u64>): u64 {
        vector::length(scores)
    }

    /// Checks if the scoreboard is empty
    public fun is_empty(scores: &vector<u64>): bool {
        vector::length(scores) == 0
    }

    /// Checks if we have enough players (at least 5)
    public fun has_enough_players(players: &vector<u64>): bool {
        vector::length(players) >= 5
    }

    /// Safely removes last element, returns 0 if empty
    public fun safe_pop(scores: &mut vector<u64>): u64 {
        if (vector::length(scores) == 0) {
            0
        } else {
            vector::pop_back(scores)
        }
    }
}
```

### Putting It All Together

"Let me show you a complete example," Jaymart said, pulling up a more comprehensive module.

```move
module tournament::team_roster {
    use std::vector;

    /// Manages a team roster with player IDs
    struct TeamRoster has drop {
        player_ids: vector<u64>,
        team_name: vector<u8>
    }

    /// Creates a new empty roster
    public fun create_roster(): TeamRoster {
        TeamRoster {
            player_ids: vector::empty<u64>(),
            team_name: vector::empty<u8>()
        }
    }

    /// Adds a player to the roster
    public fun add_player(roster: &mut TeamRoster, player_id: u64) {
        vector::push_back(&mut roster.player_ids, player_id);
    }

    /// Removes the last player added
    public fun remove_last_player(roster: &mut TeamRoster): u64 {
        vector::pop_back(&mut roster.player_ids)
    }

    /// Gets the roster size
    public fun get_roster_size(roster: &TeamRoster): u64 {
        vector::length(&roster.player_ids)
    }

    /// Checks if roster is full (max 12 players)
    public fun is_roster_full(roster: &TeamRoster): bool {
        vector::length(&roster.player_ids) >= 12
    }
}
```

---

## Concept Breakdown

### Vector Creation Methods

| Method                 | Description                | Example                 |
| ---------------------- | -------------------------- | ----------------------- |
| `vector::empty<T>()`   | Creates empty vector       | `vector::empty<u64>()`  |
| `vector[...]`          | Literal syntax with values | `vector[1, 2, 3]`       |
| `vector::singleton(v)` | Vector with one element    | `vector::singleton(42)` |

### Core Operations

| Operation | Syntax                            | Notes                           |
| --------- | --------------------------------- | ------------------------------- |
| Push      | `vector::push_back(&mut v, elem)` | Adds to end                     |
| Pop       | `vector::pop_back(&mut v)`        | Removes from end, returns value |
| Length    | `vector::length(&v)`              | Returns element count           |

### Key Points

1. **Type Safety**: Vectors are generic - `vector<T>` holds only type `T`
2. **Mutable Operations**: `push_back` and `pop_back` require `&mut`
3. **Read-Only Operations**: `length` only needs `&` (immutable reference)
4. **Empty Check**: Always verify `length > 0` before calling `pop_back`

---

## Closing Scene

Joas leaned back, a smile spreading across his face. "This is exactly what I needed! Now I can track all the player scores dynamically."

"And you can add or remove players as the tournament progresses," Jaymart added. "No more creating hundreds of individual variables."

"Thanks, Jaymart. These vector fundamentals will make my tournament tracker so much cleaner!"

Jaymart stood up, picking up the basketball. "Once you master these basics, we can move on to more advanced operations like searching and removing specific elements. But first—want to play a quick game?"
