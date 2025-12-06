# Quiz 29: Logic Mini Project

Test your understanding of the complete Barangay Service Portal system!

---

## Quiz 1

### Question 1
What data structure stores all visitors in the system?

A) Object  
B) Array  
C) String  
D) Number

---

### Question 2
What does the `nextId` variable do?

A) Stores current visitor count  
B) Generates unique IDs for new visitors  
C) Tracks completed visitors  
D) Calculates total fees

---

### Question 3
Which discount applies to a 65-year-old visitor?

A) No discount  
B) PWD discount (20%)  
C) Senior discount (20%)  
D) Both senior and PWD (40%)

---

### Question 4
What does `isValidService()` function check?

A) If visitor age is valid  
B) If service type exists in CONFIG  
C) If discount is applicable  
D) If visitor name is provided

---

### Question 5
How does `calculateFee()` determine the final fee?

A) Always returns base fee  
B) Applies discount based on age or PWD status  
C) Uses random discount  
D) Asks user for discount amount

---

## Quiz 2

### Question 6
What happens if you call `addVisitor()` with an empty name?

A) Adds visitor anyway  
B) Returns error message and false  
C) Crashes the program  
D) Uses default name "Guest"

---

### Question 7
How does `searchVisitor()` work?

A) Only searches by ID  
B) Only searches by name  
C) Searches by both ID and partial name match  
D) Requires exact name match

---

### Question 8
What does `processVisitor()` function do?

A) Adds new visitor  
B) Changes visitor status to "completed"  
C) Calculates visitor fee  
D) Deletes visitor

---

### Question 9
In `generateReport()`, what does it calculate?

A) Only total visitors  
B) Only total revenue  
C) Comprehensive stats: visitors, revenue, discounts, service breakdown  
D) Only senior citizen count

---

### Question 10
Why use functions instead of writing all code in one place?

A) Makes code longer  
B) Organizes code, makes it reusable and easier to maintain  
C) No particular reason  
D) Required by JavaScript

---

## Answers

1. **B** - Array
2. **B** - Generates unique IDs for new visitors
3. **C** - Senior discount (20%)
4. **B** - If service type exists in CONFIG
5. **B** - Applies discount based on age or PWD status
6. **B** - Returns error message and false
7. **C** - Searches by both ID and partial name match
8. **B** - Changes visitor status to "completed"
9. **C** - Comprehensive stats: visitors, revenue, discounts, service breakdown
10. **B** - Organizes code, makes it reusable and easier to maintain

---

## Detailed Explanations

### Question 1: Data structure for visitors
**Answer: B - Array**

**Explanation:**
```javascript
let visitors = [];  // Array stores multiple visitors
```

- **Array** is used because we need to store multiple visitor objects
- Each visitor is an object with properties (name, age, service, etc.)
- Array allows us to:
  - Add new visitors with `push()`
  - Loop through all visitors
  - Search by index
  - Count with `.length`

**Example:**
```javascript
let visitors = [
    { id: 1, name: "Juan", age: 25 },
    { id: 2, name: "Maria", age: 65 },
    { id: 3, name: "Pedro", age: 30 }
];

console.log("Total visitors: " + visitors.length);  // 3
```

**Why not other options?**
- Object: Would store one visitor, not a list
- String: Can't store structured data
- Number: Only stores numeric values

---

### Question 2: nextId variable
**Answer: B - Generates unique IDs for new visitors**

**Explanation:**
```javascript
let nextId = 1;  // Start at 1

function addVisitor(name, age, serviceType, isPWD) {
    const visitor = {
        id: nextId++,  // Use current value, then increment
        name: name,
        // ...
    };
}
```

**How it works:**
- Starts at 1
- Each new visitor gets current `nextId` value
- `nextId++` increments for next visitor
- Ensures every visitor has unique ID

**Example:**
```javascript
addVisitor("Juan", 25, "clearance", false);  // Gets ID 1, nextId becomes 2
addVisitor("Maria", 65, "residency", false); // Gets ID 2, nextId becomes 3
addVisitor("Pedro", 30, "indigency", true);  // Gets ID 3, nextId becomes 4
```

---

### Question 3: Senior citizen discount
**Answer: C - Senior discount (20%)**

**Explanation:**
```javascript
function calculateFee(visitor) {
    // ...
    if (visitor.age >= 60) {
        discount = baseFee * CONFIG.discounts.senior;  // 20%
        discountReason = "Senior Citizen (20%)";
    } else if (visitor.isPWD) {
        discount = baseFee * CONFIG.discounts.pwd;  // 20%
        discountReason = "PWD (20%)";
    }
    // ...
}
```

