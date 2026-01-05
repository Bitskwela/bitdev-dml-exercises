### Smart contract activity

```move
module community::aid_classifier {

    /// Beneficiary record with multiple eligibility fields
    struct Beneficiary has copy, drop {
        age: u64,
        income: u64,
        family_size: u64,
        is_pwd: bool,
    }

    /// Address information for a resident
    struct Address has copy, drop {
        barangay_code: u64,
        zone: u64,
    }

    /// Full resident record with nested address
    struct Resident has copy, drop {
        id: u64,
        age: u64,
        address: Address,
    }

    // TODO: Implement classify_beneficiary function

    // TODO: Implement calculate_aid_amount function

    // TODO: Implement is_local_senior function

    // TODO: Implement get_zone_priority function
}
```

## Tasks for Learners

- Implement `classify_beneficiary` using basic destructuring to extract fields and return a category:

  - Senior (age >= 60) gets category 1
  - PWD gets category 2
  - Large family (family_size > 5) gets category 3
  - Low income (income < 15000) gets category 4
  - Otherwise category 5

  ```move
  public fun classify_beneficiary(b: Beneficiary): u8 {
      let Beneficiary { age, income, family_size, is_pwd } = b;

      if (age >= 60) {
          1
      } else if (is_pwd) {
          2
      } else if (family_size > 5) {
          3
      } else if (income < 15000) {
          4
      } else {
          5
      }
  }
  ```

- Implement `calculate_aid_amount` using destructuring with renamed fields:

  - Base amount is 1000
  - Add 500 if age >= 60
  - Add 500 if is_pwd
  - Add 200 for each family member above 4

  ```move
  public fun calculate_aid_amount(b: Beneficiary): u64 {
      let Beneficiary {
          age: beneficiary_age,
          income: _,
          family_size: members,
          is_pwd: has_disability
      } = b;

      let mut amount = 1000;
      if (beneficiary_age >= 60) {
          amount = amount + 500;
      };
      if (has_disability) {
          amount = amount + 500;
      };
      if (members > 4) {
          amount = amount + ((members - 4) * 200);
      };
      amount
  }
  ```

- Implement `is_local_senior` using nested struct destructuring:

  - Extract age from Resident and barangay_code from nested Address
  - Return true if age >= 60 AND barangay_code == 101

  ```move
  public fun is_local_senior(resident: Resident): bool {
      let Resident {
          id: _,
          age,
          address: Address { barangay_code, zone: _ }
      } = resident;

      age >= 60 && barangay_code == 101
  }
  ```

- Implement `get_zone_priority` using destructuring in the function parameter:

  - Zone 1 with population > 1000 returns priority 1
  - Zone 1 otherwise returns priority 2
  - Zone 2 returns priority 3
  - Other zones return priority 4

  ```move
  public fun get_zone_priority(Address { barangay_code: _, zone }: Address, population: u64): u8 {
      if (zone == 1) {
          if (population > 1000) { 1 } else { 2 }
      } else if (zone == 2) {
          3
      } else {
          4
      }
  }
  ```

### Breakdown for learners

- Basic Destructuring:

  - Extract struct fields into local variables: `let Struct { field1, field2 } = value;`
  - Fields become directly accessible without dot notation
  - Makes intent clear about which fields are used

- Renaming During Destructuring:

  - Use colon to rename: `let Struct { old_name: new_name } = value;`
  - Useful when field names are long or unclear
  - Improves local code readability

- Ignoring Fields:

  - Use underscore to ignore: `let Struct { used_field, ignored: _ } = value;`
  - Compiler won't warn about unused variables
  - Explicitly shows which fields are not needed

- Nested Destructuring:

  - Destructure structs within structs in one pattern
  - `let Outer { inner: Inner { field } } = value;`
  - Avoids multiple let statements for nested access

- Parameter Destructuring:

  - Destructure directly in function signature
  - Reduces boilerplate at function start
  - Makes API clearer about which fields are used
