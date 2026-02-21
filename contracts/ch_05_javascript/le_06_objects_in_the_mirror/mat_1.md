## Background Story

![Cover Image](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_5/C5+6.0+-+COVER.png)

It was a warm Thursday afternoon in Quezon City, and Odessa was sipping her iced coffee from Jollibee while studying in the campus garden. 🌳☕ As an IT student at UP Diliman, she’d been collecting her classmates’ grades in Excel sheets for her “Database Fundamentals” class. Every time she opened that spreadsheet, she felt the numbers were just floating—detached from real meaning.

![image](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_5/C5+6.1.png)

One evening, while riding the MRT home, an idea struck her: “What if I treat each record as an object in JavaScript?” Suddenly, her mind painted a vivid street scene: jeepneys filled with students, tricycles zooming by, and every passenger carrying their own “object” of data—name, age, course, year. She imagined mapping those passengers into objects, each with nested details like contact info and grades. 🚍👩‍💻

The next day in the lab, she opened VS Code and wrote her first object literal:

```js
const passenger = {
  name: "Juan Dela Cruz",
  age: 20,
  course: "BSIT",
  year: 2,
};
```

She saw data transform into relationships: `passenger.name` was no longer a cell in Excel, but a property she could access and manipulate. This shift opened her eyes to the power of objects.

That same week, the president of her student developers’ org approached her with an exciting challenge: build a mini internal tool to manage project assignments and member details. It would be Odessa’s first mini client project! Her heart raced—this was her chance to apply object literals, dot vs bracket notation, and nested objects to a real-world scenario.

Under the soft glow of her table lamp that night, Odessa sketched a data model on her notebook:

- Project object with title, deadline, and members array
- Member objects nested with name, role, and tasks
- Task objects with description and status

She could almost hear the clack-clack of her keyboard as she planned out functions to add members, update statuses, and print summaries. The project didn’t have a fancy UI yet, but the data structure was solid. 🔧✨

Inspired by the busy scenes of Maginhawa Street and the warmth of her community, Odessa took a deep breath. “Let’s turn spreadsheet chaos into clean JavaScript objects!” she whispered. With that, she embarked on Lesson 6: **Objects in the Mirror**.

---

## Theory & Lecture Content

### What Are Objects?

**Think of objects like a person's ID card** 🪪. An ID has different fields: name, age, address, photo. Each field holds specific information about that person. JavaScript objects work the same way—they store **related data together** as key-value pairs.

In JavaScript, an **object literal** is a comma-separated list of key–value pairs wrapped in curly braces `{}`. Objects let you group related information and organize your code logically.

### Why Objects Matter

**Without objects (using separate variables):**

```js
const studentName = "Odessa";
const studentCourse = "BSIT";
const studentYear = 3;
const studentAge = 20;
// If you have 10 students, you need 40 variables!
```

**With objects:**

```js
const student = {
  name: "Odessa",
  course: "BSIT",
  year: 3,
  age: 20,
};
// One object keeps all related data together
```

**Benefits:**

- **Organization**: Related data stays together
- **Scalability**: Easy to add more properties
- **Readability**: `student.name` is clearer than `studentName`
- **Functionality**: Can contain methods (functions) too

### 1. Object Literals

**Basic syntax:**

```js
const student = {
  name: "Odessa",
  course: "BSIT",
  year: 3,
};
```

**Key points:**

- **Keys** (properties) are strings or identifiers (quotes optional for simple names)
- **Values** can be any data type: strings, numbers, booleans, arrays, functions, or other objects
- Properties are separated by commas
- Objects can be empty: `const obj = {};`

**Different types of values:**

```js
const person = {
  // String
  name: "Juan",

  // Number
  age: 25,

  // Boolean
  isStudent: true,

  // Array
  hobbies: ["coding", "gaming", "reading"],

  // Object (nested)
  address: {
    city: "Manila",
    barangay: "Poblacion",
  },

  // Function (method)
  greet: function () {
    return `Hello, I'm ${this.name}`;
  },
};
```

Reference:  
https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer

### 2. Dot Notation vs. Bracket Notation

There are **two ways to access** object properties:

#### Dot Notation (Most Common)

```js
const student = {
  name: "Odessa",
  course: "BSIT",
};

console.log(student.name); // "Odessa" (reading)
student.year = 3; // (adding new property)
student.course = "BSCS"; // (updating existing property)
```

**When to use dot notation:**

- Property name is a valid identifier (no spaces, starts with letter)
- You know the property name in advance
- Cleaner and more readable

#### Bracket Notation (More Flexible)

```js
const student = {
  name: "Odessa",
  "full name": "Odessa Santos", // Property with spaces
  course: "BSIT",
};

// Access property with spaces
console.log(student["full name"]); // "Odessa Santos"

// Dynamic property access
const prop = "course";
console.log(student[prop]); // "BSIT"

// Property name from variable
const key = "name";
console.log(student[key]); // "Odessa"
```

**When to use bracket notation:**

- Property names with spaces or special characters
- Property name is stored in a variable (dynamic access)
- Property name is computed at runtime

**Comparison table:**

| Feature         | Dot Notation   | Bracket Notation  |
| --------------- | -------------- | ----------------- |
| Syntax          | `obj.property` | `obj["property"]` |
| Dynamic keys    | ❌ No          | ✅ Yes            |
| Spaces in names | ❌ No          | ✅ Yes            |
| Readability     | ✅ Cleaner     | ⚠️ More verbose   |

Reference:  
https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Property_accessors

### 3. Nested Objects

Objects can contain other objects or arrays, creating **hierarchical data structures**. This models real-world relationships:

```js
const project = {
  title: "Campus App",
  deadline: "2024-05-30",

  // Array of objects
  members: [
    { name: "Li", role: "Frontend" },
    { name: "Arnel", role: "Backend" },
  ],

  // Object containing objects
  tasks: {
    design: { status: "done", assignedTo: "Li" },
    develop: { status: "in-progress", assignedTo: "Arnel" },
  },

  // Nested object
  lead: {
    name: "Odessa",
    contact: {
      email: "odessa@example.com",
      phone: "0917-123-4567",
    },
  },
};
```

**Accessing nested values:**

```js
// Access array element's property
console.log(project.members[1].name);
// "Arnel" (second member's name)

