````markdown
# Activity: Building the UserProfile System

## Objective

Create a user profile system for MoveStack that demonstrates struct definitions, field access, instantiation patterns, and destructuring in Move.

## Scenario

Mike walks into the dev area with a fresh requirements document. "We need a user profile system for MoveStack. Each profile should track the user's basic info—name, reputation score, join timestamp, and whether they're verified."

Neri looks up from her screen. "Sounds like a perfect use case for structs. We can model all that data in a single type."

Ronnie joins the conversation, sketching on a whiteboard. "Let's think about the abilities too. Will profiles be stored globally? Can they be copied? We need to decide that upfront."

"Good point," Mike nods. "Profiles should be unique resources—one per user, non-copyable. But we'll need helper structs for some data that CAN be copied, like reputation info."

## Starter Code

```move
module movestack::user_profile {
    // ============================================
    // STRUCT DEFINITIONS
    // ============================================

    // TODO: Create a struct called 'ReputationInfo' with abilities: copy, drop
    // Fields:
    //   - score: u64
    //   - level: u8 (1-5 representing bronze to diamond)
    //   - reviews_count: u64

    // TODO: Create a struct called 'UserProfile' with ability: key
    // Fields:
    //   - id: u64
    //   - name: vector<u8>
    //   - reputation: ReputationInfo (nested struct)
    //   - joined_at: u64 (timestamp)
    //   - is_verified: bool

    // ============================================
    // STRUCT CREATION FUNCTIONS
    // ============================================

    // TODO: Create a public function called 'create_reputation'
    // Parameters: score (u64), level (u8), reviews_count (u64)
    // Returns: ReputationInfo

    // TODO: Create a public function called 'create_profile'
    // Parameters: id (u64), name (vector<u8>), reputation (ReputationInfo),
    //             joined_at (u64), is_verified (bool)
    // Returns: UserProfile

    // ============================================
    // FIELD ACCESS (GETTERS)
    // ============================================

    // TODO: Create a public function called 'get_name'
    // Takes a reference to UserProfile
    // Returns a reference to the name field (vector<u8>)

    // TODO: Create a public function called 'get_reputation_score'
    // Takes a reference to UserProfile
    // Returns the reputation score (u64)

    // TODO: Create a public function called 'is_verified'
    // Takes a reference to UserProfile
    // Returns the is_verified field (bool)

    // ============================================
    // DESTRUCTURING
    // ============================================

    // TODO: Create a public function called 'unpack_reputation'
    // Takes ReputationInfo by value (consuming it)
    // Destructures and returns all three fields as a tuple: (u64, u8, u64)
}
```

## Tasks

1. **Define the structs**

   - Create `ReputationInfo` with `copy` and `drop` abilities (helper struct)
   - Create `UserProfile` with `key` ability (resource for global storage)
   - Use appropriate field types including a nested struct

2. **Implement creation functions**

   - `create_reputation` instantiates a ReputationInfo
   - `create_profile` instantiates a UserProfile with a nested ReputationInfo

3. **Implement getters with references**
   - Use `&UserProfile` to borrow without consuming
   - Return references or copy values as appropriate
   - Access nested struct fields

## Expected Behavior

After completing this activity:

- `create_reputation(100, 3, 25)` returns a ReputationInfo struct
- `create_profile(...)` returns a UserProfile with nested reputation
- `get_name(&profile)` returns a reference to the name
- `get_reputation_score(&profile)` returns `100`
- `unpack_reputation(rep)` returns `(100, 3, 25)` and consumes the struct

## Hints

<details>
<summary>Hint 1: Struct with abilities</summary>

Declare abilities after the struct name:

```move
struct ReputationInfo has copy, drop {
    score: u64,
    level: u8,
    reviews_count: u64,
}
```

</details>

<details>
<summary>Hint 2: Struct with nested type</summary>

Structs can contain other structs:

```move
struct UserProfile has key {
    id: u64,
    name: vector<u8>,
    reputation: ReputationInfo,
    joined_at: u64,
    is_verified: bool,
}
```

</details>

<details>
<summary>Hint 3: Struct instantiation</summary>

Create structs with named field syntax:

```move
public fun create_reputation(score: u64, level: u8, reviews_count: u64): ReputationInfo {
    ReputationInfo {
        score,
        level,
        reviews_count,
    }
}
```

</details>

<details>
<summary>Hint 4: Accessing nested fields</summary>

Use dot notation to access nested struct fields:

```move
public fun get_reputation_score(profile: &UserProfile): u64 {
    profile.reputation.score
}
```

</details>

<details>
<summary>Hint 5: Destructuring structs</summary>

Destructure to extract all fields at once:

```move
public fun unpack_reputation(rep: ReputationInfo): (u64, u8, u64) {
    let ReputationInfo { score, level, reviews_count } = rep;
    (score, level, reviews_count)
}
```

</details>
````
