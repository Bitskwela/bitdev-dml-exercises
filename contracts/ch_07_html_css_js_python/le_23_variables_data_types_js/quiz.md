# Quiz 1

**Scenario:** Tian is storing barangay resident information in JavaScript variables.

1. Which keyword should Tian use for a value that will change?
   - A. `const`
   - B. `let`
   - C. `var`
   - D. `variable`

2. What data type is `"Barangay San Miguel"`?
   - A. Number
   - B. String
   - C. Boolean
   - D. Object

3. What will `console.log(typeof 42)` output?
   - A. `"string"`
   - B. `"number"`
   - C. `"integer"`
   - D. `42`

4. Which variable declaration will cause an error?
   - A. `let age = 15;`
   - B. `const name = "Tian";`
   - C. `const PI = 3.14; PI = 3.15;`
   - D. `let city = "Batangas"; city = "Manila";`

5. What data type is `true`?
   - A. String
   - B. Number
   - C. Boolean
   - D. Truthy

---

# Quiz 2

**Scenario:** Rhea Joy is creating a barangay visitor counter with JavaScript.

6. What is the output of: `console.log("10" + 5);`?
   - A. `15`
   - B. `"15"`
   - C. `"105"`
   - D. Error

7. Which is the correct way to declare a constant?
   - A. `constant BARANGAY = "San Miguel";`
   - B. `const BARANGAY = "San Miguel";`
   - C. `let const BARANGAY = "San Miguel";`
   - D. `var BARANGAY = "San Miguel";`

8. What is the difference between `null` and `undefined`?
   - A. They are the same
   - B. `null` is intentional, `undefined` is unassigned
   - C. `null` is for numbers, `undefined` is for strings
   - D. `undefined` is newer than `null`

9. Which variable name is INVALID?
   - A. `firstName`
   - B. `first_name`
   - C. `first-name`
   - D. `_firstName`

10. What does `` `Hello, ${name}!` `` use?
    - A. String concatenation
    - B. Template literals
    - C. Variable interpolation
    - D. Both B and C

---

# Answers

1. **B** - `let`
2. **B** - String
3. **B** - `"number"`
4. **C** - `const PI = 3.14; PI = 3.15;`
5. **C** - Boolean
6. **C** - `"105"`
7. **B** - `const BARANGAY = "San Miguel";`
8. **B** - `null` is intentional, `undefined` is unassigned
9. **C** - `first-name`
10. **D** - Both B and C

---

# Explanations

**Question 1:** Use `let` for variables that **will change** (can be reassigned).

```javascript
// Use let for changing values
let visitorCount = 0;
visitorCount = 1;      // ✅ Can change
visitorCount = 2;      // ✅ Can change
visitorCount++;        // ✅ Can increment

// Use const for fixed values
const barangayName = "San Miguel";
barangayName = "New Name";  // ❌ Error: Cannot reassign const

// Don't use var (old, problematic)
var age = 15;  // ❌ Avoid var
```

**When to use each:**

**let** - Values that change:
```javascript
let age = 15;
age = 16;  // Birthday! Age changes

let score = 0;
score = score + 10;  // Score increases

let isOpen = true;
isOpen = false;  // Status changes
```

**const** - Values that don't change:
```javascript
const barangayName = "San Miguel";  // Never changes
const PI = 3.14159;                 // Mathematical constant
const MAX_CAPACITY = 100;           // Fixed limit
const API_KEY = "abc123";           // Configuration
```

**Barangay example:**
```javascript
// Fixed information (const)
const barangayName = "San Miguel";
const barangayCaptain = "Juan Dela Cruz";
const officeAddress = "123 Main St, Batangas";

// Changing information (let)
let currentVisitors = 25;
let todayDate = "2025-11-16";
let queueNumber = 1;

// Update changing values
currentVisitors = currentVisitors + 1;  // ✅ Works
queueNumber++;                          // ✅ Works
barangayName = "New Name";              // ❌ Error!
```

