# Conditionals in Move

## Opening Scene

The morning sun cast long shadows across the barangay hall as Jaymart arrived with a stack of papers tucked under his arm. He found Neri already at work, her brow furrowed as she studied a complex spreadsheet on her laptop.

"Ate Neri, I've been thinking," Jaymart said, pulling up a chair. "Our relief distribution system works, but it's too rigid. We give the same package to everyone regardless of their situation."

Neri looked up, intrigued. "What do you have in mind?"

"Different families have different needs," Jaymart explained, spreading his papers on the desk. "Senior citizens might need medicine priority. Families with infants need milk and diapers. We should be making decisions based on their circumstances."

A knowing smile crossed Neri's face. "You're describing conditional logic, Jaymart. In Move, we use `if` and `else` to make our smart contracts intelligent enough to handle different situations."

---

## Topics

### Basic If/Else Syntax

Neri pulled up her code editor. "The simplest form of conditional is the `if` statement. It checks a condition and executes code only when that condition is true."

```move
module relief::distribution {
    public fun check_eligibility(age: u64): bool {
        if (age >= 60) {
            return true
        };
        false
    }
}
```

"Notice the syntax," Neri pointed out. "The condition goes in parentheses, followed by a block in curly braces. Unlike some languages, Move requires the parentheses around the condition."

Jaymart nodded. "And when we need to handle the opposite case?"

"That's where `else` comes in," Neri continued.

```move
public fun determine_priority(age: u64): u8 {
    if (age >= 60) {
        1  // High priority
    } else {
        2  // Normal priority
    }
}
```

### If as an Expression

"Here's something powerful about Move," Neri said, her eyes lighting up. "The `if` statement is actually an expression. It returns a value!"

```move
public fun get_allocation(is_senior: bool): u64 {
    let amount = if (is_senior) {
        5000
    } else {
        3000
    };
    amount
}
```

Jaymart leaned forward. "So we can assign the result of an `if` directly to a variable?"

"Exactly! This makes our code cleaner and more expressive," Neri confirmed. "But remember—when using `if` as an expression, both branches must return the same type."

```move
public fun calculate_relief_amount(family_size: u64, has_pwd: bool): u64 {
    let base_amount = family_size * 1000;
    let bonus = if (has_pwd) { 500 } else { 0 };
    base_amount + bonus
}
```

### Nested Conditionals

Jaymart scratched his head. "What if we need to check multiple conditions? Like age AND family size?"

"We can nest conditionals inside each other," Neri explained.

```move
public fun assign_package_type(age: u64, family_size: u64): u8 {
    if (age >= 60) {
        if (family_size > 5) {
            1  // Senior large family package
        } else {
            2  // Senior standard package
        }
    } else {
        if (family_size > 5) {
            3  // Regular large family package
        } else {
            4  // Regular standard package
        }
    }
}
```

"That works, but it can get messy," Jaymart observed.

Neri nodded in agreement. "For cleaner code, we can use `else if` to chain conditions."

```move
public fun determine_aid_category(income: u64): u8 {
    if (income == 0) {
        1  // Priority A - No income
    } else if (income < 10000) {
        2  // Priority B - Below minimum wage
    } else if (income < 20000) {
        3  // Priority C - Low income
    } else {
        4  // Priority D - Standard
    }
}
```

### Conditional Returns

"Sometimes we want to exit a function early based on a condition," Neri added. "This is called an early return pattern."

```move
public fun validate_and_process(age: u64, is_registered: bool): u64 {
    // Early return if not eligible
    if (!is_registered) {
        return 0
    };

    if (age < 18) {
        return 0
    };

    // Main processing logic
    if (age >= 60) {
        5000
    } else {
        3000
    }
}
```

Jaymart studied the code. "So we filter out invalid cases first, then handle the main logic?"

"Precisely! It's called the 'guard clause' pattern," Neri said. "It keeps our main logic clean and easy to follow."

```move
public fun distribute_relief(
    beneficiary_age: u64,
    has_valid_id: bool,
    already_claimed: bool
): u64 {
    // Guard clauses
    if (!has_valid_id) {
        return 0
    };

    if (already_claimed) {
        return 0
    };

    // Main distribution logic
    if (beneficiary_age >= 60) {
        5000
    } else if (beneficiary_age >= 18) {
        3000
    } else {
        2000  // Minor rate with guardian
    }
}
```

---

## Closing Scene

Jaymart sat back, his mind racing with possibilities. "This changes everything, Ate Neri. We can now build a system that truly adapts to each family's needs."

"That's the power of conditional logic," Neri replied, saving her work. "Our smart contracts can now make intelligent decisions, just like we do when we evaluate each case personally."

"It's like teaching the blockchain to think," Jaymart mused.

Neri chuckled. "In a way, yes. But remember—the logic is only as good as the conditions we define. We need to think through every scenario carefully."

Jaymart gathered his papers, already planning the new distribution rules. "I'll draft the complete eligibility criteria. With conditionals, we can finally make our barangay relief system fair and responsive."

"Now you're thinking like a Move developer," Neri said with an approving nod.

---

## Summary

### If/Else Basics

- Use `if (condition) { ... }` to execute code conditionally
- Add `else { ... }` to handle the alternative case
- Parentheses around the condition are required in Move

### If as an Expression

- `if` statements return values and can be assigned to variables
- Both branches must return the same type when used as an expression
- Enables cleaner, more functional code patterns

### Nested Conditionals

- Conditionals can be nested inside each other
- Use `else if` for cleaner chaining of multiple conditions
- Avoid deep nesting for better readability

### Conditional Returns

- Use early returns to filter invalid cases (guard clauses)
- Keep main logic clean by handling edge cases first
- Functions can have multiple return points based on conditions