**Logic:**
- Age 65 >= 60, so qualifies as senior
- Gets 20% discount
- PWD discount is checked with `else if`, so not applied if already senior

**Examples:**
```javascript
// Age 65, base fee ₱100
// Discount: ₱100 × 0.20 = ₱20
// Final: ₱100 - ₱20 = ₱80

// Age 30, PWD, base fee ₱100
// Discount: ₱100 × 0.20 = ₱20
// Final: ₱100 - ₱20 = ₱80

// Age 25, not PWD, base fee ₱100
// No discount
// Final: ₱100
```

---

### Question 4: isValidService() function
**Answer: B - If service type exists in CONFIG**

**Explanation:**
```javascript
function isValidService(serviceType) {
    return CONFIG.services.hasOwnProperty(serviceType);
}
```

**Purpose:** Validate service type before creating visitor

**Valid services:**
```javascript
const CONFIG = {
    services: {
        clearance: { name: "Barangay Clearance", fee: 50 },
        residency: { name: "Residency Certificate", fee: 30 },
        indigency: { name: "Indigency Certificate", fee: 20 },
        permit: { name: "Business Permit", fee: 100 }
    }
};
```

**Examples:**
```javascript
isValidService("clearance");  // true (exists)
isValidService("residency");  // true (exists)
isValidService("license");    // false (doesn't exist)
isValidService("unknown");    // false (doesn't exist)
```

**Usage in addVisitor():**
```javascript
if (!isValidService(serviceType)) {
    console.log("❌ Error: Invalid service type");
    return false;
}
```

---

### Question 5: calculateFee() logic
**Answer: B - Applies discount based on age or PWD status**

**Explanation:**
```javascript
function calculateFee(visitor) {
    const baseFee = service.fee;
    let finalFee = baseFee;
    let discount = 0;
    
    // Check for discounts
    if (visitor.age >= 60) {
        discount = baseFee * CONFIG.discounts.senior;  // 20%
    } else if (visitor.isPWD) {
        discount = baseFee * CONFIG.discounts.pwd;  // 20%
    }
    
    finalFee = baseFee - discount;
    return { baseFee, discount, finalFee, /* ... */ };
}
```

**Decision flow:**
1. Start with base fee from service type
2. Check if age >= 60 → Apply senior discount
3. Else, check if PWD → Apply PWD discount
4. Otherwise, no discount
5. Calculate final fee = base - discount

**Examples:**
```javascript
// Visitor: age 65, clearance (₱50)
// Senior discount: ₱50 × 0.20 = ₱10
// Final: ₱50 - ₱10 = ₱40

// Visitor: age 30, PWD, residency (₱30)
// PWD discount: ₱30 × 0.20 = ₱6
// Final: ₱30 - ₱6 = ₱24

// Visitor: age 25, not PWD, permit (₱100)
// No discount
// Final: ₱100
```

---

### Question 6: Empty name validation
**Answer: B - Returns error message and false**

**Explanation:**
```javascript
function addVisitor(name, age, serviceType, isPWD) {
    // Validation
    if (!name || name.trim() === "") {
        console.log("❌ Error: Name is required");
        return false;  // Exit function, don't add visitor
    }
    
    // ... rest of function
}
```

**Validation checks:**
- `!name`: Checks if name is null, undefined, or empty string
- `name.trim() === ""`: Checks if name is only whitespace

**Examples:**
```javascript
addVisitor("", 25, "clearance", false);
// Output: ❌ Error: Name is required
// Returns: false

addVisitor("   ", 30, "residency", false);
// Output: ❌ Error: Name is required (whitespace trimmed)
// Returns: false

addVisitor("Juan", 25, "clearance", false);
// ✅ Visitor added successfully!
// Returns: true
```

**Why validate?**
- Prevents bad data
- Ensures database integrity
- Provides user feedback

---

### Question 7: searchVisitor() functionality
**Answer: C - Searches by both ID and partial name match**

**Explanation:**
```javascript
function searchVisitor(searchTerm) {
    const results = [];
    const searchString = String(searchTerm).toLowerCase();
    
    for (let visitor of visitors) {
        // Search by ID (exact match)
        if (visitor.id === parseInt(searchTerm)) {
            results.push(visitor);
        }
        // Search by name (partial match)
        else if (visitor.name.toLowerCase().includes(searchString)) {
            results.push(visitor);
        }
    }
    // ...
}
```

**Two search modes:**

**1. By ID (exact):**
```javascript
searchVisitor(3);
// Finds visitor with id: 3
```

**2. By name (partial):**
```javascript
searchVisitor("Maria");
// Finds "Maria Santos"

searchVisitor("cruz");
// Finds "Juan Dela Cruz" (case-insensitive)

searchVisitor("san");
// Finds "Maria Santos" (partial match)
```

