# Quiz 28: Arrays and Objects

Test your understanding of arrays, objects, and complex data structures!

---

## Quiz 1

### Question 1
What is the output?
```javascript
let numbers = [10, 20, 30];
console.log(numbers[1]);
```

A) `10`  
B) `20`  
C) `30`  
D) `1`

**Answer: B**

Arrays use zero-based indexing. Index 0 is 10, index 1 is 20, index 2 is 30.

---

### Question 2
What does `array.length` return?
```javascript
let visitors = ["Juan", "Maria", "Pedro"];
console.log(visitors.length);
```

A) `2`  
B) `3`  
C) `4`  
D) `undefined`

**Answer: B**

`.length` returns the number of elements in the array. There are 3 elements: "Juan", "Maria", "Pedro".

---

### Question 3
What is the output?
```javascript
let queue = ["Juan", "Maria"];
queue.push("Pedro");
console.log(queue);
```

A) `["Juan", "Maria"]`  
B) `["Juan", "Maria", "Pedro"]`  
C) `["Pedro", "Juan", "Maria"]`  
D) `["Pedro"]`

**Answer: B**

`push()` adds an element to the end of the array. "Pedro" is added after "Maria".

---

### Question 4
What does `pop()` do?
```javascript
let numbers = [1, 2, 3];
let last = numbers.pop();
```

A) Adds element to end  
B) Removes and returns last element  
C) Removes first element  
D) Returns array length

**Answer: B**

`pop()` removes and returns the last element. It modifies the original array.

---

### Question 5
How do you access object properties?
```javascript
let person = { name: "Juan", age: 25 };
```

A) `person[0]`  
B) `person.name` or `person["name"]`  
C) `person->name`  
D) `person(name)`

**Answer: B**

Access object properties with dot notation (`person.name`) or bracket notation (`person["name"]`).

---

## Quiz 2

### Question 6
What is the output?
```javascript
let visitor = {
    name: "Juan",
    age: 25
};

console.log(visitor.age);
```

A) `"Juan"`  
B) `25`  
C) `undefined`  
D) `age`

**Answer: B**

`visitor.age` accesses the `age` property, which has the value 25.

---

### Question 7
What is the output?
```javascript
let services = ["Clearance", "Residency"];
console.log(services.includes("Clearance"));
```

A) `0`  
B) `1`  
C) `true`  
D) `false`

**Answer: C**

`includes()` returns `true` if the element exists in the array, `false` otherwise. "Clearance" is in the array.

---

### Question 8
What is the output?
```javascript
let visitors = [
    { name: "Juan", age: 25 },
    { name: "Maria", age: 30 }
];

console.log(visitors[0].name);
```

A) `"Juan"`  
B) `"Maria"`  
C) `25`  
D) `0`

**Answer: A**

`visitors[0]` gets the first object, then `.name` accesses its name property: "Juan".

---

### Question 9
What does `shift()` do?
```javascript
let queue = ["Juan", "Maria", "Pedro"];
let first = queue.shift();
```

A) Adds element to beginning  
B) Removes and returns first element  
C) Removes last element  
D) Returns array length

**Answer: B**

`shift()` removes and returns the first element. It modifies the original array.

---

### Question 10
What is the output?
```javascript
let person = { name: "Juan" };
person.age = 25;
console.log(person.age);
```

A) `undefined`  
B) `25`  
C) `"age"`  
D) Error

**Answer: B**

You can add new properties to objects dynamically. `person.age = 25;` adds the `age` property with value 25.

---

## Detailed Explanations

### Question 1: Array indexing
```javascript
let numbers = [10, 20, 30];
console.log(numbers[1]);
```

**Answer: B - `20`**

**Explanation:**
- Arrays use **zero-based indexing**
- Index 0: `10`
- Index 1: `20` ✓
- Index 2: `30`

**Barangay services:**
```javascript
let services = ["Clearance", "Residency", "Indigency"];

console.log(services[0]);  // Clearance
console.log(services[1]);  // Residency
console.log(services[2]);  // Indigency
```

---

### Question 2: Array length property
```javascript
let visitors = ["Juan", "Maria", "Pedro"];
console.log(visitors.length);
```

**Answer: B - `3`**

**Explanation:**
- `.length` returns the number of elements
- Array has 3 elements: `"Juan"`, `"Maria"`, `"Pedro"`
- Returns: `3`

