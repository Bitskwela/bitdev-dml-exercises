# Lesson 28: Arrays and Objects

---

## Storing Complex Data

"Kuya Miguel, how do we store information about 100 residents? Do we need 100 variables?" Tian asked.

Rhea Joy added, "And what if each resident has name, age, address, and service type?"

Kuya Miguel smiled. "That's why we use **arrays and objects**—data structures that store multiple values. Arrays for lists, objects for structured data!"

---

## What are Arrays?

**Arrays** store multiple values in a single variable, accessed by index (position).

**Syntax:**
```javascript
let arrayName = [value1, value2, value3];
```

**Examples:**
```javascript
let numbers = [1, 2, 3, 4, 5];
let names = ["Juan", "Maria", "Pedro"];
let mixed = [25, "Juan", true, 50.5];
```

**Accessing elements (zero-indexed):**
```javascript
let visitors = ["Juan", "Maria", "Pedro"];

console.log(visitors[0]);  // Output: Juan
console.log(visitors[1]);  // Output: Maria
console.log(visitors[2]);  // Output: Pedro
```

**Barangay services:**
```javascript
let services = ["Clearance", "Residency", "Indigency", "Business Permit"];

console.log("=== Available Services ===");
console.log("1. " + services[0]);
console.log("2. " + services[1]);
console.log("3. " + services[2]);
console.log("4. " + services[3]);
```

---

## Array Properties and Methods

### length property
```javascript
let visitors = ["Juan", "Maria", "Pedro"];
console.log(visitors.length);  // Output: 3
```

### push() - Add to end
```javascript
let queue = ["Juan", "Maria"];
queue.push("Pedro");
console.log(queue);  // ["Juan", "Maria", "Pedro"]
```

### pop() - Remove from end
```javascript
let queue = ["Juan", "Maria", "Pedro"];
let last = queue.pop();
console.log(last);   // "Pedro"
console.log(queue);  // ["Juan", "Maria"]
```

### unshift() - Add to beginning
```javascript
let queue = ["Maria", "Pedro"];
queue.unshift("Juan");
console.log(queue);  // ["Juan", "Maria", "Pedro"]
```

### shift() - Remove from beginning
```javascript
let queue = ["Juan", "Maria", "Pedro"];
let first = queue.shift();
console.log(first);  // "Juan"
console.log(queue);  // ["Maria", "Pedro"]
```

**Barangay queue system:**
```javascript
let serviceQueue = [];

// Add visitors to queue
serviceQueue.push("Juan");
serviceQueue.push("Maria");
serviceQueue.push("Pedro");
console.log("Queue:", serviceQueue);
// ["Juan", "Maria", "Pedro"]

// Serve first visitor
let currentVisitor = serviceQueue.shift();
console.log("Now serving:", currentVisitor);  // Juan
console.log("Remaining:", serviceQueue);
// ["Maria", "Pedro"]
```

---

## More Array Methods

### indexOf() - Find position
```javascript
let visitors = ["Juan", "Maria", "Pedro", "Rosa"];
console.log(visitors.indexOf("Pedro"));  // 2
console.log(visitors.indexOf("Jose"));   // -1 (not found)
```

### includes() - Check if exists
```javascript
let services = ["Clearance", "Residency", "Indigency"];
console.log(services.includes("Clearance"));  // true
console.log(services.includes("Permit"));     // false
```

### slice() - Extract portion
```javascript
let numbers = [1, 2, 3, 4, 5];
let portion = numbers.slice(1, 4);
console.log(portion);  // [2, 3, 4]
console.log(numbers);  // [1, 2, 3, 4, 5] (original unchanged)
```

### splice() - Add/remove elements
```javascript
let visitors = ["Juan", "Maria", "Pedro"];

// Remove 1 element at index 1
visitors.splice(1, 1);
console.log(visitors);  // ["Juan", "Pedro"]

// Add elements at index 1
visitors.splice(1, 0, "Rosa", "Jose");
console.log(visitors);  // ["Juan", "Rosa", "Jose", "Pedro"]
```

---

## Looping Through Arrays

### for loop
```javascript
let services = ["Clearance", "Residency", "Indigency"];

for (let i = 0; i < services.length; i++) {
    console.log((i + 1) + ". " + services[i]);
}
```

### for...of loop (modern)
```javascript
let services = ["Clearance", "Residency", "Indigency"];

for (let service of services) {
    console.log("Service: " + service);
}
```

**Barangay fee calculation:**
```javascript
let fees = [50, 30, 20, 100, 50];
let total = 0;

for (let fee of fees) {
    total += fee;
}

console.log("Total revenue: ₱" + total);  // ₱250
```

---

## What are Objects?

**Objects** store data as key-value pairs, representing real-world entities.

**Syntax:**
```javascript
let objectName = {
    key1: value1,
    key2: value2,
    key3: value3
};
```