**Flexible searching benefits:**
- Don't need to remember exact ID
- Don't need to type full name
- Case-insensitive

---

### Question 8: processVisitor() purpose
**Answer: B - Changes visitor status to "completed"**

**Explanation:**
```javascript
function processVisitor(visitorId) {
    for (let visitor of visitors) {
        if (visitor.id === visitorId) {
            visitor.status = "completed";  // Update status
            console.log("✅ Visitor #" + visitorId + " marked as completed");
            displayVisitorDetails(visitor);
            break;
        }
    }
}
```

**What it does:**
1. Find visitor by ID
2. Change status from "pending" to "completed"
3. Display updated information

**Example:**
```javascript
// Before
{ id: 1, name: "Juan", status: "pending" }

processVisitor(1);

// After
{ id: 1, name: "Juan", status: "completed" }
```

**Use case:**
- Track which visitors have been served
- Generate reports showing completion rate
- Manage queue efficiently

---

### Question 9: generateReport() capabilities
**Answer: C - Comprehensive stats: visitors, revenue, discounts, service breakdown**

**Explanation:**

**Full report includes:**

**1. Visitor Statistics:**
```javascript
Total Visitors: 6
  • Senior Citizens: 2
  • PWD: 1
  • Regular: 3
```

**2. Status Breakdown:**
```javascript
Status Breakdown:
  • Completed: 3
  • Pending: 3
```

**3. Service Breakdown:**
```javascript
SERVICE BREAKDOWN
  • Barangay Clearance: 2
  • Residency Certificate: 2
  • Indigency Certificate: 1
  • Business Permit: 1
```

**4. Financial Summary:**
```javascript
💰 FINANCIAL SUMMARY
Total Revenue: ₱210.00
Average Fee: ₱35.00
Total Discounts Given: ₱40.00
Discount Rate: 16.0%
```

**Code that calculates everything:**
```javascript
function generateReport() {
    let totalRevenue = 0;
    let seniorCount = 0;
    let pwdCount = 0;
    let regularCount = 0;
    let completedCount = 0;
    let pendingCount = 0;
    
    for (let visitor of visitors) {
        const feeInfo = calculateFee(visitor);
        totalRevenue += feeInfo.finalFee;
        
        if (visitor.age >= 60) seniorCount++;
        else if (visitor.isPWD) pwdCount++;
        else regularCount++;
        
        if (visitor.status === "completed") completedCount++;
        else pendingCount++;
    }
    // Display all statistics...
}
```

---

### Question 10: Benefits of functions
**Answer: B - Organizes code, makes it reusable and easier to maintain**

**Explanation:**

**Without functions (BAD):**
```javascript
// All code in one place - 500+ lines!
let visitors = [];
// ... add visitor code here (50 lines)
// ... calculate fee code here (30 lines)
// ... search code here (40 lines)
// ... display code here (60 lines)
// ... report code here (100 lines)
// Hard to read, test, and modify!
```

**With functions (GOOD):**
```javascript
function addVisitor() { /* 20 lines */ }
function calculateFee() { /* 15 lines */ }
function searchVisitor() { /* 25 lines */ }
function displayVisitor() { /* 30 lines */ }
function generateReport() { /* 50 lines */ }

// Easy to understand and maintain!
```

**Benefits:**

**1. Reusability:**
```javascript
calculateFee(visitor1);  // Use for visitor 1
calculateFee(visitor2);  // Reuse for visitor 2
calculateFee(visitor3);  // Reuse for visitor 3
```

**2. Testing:**
```javascript
// Test individual function
let testVisitor = { age: 65, serviceType: "clearance", isPWD: false };
let result = calculateFee(testVisitor);
console.log(result.finalFee);  // Should be 40
```

**3. Maintenance:**
```javascript
// Change discount in one place
function calculateFee(visitor) {
    if (visitor.age >= 60) {
        discount = baseFee * 0.25;  // Changed from 0.20 to 0.25
    }
    // All uses of this function updated automatically!
}
```

**4. Readability:**
```javascript
// Clear what each part does
addVisitor("Juan", 25, "clearance", false);
processVisitor(1);
generateReport();
// vs hundreds of lines of inline code
```

---

**Project Complete!** 🎉

You've built a full-featured system using:
- ✅ Variables and constants
- ✅ Arrays and objects
- ✅ Functions
- ✅ Conditionals
- ✅ Loops
- ✅ Validation
- ✅ Error handling
- ✅ Data management

**Next step:** Learn DOM manipulation to make this interactive in a web browser!

---
