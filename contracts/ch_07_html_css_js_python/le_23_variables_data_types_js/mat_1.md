## Background Story

The barangay website was beautiful. After weeks of work, Tian and Rhea Joy had created something they were genuinely proud of: a clean, modern, responsive design with intuitive navigation, perfect color contrast, and smooth CSS transitions. It looked professional—good enough to be a real municipal website.

But it was static. Completely, utterly static.

Every page showed the same content to every visitor. There was no interactivity, no personalization, no ability to respond to user actions. Click a button? Nothing happens—it's just a styled link. Fill out a form? The data goes nowhere. Want to display the current date or count visitors? Impossible with just HTML and CSS.

It was Friday afternoon, and Tian was presenting the website to their Computer Science class as part of their quarterly project. The projector displayed the homepage, and Tian walked through each section, explaining the semantic HTML structure and the CSS techniques they'd used for the responsive layout.

When the presentation ended, their teacher, Ms. Santos, nodded approvingly. "Excellent work on the structure and design. But I have a question—what happens when someone clicks the 'Apply for Clearance' button?"

Tian hesitated. "Um... it goes to a form page."

"And when they submit the form?"

"It... well, right now it doesn't do anything. The data isn't saved or processed. It's just HTML."

Ms. Santos smiled knowingly. "So it's a static website. Beautiful, well-structured, but not functional. What you need is programming—logic, interactivity, data handling. That's where JavaScript comes in. Have you started learning it yet?"

Tian shook their head. "Not yet, ma'am. Just HTML and CSS so far."

"Then that's your next step. HTML is structure. CSS is presentation. JavaScript is behavior—it makes websites *do* things. Without it, you're building digital brochures, not web applications."

That comment stuck with Tian for the rest of the day. Digital brochures. That's what they'd been building—beautiful, but lifeless.

That evening, Tian and Rhea Joy sat in the school library, both staring at the website on Tian's laptop.

"Ms. Santos is right," Rhea Joy said quietly. "It looks great, but it doesn't *do* anything. It's like a car that looks amazing but has no engine."

"We need JavaScript," Tian said. "I've been putting it off because it seems harder than HTML and CSS. Those are markup and styling—straightforward. But JavaScript is actual programming. Logic. Code that thinks."

"Can Kuya Miguel teach us?" Rhea Joy asked.

Tian was already pulling out their phone to call him.

Miguel answered after two rings. "Tian! How'd the presentation go?"

"Good! But Ms. Santos pointed out the obvious—our website is static. It's just HTML and CSS. We need JavaScript to make it actually functional. To handle forms, store data, respond to user actions, make it interactive."

"Ah, you've hit the wall that every web developer hits," Miguel said. "The moment you realize that design without functionality is incomplete. Alright, both of you free this weekend?"

"Yes," Tian and Rhea Joy said in unison.

"Perfect. We're starting JavaScript. And I mean really starting—from the absolute foundation. Variables, data types, how to think in code. JavaScript is different from HTML and CSS. It's not declarative—it's imperative. You're not describing what things *are*, you're instructing what things should *do*. It requires a different mindset. But once you get it, everything changes. Your websites go from static pages to living, breathing applications."

Miguel paused, then added, "Fair warning: JavaScript has a learning curve. It might be frustrating at first. But stick with it. Because once you can write JavaScript, you're not just a designer or a markup developer—you're a programmer. And that opens every door in tech."

Tian and Rhea Joy exchanged glances. The excitement was mixed with nervousness. This was the leap from consumer to creator, from designer to developer, from static to dynamic.

"We're ready, Kuya," Tian said. "Teach us how to make websites think."

---

## Theory & Lecture Content

## What is JavaScript?

**JavaScript** is a programming language that runs in the browser, making websites interactive and dynamic.

**What you can do with JavaScript:**
- Respond to user clicks/inputs
- Update content without reloading
- Validate forms
- Create animations
- Store and manipulate data
- Communicate with servers

**HTML + CSS + JavaScript:**
```
HTML = Structure (bones)
CSS = Appearance (skin)
JavaScript = Behavior (brain)
```

---

## Adding JavaScript to HTML

### Method 1: Inline (Not Recommended)

```html
<button onclick="alert('Hello!')">Click Me</button>
```

---

### Method 2: Internal Script

```html
<!DOCTYPE html>
<html>
<head>
    <title>Barangay JS</title>
</head>
<body>
    <h1>Welcome</h1>
    
    <script>
        // JavaScript code here
        console.log("Hello from JavaScript!");
    </script>
</body>
</html>
```

**Best practice:** Place `<script>` before closing `</body>` tag.

---

### Method 3: External File (Recommended)

**HTML (index.html):**
```html
<!DOCTYPE html>
<html>
<head>
    <title>Barangay JS</title>
</head>
<body>
    <h1>Welcome</h1>
    
    <script src="script.js"></script>
</body>
</html>
```

**JavaScript (script.js):**
```javascript
console.log("Hello from external file!");
```

---

## Console and Comments

### Console.log() - Debugging Tool

**Print messages to browser console:**
```javascript
console.log("Hello, world!");
console.log(123);
console.log("Barangay San Miguel");
```

