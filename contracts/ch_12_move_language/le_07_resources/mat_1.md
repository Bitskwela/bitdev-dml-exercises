## Scene

Dex, MoveStack's protocol designer, has commandeered the main conference room. The whiteboard is covered in flow diagrams showing token transfers, ownership transitions, and lifecycle states.

"Resources," Dex begins as Det and Neri take their seats. "Not just a Move feature—the foundation of trustless systems."

Det leans forward. "I've explained ownership to Jaymart. But resources take it further, right?"

"Much further," Dex confirms. "In other languages, when you transfer value, you hope the transfer is legitimate. How many copies were made? Were the bytes corrupted? Did someone duplicate the transfer? You don't know because the system trusts humans."

Neri shakes her head. "Move doesn't trust anyone."

"Exactly." Dex draws a diagram showing a token moving from one address to another. "Move uses the linear type system to *prove* that every resource has exactly one owner at any moment. No copies. No duplicates. No disappearances. Mathematical certainty."

Det studies the diagram. "So when I transfer a token..."

"The blockchain can prove—with math—that the sender no longer has it and the receiver now does," Dex finishes. "No auditors required. The compiler enforces it."

Dex pulls up a fresh terminal. "Today we build MoveStack's ticket system. Real resources with real guarantees. Mint, burn, transfer—all with linear type safety."

---

## 📚 Topics & Deep Lessons

### 1️⃣ **What is a Resource: More Than Data**

A resource is a value that:

- Has exactly one owner at any moment
- Cannot be copied
- Cannot be discarded
- Cannot disappear or multiply

```move
struct Coin {  // RESOURCE (no abilities)
    value: u64
}

// Key property: The compiler FORCES linear behavior
let coin = Coin { value: 100 };
let coin2 = coin;      // ❌ MOVE (coin is gone)
// println!("{}", coin);  // ❌ ERROR! coin no longer exists

// Result: Exactly one path through the code where this coin exists
```

**Why this matters for blockchain:**

In a regular database, a transaction record might look like:

```
Alice: 100 coins
Transfer to Bob: 50 coins
Alice: 50 coins (hopefully)
Bob: 150 coins (hopefully)
```

But in a Move system with resources:

```move
struct Coin { value: u64 }  // RESOURCE

public fun transfer(from_coin: Coin, amount: u64): (Coin, Coin) {
    // MUST split from_coin into two:
    let returned = Coin { value: from_coin.value - amount };
    let sent = Coin { value: amount };
    (returned, sent)
    // from_coin is CONSUMED—it no longer exists
    // Two NEW coins exist
}
```

The compiler ensures:

- ✅ from_coin is used EXACTLY once (no accidental re-use)
- ✅ Result coins must be used (can't lose them)
- ✅ Math is impossible to violate

### 2️⃣ **Resource Invariants: Rules That Cannot Be Broken**

A resource invariant is a mathematical property that MUST remain true:

```move
struct CoinPurse {
    coins: vector<Coin>
}

// INVARIANT: The total value in the purse cannot change
//            except through explicit withdraw/deposit

public fun deposit(purse: &mut CoinPurse, coin: Coin) {
    // The compiler ensures:
    // - coin WILL be added (can't be dropped)
    // - coin CANNOT be copied (can't add 2x)
    // - purse MUST exist after (can't destroy it accidentally)
    vector::push_back(&mut purse.coins, coin);
}

public fun withdraw(purse: &mut CoinPurse): Coin {
    // The compiler ensures:
    // - Exactly ONE coin is removed
    // - If withdraw fails (vector empty), the TX fails
    // - purse still exists after
    vector::pop_back(&mut purse.coins)
}
```

**The guarantee:**

```
total_coins_in_system = sum of all coins in purses
This value NEVER changes except through explicit operations!
```

### 3️⃣ **The Linear Type System: Mathematics Enforcing Safety**

The linear type system is based on a simple idea: each value has exactly one owner.

```move
let resource = MyResource { data: 100 };
// resource has exactly one owner: this scope

let moved = resource;  // Ownership transfers
// NOW: moved has the resource, the original scope does not
// The original reference "resource" is invalid

// If you try to use "resource" again:
// println!("{}", resource);  // ❌ ERROR!
// The compiler PREVENTS this—it's mathematically impossible
```

**Linear typing consequences:**

1. **No aliasing without permission**

```move
let original = Coin { value: 100 };
let copy = original;  // ❌ ERROR! Cannot create alias
// (unless Coin has "copy" ability—but resources don't)
```

2. **No lost resources**

```move
let coin = Coin { value: 100 };
// end of scope
// ❌ ERROR! Coin must be explicitly handled
// (unless it has "drop" ability—resources don't)
```

3. **All paths must handle resources**

```move
public fun maybe_transfer(condition: bool): Coin {
    let coin = Coin { value: 100 };

    if (condition) {
        coin  // ✅ Path 1: return coin
    } else {
        coin  // ✅ Path 2: also return coin
    }
    // Both paths must handle coin—compiler ensures it
}
```

### 4️⃣ **Preventing Accidental Destroy/Duplicate: The Guarantee**

Without the linear type system, resources could be lost or duplicated. With it, the compiler prevents both:

**Prevention of accidental destruction:**

```move
struct Spell {  // RESOURCE
    power: u64
}

public fun use_spell(spell: Spell) {
    // DO NOT COMPILE: println!("{}", spell.power);
    // spell is unused—must be explicitly consumed
    // ❌ ERROR! Spell must be moved/returned/consumed
}

// ✅ CORRECT: Explicitly consume the spell
public fun use_spell(spell: Spell) {
    assert!(spell.power > 0, 1);
    // spell is implicitly consumed at end of scope
}
```

**Prevention of accidental duplication:**

```move
struct Token {  // RESOURCE
    amount: u64
}

public fun duplicate_attempt(token: Token) {
    let copy = token;      // ❌ MOVE (not copy!)
    // let copy2 = token;   // ❌ ERROR! token already moved
    // Can't create two references to the same resource
}
```

### 5️⃣ **Building Trustless Systems: The Promise**

With resources and invariants, you can build systems that don't require trust:

```move
struct Vault {
    assets: vector<Coin>,
    owner: address
}

public fun create_vault(owner: address): Vault {
    Vault {
        assets: vector::empty(),
        owner
    }
}

public fun deposit(vault: &mut Vault, coin: Coin) {
    // Compiler GUARANTEES:
    // - coin is real (not duplicated)
    // - coin will be added (not lost)
    // - vault still exists after
    vector::push_back(&mut vault.assets, coin);
}

public fun withdraw(vault: &mut Vault): Coin {
    // Compiler GUARANTEES:
    // - Exactly one coin removed
    // - If vault is empty, transaction reverts
    // - Retrieved coin is real (not a copy)
    vector::pop_back(&mut vault.assets)
}

// The INVARIANT: sum(vault.assets) never changes except through explicit calls
// No auditor needed—math proves it!
```

---

## 🎯 Activity / Exercises

### Exercise 1: Resource Invariants 💎

**Scenario:** Build a Bank that maintains an invariant: the total coins in the bank equals all deposits minus withdrawals.

**Boilerplate Code:**

```move
module spell_library::bank_invariant {

    struct Coin {  // RESOURCE
        value: u64
    }

    struct Bank {
        total_coins: u64,
        owner: address
    }

    public fun create_bank(owner: address): Bank {
        Bank {
            total_coins: 0,
            owner
        }
    }

    public fun deposit(bank: &mut Bank, coin: Coin) {
        // TODO: Update the bank's total and "consume" the coin
        // - Add coin.value to bank.total_coins
        // - Coin is implicitly consumed (no "drop", so it's handled)
        bank.total_coins = bank.total_coins + coin.value;
        // coin is dropped/consumed here
    }

    public fun withdraw(bank: &mut Bank, amount: u64): Coin {
        // TODO: Check if bank has enough, then create a coin
        // INVARIANT: bank.total_coins >= amount
        assert!(bank.total_coins >= amount, 1);
        bank.total_coins = bank.total_coins - amount;
        Coin { value: amount }
    }

    public fun test_invariant() {
        let mut bank = create_bank(@0x1);

        // Deposit two coins (100 and 50)
        deposit(&mut bank, Coin { value: 100 });
        deposit(&mut bank, Coin { value: 50 });

        // TODO: Assert the invariant: bank.total_coins == 150
        assert!(bank.total_coins == 150, 1);

        // Withdraw 30
        let coin = withdraw(&mut bank, 30);

        // TODO: Assert the invariant after withdrawal
        assert!(bank.total_coins == 120, 2);
        assert!(coin.value == 30, 3);
    }
}
```

**Your Task:**

1. Implement `deposit` to add coin value and consume the coin
2. Implement `withdraw` to check balance and return a new coin
3. Verify the invariant holds after each operation

---

### Exercise 2: Linear Type Enforcement 🔗

**Scenario:** Create a SpecialResource and demonstrate that the compiler enforces linear behavior.

**Boilerplate Code:**

```move
module spell_library::linear_enforcement {

    struct SpecialResource {  // RESOURCE
        id: u64,
        data: u64
    }

    public fun create(id: u64): SpecialResource {
        SpecialResource { id, data: 100 }
    }

    public fun consume(resource: SpecialResource): u64 {
        // TODO: Extract and return the data
        // resource is consumed (moved into function)
        // Cannot be used after this
        resource.data
    }

    public fun test_linear_behavior() {
        let res = create(1);

        // TODO: Call consume to move the resource
        let data = consume(____);

        // TODO: Verify the data is correct
        assert!(data == 100, 1);

        // TODO: Try to use res again—what happens?
        // Uncomment below to see the error:
        // let data2 = consume(res);  // ❌ ERROR! res was already moved
    }

    public fun test_cannot_copy() {
        let res = create(2);

        // TODO: Try to create two references—this should NOT compile
        // let copy = res;
        // let copy2 = res;
        // ❌ ERROR! After the first assignment, res is moved

        // ✅ This works because we only use it once:
        let final_data = consume(res);
        assert!(final_data == 100, 1);
    }
}
```

**Your Task:**

1. Implement `consume` to extract the resource's data
2. Call `consume` with the resource (this moves it)
3. Verify that using the resource again causes an error
4. Explain why copying is impossible

---

### Exercise 3: Preventing Double-Spend 💰

**Scenario:** Simulate a transaction where resources cannot be accidentally double-spent.

**Boilerplate Code:**

```move
module spell_library::double_spend_prevention {

    struct Token {  // RESOURCE
        amount: u64
    }

    public fun transfer(
        sender_token: Token,
        amount: u64
    ): (Token, Token) {
        // TODO: Split the token into two
        // - remainder: sender_token.amount - amount
        // - payment: amount

        assert!(sender_token.amount >= amount, 1);  // Check balance

        let remainder = Token { value: ____ };
        let payment = Token { value: ____ };

        (remainder, payment)
        // sender_token is CONSUMED (moved)
        // Two new tokens created
    }

    public fun test_no_double_spend() {
        let original = Token { amount: 100 };

        // TODO: Transfer 40 from original
        let (remaining, payment) = transfer(original, 40);

        // TODO: Verify the split
        assert!(remaining.amount == 60, 1);
        assert!(payment.amount == 40, 2);

        // TODO: Try to use original again—what happens?
        // Uncomment below to see the error:
        // let (r2, p2) = transfer(original, 20);  // ❌ ERROR! original was moved
    }
}
```

**Your Task:**

1. Implement the `transfer` function to split a token
2. Verify that the split is correct
3. Explain why the original token cannot be used twice (preventing double-spend)

---

## ✅ Full Answers

### Exercise 1: Complete Solution

```move
module spell_library::bank_invariant {

    struct Coin {  // RESOURCE
        value: u64
    }

    struct Bank {
        total_coins: u64,
        owner: address
    }

    public fun create_bank(owner: address): Bank {
        Bank {
            total_coins: 0,
            owner
        }
    }

    public fun deposit(bank: &mut Bank, coin: Coin) {
        // Add coin value to bank and consume coin
        bank.total_coins = bank.total_coins + coin.value;
        // coin is consumed—it's a resource with no drop ability
    }

    public fun withdraw(bank: &mut Bank, amount: u64): Coin {
        // Check if bank has enough
        assert!(bank.total_coins >= amount, 1);
        bank.total_coins = bank.total_coins - amount;
        Coin { value: amount }
    }

    public fun test_invariant() {
        let mut bank = create_bank(@0x1);

        // Deposit two coins
        deposit(&mut bank, Coin { value: 100 });
        deposit(&mut bank, Coin { value: 50 });

        // Verify invariant
        assert!(bank.total_coins == 150, 1);

        // Withdraw 30
        let coin = withdraw(&mut bank, 30);

        // Verify invariant after withdrawal
        assert!(bank.total_coins == 120, 2);
        assert!(coin.value == 30, 3);
    }
}
```

### Exercise 2: Complete Solution

```move
module spell_library::linear_enforcement {

    struct SpecialResource {  // RESOURCE
        id: u64,
        data: u64
    }

    public fun create(id: u64): SpecialResource {
        SpecialResource { id, data: 100 }
    }

    public fun consume(resource: SpecialResource): u64 {
        // Extract and return the data
        // resource is moved into function
        resource.data
    }

    public fun test_linear_behavior() {
        let res = create(1);

        // Call consume to move the resource
        let data = consume(res);

        // Verify the data
        assert!(data == 100, 1);

        // res is no longer valid—it was moved
    }

    public fun test_cannot_copy() {
        let res = create(2);

        // After first use, res is moved—cannot use again
        let final_data = consume(res);
        assert!(final_data == 100, 1);
    }
}
```

### Exercise 3: Complete Solution

```move
module spell_library::double_spend_prevention {

    struct Token {  // RESOURCE
        amount: u64
    }

    public fun transfer(
        sender_token: Token,
        amount: u64
    ): (Token, Token) {
        // Check sender has enough
        assert!(sender_token.amount >= amount, 1);

        // Split into two tokens
        let remainder = Token { value: sender_token.amount - amount };
        let payment = Token { value: amount };

        (remainder, payment)
        // sender_token is CONSUMED
    }

    public fun test_no_double_spend() {
        let original = Token { amount: 100 };

        // Transfer 40 from original
        let (remaining, payment) = transfer(original, 40);

        // Verify the split
        assert!(remaining.amount == 60, 1);
        assert!(payment.amount == 40, 2);

        // original cannot be used again—it was moved
    }
}
```

---

## 💡 Answers & Explanation

### Exercise 1 Explanation: Resource Invariants

**The invariant:**

```
bank.total_coins = sum of all coins ever deposited - sum of all coins withdrawn
```

**Why the compiler ensures this:**

- `deposit` consumes the coin (resource, no drop) → value added to total
- `withdraw` creates a new coin → value subtracted from total
- Every coin that exists is accounted for

**This is trustless:**

- No need for auditors
- Math proves correctness
- Impossible to corrupt

### Exercise 2 Explanation: Linear Behavior

**Why copy fails:**

```move
let res = create(1);
let copy = res;     // ❌ MOVE (res no longer exists)
// let copy2 = res;  // ❌ ERROR! res is gone
```

**Why drop fails:**

```move
let res = create(1);
// end of scope
// ❌ ERROR! Must explicitly use res
// (unless it has "drop" ability—resources don't)
```

**The guarantee:** Each resource is used exactly once, no more, no less.

### Exercise 3 Explanation: Double-Spend Prevention

**The transfer:**

```move
let original = Token { amount: 100 };
let (remaining, payment) = transfer(original, 40);
// original is CONSUMED in transfer
// Two NEW tokens exist: remaining (60) and payment (40)
```

**Why double-spend is impossible:**

```move
// Total before: 100
// After transfer: remaining (60) + payment (40) = 100
// original is GONE—can't be used again
// Compiler prevents: let (r2, p2) = transfer(original, ...);
```

**The proof:** The compiler ensures that every resource exists in exactly one place at any time.

---

## 🧪 Unit Tests

Here's a comprehensive test file:

```move
#[test_only]
module spell_library::resource_tests {
    use spell_library::bank_invariant;
    use spell_library::linear_enforcement;
    use spell_library::double_spend_prevention;

    #[test]
    fun test_bank_invariant() {
        bank_invariant::test_invariant();
    }

    #[test]
    fun test_bank_multiple_operations() {
        let mut bank = bank_invariant::create_bank(@0x1);

        // Multiple deposits
        bank_invariant::deposit(&mut bank, bank_invariant::Coin { value: 50 });
        bank_invariant::deposit(&mut bank, bank_invariant::Coin { value: 30 });
        bank_invariant::deposit(&mut bank, bank_invariant::Coin { value: 20 });

        // Multiple withdrawals
        let w1 = bank_invariant::withdraw(&mut bank, 25);
        let w2 = bank_invariant::withdraw(&mut bank, 15);

        assert!(bank.total_coins == 60, 1);
        assert!(w1.value == 25, 2);
        assert!(w2.value == 15, 3);
    }

    #[test]
    #[expected_failure(abort_code = 1)]
    fun test_bank_overdraft_fails() {
        let mut bank = bank_invariant::create_bank(@0x1);
        bank_invariant::deposit(&mut bank, bank_invariant::Coin { value: 50 });

        // Try to withdraw more than available
        let _ = bank_invariant::withdraw(&mut bank, 100);  // ❌ Should fail
    }

    #[test]
    fun test_linear_enforcement() {
        linear_enforcement::test_linear_behavior();
        linear_enforcement::test_cannot_copy();
    }

    #[test]
    fun test_double_spend_prevention() {
        double_spend_prevention::test_no_double_spend();
    }

    #[test]
    fun test_token_splitting() {
        let token = double_spend_prevention::Token { amount: 100 };
        let (r1, p1) = double_spend_prevention::transfer(token, 30);
        assert!(r1.amount == 70, 1);
        assert!(p1.amount == 30, 2);

        // Split the remainder
        let (r2, p2) = double_spend_prevention::transfer(r1, 20);
        assert!(r2.amount == 50, 3);
        assert!(p2.amount == 20, 4);
    }

    #[test]
    fun test_resource_conservation() {
        // Total value before
        let t1 = double_spend_prevention::Token { amount: 100 };
        let t2 = double_spend_prevention::Token { amount: 50 };
        // Total: 150

        let (r1, p1) = double_spend_prevention::transfer(t1, 40);
        let (r2, p2) = double_spend_prevention::transfer(t2, 25);

        // Total after: (60 + 40) + (25 + 25) = 150 ✅
        assert!(r1.amount + p1.amount + r2.amount + p2.amount == 150, 1);
    }
}
```

### Running the Tests

```bash
move test
move test -- --verbose
```

---

## 🌟 Closing Story

Lyra watches as Odessa completes her final test, the Bank maintaining its perfect invariant through all operations.

> "Do you understand now?" Lyra asks. "A resource is not just a type. It is a mathematical proof written in code. Every transfer proves that value is conserved. Every withdrawal proves that funds existed. Every operation leaves no room for dishonesty."

Odessa looks at the glowing vault below, watching thousands of transactions flow like a river of light.

> "In old systems, auditors spent years verifying that nobody cheated. Here, the code verifies it in microseconds. Not through trust, not through institutions, but through pure mathematics."

> "You have learned the deepest secret of Move: it makes certain kinds of theft mathematically impossible. You cannot create money from nothing. You cannot spend what you don't have. You cannot hide corruption. The system is not trusted because it is trustless."

Lyra smiles, and the light beneath them grows brighter.

> "But understanding resources is only half the story. Resources must _live_ somewhere. They must be stored, retrieved, and manipulated on the blockchain itself. Tomorrow, you learn the final layer: the Global Storage Model—how resources persists in the vault of the chain itself."

---

**Next Lesson Preview:** 🏛️ _Global Storage Model: Resources in the Vault_

- How Move manages persistent on-chain storage
- Resources as first-class entities on the blockchain
- Publishing and loading resources from global state
- Storage invariants and access control
- Building systems that survive forever

_The final foundation awaits. Are you ready to build eternal systems?_