// Access nested object property
console.log(project.tasks.develop.status);
// "in-progress"

// Deep nesting
console.log(project.lead.contact.email);
// "odessa@example.com"

// Combine dot and bracket notation
console.log(project["members"][0]["role"]);
// "Frontend"
```

**Modifying nested data:**

```js
// Update nested property
project.tasks.design.status = "reviewed";

// Add new member to array
project.members.push({ name: "Maria", role: "Designer" });

// Add new task
project.tasks.testing = { status: "not-started", assignedTo: "TBD" };
```

### Real-World Applications in the Philippines

Objects are perfect for modeling Filipino daily life:

**Sari-sari store inventory:**

```js
const product = {
  name: "Lucky Me Pancit Canton",
  price: 15,
  stock: 50,
  category: "instant noodles",
  supplier: "Monde Nissin",
};
```

**Jeepney route information:**

```js
const route = {
  number: "04L",
  start: "Cubao",
  end: "Fairview",
  fare: 13,
  landmarks: ["SM North", "Ever", "CommonWealth"],
};
```

**Student record:**

```js
const student = {
  idNumber: "2024-12345",
  name: "Juan Dela Cruz",
  grades: {
    math: 85,
    science: 90,
    english: 88,
  },
  isScholar: true,
};
```

### Common Beginner Mistakes

**1. Forgetting quotes for property names with spaces**

```js
// ❌ WRONG: Syntax error
const person = {
  full name: "Juan"  // Can't have spaces without quotes
};

// ✅ CORRECT: Use quotes
const person = {
  "full name": "Juan"
};
console.log(person["full name"]);
```

**2. Using dot notation for dynamic properties**

```js
const student = { name: "Odessa", age: 20 };
const key = "name";

// ❌ WRONG: Looks for property literally called "key"
console.log(student.key); // undefined

// ✅ CORRECT: Use bracket notation for variables
console.log(student[key]); // "Odessa"
```

**3. Trailing commas causing issues in old browsers**

```js
// ⚠️ RISKY: Trailing comma (after last property)
const obj = {
  name: "Juan",
  age: 25, // ← This comma
};
// Modern JS allows this, but old IE doesn't
// Safe practice: no comma after last property
```

**4. Accessing nested properties without checking if they exist**

```js
const user = {
  name: "Odessa",
  // No 'address' property
};

// ❌ WRONG: TypeError if address is undefined
console.log(user.address.city);

// ✅ CORRECT: Check if property exists first
if (user.address && user.address.city) {
  console.log(user.address.city);
}

// ✅ MODERN: Optional chaining (ES2020)
console.log(user.address?.city); // undefined (no error)
```

**5. Confusing arrays and objects**

```js
// ❌ WRONG: Using array syntax for objects
const student = {
  0: "Odessa", // Objects can have numeric keys but...
  1: "BSIT",
};
console.log(student[0]); // Works but confusing

// ✅ BETTER: Use descriptive keys for objects
const student = {
  name: "Odessa",
  course: "BSIT",
};

// Arrays are for ordered lists, objects for key-value pairs
const students = ["Odessa", "Juan", "Maria"]; // Array
```

**6. Modifying object properties accidentally**

```js
const config = {
  apiUrl: "https://api.example.com",
};

// ❌ AVOID: Accidentally changing shared config
function updateConfig() {
  config.apiUrl = "https://test.example.com";
  // This affects the original object!
}

// ✅ BETTER: Make object immutable or create a copy
const config = Object.freeze({
  apiUrl: "https://api.example.com",
});
// Now config cannot be modified
```

### Useful Object Methods

```js
const student = {
  name: "Odessa",
  course: "BSIT",
  year: 3,
};

// Get all property names (keys)
Object.keys(student);
// ["name", "course", "year"]

// Get all values
Object.values(student);
// ["Odessa", "BSIT", 3]

// Get key-value pairs
Object.entries(student);
// [["name", "Odessa"], ["course", "BSIT"], ["year", 3]]

// Check if property exists
student.hasOwnProperty("name"); // true
student.hasOwnProperty("age"); // false
```

**Edge Cases & Best Practices**

- ✅ Avoid deep nesting beyond 3–4 levels. Consider flattening or using separate modules
- ✅ Use `Object.freeze()` for read-only configs
- ✅ Validate that keys exist: `if (obj && obj.subObj) {...}` to prevent runtime errors
- ✅ Use meaningful property names: `studentId` not `sid`
- ✅ Keep related data together in one object
- ✅ Use const for objects you don't want to reassign (properties can still change)

## Closing Story

Odessa hit **CTRL+S** with a big smile. She tested the internal tool, saw her objects connect seamlessly, and even impressed the org president during their Monday briefing. 🎉 Her simple console-based dashboard listed projects, members, and tasks—all powered by her object models.

That evening, as she toasted a **halo-halo** with friends in Cubao, she realized how object literals transformed raw data into living models, just like how stories transform simple facts into memories. Next up, she’ll dive into **Arrays & Iteration** to handle lists of data more efficiently—because every great app needs both objects _and_ arrays working in harmony.

Stay tuned for Lesson 7: **“Array of Sunshine”**! 🌞

Good luck, future full-stack dev! 🚀