**Example:**
```javascript
let person = {
    name: "Juan Dela Cruz",
    age: 25,
    city: "Batangas"
};
```

**Accessing properties:**
```javascript
// Dot notation
console.log(person.name);  // Juan Dela Cruz
console.log(person.age);   // 25

// Bracket notation
console.log(person["name"]);  // Juan Dela Cruz
console.log(person["age"]);   // 25
```

**Barangay visitor:**
```javascript
let visitor = {
    name: "Juan Dela Cruz",
    age: 25,
    service: "Clearance",
    isPWD: false
};

console.log("=== Visitor Information ===");
console.log("Name: " + visitor.name);
console.log("Age: " + visitor.age);
console.log("Service: " + visitor.service);
console.log("PWD: " + visitor.isPWD);
```

---

## Modifying Objects

### Update properties
```javascript
let visitor = {
    name: "Juan",
    age: 25
};

visitor.age = 26;
console.log(visitor.age);  // 26
```

### Add new properties
```javascript
let visitor = {
    name: "Juan"
};

visitor.age = 25;
visitor.city = "Batangas";
console.log(visitor);
// { name: "Juan", age: 25, city: "Batangas" }
```

### Delete properties
```javascript
let visitor = {
    name: "Juan",
    age: 25,
    temp: "delete me"
};

delete visitor.temp;
console.log(visitor);
// { name: "Juan", age: 25 }
```

---

## Object Methods

**Objects can contain functions:**

```javascript
let calculator = {
    add: function(a, b) {
        return a + b;
    },
    subtract: function(a, b) {
        return a - b;
    }
};

console.log(calculator.add(5, 3));       // 8
console.log(calculator.subtract(10, 4)); // 6
```

**Barangay fee calculator object:**
```javascript
let feeCalculator = {
    baseFee: 50,
    seniorDiscount: 0.20,
    
    calculateFee: function(age) {
        if (age >= 60) {
            return this.baseFee * (1 - this.seniorDiscount);
        }
        return this.baseFee;
    },
    
    displayFee: function(age) {
        let fee = this.calculateFee(age);
        console.log("Age: " + age + " → Fee: ₱" + fee);
    }
};

feeCalculator.displayFee(25);  // Age: 25 → Fee: ₱50
feeCalculator.displayFee(65);  // Age: 65 → Fee: ₱40
```

**Note:** `this` refers to the current object.

---

## Arrays of Objects

**Combine arrays and objects for complex data:**

```javascript
let visitors = [
    { name: "Juan Dela Cruz", age: 25, service: "Clearance" },
    { name: "Maria Santos", age: 65, service: "Residency" },
    { name: "Pedro Reyes", age: 30, service: "Indigency" }
];

// Access specific visitor
console.log(visitors[0].name);  // Juan Dela Cruz
console.log(visitors[1].age);   // 65

// Loop through all visitors
for (let visitor of visitors) {
    console.log(visitor.name + " - " + visitor.service);
}
```

**Complete barangay system:**
```javascript
let dailyVisitors = [
    { name: "Juan Dela Cruz", age: 25, service: "Clearance", fee: 50 },
    { name: "Maria Santos", age: 65, service: "Residency", fee: 30 },
    { name: "Pedro Reyes", age: 30, service: "Indigency", fee: 20 },
    { name: "Rosa Garcia", age: 70, service: "Clearance", fee: 50 }
];

console.log("=== BARANGAY SERVICE REPORT ===\n");

let totalRevenue = 0;
let seniorCount = 0;

for (let i = 0; i < dailyVisitors.length; i++) {
    let visitor = dailyVisitors[i];
    let finalFee = visitor.fee;
    
    console.log("Visitor #" + (i + 1));
    console.log("Name: " + visitor.name);
    console.log("Age: " + visitor.age);
    console.log("Service: " + visitor.service);
    
    // Apply senior discount
    if (visitor.age >= 60) {
        finalFee = visitor.fee * 0.8;
        seniorCount++;
        console.log("🎉 Senior Discount Applied");
    }
    
    console.log("Fee: ₱" + finalFee);
    totalRevenue += finalFee;
    console.log("---");
}

console.log("\n=== SUMMARY ===");
console.log("Total Visitors: " + dailyVisitors.length);
console.log("Senior Citizens: " + seniorCount);
console.log("Total Revenue: ₱" + totalRevenue);
```

---

## Nested Objects

**Objects can contain other objects:**

```javascript
let visitor = {
    name: "Juan Dela Cruz",
    age: 25,
    address: {
        street: "123 Main St",
        barangay: "San Juan",
        city: "Batangas"
    },
    contact: {
        phone: "0912-345-6789",
        email: "juan@example.com"
    }
};

console.log(visitor.name);                  // Juan Dela Cruz
console.log(visitor.address.barangay);      // San Juan
console.log(visitor.contact.phone);         // 0912-345-6789
```

