# Pattern Matching in Move

## Opening Scene

EJ burst into the community center, laptop bag swinging wildly. "Ate Neri! I've been wrestling with this code all morning!"

Neri looked up from her workstation, eyebrows raised at EJ's dramatic entrance. "What's got you so worked up?"

"I'm building a beneficiary classification system," EJ explained, setting up his laptop beside her. "Each beneficiary has a struct with multiple fields—age, income, family size, PWD status. I need to check different combinations, but my code is turning into a nightmare of nested if-statements."

Neri nodded knowingly. "You're describing a classic pattern matching problem. Move has elegant ways to destructure data and match against patterns. Let me show you how to tame that complexity."

EJ's eyes lit up. "Pattern matching? Like recognizing shapes in data?"

"Something like that," Neri smiled. "It's about breaking down structured data and making decisions based on its components."

---

## Topics

### Destructuring Basics

"Let's start with destructuring," Neri began. "When you have a struct, you can break it apart to access its fields directly."

```move
module community::classifier {
    struct Beneficiary has copy, drop {
        age: u64,
        income: u64,
        family_size: u64,
    }

    public fun analyze_beneficiary(b: Beneficiary): u64 {
        // Destructure the struct into individual variables
        let Beneficiary { age, income, family_size } = b;

        // Now we can use age, income, family_size directly
        if (age >= 60 && income < 10000) {
            1  // Priority senior
        } else if (family_size > 5) {
            2  // Large family
        } else {
            3  // Standard
        }
    }
}
```

"So instead of writing `b.age`, `b.income` everywhere, we extract them all at once?" EJ asked.

"Exactly! It's cleaner and makes your intent clear. You're declaring upfront which fields you care about."

### Renaming During Destructuring

"Sometimes field names don't match what you want to use locally," Neri continued.

```move
struct BeneficiaryRecord has copy, drop {
    beneficiary_age: u64,
    monthly_income: u64,
    household_members: u64,
}

public fun process_record(record: BeneficiaryRecord): bool {
    // Rename fields during destructuring
    let BeneficiaryRecord {
        beneficiary_age: age,
        monthly_income: income,
        household_members: family_size
    } = record;

    age >= 18 && income < 20000 && family_size > 0
}
```

EJ nodded. "That's much more readable than using long field names throughout the function."

### Partial Destructuring

"What if I only need some fields?" EJ asked.

"You can ignore fields you don't need," Neri explained.

```move
struct FullRecord has copy, drop {
    id: u64,
    name_hash: u256,
    age: u64,
    income: u64,
    registration_date: u64,
    last_updated: u64,
}

public fun check_age_eligibility(record: FullRecord): bool {
    // We only care about age, ignore the rest
    let FullRecord {
        id: _,
        name_hash: _,
        age,
        income: _,
        registration_date: _,
        last_updated: _
    } = record;

    age >= 18
}
```

"The underscore `_` means 'I don't care about this value,'" Neri explained. "The compiler won't create unused variables."

### Destructuring Nested Structs

"Real data often has structs inside structs," Neri said, building a more complex example.

```move
struct Address has copy, drop {
    barangay_code: u64,
    zone: u64,
}

struct Person has copy, drop {
    age: u64,
    address: Address,
}

public fun is_local_senior(person: Person): bool {
    // Destructure nested structs
    let Person {
        age,
        address: Address { barangay_code, zone: _ }
    } = person;

    age >= 60 && barangay_code == 101
}
```

EJ's eyes widened. "We can go multiple levels deep!"

"As deep as your data structures go," Neri confirmed.

### Matching Struct Fields in Conditions

"Now let's combine destructuring with conditional logic for powerful pattern matching," Neri said.

```move
struct Applicant has copy, drop {
    is_senior: bool,
    is_pwd: bool,
    is_solo_parent: bool,
    income_bracket: u8,
}

public fun determine_aid_package(applicant: Applicant): u8 {
    let Applicant {
        is_senior,
        is_pwd,
        is_solo_parent,
        income_bracket
    } = applicant;

    // Match against field combinations
    if (is_senior && is_pwd) {
        1  // Maximum assistance
    } else if (is_senior || is_pwd) {
        if (income_bracket < 2) {
            2  // High priority
        } else {
            3  // Priority
        }
    } else if (is_solo_parent && income_bracket < 3) {
        4  // Solo parent support
    } else if (income_bracket < 2) {
        5  // Low income support
    } else {
        6  // Standard package
    }
}
```