**Viewing console:**
- Press F12 (Windows) or Cmd+Opt+I (Mac)
- Click "Console" tab

---

### Comments

```javascript
// Single-line comment

/*
   Multi-line comment
   Can span multiple lines
*/

// Comments are ignored by JavaScript
// Use them to explain your code
```

---

## Variables

**Variables** store data that can be used and changed later.

**Think of variables as labeled boxes:**
```
+----------------+
| age            |
| Value: 15      |
+----------------+
```

---

### Declaring Variables

**Three ways to declare variables:**

#### 1. let (Recommended for changing values)

```javascript
let age = 15;
let name = "Tian";
let isStudent = true;

console.log(age);  // Output: 15

// Can be changed
age = 16;
console.log(age);  // Output: 16
```

---

#### 2. const (Recommended for fixed values)

```javascript
const barangayName = "San Miguel";
const maxCapacity = 100;

console.log(barangayName);  // Output: San Miguel

// Cannot be changed
barangayName = "New Name";  // ❌ Error: Assignment to constant variable
```

**Use `const` for values that shouldn't change.**

---

#### 3. var (Old way, avoid)

```javascript
var city = "Batangas";

// var has issues (function scope, hoisting)
// Use let/const instead
```

---

### Variable Naming Rules

**Valid names:**
```javascript
let name = "Tian";
let age = 15;
let firstName = "Rhea Joy";  // camelCase (recommended)
let first_name = "Miguel";   // snake_case
let _private = true;
let $price = 100;
let age2 = 20;
```

**Invalid names:**
```javascript
let 2age = 20;           // ❌ Can't start with number
let first-name = "Tian"; // ❌ No hyphens
let let = 5;             // ❌ Can't use reserved keywords
let first name = "Joy";  // ❌ No spaces
```

**Best practices:**
- Use **camelCase**: `firstName`, `totalAmount`, `isActive`
- Descriptive names: `userAge` not `x`
- Start with lowercase (except classes)
- No spaces or special characters (except _ and $)

---

## Data Types

**JavaScript has 7 primitive data types:**

### 1. String (Text)

**Represents text, enclosed in quotes:**

```javascript
let name = "Tian";
let city = 'Batangas';  // Single quotes OK
let message = `Hello, ${name}!`;  // Template literals (backticks)

console.log(name);     // Output: Tian
console.log(message);  // Output: Hello, Tian!
```

**String concatenation:**
```javascript
let firstName = "Rhea";
let lastName = "Joy";
let fullName = firstName + " " + lastName;
console.log(fullName);  // Output: Rhea Joy

// Template literals (modern way)
let greeting = `My name is ${firstName} ${lastName}`;
console.log(greeting);  // Output: My name is Rhea Joy
```

---

### 2. Number (Integer and Decimal)

**Represents numbers:**

```javascript
let age = 15;
let price = 99.99;
let temperature = -5;
let population = 1000000;

console.log(age);        // Output: 15
console.log(price);      // Output: 99.99
```

**Math operations:**
```javascript
let a = 10;
let b = 3;

console.log(a + b);  // 13 (Addition)
console.log(a - b);  // 7  (Subtraction)
console.log(a * b);  // 30 (Multiplication)
console.log(a / b);  // 3.333... (Division)
console.log(a % b);  // 1  (Remainder/Modulo)
```

---

### 3. Boolean (True/False)

**Represents logical values:**

```javascript
let isStudent = true;
let hasLicense = false;
let isAdult = age >= 18;  // Result of comparison

console.log(isStudent);  // Output: true
console.log(hasLicense); // Output: false
```

**Used in conditions:**
```javascript
let age = 17;
let canVote = age >= 18;
console.log(canVote);  // Output: false
```

---

### 4. Undefined

**Variable declared but not assigned a value:**

```javascript
let name;
console.log(name);  // Output: undefined

let age = undefined;
console.log(age);   // Output: undefined
```

---

### 5. Null

**Intentionally empty value:**

```javascript
let selectedOption = null;  // Explicitly no value
console.log(selectedOption);  // Output: null
```

**Difference:**
- `undefined`: Variable declared but not assigned
- `null`: Intentionally set to "no value"

---

### 6. Symbol (Advanced)

**Unique identifier (not commonly used):**
```javascript
let id = Symbol("id");
```

---

### 7. BigInt (Large Numbers)

**For very large integers:**
```javascript
let bigNumber = 123456789012345678901234567890n;
```

---

## Checking Data Types: typeof

**Use `typeof` to check variable type:**

```javascript
let name = "Tian";
let age = 15;
let isStudent = true;
let nothing = null;
let notDefined;

console.log(typeof name);       // Output: string
console.log(typeof age);        // Output: number
console.log(typeof isStudent);  // Output: boolean
console.log(typeof nothing);    // Output: object (quirk!)
console.log(typeof notDefined); // Output: undefined
```

**Note:** `typeof null` returns `"object"` (JavaScript quirk)

---

## Barangay Visitor Counter Example

