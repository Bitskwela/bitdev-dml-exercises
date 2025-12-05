# Lesson 27 Activities: Functions and Scoping

## Reusable Code Blocks

Master functions to organize code into reusable, modular pieces!

---

## Activity 1: Function Declarations

**Goal:** Create and call basic functions.

**Create:** `function-basics.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Function Basics</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        h1 { color: #1a73e8; }
        .card {
            background-color: #f9f9f9;
            padding: 20px;
            margin: 15px 0;
            border-radius: 8px;
            border-left: 5px solid #1a73e8;
        }
        .result {
            background-color: #e3f2fd;
            padding: 15px;
            border-radius: 5px;
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎯 Function Basics</h1>
        <div id="output"></div>
    </div>
    
    <script>
        // Function declaration
        function greet() {
            return "Mabuhay! Welcome to Barangay Services";
        }
        
        function displayOfficeHours() {
            return "Office Hours: Monday-Friday, 8AM-5PM";
        }
        
        function calculateClearanceFee() {
            return 50;
        }
        
        // Call functions
        let output = '';
        
        output += '<div class="card">';
        output += '<h2>Example 1: Simple Functions</h2>';
        output += `<div class="result"><p>${greet()}</p></div>`;
        output += `<div class="result"><p>${displayOfficeHours()}</p></div>`;
        output += `<div class="result"><p>Clearance Fee: ₱${calculateClearanceFee()}</p></div>`;
        output += '</div>';
        
        // Function structure
        output += `
            <div class="card">
                <h2>Function Declaration Syntax</h2>
                <pre><code>function functionName() {
    // Code to execute
    return value;  // Optional
}

// Call the function
functionName();  // Executes the code inside</code></pre>
            </div>
        `;
        
        document.getElementById('output').innerHTML = output;
    </script>
</body>
</html>
```

---

## Activity 2: Parameters and Arguments

**Goal:** Pass data into functions using parameters.

**Create:** `function-parameters.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Function Parameters</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        h1 { color: #1a73e8; }
        .card {
            background-color: #f9f9f9;
            padding: 20px;
            margin: 15px 0;
            border-radius: 8px;
            border-left: 5px solid #2196f3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📥 Function Parameters</h1>
        <div id="output"></div>
    </div>
    
    <script>
        // Functions with parameters
        function greetResident(name) {
            return `Welcome, ${name}!`;
        }
        
        function calculateDiscount(price, discountRate) {
            const discount = price * discountRate;
            const finalPrice = price - discount;
            return finalPrice;
        }
        
        function createResidentCard(name, age, zone) {
            return `
                <div style="border: 1px solid #ddd; padding: 15px; margin: 10px 0; border-radius: 5px;">
                    <h3>${name}</h3>
                    <p>Age: ${age}</p>
                    <p>Zone: ${zone}</p>
                </div>
            `;
        }
        
        function calculateFee(age, isPWD, isSenior) {
            let baseFee = 50;
            
            if (isSenior && isPWD) {
                return baseFee * 0.70;  // 30% off
            } else if (isSenior || isPWD) {
                return baseFee * 0.80;  // 20% off
            }
            return baseFee;
        }
        
        // Use functions
        let output = '';
        
        output += '<div class="card">';
        output += '<h2>Example 1: Single Parameter</h2>';
        output += `<p>${greetResident('Juan Dela Cruz')}</p>`;
        output += `<p>${greetResident('Maria Santos')}</p>`;
        output += '</div>';
        
        output += '<div class="card">';
        output += '<h2>Example 2: Multiple Parameters</h2>';
        const originalPrice = 500;
        const discounted = calculateDiscount(originalPrice, 0.20);
        output += `<p>Original: ₱${originalPrice}</p>`;
        output += `<p>With 20% discount: ₱${discounted}</p>`;
        output += '</div>';
        
        output += '<div class="card">';
        output += '<h2>Example 3: Resident Cards</h2>';
        output += createResidentCard('Juan Dela Cruz', 25, 'A');
        output += createResidentCard('Maria Santos', 65, 'B');
        output += createResidentCard('Pedro Garcia', 30, 'C');
        output += '</div>';
        
        output += '<div class="card">';
        output += '<h2>Example 4: Complex Calculations</h2>';
        const cases = [
            { name: 'Regular', age: 30, isPWD: false, isSenior: false },
            { name: 'Senior', age: 65, isPWD: false, isSenior: true },
            { name: 'PWD', age: 30, isPWD: true, isSenior: false },
            { name: 'Senior + PWD', age: 65, isPWD: true, isSenior: true }
        ];
        
        cases.forEach(c => {
            const fee = calculateFee(c.age, c.isPWD, c.isSenior);
            output += `<p>${c.name}: ₱${fee.toFixed(2)}</p>`;
        });
        output += '</div>';
        
        // Syntax
        output += `
            <div class="card">
                <h2>Parameter Syntax</h2>
                <pre><code>function functionName(param1, param2, param3) {
    // Use parameters inside function
    return param1 + param2 + param3;
}