---

**Question 2:** Text enclosed in quotes is a **String** data type.

```javascript
// Strings - Text data
let barangay = "Barangay San Miguel";  // String
let captain = 'Juan Dela Cruz';        // String (single quotes OK)
let address = `123 Main Street`;       // String (backticks for template literals)

console.log(typeof barangay);  // Output: "string"
```

**String examples:**
```javascript
let name = "Tian";
let city = "Batangas";
let message = "Welcome to our barangay!";
let number = "123";  // String, not number! (has quotes)
```

**Not strings:**
```javascript
let age = 15;           // Number (no quotes)
let isOpen = true;      // Boolean
let count = null;       // Null
```

**String operations:**
```javascript
let firstName = "Rhea";
let lastName = "Joy";

// Concatenation
let fullName = firstName + " " + lastName;
console.log(fullName);  // "Rhea Joy"

// Template literals (modern)
let greeting = `Hello, ${firstName}!`;
console.log(greeting);  // "Hello, Rhea!"

// String properties
console.log(fullName.length);        // 8 (number of characters)
console.log(fullName.toUpperCase()); // "RHEA JOY"
```

**Barangay data:**
```javascript
const serviceName = "Barangay Clearance";     // String
const processingDays = "3-5 days";            // String
const requirements = "Valid ID, 2x2 photo";   // String

console.log(typeof serviceName);     // "string"
console.log(typeof processingDays);  // "string"
```

---

**Question 3:** `typeof 42` returns `"number"` because 42 is a number.

```javascript
console.log(typeof 42);        // "number"
console.log(typeof 99.99);     // "number"
console.log(typeof -5);        // "number"
console.log(typeof 0);         // "number"
```

**typeof operator checks data type:**

```javascript
// Numbers
console.log(typeof 15);           // "number"
console.log(typeof 3.14);         // "number"

// Strings
console.log(typeof "Hello");      // "string"
console.log(typeof "123");        // "string" (quotes make it string!)

// Boolean
console.log(typeof true);         // "boolean"
console.log(typeof false);        // "boolean"

// Undefined
console.log(typeof undefined);    // "undefined"

// Null (quirk!)
console.log(typeof null);         // "object" (JavaScript bug)
```

**Barangay visitor counter:**
```javascript
let visitorCount = 1250;
let barangayName = "San Miguel";
let isOpen = true;

console.log(typeof visitorCount);  // "number"
console.log(typeof barangayName);  // "string"
console.log(typeof isOpen);        // "boolean"

// Checking before operations
if (typeof visitorCount === "number") {
    visitorCount = visitorCount + 1;  // Safe to add
}
```

**Common mistake:**
```javascript
let age = "15";  // String (has quotes)
console.log(typeof age);  // "string"

let ageNumber = 15;  // Number (no quotes)
console.log(typeof ageNumber);  // "number"

// Different types!
console.log(age === ageNumber);  // false
```

---

**Question 4:** Reassigning a `const` variable causes an error.

```javascript
// Option A - Valid
let age = 15;  // ✅ let can be reassigned

// Option B - Valid
const name = "Tian";  // ✅ const declaration is fine

// Option C - ERROR
const PI = 3.14;
PI = 3.15;  // ❌ Error: Assignment to constant variable

// Option D - Valid
let city = "Batangas";
city = "Manila";  // ✅ let can be reassigned
```

**const cannot be reassigned:**
```javascript
const barangayName = "San Miguel";
barangayName = "New Name";  // ❌ Error!

const maxCapacity = 100;
maxCapacity = 150;  // ❌ Error!

const services = ["Clearance", "Certificate"];
services = ["Permit"];  // ❌ Error! (can't reassign array)
```

**let can be reassigned:**
```javascript
let count = 0;
count = 1;     // ✅ OK
count = 2;     // ✅ OK
count++;       // ✅ OK

let status = "open";
status = "closed";  // ✅ OK
```

