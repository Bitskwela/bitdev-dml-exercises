# Abort and Assert in Move

## Opening Scene

The afternoon heat was unforgiving as Odessa burst through the doors of the barangay tech hub, her expression a mix of frustration and determination. She found Neri calmly reviewing code, seemingly unaffected by the chaos outside.

"Ate Neri, we have a problem!" Odessa announced, setting her laptop down with a thud. "Someone tried to withdraw more funds than they deposited in our community savings module. The transaction went through, and now the accounts are all messed up!"

Neri's calm demeanor shifted to concern. "Show me the code."

Odessa pulled up the offending module. The withdrawal function had no safeguards—it blindly processed any amount requested without checking the balance first.

"This is exactly why we need proper error handling," Neri said, pulling up a chair. "In Move, we use `abort` and `assert!` to stop bad transactions in their tracks. Let me show you how to make your code bulletproof."

---

## Topics

### Understanding Abort

"The most direct way to stop execution is `abort`," Neri began. "When Move encounters an abort, it immediately stops the transaction and reverts all changes."

```move
module savings::account {
    const E_INSUFFICIENT_BALANCE: u64 = 1;
    const E_INVALID_AMOUNT: u64 = 2;

    public fun withdraw(balance: u64, amount: u64): u64 {
        if (amount > balance) {
            abort E_INSUFFICIENT_BALANCE
        };
        balance - amount
    }
}
```

Odessa studied the code. "So `abort` takes an error code?"

"Exactly," Neri confirmed. "The error code is a `u64` that helps identify what went wrong. It's convention to define these as constants at the top of your module."

```move
module relief::distribution {
    const E_NOT_REGISTERED: u64 = 1;
    const E_ALREADY_CLAIMED: u64 = 2;
    const E_DISTRIBUTION_CLOSED: u64 = 3;

    public fun claim_relief(
        is_registered: bool,
        has_claimed: bool,
        is_open: bool
    ) {
        if (!is_registered) {
            abort E_NOT_REGISTERED
        };

        if (has_claimed) {
            abort E_ALREADY_CLAIMED
        };

        if (!is_open) {
            abort E_DISTRIBUTION_CLOSED
        };

        // Process the claim...
    }
}
```

### The Assert! Macro

"Writing `if` checks followed by `abort` is common, so Move provides a shortcut," Neri continued. "The `assert!` macro combines both into one line."

```move
module savings::account_v2 {
    const E_INSUFFICIENT_BALANCE: u64 = 1;
    const E_INVALID_AMOUNT: u64 = 2;

    public fun withdraw(balance: u64, amount: u64): u64 {
        assert!(amount > 0, E_INVALID_AMOUNT);
        assert!(balance >= amount, E_INSUFFICIENT_BALANCE);
        balance - amount
    }
}
```

Odessa's eyes widened. "That's so much cleaner!"

"Right? The syntax is `assert!(condition, error_code)`," Neri explained. "If the condition is false, it aborts with the given error code."

```move
module beneficiary::validator {
    const E_UNDERAGE: u64 = 1;
    const E_NOT_RESIDENT: u64 = 2;
    const E_INCOME_TOO_HIGH: u64 = 3;

    public fun validate_eligibility(
        age: u64,
        is_resident: bool,
        monthly_income: u64,
        income_threshold: u64
    ) {
        assert!(age >= 18, E_UNDERAGE);
        assert!(is_resident, E_NOT_RESIDENT);
        assert!(monthly_income <= income_threshold, E_INCOME_TOO_HIGH);

        // Beneficiary is eligible, continue processing...
    }
}
```

### Error Code Conventions

"Let's talk about organizing error codes," Neri said. "A well-structured module makes debugging much easier."

```move
module donation::fund {
    // Error codes: 1xx for validation, 2xx for authorization, 3xx for state
    const E_INVALID_AMOUNT: u64 = 100;
    const E_AMOUNT_TOO_SMALL: u64 = 101;
    const E_AMOUNT_TOO_LARGE: u64 = 102;

    const E_NOT_AUTHORIZED: u64 = 200;
    const E_NOT_ADMIN: u64 = 201;
    const E_NOT_DONOR: u64 = 202;

    const E_FUND_CLOSED: u64 = 300;
    const E_FUND_DEPLETED: u64 = 301;
    const E_ALREADY_WITHDRAWN: u64 = 302;

    public fun donate(amount: u64, is_fund_open: bool) {
        assert!(is_fund_open, E_FUND_CLOSED);
        assert!(amount > 0, E_INVALID_AMOUNT);
        assert!(amount >= 100, E_AMOUNT_TOO_SMALL);

        // Process donation...
    }

    public fun admin_withdraw(
        is_admin: bool,
        fund_balance: u64,
        amount: u64
    ): u64 {
        assert!(is_admin, E_NOT_ADMIN);
        assert!(fund_balance > 0, E_FUND_DEPLETED);
        assert!(amount <= fund_balance, E_INVALID_AMOUNT);

        fund_balance - amount
    }
}
```