// Call with arguments
functionName(10, 20, 30);  // Returns 60</code></pre>
                <p><strong>Parameters:</strong> Variables in function definition</p>
                <p><strong>Arguments:</strong> Values passed when calling function</p>
            </div>
        `;
        
        document.getElementById('output').innerHTML = output;
    </script>
</body>
</html>
```

---

## Activity 3: Return Values

**Goal:** Return data from functions for use elsewhere.

**Create:** `return-values.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Return Values</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        h1 { color: #1a73e8; }
        .card {
            background-color: #f9f9f9;
            padding: 20px;
            margin: 15px 0;
            border-radius: 8px;
            border-left: 5px solid #4caf50;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📤 Return Values</h1>
        <div id="output"></div>
    </div>
    
    <script>
        // Functions that return values
        function add(a, b) {
            return a + b;
        }
        
        function isAdult(age) {
            return age >= 18;
        }
        
        function getDiscount(age, isPWD) {
            if (age >= 60 || isPWD) {
                return 0.20;
            }
            return 0;
        }
        
        function calculateTotal(price, quantity, discount) {
            const subtotal = price * quantity;
            const discountAmount = subtotal * discount;
            const total = subtotal - discountAmount;
            return total;
        }
        
        function checkEligibility(age, isResident, hasUnpaidFees) {
            if (age < 18) {
                return { eligible: false, reason: 'Must be 18+' };
            }
            if (!isResident) {
                return { eligible: false, reason: 'Must be resident' };
            }
            if (hasUnpaidFees) {
                return { eligible: false, reason: 'Has unpaid fees' };
            }
            return { eligible: true, reason: 'Approved' };
        }
        
        // Use return values
        let output = '';
        
        output += '<div class="card">';
        output += '<h2>Example 1: Simple Returns</h2>';
        const sum = add(10, 20);
        output += `<p>10 + 20 = ${sum}</p>`;
        
        const age1 = 17;
        const age2 = 25;
        output += `<p>Age ${age1} is adult? ${isAdult(age1)}</p>`;
        output += `<p>Age ${age2} is adult? ${isAdult(age2)}</p>`;
        output += '</div>';
        
        output += '<div class="card">';
        output += '<h2>Example 2: Using Return Value in Calculations</h2>';
        const discount1 = getDiscount(30, false);
        const discount2 = getDiscount(65, false);
        const discount3 = getDiscount(30, true);
        
        output += `<p>Regular (30): ${discount1 * 100}% discount</p>`;
        output += `<p>Senior (65): ${discount2 * 100}% discount</p>`;
        output += `<p>PWD (30): ${discount3 * 100}% discount</p>`;
        output += '</div>';
        
        output += '<div class="card">';
        output += '<h2>Example 3: Chaining Functions</h2>';
        const price = 50;
        const quantity = 3;
        const customerAge = 65;
        const customerPWD = false;
        
        // Use return value of one function as argument for another
        const discount = getDiscount(customerAge, customerPWD);
        const total = calculateTotal(price, quantity, discount);
        
        output += `<p>Price: ₱${price} × ${quantity}</p>`;
        output += `<p>Discount: ${discount * 100}%</p>`;
        output += `<p><strong>Total: ₱${total.toFixed(2)}</strong></p>`;
        output += '</div>';
        
        output += '<div class="card">';
        output += '<h2>Example 4: Returning Objects</h2>';
        const applicants = [
            { name: 'Juan', age: 25, resident: true, unpaid: false },
            { name: 'Maria', age: 17, resident: true, unpaid: false },
            { name: 'Pedro', age: 30, resident: false, unpaid: false },
            { name: 'Ana', age: 28, resident: true, unpaid: true }
        ];
        
        applicants.forEach(app => {
            const result = checkEligibility(app.age, app.resident, app.unpaid);
            const statusColor = result.eligible ? '#4caf50' : '#f44336';
            output += `
                <div style="padding: 10px; margin: 5px 0; background-color: white; border-radius: 5px;">
                    <p><strong>${app.name}:</strong> <span style="color: ${statusColor}">${result.reason}</span></p>
                </div>
            `;
        });
        output += '</div>';
        
        // Syntax
        output += `
            <div class="card">
                <h2>Return Statement</h2>
                <pre><code>function calculate(x, y) {
    const result = x + y;
    return result;  // Send value back
}

const answer = calculate(5, 3);  // answer = 8

// Return stops function execution
function checkAge(age) {
    if (age < 18) {
        return "Minor";  // Stops here
    }
    return "Adult";  // Only runs if age >= 18
}</code></pre>
                <p><strong>Note:</strong> <code>return</code> immediately exits the function</p>
            </div>
        `;
        
        document.getElementById('output').innerHTML = output;
    </script>
</body>
</html>
```