**Note:** `const` objects/arrays can have their contents modified:
```javascript
const resident = {
    name: "Juan",
    age: 25
};

// Can modify properties
resident.age = 26;  // ✅ OK (modifying property)

// But can't reassign the whole object
resident = { name: "Pedro" };  // ❌ Error!
```

**Best practice:**
```javascript
// Use const by default
const barangayName = "San Miguel";
const captain = "Juan Dela Cruz";

// Only use let when value will change
let visitorCount = 0;
let currentDate = "2025-11-16";
```

---

**Question 5:** `true` and `false` are **Boolean** data type.

```javascript
let isOpen = true;      // Boolean
let hasLicense = false; // Boolean

console.log(typeof true);   // "boolean"
console.log(typeof false);  // "boolean"
```

**Boolean values:**
- Only two possible values: `true` or `false`
- Used for yes/no, on/off, present/absent
- Result of comparisons

**Examples:**
```javascript
// Direct assignment
let isStudent = true;
let hasCar = false;
let isRaining = true;

// From comparisons
let age = 17;
let isAdult = age >= 18;  // false (17 is not >= 18)

let score = 85;
let isPassing = score >= 75;  // true (85 >= 75)

// From logical operations
let hasID = true;
let isResident = true;
let canApply = hasID && isResident;  // true (both are true)
```

**Barangay office status:**
```javascript
const isWeekday = true;
const isHoliday = false;
let isOpen = isWeekday && !isHoliday;  // true

console.log("Office is open:", isOpen);  // Office is open: true

if (isOpen) {
    console.log("Welcome! Office hours: 8AM-5PM");
} else {
    console.log("Sorry, office is closed.");
}
```

**Service eligibility:**
```javascript
let applicantAge = 25;
let hasValidID = true;
let isResident = true;

// Check eligibility
let isEligible = applicantAge >= 18 && hasValidID && isResident;
console.log("Eligible for service:", isEligible);  // true
```

**Not Boolean:**
```javascript
let status = "true";   // ❌ String, not boolean!
let active = 1;        // ❌ Number, not boolean!
let enabled = "yes";   // ❌ String, not boolean!

// These are booleans:
let status = true;     // ✅ Boolean
let active = false;    // ✅ Boolean
let enabled = age >= 18;  // ✅ Boolean (result of comparison)
```

---

**Question 6:** `"10" + 5` outputs `"105"` (string concatenation, not addition).

```javascript
console.log("10" + 5);   // "105" (string concatenation)
console.log(10 + 5);     // 15 (number addition)
```

**Why "105" not 15?**
- First operand is string (`"10"`)
- JavaScript converts number `5` to string `"5"`
- Concatenates: `"10" + "5"` = `"105"`

**String + Number = String:**
```javascript
console.log("Age: " + 15);      // "Age: 15"
console.log("Score: " + 100);   // "Score: 100"
console.log("10" + 20);         // "1020"
console.log("5" + "5");         // "55"
```

**Number + Number = Number:**
```javascript
console.log(10 + 5);    // 15
console.log(100 + 50);  // 150
```

**Barangay fee calculation problem:**
```javascript
let baseFee = "50";  // ❌ String! (from form input)
let additionalFee = 20;

let total = baseFee + additionalFee;
console.log(total);  // "5020" ❌ Wrong! String concatenation

// Fix: Convert string to number
let baseFeeNumber = Number(baseFee);
let totalCorrect = baseFeeNumber + additionalFee;
console.log(totalCorrect);  // 70 ✅ Correct!

// Or use parseInt
let totalFixed = parseInt(baseFee) + additionalFee;
console.log(totalFixed);  // 70 ✅ Correct!
```

**Other operators convert to number:**
```javascript
console.log("10" - 5);   // 5 (subtraction converts to number)
console.log("10" * 2);   // 20 (multiplication converts)
console.log("10" / 2);   // 5 (division converts)
console.log("10" % 3);   // 1 (modulo converts)

// Only + does concatenation with strings
```