**Using length in loops:**
```javascript
let queue = ["Juan", "Maria", "Pedro", "Rosa"];

console.log("Queue size: " + queue.length);  // 4

for (let i = 0; i < queue.length; i++) {
    console.log("Position " + i + ": " + queue[i]);
}
```

---

### Question 3: push() method
```javascript
let queue = ["Juan", "Maria"];
queue.push("Pedro");
console.log(queue);
```

**Answer: B - `["Juan", "Maria", "Pedro"]`**

**Explanation:**
- `push()` adds element to **end** of array
- Original: `["Juan", "Maria"]`
- After push: `["Juan", "Maria", "Pedro"]`
- `push()` modifies the original array

**Barangay queue system:**
```javascript
let serviceQueue = [];

console.log("Initial queue:", serviceQueue);  // []

serviceQueue.push("Juan");
console.log("After Juan:", serviceQueue);  // ["Juan"]

serviceQueue.push("Maria");
console.log("After Maria:", serviceQueue);  // ["Juan", "Maria"]

serviceQueue.push("Pedro");
console.log("After Pedro:", serviceQueue);  // ["Juan", "Maria", "Pedro"]
```

---

### Question 4: pop() method
```javascript
let numbers = [1, 2, 3];
let last = numbers.pop();
```

**Answer: B - Removes and returns last element**

**Explanation:**
- `pop()` removes the **last** element
- Returns the removed element
- Modifies original array

```javascript
let numbers = [1, 2, 3];

let last = numbers.pop();
console.log(last);      // 3 (returned value)
console.log(numbers);   // [1, 2] (modified array)
```

**Barangay queue (serving last person):**
```javascript
let lateQueue = ["Juan", "Maria", "Pedro"];

console.log("Queue:", lateQueue);  // ["Juan", "Maria", "Pedro"]

let lastPerson = lateQueue.pop();
console.log("Removed:", lastPerson);  // Pedro
console.log("Remaining:", lateQueue);  // ["Juan", "Maria"]
```

---

### Question 5: Accessing object properties
```javascript
let person = { name: "Juan", age: 25 };
```

**Answer: B - `person.name` or `person["name"]`**

**Explanation:**
Two ways to access object properties:

**1. Dot notation:**
```javascript
let person = { name: "Juan", age: 25 };
console.log(person.name);  // Juan
console.log(person.age);   // 25
```

**2. Bracket notation:**
```javascript
let person = { name: "Juan", age: 25 };
console.log(person["name"]);  // Juan
console.log(person["age"]);   // 25
```

**When to use bracket notation:**
```javascript
let visitor = {
    name: "Juan",
    "service type": "Clearance"  // Property with space
};

// console.log(visitor.service type);  // Error!
console.log(visitor["service type"]);  // Works!

// Dynamic property access
let property = "name";
console.log(visitor[property]);  // Juan
```

---

### Question 6: Object property access
```javascript
let visitor = {
    name: "Juan",
    age: 25
};

console.log(visitor.age);
```

**Answer: B - `25`**

**Explanation:**
- `visitor.age` accesses the `age` property
- Value is `25`

**Barangay visitor info:**
```javascript
let visitor = {
    name: "Juan Dela Cruz",
    age: 25,
    service: "Clearance",
    fee: 50
};

console.log("Name:", visitor.name);      // Juan Dela Cruz
console.log("Age:", visitor.age);        // 25
console.log("Service:", visitor.service);// Clearance
console.log("Fee: ₱" + visitor.fee);     // Fee: ₱50
```

---

### Question 7: includes() method
```javascript
let services = ["Clearance", "Residency"];
console.log(services.includes("Clearance"));
```

**Answer: C - `true`**

**Explanation:**
- `includes()` checks if value exists in array
- `"Clearance"` is in the array
- Returns: `true`

```javascript
let services = ["Clearance", "Residency", "Indigency"];

console.log(services.includes("Clearance"));  // true
console.log(services.includes("Residency"));  // true
console.log(services.includes("Permit"));     // false
```

**Barangay service validation:**
```javascript
let availableServices = ["Clearance", "Residency", "Indigency"];
let requestedService = "Clearance";

if (availableServices.includes(requestedService)) {
    console.log("✅ Service available");
} else {
    console.log("❌ Service not available");
}
// Output: ✅ Service available
```

---

### Question 8: Array of objects
```javascript
let visitors = [
    { name: "Juan", age: 25 },
    { name: "Maria", age: 30 }
];

console.log(visitors[0].name);
```