---

## Activity 4: Arrow Functions

**Goal:** Use modern arrow function syntax.

**Create:** `arrow-functions.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Arrow Functions</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        h1 { color: #1a73e8; }
        .card {
            background-color: #f9f9f9;
            padding: 20px;
            margin: 15px 0;
            border-radius: 8px;
            border-left: 5px solid #ff9800;
        }
        .comparison {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>➡️ Arrow Functions</h1>
        <div id="output"></div>
    </div>
    
    <script>
        // Arrow function syntax
        const greet = () => {
            return "Hello!";
        };
        
        // Single parameter (no parentheses needed)
        const double = num => num * 2;
        
        // Multiple parameters
        const add = (a, b) => a + b;
        
        // Multi-line with explicit return
        const calculateFee = (age, isPWD) => {
            const baseFee = 50;
            if (age >= 60 || isPWD) {
                return baseFee * 0.80;
            }
            return baseFee;
        };
        
        // Returning object (wrap in parentheses)
        const createResident = (name, age) => ({
            name: name,
            age: age,
            zone: 'A'
        });
        
        // Use arrow functions
        let output = '';
        
        output += '<div class="card">';
        output += '<h2>Example 1: Basic Arrow Functions</h2>';
        output += `<p>${greet()}</p>`;
        output += `<p>Double 5: ${double(5)}</p>`;
        output += `<p>Add 10 + 20: ${add(10, 20)}</p>`;
        output += '</div>';
        
        // Comparison
        output += '<h2>Comparison: Regular vs Arrow</h2>';
        output += '<div class="comparison">';
        
        output += `
            <div class="card">
                <h3>Regular Function</h3>
                <pre><code>function greet(name) {
    return "Hello " + name;
}</code></pre>
            </div>
            <div class="card">
                <h3>Arrow Function</h3>
                <pre><code>const greet = (name) => {
    return "Hello " + name;
};</code></pre>
            </div>
        `;
        
        output += `
            <div class="card">
                <h3>Regular (Implicit Return)</h3>
                <pre><code>function double(x) {
    return x * 2;
}</code></pre>
            </div>
            <div class="card">
                <h3>Arrow (Implicit Return)</h3>
                <pre><code>const double = x => x * 2;</code></pre>
            </div>
        `;
        
        output += '</div>';
        
        // Array methods with arrows
        output += '<div class="card">';
        output += '<h2>Example 2: Arrow Functions with Arrays</h2>';
        
        const residents = ['Juan', 'Maria', 'Pedro', 'Ana'];
        
        // map
        const upperNames = residents.map(name => name.toUpperCase());
        output += `<p><strong>Uppercase:</strong> ${upperNames.join(', ')}</p>`;
        
        // filter
        const shortNames = residents.filter(name => name.length <= 4);
        output += `<p><strong>Short names:</strong> ${shortNames.join(', ')}</p>`;
        
        // forEach
        output += '<p><strong>Greetings:</strong></p>';
        residents.forEach(name => {
            output += `<p>  Hello, ${name}!</p>`;
        });
        output += '</div>';
        
        // Complex example
        output += '<div class="card">';
        output += '<h2>Example 3: Complete System</h2>';
        
        const services = [
            { name: 'Clearance', price: 50 },
            { name: 'ID', price: 30 },
            { name: 'Permit', price: 500 },
            { name: 'Certificate', price: 30 }
        ];
        
        // Arrow functions for data processing
        const applyDiscount = (service, discount) => ({
            ...service,
            originalPrice: service.price,
            discountedPrice: service.price * (1 - discount)
        });
        
        const formatService = service => `
            <div style="padding: 10px; margin: 5px 0; background-color: white; border-radius: 5px;">
                <p><strong>${service.name}</strong></p>
                ${service.originalPrice ? 
                    `<p>Original: ₱${service.originalPrice} | Discounted: ₱${service.discountedPrice.toFixed(2)}</p>` :
                    `<p>Price: ₱${service.price}</p>`
                }
            </div>
        `;
        
        // Senior discount
        const discount = 0.20;
        const discountedServices = services.map(s => applyDiscount(s, discount));
        
        output += '<h3>Senior Citizen Prices (20% off):</h3>';
        discountedServices.forEach(service => {
            output += formatService(service);
        });
        output += '</div>';
        
        // Arrow function syntax guide
        output += `
            <div class="card">
                <h2>Arrow Function Syntax</h2>
                <pre><code>// No parameters
const greet = () => "Hello";

// One parameter (no parentheses)
const double = x => x * 2;

// Multiple parameters
const add = (a, b) => a + b;

// Multi-line (explicit return)
const calculate = (x, y) => {
    const sum = x + y;
    return sum;
};