**Safe practice:**
```javascript
// Always convert string numbers before math
let input = "100";
let fee = Number(input) + 50;  // 150 ✅

// Or use template literals for display
let display = `Total: ${Number(input) + 50}`;  // "Total: 150"
```

---

**Question 7:** Use `const` keyword to declare constants (fixed values).

```javascript
// Correct
const BARANGAY = "San Miguel";  // ✅

// Wrong
constant BARANGAY = "San Miguel";  // ❌ No such keyword
let const BARANGAY = "San Miguel"; // ❌ Can't combine let and const
var BARANGAY = "San Miguel";       // ❌ var is for variables, not constants
```

**const declaration syntax:**
```javascript
const VARIABLE_NAME = value;
```

**Barangay constants:**
```javascript
// Configuration values (never change)
const BARANGAY_NAME = "San Miguel";
const BARANGAY_CAPTAIN = "Juan Dela Cruz";
const OFFICE_ADDRESS = "123 Main St, Batangas";
const MAX_QUEUE = 50;
const CLEARANCE_FEE = 50;

// These cannot be changed
BARANGAY_NAME = "New Name";  // ❌ Error!
MAX_QUEUE = 100;             // ❌ Error!
```

**Naming convention for constants:**
```javascript
// ALL_CAPS for true constants (configuration)
const API_KEY = "abc123";
const MAX_RETRIES = 3;
const DEFAULT_LANG = "en";

// camelCase for regular const (won't change but not config)
const userName = "Tian";
const currentDate = "2025-11-16";
const serviceList = ["Clearance", "Certificate"];
```

**Must initialize immediately:**
```javascript
const barangay;  // ❌ Error: Missing initializer

const barangay = "San Miguel";  // ✅ Correct
```

---

**Question 8:** `null` is **intentionally set to empty**, `undefined` means **not yet assigned**.

```javascript
// undefined - Not assigned yet
let name;
console.log(name);  // undefined (declared but no value)

// null - Intentionally empty
let selectedService = null;  // Explicitly "no selection"
```

**undefined examples:**
```javascript
let age;                    // undefined (no value assigned)
let city = undefined;       // undefined (explicitly set)

function getName() {
    // No return statement
}
console.log(getName());     // undefined (function returns nothing)

let person = { name: "Tian" };
console.log(person.age);    // undefined (property doesn't exist)
```

**null examples:**
```javascript
let selectedResident = null;     // No resident selected yet
let currentApplication = null;   // No active application
let errorMessage = null;         // No error (intentional)

// Later, assign a value
selectedResident = "Juan Dela Cruz";
currentApplication = { id: 123, service: "Clearance" };
```

**Practical difference:**
```javascript
// Barangay application form
let applicantName;              // undefined (not filled yet)
let middleName = null;          // null (applicant has no middle name)
let suffix = null;              // null (no suffix like Jr., Sr.)

console.log(typeof applicantName);  // "undefined"
console.log(typeof middleName);     // "object" (quirk!)

// Checking for values
if (applicantName === undefined) {
    console.log("Name not provided");  // This runs
}

if (middleName === null) {
    console.log("No middle name");     // This runs
}
```

**Best practice:**
```javascript
// Use null when you intentionally want "no value"
let selectedDocument = null;  // No document selected

// undefined happens automatically
let temp;  // undefined
```

---

**Question 9:** `first-name` is invalid because **hyphens are not allowed** in variable names.

```javascript
// Valid names
let firstName = "Tian";      // ✅ camelCase (recommended)
let first_name = "Rhea";     // ✅ snake_case
let _firstName = "Miguel";   // ✅ Can start with underscore
let $price = 100;            // ✅ Can use $
let name2 = "Juan";          // ✅ Can contain numbers (not start)

// Invalid names
let first-name = "Joy";      // ❌ No hyphens!
let 2name = "Pedro";         // ❌ Can't start with number
let first name = "Maria";    // ❌ No spaces!
let let = 5;                 // ❌ Can't use keywords
```