---

## JSON (JavaScript Object Notation)

**JSON is a text format for storing and exchanging data:**

```javascript
// JavaScript object
let visitor = {
    name: "Juan",
    age: 25
};

// Convert to JSON string
let jsonString = JSON.stringify(visitor);
console.log(jsonString);
// Output: {"name":"Juan","age":25}

// Convert back to object
let parsed = JSON.parse(jsonString);
console.log(parsed.name);  // Juan
```

**Used for:**
- Storing data
- Sending data to servers
- Receiving data from APIs

---

## Complete Barangay Management System

```javascript
// Service configuration
const SERVICES = {
    clearance: { name: "Barangay Clearance", fee: 50 },
    residency: { name: "Residency Certificate", fee: 30 },
    indigency: { name: "Indigency Certificate", fee: 20 },
    permit: { name: "Business Permit", fee: 100 }
};

// Visitor database
let visitors = [];

// Function: Add visitor
function addVisitor(name, age, serviceType, isPWD) {
    let visitor = {
        id: visitors.length + 1,
        name: name,
        age: age,
        serviceType: serviceType,
        isPWD: isPWD,
        timestamp: new Date().toLocaleString()
    };
    
    visitors.push(visitor);
    console.log("✅ Visitor added: " + name);
}

// Function: Calculate fee with discounts
function calculateFee(visitor) {
    let service = SERVICES[visitor.serviceType];
    let baseFee = service.fee;
    let finalFee = baseFee;
    let discountReason = "";
    
    if (visitor.age >= 60) {
        finalFee = baseFee * 0.8;
        discountReason = "Senior (20% off)";
    } else if (visitor.isPWD) {
        finalFee = baseFee * 0.8;
        discountReason = "PWD (20% off)";
    }
    
    return {
        serviceName: service.name,
        baseFee: baseFee,
        finalFee: finalFee,
        discount: baseFee - finalFee,
        discountReason: discountReason
    };
}

// Function: Display visitor summary
function displaySummary() {
    console.log("\n=== BARANGAY SERVICE SUMMARY ===\n");
    
    let totalRevenue = 0;
    
    for (let visitor of visitors) {
        let feeInfo = calculateFee(visitor);
        
        console.log("ID: " + visitor.id);
        console.log("Name: " + visitor.name);
        console.log("Age: " + visitor.age);
        console.log("Service: " + feeInfo.serviceName);
        console.log("Base Fee: ₱" + feeInfo.baseFee);
        
        if (feeInfo.discount > 0) {
            console.log("Discount: -₱" + feeInfo.discount + " (" + feeInfo.discountReason + ")");
        }
        
        console.log("Final Fee: ₱" + feeInfo.finalFee);
        console.log("Time: " + visitor.timestamp);
        console.log("---");
        
        totalRevenue += feeInfo.finalFee;
    }
    
    console.log("\n=== TOTALS ===");
    console.log("Total Visitors: " + visitors.length);
    console.log("Total Revenue: ₱" + totalRevenue);
    console.log("Average Fee: ₱" + (totalRevenue / visitors.length).toFixed(2));
}

// Test the system
addVisitor("Juan Dela Cruz", 25, "clearance", false);
addVisitor("Maria Santos", 65, "residency", false);
addVisitor("Pedro Reyes", 30, "indigency", true);
addVisitor("Rosa Garcia", 45, "permit", false);

displaySummary();
```

---

## Best Practices

### 1. Use descriptive property names
```javascript
// Bad
let v = { n: "Juan", a: 25 };

// Good
let visitor = { name: "Juan", age: 25 };
```

### 2. Use arrays for lists, objects for structured data
```javascript
// Good - list of names
let names = ["Juan", "Maria", "Pedro"];

// Good - structured information
let visitor = {
    name: "Juan",
    age: 25,
    service: "Clearance"
};
```

### 3. Combine arrays and objects for complex data
```javascript
let visitors = [
    { name: "Juan", age: 25 },
    { name: "Maria", age: 30 }
];
```

---

## Summary

Tian reviewed data structures:

**Arrays (lists):**
```javascript
let array = [value1, value2, value3];
array[0]  // Access by index
array.push(value)  // Add to end
array.length  // Get size
```

**Objects (structured data):**
```javascript
let object = {
    key1: value1,
    key2: value2
};
object.key1  // Access property
object["key1"]  // Alternative access
```

**Arrays of Objects:**
```javascript
let data = [
    { name: "Juan", age: 25 },
    { name: "Maria", age: 30 }
];
```

Rhea Joy smiled. "Now we can manage complex barangay data efficiently!"

---

## What's Next?

In the next lesson, you'll build a **Mini Project** combining everything you've learned: variables, operators, conditionals, loops, functions, arrays, and objects!

---