// Return object (wrap in parentheses)
const makePerson = (name, age) => ({
    name: name,
    age: age
});</code></pre>
            </div>
        `;
        
        document.getElementById('output').innerHTML = output;
    </script>
</body>
</html>
```

---

## Activity 5: Function Scope

**Goal:** Understand variable visibility and scope.

**Create:** `function-scope.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Function Scope</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        h1 { color: #1a73e8; }
        .card {
            background-color: #f9f9f9;
            padding: 20px;
            margin: 15px 0;
            border-radius: 8px;
            border-left: 5px solid #9c27b0;
        }
        .global { background-color: #e1f5fe; border-left-color: #03a9f4; }
        .local { background-color: #f3e5f5; border-left-color: #9c27b0; }
        .error { background-color: #ffebee; border-left-color: #f44336; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔭 Function Scope</h1>
        <div id="output"></div>
    </div>
    
    <script>
        let output = '';
        
        // Global scope
        const barangayName = "Barangay San Juan";
        let totalResidents = 100;
        
        function displayBarangayInfo() {
            // Can access global variables
            return `${barangayName} has ${totalResidents} residents`;
        }
        
        output += '<div class="card global">';
        output += '<h2>Example 1: Global Scope</h2>';
        output += `<p>${displayBarangayInfo()}</p>`;
        output += '<pre><code>// Global variables (outside functions)\nconst barangayName = "San Juan";\nlet totalResidents = 100;\n\nfunction displayInfo() {\n    // ✅ Can access global variables\n    return barangayName + " has " + totalResidents;\n}</code></pre>';
        output += '</div>';
        
        // Local scope
        function calculateFee() {
            // Local variable (only exists inside this function)
            const baseFee = 50;
            const tax = 5;
            return baseFee + tax;
        }
        
        output += '<div class="card local">';
        output += '<h2>Example 2: Local Scope</h2>';
        output += `<p>Total Fee: ₱${calculateFee()}</p>`;
        output += '<pre><code>function calculateFee() {\n    const baseFee = 50;  // Local variable\n    return baseFee;\n}\n\nconsole.log(baseFee);  // ❌ ERROR: baseFee not defined</code></pre>';
        output += '<p><strong>baseFee</strong> only exists inside the function!</p>';
        output += '</div>';
        
        // Shadowing
        const message = "Global message";
        
        function showMessage() {
            const message = "Local message";  // Shadows global
            return message;
        }
        
        output += '<div class="card">';
        output += '<h2>Example 3: Variable Shadowing</h2>';
        output += `<p>Global: ${message}</p>`;
        output += `<p>Inside function: ${showMessage()}</p>`;
        output += `<p>Global again: ${message}</p>`;
        output += '<pre><code>const message = "Global";\n\nfunction show() {\n    const message = "Local";  // Different variable!\n    return message;  // Returns "Local"\n}\n\nconsole.log(message);  // Still "Global"</code></pre>';
        output += '</div>';
        
        // Block scope
        output += '<div class="card">';
        output += '<h2>Example 4: Block Scope</h2>';
        
        let blockExample = '';
        if (true) {
            let blockVar = "Inside block";
            blockExample += `Inside if: ${blockVar}<br>`;
        }
        // blockVar doesn't exist here!
        blockExample += "Outside if: blockVar is not accessible";
        
        output += `<p>${blockExample}</p>`;
        output += '<pre><code>if (true) {\n    let blockVar = "Inside";\n    console.log(blockVar);  // ✅ Works\n}\nconsole.log(blockVar);  // ❌ ERROR: not defined</code></pre>';
        output += '</div>';
        
        // Practical example
        output += '<div class="card">';
        output += '<h2>Example 5: Practical Scoping</h2>';
        
        // Global configuration
        const serviceFees = {
            clearance: 50,
            id: 30,
            permit: 500
        };
        
        function calculateServiceFee(serviceType, age, isPWD) {
            // Local variables
            const baseFee = serviceFees[serviceType];
            let discount = 0;
            
            // Determine discount
            if (age >= 60 || isPWD) {
                discount = 0.20;
            }
            
            // Calculate final fee
            const finalFee = baseFee * (1 - discount);
            
            return {
                service: serviceType,
                baseFee: baseFee,
                discount: discount * 100,
                finalFee: finalFee
            };
        }
        
        const services = [
            calculateServiceFee('clearance', 65, false),
            calculateServiceFee('id', 30, true),
            calculateServiceFee('permit', 25, false)
        ];
        
        services.forEach(s => {
            output += `
                <div style="padding: 10px; margin: 5px 0; background-color: white; border-radius: 5px;">
                    <p><strong>${s.service.toUpperCase()}</strong></p>
                    <p>Base: ₱${s.baseFee} | Discount: ${s.discount}% | Final: ₱${s.finalFee.toFixed(2)}</p>
                </div>
            `;
        });
        output += '</div>';
        
        // Best practices
        output += `
            <div class="card">
                <h2>Scope Best Practices</h2>
                <h3>✅ DO:</h3>
                <ul>
                    <li>Use <code>const</code> and <code>let</code> (block-scoped)</li>
                    <li>Keep variables in smallest scope needed</li>
                    <li>Use descriptive names to avoid confusion</li>
                    <li>Pass data through parameters, not globals</li>
                </ul>
                <h3>❌ DON'T:</h3>
                <ul>
                    <li>Use <code>var</code> (function-scoped, confusing)</li>
                    <li>Make everything global</li>
                    <li>Shadow variables unnecessarily</li>
                    <li>Rely on global state in functions</li>
                </ul>
            </div>
        `;
        
        document.getElementById('output').innerHTML = output;
    </script>
</body>
</html>
```