**Variable naming rules:**

**Can use:**
- Letters (a-z, A-Z)
- Numbers (0-9, but not first character)
- Underscore (_)
- Dollar sign ($)

**Cannot use:**
- Hyphens (-)
- Spaces
- Special characters (@, #, %, etc.)
- Reserved keywords (let, const, if, for, etc.)

**Barangay variables:**
```javascript
// ✅ Good names (camelCase)
let residentName = "Juan Dela Cruz";
let birthDate = "1990-01-15";
let contactNumber = "09171234567";
let homeAddress = "123 Main St";
let isResident = true;

// ❌ Bad names
let resident-name = "Juan";    // ❌ Hyphen
let birth date = "1990-01-15"; // ❌ Space
let 123id = "ID001";           // ❌ Starts with number
let contact# = "09171234567";  // ❌ Special character
```

**Reserved keywords (can't use):**
```javascript
let let = 5;        // ❌ 'let' is keyword
let const = 10;     // ❌ 'const' is keyword
let if = true;      // ❌ 'if' is keyword
let function = 20;  // ❌ 'function' is keyword
```

**Best practices:**
```javascript
// Use descriptive, camelCase names
let applicantAge = 25;         // ✅ Clear and readable
let totalProcessingFee = 150;  // ✅ Descriptive
let hasValidID = true;         // ✅ Boolean (starts with is/has)

// Avoid short, unclear names
let a = 25;        // ❌ What is 'a'?
let x = 150;       // ❌ What is 'x'?
let flag = true;   // ❌ What flag?
```

---

**Question 10:** Backticks (`` ` ``) create **template literals** which allow **variable interpolation** using `${}` syntax.

```javascript
let name = "Tian";

// Template literal (backticks)
let greeting = `Hello, ${name}!`;
console.log(greeting);  // "Hello, Tian!"

// Old way (concatenation)
let greetingOld = "Hello, " + name + "!";
console.log(greetingOld);  // "Hello, Tian!"
```

**Template literals features:**

**1. Variable interpolation:**
```javascript
let firstName = "Rhea";
let lastName = "Joy";
let age = 15;

let message = `My name is ${firstName} ${lastName} and I'm ${age} years old.`;
console.log(message);
// "My name is Rhea Joy and I'm 15 years old."
```

**2. Expression evaluation:**
```javascript
let price = 100;
let quantity = 3;

let total = `Total: ₱${price * quantity}`;
console.log(total);  // "Total: ₱300"

let message = `You are ${age >= 18 ? 'adult' : 'minor'}`;
console.log(message);  // "You are minor"
```

**3. Multi-line strings:**
```javascript
let address = `Barangay San Miguel
Main Street, Building 123
Batangas City, Philippines`;

console.log(address);
// Barangay San Miguel
// Main Street, Building 123
// Batangas City, Philippines
```

**Barangay application:**
```javascript
const serviceName = "Barangay Clearance";
const applicantName = "Juan Dela Cruz";
const processingFee = 50;
const processingDays = 3;

// Template literal for formatted message
let confirmation = `
=== Application Confirmation ===
Service: ${serviceName}
Applicant: ${applicantName}
Fee: ₱${processingFee}
Processing Time: ${processingDays} days
Total Amount: ₱${processingFee}
Thank you for your application!
`;

console.log(confirmation);
```

**Comparison:**
```javascript
// Concatenation (old way, harder to read)
let msg = "Name: " + name + ", Age: " + age + ", City: " + city;

// Template literal (modern, cleaner)
let msg = `Name: ${name}, Age: ${age}, City: ${city}`;
```

**Dynamic HTML generation:**
```javascript
let residentName = "Juan Dela Cruz";
let status = "Active";

let html = `
<div class="resident-card">
    <h3>${residentName}</h3>
    <p>Status: ${status}</p>
</div>
`;

document.body.innerHTML = html;
```

---