### Destructuring in Function Parameters

"Here's a pro tip," Neri added. "You can destructure right in the function signature!"

```move
struct Coordinates has copy, drop {
    x: u64,
    y: u64,
}

struct Zone has copy, drop {
    zone_id: u64,
    coords: Coordinates,
    population: u64,
}

// Destructure in parameter
public fun get_zone_density(Zone { zone_id: _, coords, population }: Zone): u64 {
    let Coordinates { x, y } = coords;
    let area = x * y;
    if (area == 0) {
        0
    } else {
        population / area
    }
}
```

EJ sat back, impressed. "So the struct is taken apart as soon as it enters the function?"

"Exactly. It makes clear which parts of the input you're actually using."

### Practical Pattern Matching Example

"Let me show you a real-world pattern," Neri said, writing a comprehensive example.

```move
struct ClaimRequest has copy, drop {
    claimant_age: u64,
    claimant_income: u64,
    has_valid_id: bool,
    previous_claims: u64,
}

struct ClaimResult has copy, drop {
    approved: bool,
    amount: u64,
    reason_code: u8,
}

public fun process_claim(request: ClaimRequest): ClaimResult {
    let ClaimRequest {
        claimant_age: age,
        claimant_income: income,
        has_valid_id,
        previous_claims
    } = request;

    // Guard: Must have valid ID
    if (!has_valid_id) {
        return ClaimResult { approved: false, amount: 0, reason_code: 1 }
    };

    // Guard: Claim limit
    if (previous_claims >= 3) {
        return ClaimResult { approved: false, amount: 0, reason_code: 2 }
    };

    // Calculate amount based on pattern matching
    let amount = if (age >= 60 && income < 10000) {
        5000  // Senior low income
    } else if (age >= 60) {
        3000  // Senior
    } else if (income < 10000) {
        2500  // Low income
    } else {
        1500  // Standard
    };

    ClaimResult { approved: true, amount, reason_code: 0 }
}
```

---

## Closing Scene

EJ leaned back from his laptop, a satisfied grin on his face. His once-tangled classification code now read like a clear decision tree.

"This is exactly what I needed, Ate Neri," he said. "Destructuring makes my intent so much clearer. Instead of `applicant.household.address.barangay_code`, I can just extract what I need upfront."

"That's the philosophy," Neri agreed. "Pattern matching is about declaring what structure you expect and what parts matter to you. The code becomes self-documenting."

EJ saved his refactored module. "And matching against field combinations feels so natural. It's like describing rules in plain language."

"The best code often does feel like that," Neri said. "When you can read your conditions and understand the business logic without mental translation, you've written good code."

"One more tool in the toolbox," EJ said, closing his laptop with satisfaction. "I'm going to refactor all my old classification code with this."

Neri laughed. "That's the spirit! Just remember—pattern matching is powerful, but keep it readable. If your patterns get too complex, consider breaking them into smaller functions."

---

## Summary

### Destructuring Basics

- Use `let StructName { field1, field2 } = value` to extract fields
- Creates local variables with the same names as the struct fields
- Makes code cleaner by avoiding repeated struct access

### Renaming Fields

- Use `field_name: new_name` syntax to rename during destructuring
- Helpful when field names are verbose or conflict with local variables

### Ignoring Fields

- Use `_` to ignore fields you don't need
- Prevents unused variable warnings
- Documents which fields are intentionally unused

### Nested Destructuring

- Destructure structs inside structs in one pattern
- Works to arbitrary depth
- Extract only the nested fields you need

### Function Parameter Destructuring

- Destructure directly in function parameters
- Makes dependencies on specific fields explicit
- Useful for functions that only use part of a struct

### Matching Patterns

- Combine destructuring with conditional logic
- Match against combinations of field values
- Use guard clauses for validation before main logic