---

## Activity 6: Complete Fee Calculator System

**Goal:** Build a complete system using all function concepts.

**Create:** `fee-calculator.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Fee Calculator</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 1000px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        h1 { color: #1a73e8; }
        .form-group {
            margin: 15px 0;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input, select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }
        button {
            background-color: #1a73e8;
            color: white;
            padding: 15px 30px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin: 10px 5px;
        }
        button:hover {
            background-color: #1557b0;
        }
        .result {
            background-color: #e8f5e9;
            padding: 20px;
            margin: 20px 0;
            border-radius: 8px;
            border-left: 5px solid #4caf50;
        }
        .breakdown {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 5px;
            margin: 10px 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 15px 0;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #1a73e8;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏢 Barangay Fee Calculator</h1>
        
        <div class="form-group">
            <label for="service">Service:</label>
            <select id="service">
                <option value="clearance">Barangay Clearance</option>
                <option value="id">Barangay ID</option>
                <option value="permit">Business Permit</option>
                <option value="certificate">Certificate of Residency</option>
                <option value="indigency">Indigency Certificate</option>
            </select>
        </div>
        
        <div class="form-group">
            <label for="age">Age:</label>
            <input type="number" id="age" value="25" min="1" max="120">
        </div>
        
        <div class="form-group">
            <label>
                <input type="checkbox" id="isPWD"> Person with Disability (PWD)
            </label>
        </div>
        
        <div class="form-group">
            <label>
                <input type="checkbox" id="isResident" checked> Registered Resident
            </label>
        </div>
        
        <button onclick="calculateFee()">Calculate Fee</button>
        <button onclick="showAllServices()" style="background-color: #4caf50;">Show All Services</button>
        
        <div id="output"></div>
    </div>
    
    <script>
        // Global configuration (read-only)
        const SERVICE_PRICES = {
            clearance: 50,
            id: 30,
            permit: 500,
            certificate: 30,
            indigency: 0
        };
        
        const SERVICE_NAMES = {
            clearance: 'Barangay Clearance',
            id: 'Barangay ID',
            permit: 'Business Permit',
            certificate: 'Certificate of Residency',
            indigency: 'Indigency Certificate'
        };
        
        // Pure functions (no side effects)
        const getBasePrice = (serviceType) => SERVICE_PRICES[serviceType] || 0;
        
        const getServiceName = (serviceType) => SERVICE_NAMES[serviceType] || 'Unknown Service';
        
        const calculateDiscount = (age, isPWD) => {
            const isSenior = age >= 60;
            
            if (isSenior && isPWD) {
                return 0.30;  // 30% discount
            } else if (isSenior || isPWD) {
                return 0.20;  // 20% discount
            }
            return 0;  // No discount
        };
        
        const getDiscountReason = (age, isPWD) => {
            const isSenior = age >= 60;
            
            if (isSenior && isPWD) {
                return 'Senior Citizen + PWD';
            } else if (isSenior) {
                return 'Senior Citizen';
            } else if (isPWD) {
                return 'Person with Disability';
            }
            return 'No discount';
        };
        
        const applyDiscount = (price, discountRate) => {
            const discountAmount = price * discountRate;
            return {
                originalPrice: price,
                discountRate: discountRate,
                discountAmount: discountAmount,
                finalPrice: price - discountAmount
            };
        };
        
        const checkEligibility = (isResident) => {
            if (!isResident) {
                return {
                    eligible: false,
                    message: '❌ Must be a registered resident'
                };
            }
            return {
                eligible: true,
                message: '✅ Eligible'
            };
        };
        
        // Main calculation function
        function calculateServiceFee(serviceType, age, isPWD, isResident) {
            // Check eligibility first
            const eligibility = checkEligibility(isResident);
            if (!eligibility.eligible) {
                return {
                    success: false,
                    message: eligibility.message
                };
            }
            
            // Get service details
            const serviceName = getServiceName(serviceType);
            const basePrice = getBasePrice(serviceType);
            
            // Calculate discount
            const discountRate = calculateDiscount(age, isPWD);
            const discountReason = getDiscountReason(age, isPWD);
            
            // Apply discount
            const pricing = applyDiscount(basePrice, discountRate);
            
            return {
                success: true,
                serviceName: serviceName,
                ...pricing,
                discountReason: discountReason
            };
        }
        
        // Display function
        function displayResult(result) {
            if (!result.success) {
                return `
                    <div class="result" style="background-color: #ffebee; border-left-color: #f44336;">
                        <h2>${result.message}</h2>
                    </div>
                `;
            }
            
            return `
                <div class="result">
                    <h2>${result.serviceName}</h2>
                    <div class="breakdown">
                        <p><strong>Base Price:</strong> ₱${result.originalPrice.toFixed(2)}</p>
                        <p><strong>Discount:</strong> ${(result.discountRate * 100).toFixed(0)}% (${result.discountReason})</p>
                        <p><strong>Discount Amount:</strong> -₱${result.discountAmount.toFixed(2)}</p>
                        <hr>
                        <p style="font-size: 1.5em;"><strong>Total:</strong> ₱${result.finalPrice.toFixed(2)}</p>
                    </div>
                </div>
            `;
        }
        
        // Event handler
        function calculateFee() {
            const serviceType = document.getElementById('service').value;
            const age = parseInt(document.getElementById('age').value);
            const isPWD = document.getElementById('isPWD').checked;
            const isResident = document.getElementById('isResident').checked;
            
            const result = calculateServiceFee(serviceType, age, isPWD, isResident);
            document.getElementById('output').innerHTML = displayResult(result);
        }
        
        // Show all services
        function showAllServices() {
            const age = parseInt(document.getElementById('age').value);
            const isPWD = document.getElementById('isPWD').checked;
            const isResident = document.getElementById('isResident').checked;
            
            let output = '<h2>All Services</h2>';
            output += '<table><thead><tr><th>Service</th><th>Base</th><th>Discount</th><th>Final</th></tr></thead><tbody>';
            
            Object.keys(SERVICE_PRICES).forEach(serviceType => {
                const result = calculateServiceFee(serviceType, age, isPWD, isResident);
                if (result.success) {
                    output += `
                        <tr>
                            <td>${result.serviceName}</td>
                            <td>₱${result.originalPrice.toFixed(2)}</td>
                            <td>${(result.discountRate * 100).toFixed(0)}%</td>
                            <td><strong>₱${result.finalPrice.toFixed(2)}</strong></td>
                        </tr>
                    `;
                }
            });
            
            output += '</tbody></table>';
            document.getElementById('output').innerHTML = output;
        }
    </script>
</body>
</html>
```

