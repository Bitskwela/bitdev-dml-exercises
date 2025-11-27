# Quiz 25: Conditional Branching

Test your understanding of if/else statements and switch cases!

---

## Quiz 1

### Question 1
What will this code output?
```javascript
let age = 20;

if (age >= 18) {
    console.log("Adult");
} else {
    console.log("Minor");
}
```

A) `Minor`  
B) `Adult`  
C) Nothing  
D) Error

---

### Question 2
What is the output?
```javascript
let score = 85;

if (score >= 90) {
    console.log("Excellent");
} else if (score >= 80) {
    console.log("Very Good");
} else {
    console.log("Good");
}
```

A) `Excellent`  
B) `Very Good`  
C) `Good`  
D) Error

---

### Question 3
What will this code display?
```javascript
let hasID = true;
let age = 16;

if (hasID && age >= 18) {
    console.log("Approved");
} else {
    console.log("Denied");
}
```

A) `Approved`  
B) `Denied`  
C) `true`  
D) Nothing

---

### Question 4
What is the output?
```javascript
let day = 2;

switch (day) {
    case 1:
        console.log("Monday");
        break;
    case 2:
        console.log("Tuesday");
        break;
    default:
        console.log("Other");
}
```

A) `Monday`  
B) `Tuesday`  
C) `Other`  
D) Error

---

### Question 5
What happens if you forget `break` in a switch case?
```javascript
let code = "A";

switch (code) {
    case "A":
        console.log("First");
    case "B":
        console.log("Second");
        break;
    default:
        console.log("Default");
}
```

A) Only `First`  
B) `First` and `Second`  
C) Only `Second`  
D) Error

---

## Quiz 2

### Question 6
What is the output?
```javascript
let name = "";

if (name) {
    console.log("Name provided");
} else {
    console.log("Name missing");
}
```

A) `Name provided`  
B) `Name missing`  
C) `""`  
D) Error

---

### Question 7
What will this code display?
```javascript
let age = 65;
let fee = 50;

if (age >= 60) {
    fee = fee * 0.8;  // 20% discount
}

console.log("Fee: ₱" + fee);
```

A) `Fee: ₱50`  
B) `Fee: ₱40`  
C) `Fee: ₱30`  
D) `Fee: ₱45`

---

### Question 8
What is the output?
```javascript
let x = 10;

if (x > 5) {
    if (x < 15) {
        console.log("Between 5 and 15");
    }
}
```

A) Nothing  
B) `Between 5 and 15`  
C) `true`  
D) Error

---

### Question 9
Which value is NOT falsy in JavaScript?

A) `0`  
B) `""`  
C) `"0"`  
D) `null`

---

### Question 10
What is the output?
```javascript
let applicantAge = 25;
let hasID = false;

if (applicantAge >= 18) {
    if (hasID) {
        console.log("Approved");
    } else {
        console.log("Need ID");
    }
} else {
    console.log("Too young");
}
```

A) `Approved`  
B) `Need ID`  
C) `Too young`  
D) Nothing

---

## Answers

1. **B** - `Adult`
2. **B** - `Very Good`
3. **B** - `Denied`
4. **B** - `Tuesday`
5. **B** - `First` and `Second`
6. **B** - `Name missing`
7. **B** - `Fee: ₱40`
8. **B** - `Between 5 and 15`
9. **C** - `"0"`
10. **B** - `Need ID`

---

## Detailed Explanations

### Question 1: Basic if/else
```javascript
let age = 20;

if (age >= 18) {
    console.log("Adult");
} else {
    console.log("Minor");
}
```

**Answer: B - `Adult`**

**Explanation:**
- `age` is `20`
- Condition: `20 >= 18` is `true`
- So the if block executes: `"Adult"`
- The else block is skipped

**Barangay example:**
```javascript
let applicantAge = 22;

if (applicantAge >= 18) {
    console.log("Eligible for barangay clearance");
} else {
    console.log("Need parent consent");
}
// Output: Eligible for barangay clearance
```

---