Odessa nodded thoughtfully. "So grouping by category makes it clear what type of error occurred?"

"Exactly! When a transaction fails with error code 201, you immediately know it's an authorization issue," Neri confirmed.

### Multiple Validations Pattern

"For complex operations, stack your assertions at the beginning," Neri advised. "This is called the 'fail fast' pattern."

```move
module scholarship::application {
    const E_INVALID_AGE: u64 = 1;
    const E_NOT_ENROLLED: u64 = 2;
    const E_LOW_GRADES: u64 = 3;
    const E_INCOME_TOO_HIGH: u64 = 4;
    const E_ALREADY_APPLIED: u64 = 5;

    public fun apply(
        age: u64,
        is_enrolled: bool,
        grade_average: u64,
        family_income: u64,
        has_existing_application: bool
    ) {
        // Validate all requirements upfront
        assert!(age >= 16 && age <= 25, E_INVALID_AGE);
        assert!(is_enrolled, E_NOT_ENROLLED);
        assert!(grade_average >= 85, E_LOW_GRADES);
        assert!(family_income <= 30000, E_INCOME_TOO_HIGH);
        assert!(!has_existing_application, E_ALREADY_APPLIED);

        // All validations passed, process application...
    }
}
```

### Assert with Abort Together

"Sometimes you need both patterns," Neri showed. "Use `assert!` for simple checks and `abort` for complex conditions."

```move
module voting::election {
    const E_NOT_REGISTERED_VOTER: u64 = 1;
    const E_ALREADY_VOTED: u64 = 2;
    const E_INVALID_CANDIDATE: u64 = 3;
    const E_VOTING_CLOSED: u64 = 4;
    const E_UNDERAGE: u64 = 5;

    public fun cast_vote(
        voter_age: u64,
        is_registered: bool,
        has_voted: bool,
        candidate_id: u64,
        total_candidates: u64,
        voting_open: bool
    ) {
        // Simple checks with assert!
        assert!(voting_open, E_VOTING_CLOSED);
        assert!(voter_age >= 18, E_UNDERAGE);
        assert!(is_registered, E_NOT_REGISTERED_VOTER);
        assert!(!has_voted, E_ALREADY_VOTED);

        // Complex validation with if/abort
        if (candidate_id == 0 || candidate_id > total_candidates) {
            abort E_INVALID_CANDIDATE
        };

        // Record the vote...
    }
}
```

---

## Closing Scene

Odessa quickly refactored her community savings module, adding assertions at every critical point. She ran a test withdrawal with an amount exceeding the balance.

"Transaction aborted with error code 1: Insufficient Balance," she read from the output, a smile spreading across her face. "It works! The bad transaction was stopped."

"And all changes were reverted," Neri added. "That's the beauty of `abort`—it's all or nothing. Either the entire transaction succeeds, or nothing happens at all."

Odessa saved her work, already thinking of other modules that needed similar protection. "So every function that handles money or important data should have these guards?"

"Every function that can fail should clearly communicate why it failed," Neri corrected. "Good error codes are like good documentation—they tell you exactly what went wrong and where to look."

"No more mysterious failures," Odessa said with relief. "Just clear, actionable error messages."

Neri nodded approvingly. "Now you're building robust systems. The blockchain won't let bad data slip through anymore."

---

## Summary

### Abort Statement

- Use `abort error_code` to immediately stop execution
- All changes in the transaction are reverted
- Error codes are `u64` values that identify the failure reason

### Assert! Macro

- Syntax: `assert!(condition, error_code)`
- If condition is false, aborts with the specified error code
- Cleaner alternative to `if (!condition) { abort code }`

### Error Code Conventions

- Define error codes as constants at the module level
- Use descriptive names with `E_` prefix (e.g., `E_INSUFFICIENT_BALANCE`)
- Group related errors by category (validation, authorization, state)
- Use consistent numbering schemes for easier debugging

### Best Practices

- Validate inputs at the beginning of functions (fail fast)
- Use meaningful error codes that indicate the specific problem
- Combine `assert!` for simple checks and `abort` for complex logic
- Document error codes so users understand what each code means