---

## 🎯 Interactive Coding Challenges

---

### Challenge 1: Greet Resident

**Scenario:** Create a personalized greeting for residents.

**Your Task:**
Write a function `greetResident(name)` that returns a greeting message.

**Starter Code:**
```javascript
function greetResident(name) {
    // Your code here
    // Return: "Welcome, [name]! How can we help you today?"
    
}
```

**Requirements:**
- ✅ Must accept one parameter: `name`
- ✅ Must return a string
- ✅ Include the name in the greeting
- ✅ Use template literals (backticks)

**Test Cases:**
```javascript
console.assert(greetResident("Juan") === "Welcome, Juan! How can we help you today?");
console.assert(greetResident("Maria") === "Welcome, Maria! How can we help you today?");
console.assert(greetResident("Pedro Garcia") === "Welcome, Pedro Garcia! How can we help you today?");
```

**Validation Criteria:**
- ⚠️ Points: 10
- ⚠️ Difficulty: Easy
- ⚠️ Tests string interpolation

---

### Challenge 2: Calculate Age Category

**Scenario:** Categorize residents by age for service eligibility.

**Your Task:**
Write a function `getAgeCategory(age)` that returns the category.

**Starter Code:**
```javascript
function getAgeCategory(age) {
    // Your code here
    // Return "Child" (0-17), "Adult" (18-59), or "Senior" (60+)
    
}
```

**Requirements:**
- ✅ Child: 0-17 years
- ✅ Adult: 18-59 years
- ✅ Senior: 60+ years
- ✅ Use if-else statements

**Test Cases:**
```javascript
console.assert(getAgeCategory(10) === "Child");
console.assert(getAgeCategory(17) === "Child");
console.assert(getAgeCategory(18) === "Adult");
console.assert(getAgeCategory(59) === "Adult");
console.assert(getAgeCategory(60) === "Senior");
console.assert(getAgeCategory(85) === "Senior");
```

**Validation Criteria:**
- ⚠️ Points: 15
- ⚠️ Tests conditionals inside functions
- ⚠️ Must handle boundary cases (17, 18, 59, 60)

---

### Challenge 3: Calculate Service Fee with Discount

**Scenario:** Calculate fees with age-based discounts.

**Your Task:**
Write a function `calculateFee(serviceType, age)` that:
- Clearance = ₱50, ID = ₱30, Permit = ₱500
- Senior citizens (60+) get 20% off
- Children (under 18) get 50% off