**HTML:**
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Visitor Counter</title>
</head>
<body>
    <h1>Barangay San Miguel</h1>
    <p id="visitor-count">Loading...</p>
    
    <script src="script.js"></script>
</body>
</html>
```

**JavaScript (script.js):**
```javascript
// Variables for visitor tracking
const barangayName = "San Miguel";
let visitorCount = 1250;
let isOpen = true;
let lastUpdate = null;

// Log to console
console.log("Barangay:", barangayName);
console.log("Visitors today:", visitorCount);
console.log("Office open:", isOpen);

// Update HTML
let displayText = `Welcome to Barangay ${barangayName}! Visitors today: ${visitorCount}`;
document.getElementById("visitor-count").textContent = displayText;

// Increment counter
visitorCount = visitorCount + 1;
console.log("New count:", visitorCount);  // Output: 1251
```

---

## Type Conversion

### String to Number

```javascript
let ageString = "15";
let ageNumber = Number(ageString);

console.log(typeof ageString);  // Output: string
console.log(typeof ageNumber);  // Output: number

// Alternative methods
let price = parseInt("99");      // 99 (integer)
let amount = parseFloat("99.99"); // 99.99 (decimal)
```

---

### Number to String

```javascript
let age = 15;
let ageString = String(age);

console.log(typeof age);        // Output: number
console.log(typeof ageString);  // Output: string

// Alternative
let priceText = (99.99).toString();  // "99.99"
```

---

### Automatic Type Conversion (Coercion)

**JavaScript sometimes converts types automatically:**

```javascript
// String + Number = String (concatenation)
console.log("Age: " + 15);  // Output: "Age: 15"

// Number + String = String
console.log(100 + "50");    // Output: "10050"

// Subtraction converts string to number
console.log("100" - 50);    // Output: 50

// Comparison
console.log("10" == 10);    // true (loose equality, converts types)
console.log("10" === 10);   // false (strict equality, checks type)
```

**Use `===` (strict equality) to avoid unexpected conversions!**

---

## Barangay Service Form Example

```javascript
// Barangay clearance application
const serviceName = "Barangay Clearance";
const processingFee = 50;
let applicantName = "Juan dela Cruz";
let applicantAge = 25;
let hasValidID = true;
let applicationNumber = null;  // Will be assigned later

// Check eligibility
let isEligible = hasValidID && applicantAge >= 18;

// Log application details
console.log("=== Barangay Service Application ===");
console.log("Service:", serviceName);
console.log("Applicant:", applicantName);
console.log("Age:", applicantAge);
console.log("Fee:", `₱${processingFee}`);
console.log("Eligible:", isEligible);

// Check data types
console.log("\nData Types:");
console.log("typeof serviceName:", typeof serviceName);       // string
console.log("typeof processingFee:", typeof processingFee);   // number
console.log("typeof applicantAge:", typeof applicantAge);     // number
console.log("typeof hasValidID:", typeof hasValidID);         // boolean
console.log("typeof applicationNumber:", typeof applicationNumber);  // object
```

---

## Common Mistakes

### 1. Reassigning const

```javascript
const barangay = "San Miguel";
barangay = "New Name";  // ❌ Error: Assignment to constant
```

---

### 2. Using var instead of let/const

```javascript
// Don't use var (old, problematic)
var name = "Tian";  // ❌ Avoid

// Use let or const
let name = "Tian";  // ✅ Good
const name = "Tian";  // ✅ Better (if won't change)
```

---

### 3. Case sensitivity

```javascript
let name = "Tian";
console.log(Name);  // ❌ Error: Name is not defined
// JavaScript is case-sensitive!
```

---

### 4. Forgetting quotes for strings

```javascript
let city = Batangas;  // ❌ Error: Batangas is not defined
let city = "Batangas";  // ✅ Correct
```

---

## Summary

Tian summarized:

**Variables:**
- `let`: For values that change
- `const`: For values that don't change (recommended when possible)
- `var`: Avoid (old way)

**Data Types:**
1. **String**: Text (`"Hello"`)
2. **Number**: Integers and decimals (`15`, `99.99`)
3. **Boolean**: True/false (`true`, `false`)
4. **Undefined**: Not assigned
5. **Null**: Intentionally empty

**Key Points:**
- Use `typeof` to check data type
- Use `===` for strict equality
- Template literals: `` `Hello, ${name}!` ``
- camelCase for variable names

Rhea Joy smiled. "Now we can store and work with data! The website is starting to think!"

---

## What's Next?

In the next lesson, you'll learn about **Operators and Expressions**—how to perform calculations, comparisons, and logical operations in JavaScript.

---

---

## Closing Story

Tian declared the first JavaScript variable: `let barangayName = 'Sto. Ni�o';`. Console-logged it. The value appeared in DevTools. Magic.

"JavaScript makes websites interactive," Kuya Miguel explained. "HTML is structure. CSS is style. JavaScript is behavior."

Tian experimented with variables, data types, operators. Numbers, strings, booleans, arrays, objectsall the building blocks of logic. The page was no longer static. It was programmable. Dynamic. Alive.

_Next up: Operators and Expressionsdoing math and logic!_