**Answer: A - `"Juan"`**

**Explanation:**
1. `visitors[0]` → First object: `{ name: "Juan", age: 25 }`
2. `.name` → Access `name` property: `"Juan"`

**Accessing nested data:**
```javascript
let visitors = [
    { name: "Juan", age: 25 },
    { name: "Maria", age: 30 }
];

console.log(visitors[0].name);  // Juan
console.log(visitors[0].age);   // 25
console.log(visitors[1].name);  // Maria
console.log(visitors[1].age);   // 30
```

**Barangay records:**
```javascript
let records = [
    { name: "Juan Dela Cruz", age: 25, service: "Clearance", fee: 50 },
    { name: "Maria Santos", age: 65, service: "Residency", fee: 30 },
    { name: "Pedro Reyes", age: 30, service: "Indigency", fee: 20 }
];

console.log("=== Visitor Records ===");

for (let i = 0; i < records.length; i++) {
    console.log("\nVisitor " + (i + 1) + ":");
    console.log("Name: " + records[i].name);
    console.log("Age: " + records[i].age);
    console.log("Service: " + records[i].service);
    console.log("Fee: ₱" + records[i].fee);
}
```

---

### Question 9: shift() method
```javascript
let queue = ["Juan", "Maria", "Pedro"];
let first = queue.shift();
```

**Answer: B - Removes and returns first element**

**Explanation:**
- `shift()` removes the **first** element
- Returns the removed element
- Modifies original array

```javascript
let queue = ["Juan", "Maria", "Pedro"];

let first = queue.shift();
console.log(first);   // Juan (returned value)
console.log(queue);   // ["Maria", "Pedro"] (modified array)
```

**Barangay queue processing:**
```javascript
let serviceQueue = ["Juan", "Maria", "Pedro", "Rosa"];

console.log("Initial queue:", serviceQueue);
// ["Juan", "Maria", "Pedro", "Rosa"]

console.log("\n=== Processing Queue ===");

while (serviceQueue.length > 0) {
    let currentVisitor = serviceQueue.shift();
    console.log("Now serving: " + currentVisitor);
    console.log("Remaining: " + serviceQueue.length);
}

console.log("\n✅ All visitors served");
```

**Output:**
```
Initial queue: ["Juan", "Maria", "Pedro", "Rosa"]

=== Processing Queue ===
Now serving: Juan
Remaining: 3
Now serving: Maria
Remaining: 2
Now serving: Pedro
Remaining: 1
Now serving: Rosa
Remaining: 0

✅ All visitors served
```

---

### Question 10: Adding properties to objects
```javascript
let person = { name: "Juan" };
person.age = 25;
console.log(person.age);
```

**Answer: B - `25`**

**Explanation:**
- Objects are **mutable** (can be modified)
- `person.age = 25` adds new property `age`
- Accessing `person.age` returns `25`

**Adding/modifying properties:**
```javascript
let visitor = { name: "Juan" };

console.log(visitor);  // { name: "Juan" }

// Add new properties
visitor.age = 25;
visitor.service = "Clearance";

console.log(visitor);
// { name: "Juan", age: 25, service: "Clearance" }

// Modify existing property
visitor.age = 26;
console.log(visitor.age);  // 26
```

**Barangay visitor processing:**
```javascript
let visitor = {
    name: "Juan Dela Cruz",
    age: 25,
    service: "Clearance"
};

console.log("Initial:", visitor);

// Add timestamp
visitor.timestamp = new Date().toLocaleString();

// Calculate fee
let baseFee = 50;
if (visitor.age >= 60) {
    visitor.fee = baseFee * 0.8;
    visitor.discount = "Senior";
} else {
    visitor.fee = baseFee;
    visitor.discount = "None";
}

console.log("\nProcessed:", visitor);
```

---

**Comparison: Array Methods**

| Method | Action | Returns | Example |
|--------|--------|---------|---------|
| `push(item)` | Add to end | New length | `arr.push("Pedro")` |
| `pop()` | Remove from end | Removed item | `let last = arr.pop()` |
| `unshift(item)` | Add to beginning | New length | `arr.unshift("Juan")` |
| `shift()` | Remove from beginning | Removed item | `let first = arr.shift()` |
| `includes(item)` | Check if exists | true/false | `arr.includes("Maria")` |
| `indexOf(item)` | Find position | Index or -1 | `arr.indexOf("Pedro")` |

**Great job!** You now understand how to work with arrays and objects!

---