**Starter Code:**
```javascript
function calculateFee(serviceType, age) {
    // Your code here
    // 1. Set base fee based on serviceType
    // 2. Apply discount based on age
    // 3. Return final fee
    
}
```

**Requirements:**
- ✅ Accept two parameters
- ✅ Return numeric value
- ✅ Apply correct discounts
- ✅ Handle all three service types

**Test Cases:**
```javascript
console.assert(calculateFee("Clearance", 25) === 50);     // Adult, no discount
console.assert(calculateFee("Clearance", 65) === 40);     // Senior, 20% off
console.assert(calculateFee("Clearance", 10) === 25);     // Child, 50% off
console.assert(calculateFee("ID", 30) === 30);            // Adult
console.assert(calculateFee("ID", 70) === 24);            // Senior
console.assert(calculateFee("Permit", 15) === 250);       // Child
console.assert(calculateFee("Permit", 45) === 500);       // Adult
```

**Validation Criteria:**
- ⚠️ Points: 25
- ⚠️ Difficulty: Medium
- ⚠️ Tests nested logic and multiple conditions

---

### Challenge 4: Scope Challenge - Counter

**Scenario:** Create a counter function using closures.

**Your Task:**
Write a function `createCounter()` that returns an object with `increment()`, `decrement()`, and `getValue()` methods.

**Starter Code:**
```javascript
function createCounter() {
    // Your code here
    // Create a private count variable
    // Return object with three methods
    
}
```

**Requirements:**
- ✅ `count` variable must be private (not accessible outside)
- ✅ `increment()` adds 1 to count
- ✅ `decrement()` subtracts 1 from count
- ✅ `getValue()` returns current count
- ✅ Use closure to maintain state

**Test Cases:**
```javascript
const counter = createCounter();
console.assert(counter.getValue() === 0);
counter.increment();
console.assert(counter.getValue() === 1);
counter.increment();
counter.increment();
console.assert(counter.getValue() === 3);
counter.decrement();
console.assert(counter.getValue() === 2);
```

**Validation Criteria:**
- ⚠️ Points: 30
- ⚠️ Difficulty: Hard
- ⚠️ Tests closure and scope understanding

---

### Challenge 5: Default Parameters

**Scenario:** Create resident record with optional fields.

**Your Task:**
Write a function `createResident(name, age, zone = "Unassigned")` with default parameter.

**Starter Code:**
```javascript
function createResident(name, age, zone = "Unassigned") {
    // Your code here
    // Return object with name, age, and zone properties
    
}
```

**Requirements:**
- ✅ Must have 3 parameters
- ✅ `zone` has default value "Unassigned"
- ✅ Return an object with all properties
- ✅ Use ES6 default parameter syntax

**Test Cases:**
```javascript
const resident1 = createResident("Juan", 25);
console.assert(resident1.name === "Juan");
console.assert(resident1.age === 25);
console.assert(resident1.zone === "Unassigned");

const resident2 = createResident("Maria", 30, "Zone A");
console.assert(resident2.name === "Maria");
console.assert(resident2.age === 30);
console.assert(resident2.zone === "Zone A");
```

**Validation Criteria:**
- ⚠️ Points: 15
- ⚠️ Tests default parameters and object creation

---

### 📊 Challenge Summary

| Challenge | Points | Difficulty | Concepts Tested |
|-----------|--------|------------|-----------------|
| Greet Resident | 10 | Easy | Basic functions, template literals |
| Age Category | 15 | Easy | Conditionals in functions |
| Service Fee | 25 | Medium | Multiple parameters, nested logic |
| Counter (Closure) | 30 | Hard | Closures, private variables |
| Default Parameters | 15 | Easy | ES6 default params, objects |
| **Total** | **95** | - | - |

**Grading:**
- 85-95 points: Excellent ⭐⭐⭐
- 65-84 points: Good ⭐⭐
- 40-64 points: Needs Practice ⭐
- 0-39 points: Review Lesson

---

## 💡 Tips for Success

**Function Checklist:**
1. ✅ Does your function have a descriptive name?
2. ✅ Are you returning a value (not just logging)?
3. ✅ Did you test with different inputs?
4. ✅ Are parameters named clearly?
5. ✅ Is scope properly managed?

**Common Mistakes:**
- ❌ Forgetting to `return` (using `console.log` instead)
- ❌ Accessing variables outside their scope
- ❌ Not using parameters (hardcoding values)
- ❌ Arrow function vs regular function confusion

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## Interactive Challenge Solutions

### Challenge 1: Greet Resident
```javascript
function greetResident(name) {
    return `Welcome, ${name}! How can we help you today?`;
}

// Test
console.log(greetResident("Juan"));  // "Welcome, Juan! How can we help you today?"
```

**Explanation:** Use template literals with `${}` to insert the name parameter.