### Question 2: if...else if...else
```javascript
let score = 85;

if (score >= 90) {
    console.log("Excellent");
} else if (score >= 80) {
    console.log("Very Good");
} else {
    console.log("Good");
}
```

**Answer: B - `Very Good`**

**Explanation:**
- First condition: `85 >= 90` is `false` (skip)
- Second condition: `85 >= 80` is `true` ✓
- Executes: `"Very Good"`
- Stops checking (doesn't reach else)

**Key point:** Once a condition is true, remaining conditions are not checked.

**Barangay fee classification:**
```javascript
let distance = 3;  // km

if (distance <= 1) {
    console.log("Zone A: ₱50");
} else if (distance <= 3) {
    console.log("Zone B: ₱100");
} else {
    console.log("Zone C: ₱150");
}
// Output: Zone B: ₱100
```

---

### Question 3: Logical AND in conditions
```javascript
let hasID = true;
let age = 16;

if (hasID && age >= 18) {
    console.log("Approved");
} else {
    console.log("Denied");
}
```

**Answer: B - `Denied`**

**Explanation:**
- `hasID` is `true`
- `age >= 18` is `16 >= 18` = `false`
- `true && false` = `false`
- So else block executes: `"Denied"`

**Both conditions must be true for AND:**
```javascript
// Barangay requirements
let hasValidID = true;
let isResident = true;
let hasPayment = false;

if (hasValidID && isResident && hasPayment) {
    console.log("Application approved");
} else {
    console.log("Missing requirements");
}
// Output: Missing requirements (because hasPayment is false)
```

---

### Question 4: Switch statement
```javascript
let day = 2;

switch (day) {
    case 1:
        console.log("Monday");
        break;
    case 2:
        console.log("Tuesday");
        break;
    default:
        console.log("Other");
}
```

**Answer: B - `Tuesday`**

**Explanation:**
- `day` is `2`
- Checks `case 1`: No match
- Checks `case 2`: Match! ✓
- Executes: `"Tuesday"`
- `break` stops execution

**Barangay service selector:**
```javascript
let serviceCode = "RC";

switch (serviceCode) {
    case "CL":
        console.log("Barangay Clearance");
        break;
    case "RC":
        console.log("Residency Certificate");
        break;
    case "IC":
        console.log("Indigency Certificate");
        break;
    default:
        console.log("Unknown service");
}
// Output: Residency Certificate
```

---

### Question 5: Switch without break
```javascript
let code = "A";

switch (code) {
    case "A":
        console.log("First");
    case "B":
        console.log("Second");
        break;
    default:
        console.log("Default");
}
```

**Answer: B - `First` and `Second`**

**Explanation:**
- Matches `case "A"`
- Executes: `"First"`
- **No break!** Continues to next case ("fall-through")
- Executes: `"Second"`
- Encounters `break`, stops

**Output:**
```
First
Second
```

**Always use break:**
```javascript
// Correct way
switch (code) {
    case "A":
        console.log("First");
        break;  // Stop here
    case "B":
        console.log("Second");
        break;
    default:
        console.log("Default");
}
```

---

### Question 6: Falsy values
```javascript
let name = "";

if (name) {
    console.log("Name provided");
} else {
    console.log("Name missing");
}
```

**Answer: B - `Name missing`**

**Explanation:**
- `name` is `""` (empty string)
- Empty string is **falsy**
- So condition is `false`
- else block executes: `"Name missing"`

**Falsy values:**
- `false`
- `0`
- `""` (empty string)
- `null`
- `undefined`
- `NaN`

**Barangay form validation:**
```javascript
let applicantName = "";
let applicantAge = 0;

if (applicantName) {
    console.log("Name OK");
} else {
    console.log("Name required");  // This runs
}

if (applicantAge) {
    console.log("Age OK");
} else {
    console.log("Age required");  // This runs (0 is falsy)
}
```

---

### Question 7: Modifying variables in conditions
```javascript
let age = 65;
let fee = 50;

if (age >= 60) {
    fee = fee * 0.8;  // 20% discount
}

console.log("Fee: ₱" + fee);
```

**Answer: B - `Fee: ₱40`**

**Explanation:**
- Initial fee: `50`
- Condition: `65 >= 60` is `true`
- Apply discount: `50 * 0.8 = 40`
- `fee` becomes `40`
- Output: `"Fee: ₱40"`

**Barangay discount system:**
```javascript
let age = 62;
let isPWD = false;
let baseFee = 100;
let finalFee = baseFee;

if (age >= 60) {
    finalFee = baseFee * 0.8;  // 20% off
    console.log("Senior discount applied");
} else if (isPWD) {
    finalFee = baseFee * 0.8;  // 20% off
    console.log("PWD discount applied");
}

console.log("Final fee: ₱" + finalFee);
// Output:
// Senior discount applied
// Final fee: ₱80
```

---

### Question 8: Nested if statements
```javascript
let x = 10;

if (x > 5) {
    if (x < 15) {
        console.log("Between 5 and 15");
    }
}
```

**Answer: B - `Between 5 and 15`**

**Explanation:**
- Outer condition: `10 > 5` is `true` ✓
- Inner condition: `10 < 15` is `true` ✓
- Both true, so code executes

**Better way (use && operator):**
```javascript
if (x > 5 && x < 15) {
    console.log("Between 5 and 15");
}
```

**Barangay eligibility checker:**
```javascript
let age = 25;
let yearsResident = 3;

// Nested way
if (age >= 18) {
    if (yearsResident >= 1) {
        console.log("Eligible for resident ID");
    }
}

// Better way
if (age >= 18 && yearsResident >= 1) {
    console.log("Eligible for resident ID");
}
```

---

### Question 9: Truthy vs Falsy
**Which value is NOT falsy in JavaScript?**

**Answer: C - `"0"`**

**Explanation:**

**Falsy values (only 6):**
1. `false`
2. `0` (number zero)
3. `""` (empty string)
4. `null`
5. `undefined`
6. `NaN`

**`"0"` is a non-empty string, so it's truthy!**

```javascript
if ("0") {
    console.log("This runs!");  // "0" is truthy
}

if (0) {
    console.log("This doesn't run");  // 0 is falsy
}
```

**Barangay data validation:**
```javascript
let input = "0";

if (input) {
    console.log("Input provided: " + input);
    // Output: Input provided: 0
    // (string "0" is truthy)
}

let number = 0;

if (number) {
    console.log("Number provided");
} else {
    console.log("No number");
    // Output: No number
    // (number 0 is falsy)
}
```

---

### Question 10: Nested conditions
```javascript
let applicantAge = 25;
let hasID = false;

if (applicantAge >= 18) {
    if (hasID) {
        console.log("Approved");
    } else {
        console.log("Need ID");
    }
} else {
    console.log("Too young");
}
```

**Answer: B - `Need ID`**

**Explanation:**
- Outer condition: `25 >= 18` is `true` ✓ (enter outer if)
- Inner condition: `hasID` is `false` ✗ (skip inner if)
- Execute inner else: `"Need ID"`

**Flow:**
1. Check age: OK (25 >= 18)
2. Check ID: Missing (false)
3. Result: "Need ID"

**Complete barangay application checker:**
```javascript
let age = 30;
let hasValidID = true;
let isResident = true;
let hasPayment = false;

if (age >= 18) {
    if (hasValidID) {
        if (isResident) {
            if (hasPayment) {
                console.log("✅ Application APPROVED");
            } else {
                console.log("❌ Payment required");
            }
        } else {
            console.log("❌ Must be barangay resident");
        }
    } else {
        console.log("❌ Valid ID required");
    }
} else {
    console.log("❌ Must be 18 or older");
}
// Output: ❌ Payment required
```

**Better way (flatten with &&):**
```javascript
if (age < 18) {
    console.log("❌ Must be 18 or older");
} else if (!hasValidID) {
    console.log("❌ Valid ID required");
} else if (!isResident) {
    console.log("❌ Must be barangay resident");
} else if (!hasPayment) {
    console.log("❌ Payment required");
} else {
    console.log("✅ Application APPROVED");
}
```

---

**Great job!** You now understand how to make your code make decisions!

---