---

### Challenge 2: Calculate Age Category
```javascript
function getAgeCategory(age) {
    if (age < 18) {
        return "Child";
    } else if (age < 60) {
        return "Adult";
    } else {
        return "Senior";
    }
}

// Tests
console.log(getAgeCategory(10));   // "Child"
console.log(getAgeCategory(18));   // "Adult"
console.log(getAgeCategory(60));   // "Senior"
```

**Explanation:** 
- First check: age < 18 → "Child"
- Second check: age < 60 → "Adult" (already know age >= 18)
- Otherwise: "Senior" (age >= 60)

---

### Challenge 3: Calculate Service Fee with Discount
```javascript
function calculateFee(serviceType, age) {
    // Set base fee
    let baseFee;
    if (serviceType === "Clearance") {
        baseFee = 50;
    } else if (serviceType === "ID") {
        baseFee = 30;
    } else if (serviceType === "Permit") {
        baseFee = 500;
    }
    
    // Apply age-based discount
    let discount = 0;
    if (age < 18) {
        discount = 0.50;  // 50% off for children
    } else if (age >= 60) {
        discount = 0.20;  // 20% off for seniors
    }
    
    return baseFee * (1 - discount);
}

// Alternative: More concise
function calculateFee(serviceType, age) {
    const fees = { Clearance: 50, ID: 30, Permit: 500 };
    const baseFee = fees[serviceType];
    
    if (age < 18) return baseFee * 0.5;   // 50% off
    if (age >= 60) return baseFee * 0.8;  // 20% off
    return baseFee;
}

// Tests
console.log(calculateFee("Clearance", 25));  // 50
console.log(calculateFee("Clearance", 65));  // 40
console.log(calculateFee("ID", 10));         // 15
```

**Explanation:**
- Step 1: Determine base fee from service type
- Step 2: Calculate discount based on age
- Step 3: Apply discount and return
- Alternative uses object lookup and early returns

---

### Challenge 4: Scope Challenge - Counter
```javascript
function createCounter() {
    let count = 0;  // Private variable
    
    return {
        increment: function() {
            count++;
        },
        decrement: function() {
            count--;
        },
        getValue: function() {
            return count;
        }
    };
}

// Alternative: ES6 arrow functions
function createCounter() {
    let count = 0;
    
    return {
        increment: () => count++,
        decrement: () => count--,
        getValue: () => count
    };
}

// Test
const counter = createCounter();
console.log(counter.getValue());  // 0
counter.increment();
counter.increment();
console.log(counter.getValue());  // 2
counter.decrement();
console.log(counter.getValue());  // 1
```

**Explanation:**
- `count` is private - only accessible through returned methods
- This is a **closure** - inner functions remember outer variables
- Each call to `createCounter()` creates a new independent counter

---

### Challenge 5: Default Parameters
```javascript
function createResident(name, age, zone = "Unassigned") {
    return {
        name: name,
        age: age,
        zone: zone
    };
}

// Alternative: ES6 shorthand
function createResident(name, age, zone = "Unassigned") {
    return { name, age, zone };
}

// Tests
console.log(createResident("Juan", 25));
// { name: "Juan", age: 25, zone: "Unassigned" }

console.log(createResident("Maria", 30, "Zone A"));
// { name: "Maria", age: 30, zone: "Zone A" }
```

**Explanation:**
- `zone = "Unassigned"` sets default value
- If `zone` not provided, uses "Unassigned"
- Object property shorthand: `{ name }` same as `{ name: name }`

---

## Functions Reference

### Function Declaration

```javascript
function functionName(param1, param2) {
    // Code to execute
    return value;
}

// Call function
functionName(arg1, arg2);
```

### Arrow Functions

```javascript
// No parameters
const greet = () => "Hello";

// One parameter
const double = x => x * 2;

// Multiple parameters
const add = (a, b) => a + b;

// Multi-line
const calculate = (x, y) => {
    const sum = x + y;
    return sum;
};
```

### Parameters and Arguments

```javascript
function greet(name) {  // name is parameter
    return `Hello ${name}`;
}

greet("Juan");  // "Juan" is argument
```

### Return Statement

```javascript
function add(a, b) {
    return a + b;  // Exits function, returns value
}

const result = add(5, 3);  // result = 8
```

### Scope

- **Global scope:** Variables outside functions
- **Local scope:** Variables inside functions
- **Block scope:** Variables inside { } blocks

```javascript
const global = "accessible everywhere";

function test() {
    const local = "only inside function";
    
    if (true) {
        let block = "only in this block";
    }
}
```

### Best Practices

1. Use arrow functions for short operations
2. One function = one responsibility
3. Keep variables in smallest scope needed
4. Use descriptive function names
5. Return early for validation

</details>

---

**Congratulations!** You've mastered functions!

**Next Lesson:** Arrays and Objects!
