# Lesson 23 Activities: JavaScript Variables and Data Types

## Welcome to JavaScript!

JavaScript brings websites to life with interactivity. Let's start with variables and data types!

---

## Activity 1: Understanding Variables - let, const, var

**Goal:** Learn the three ways to declare variables in JavaScript.

**Create:** `variables-basics.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JavaScript Variables</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .output {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        h1 {
            color: #1a73e8;
        }
        h2 {
            color: #333;
            border-bottom: 2px solid #1a73e8;
            padding-bottom: 10px;
        }
        code {
            background-color: #f5f5f5;
            padding: 2px 6px;
            border-radius: 3px;
            color: #e91e63;
        }
    </style>
</head>
<body>
    <h1>JavaScript Variables</h1>
    
    <div class="output">
        <h2>Variable Declarations</h2>
        <div id="output1"></div>
    </div>
    
    <div class="output">
        <h2>let vs const vs var</h2>
        <div id="output2"></div>
    </div>
    
    <script>
        // LET - can be reassigned, block-scoped
        let barangayName = "San Miguel";
        console.log("Using let:", barangayName);
        barangayName = "San Jose";  // Can reassign
        console.log("After reassignment:", barangayName);
        
        // CONST - cannot be reassigned, block-scoped
        const barangayCaptain = "Juan Dela Cruz";
        console.log("Using const:", barangayCaptain);
        // barangayCaptain = "Maria Santos";  // ERROR! Cannot reassign
        
        // VAR - old way (avoid using)
        var population = 5000;
        console.log("Using var:", population);
        
        // Display in HTML
        document.getElementById('output1').innerHTML = `
            <p><strong>let</strong> barangayName = "${barangayName}"</p>
            <p><strong>const</strong> barangayCaptain = "${barangayCaptain}"</p>
            <p><strong>var</strong> population = ${population}</p>
        `;
        
        document.getElementById('output2').innerHTML = `
            <p>✅ <strong>let</strong>: Can be reassigned, block-scoped (use for changing values)</p>
            <p>✅ <strong>const</strong>: Cannot be reassigned, block-scoped (use for constants)</p>
            <p>⚠️ <strong>var</strong>: Old way, function-scoped (avoid in modern code)</p>
        `;
    </script>
</body>
</html>
```

**Key Points:**
- `let` for values that change
- `const` for values that don't change
- Avoid `var` in modern JavaScript

---

## Activity 2: Data Types - Strings

**Goal:** Work with text data using strings.

**Create:** `strings.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JavaScript Strings</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .output {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        h1 { color: #1a73e8; }
        h2 { color: #333; margin-top: 0; }
    </style>
</head>
<body>
    <h1>JavaScript Strings</h1>
    
    <div class="output">
        <h2>String Creation</h2>
        <div id="output1"></div>
    </div>
    
    <div class="output">
        <h2>String Concatenation</h2>
        <div id="output2"></div>
    </div>
    
    <div class="output">
        <h2>Template Literals (Best Way!)</h2>
        <div id="output3"></div>
    </div>
    
    <script>
        // String creation - three ways
        let firstName = "Juan";           // Double quotes
        let lastName = 'Dela Cruz';       // Single quotes
        let fullName = `Juan Dela Cruz`;  // Template literals (backticks)
        
        document.getElementById('output1').innerHTML = `
            <p>Double quotes: "${firstName}"</p>
            <p>Single quotes: '${lastName}'</p>
            <p>Template literals: \`${fullName}\`</p>
        `;
        
        // String concatenation - old way
        let barangay = "San Miguel";
        let city = "San Pablo";
        let address = barangay + ", " + city;
        
        document.getElementById('output2').innerHTML = `
            <p>Using + operator: "${address}"</p>
        `;
        
        // Template literals - modern way
        let residentName = "Maria Santos";
        let age = 35;
        let barangayName = "San Miguel";
        
        let greeting = `Hello, ${residentName}! You are ${age} years old and live in Barangay ${barangayName}.`;
        
        // Multi-line strings
        let announcement = `
            BARANGAY ANNOUNCEMENT
            
            Date: December 4, 2025
            Subject: Community Meeting
            
            All residents are invited!
        `;
        
        document.getElementById('output3').innerHTML = `
            <p><strong>Template Literal:</strong><br>${greeting}</p>
            <p><strong>Multi-line String:</strong><pre>${announcement}</pre></p>
        `;
    </script>
</body>
</html>
```

**Best Practice:** Use template literals (backticks) for cleaner string formatting!

---

## Activity 3: Data Types - Numbers

**Goal:** Work with numeric data.

**Create:** `numbers.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JavaScript Numbers</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .output {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        h1 { color: #1a73e8; }
        h2 { color: #333; margin-top: 0; }
    </style>
</head>
<body>
    <h1>JavaScript Numbers</h1>
    
    <div class="output">
        <h2>Number Types</h2>
        <div id="output1"></div>
    </div>
    
    <div class="output">
        <h2>Basic Math Operations</h2>
        <div id="output2"></div>
    </div>
    
    <div class="output">
        <h2>Barangay Clearance Calculator</h2>
        <div id="output3"></div>
    </div>
    
    <script>
        // Number types
        let population = 5000;              // Integer
        let clearancePrice = 50.00;         // Decimal
        let percentage = 0.15;              // Percentage as decimal
        let scientificNotation = 5e3;       // 5000 in scientific notation
        
        document.getElementById('output1').innerHTML = `
            <p>Integer: ${population}</p>
            <p>Decimal: ₱${clearancePrice}</p>
            <p>Percentage: ${percentage * 100}%</p>
            <p>Scientific: ${scientificNotation}</p>
        `;
        
        // Basic math
        let a = 100;
        let b = 30;
        
        document.getElementById('output2').innerHTML = `
            <p>Addition: ${a} + ${b} = ${a + b}</p>
            <p>Subtraction: ${a} - ${b} = ${a - b}</p>
            <p>Multiplication: ${a} × ${b} = ${a * b}</p>
            <p>Division: ${a} ÷ ${b} = ${a / b}</p>
            <p>Modulo (remainder): ${a} % ${b} = ${a % b}</p>
        `;
        
        // Barangay clearance calculator
        const clearanceFee = 50;
        const idFee = 30;
        const businessPermitFee = 500;
        
        let totalClearances = 10;
        let totalIds = 5;
        let totalPermits = 2;
        
        let totalRevenue = (clearanceFee * totalClearances) + 
                          (idFee * totalIds) + 
                          (businessPermitFee * totalPermits);
        
        document.getElementById('output3').innerHTML = `
            <p><strong>Today's Transactions:</strong></p>
            <p>Clearances: ${totalClearances} × ₱${clearanceFee} = ₱${clearanceFee * totalClearances}</p>
            <p>IDs: ${totalIds} × ₱${idFee} = ₱${idFee * totalIds}</p>
            <p>Business Permits: ${totalPermits} × ₱${businessPermitFee} = ₱${businessPermitFee * totalPermits}</p>
            <p><strong>Total Revenue: ₱${totalRevenue}</strong></p>
        `;
    </script>
</body>
</html>
```

---

## Activity 4: Data Types - Booleans

**Goal:** Understand true/false values.

**Create:** `booleans.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JavaScript Booleans</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .output {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        h1 { color: #1a73e8; }
        .status {
            padding: 10px;
            border-radius: 5px;
            margin: 5px 0;
        }
        .active { background-color: #4caf50; color: white; }
        .inactive { background-color: #f44336; color: white; }
    </style>
</head>
<body>
    <h1>JavaScript Booleans</h1>
    
    <div class="output">
        <h2>Boolean Values</h2>
        <div id="output1"></div>
    </div>
    
    <div class="output">
        <h2>Resident Status Check</h2>
        <div id="output2"></div>
    </div>
    
    <script>
        // Boolean basics
        let isRegistered = true;
        let hasUnpaidFees = false;
        
        document.getElementById('output1').innerHTML = `
            <p>isRegistered: ${isRegistered}</p>
            <p>hasUnpaidFees: ${hasUnpaidFees}</p>
        `;
        
        // Resident status
        let resident1 = {
            name: "Juan Dela Cruz",
            isRegistered: true,
            hasClearance: true,
            hasId: false
        };
        
        let resident2 = {
            name: "Maria Santos",
            isRegistered: false,
            hasClearance: false,
            hasId: false
        };
        
        document.getElementById('output2').innerHTML = `
            <h3>${resident1.name}</h3>
            <div class="${resident1.isRegistered ? 'status active' : 'status inactive'}">
                Registered: ${resident1.isRegistered ? '✅' : '❌'}
            </div>
            <div class="${resident1.hasClearance ? 'status active' : 'status inactive'}">
                Has Clearance: ${resident1.hasClearance ? '✅' : '❌'}
            </div>
            <div class="${resident1.hasId ? 'status active' : 'status inactive'}">
                Has Barangay ID: ${resident1.hasId ? '✅' : '❌'}
            </div>
            
            <h3>${resident2.name}</h3>
            <div class="${resident2.isRegistered ? 'status active' : 'status inactive'}">
                Registered: ${resident2.isRegistered ? '✅' : '❌'}
            </div>
            <div class="${resident2.hasClearance ? 'status active' : 'status inactive'}">
                Has Clearance: ${resident2.hasClearance ? '✅' : '❌'}
            </div>
            <div class="${resident2.hasId ? 'status active' : 'status inactive'}">
                Has Barangay ID: ${resident2.hasId ? '✅' : '❌'}
            </div>
        `;
    </script>
</body>
</html>
```

**Booleans:** Only two values - `true` or `false`

---

## Activity 5: Special Values - undefined and null

**Goal:** Understand undefined and null.

**Create:** `special-values.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>undefined and null</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .output {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        h1 { color: #1a73e8; }
    </style>
</head>
<body>
    <h1>undefined vs null</h1>
    
    <div class="output">
        <h2>Understanding undefined</h2>
        <div id="output1"></div>
    </div>
    
    <div class="output">
        <h2>Understanding null</h2>
        <div id="output2"></div>
    </div>
    
    <script>
        // undefined - variable declared but not assigned
        let middleName;
        console.log(middleName);  // undefined
        
        let resident = {
            firstName: "Juan",
            lastName: "Dela Cruz"
            // middleName is not defined
        };
        
        document.getElementById('output1').innerHTML = `
            <p><strong>undefined</strong> = Variable exists but has no value</p>
            <p>let middleName; → ${middleName}</p>
            <p>resident.middleName → ${resident.middleName}</p>
            <p><em>JavaScript automatically assigns undefined to uninitialized variables</em></p>
        `;
        
        // null - intentionally empty value
        let appointmentDate = null;  // Intentionally no appointment yet
        let previousAddress = null;  // Intentionally no previous address
        
        document.getElementById('output2').innerHTML = `
            <p><strong>null</strong> = Intentionally empty/no value</p>
            <p>let appointmentDate = null; → ${appointmentDate}</p>
            <p>let previousAddress = null; → ${previousAddress}</p>
            <p><em>We explicitly set null to indicate "no value on purpose"</em></p>
            
            <h3>Key Difference:</h3>
            <p>✅ <strong>undefined:</strong> JavaScript says "I don't know what this is"</p>
            <p>✅ <strong>null:</strong> Developer says "This is intentionally empty"</p>
        `;
    </script>
</body>
</html>
```

---

## Activity 6: typeof Operator

**Goal:** Check variable types with typeof.

**Create:** `typeof-operator.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>typeof Operator</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .output {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        h1 { color: #1a73e8; }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #1a73e8;
            color: white;
        }
        code {
            background-color: #f5f5f5;
            padding: 2px 6px;
            border-radius: 3px;
            color: #e91e63;
        }
    </style>
</head>
<body>
    <h1>typeof Operator</h1>
    
    <div class="output">
        <h2>Checking Data Types</h2>
        <div id="output"></div>
    </div>
    
    <script>
        // Different data types
        let barangayName = "San Miguel";
        let population = 5000;
        let isActive = true;
        let captain = null;
        let secretary;  // undefined
        let residents = ["Juan", "Maria", "Pedro"];
        let barangayInfo = { name: "San Miguel", city: "San Pablo" };
        
        // Create table
        let html = `
            <table>
                <thead>
                    <tr>
                        <th>Variable</th>
                        <th>Value</th>
                        <th>Type</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><code>barangayName</code></td>
                        <td>"${barangayName}"</td>
                        <td><strong>${typeof barangayName}</strong></td>
                    </tr>
                    <tr>
                        <td><code>population</code></td>
                        <td>${population}</td>
                        <td><strong>${typeof population}</strong></td>
                    </tr>
                    <tr>
                        <td><code>isActive</code></td>
                        <td>${isActive}</td>
                        <td><strong>${typeof isActive}</strong></td>
                    </tr>
                    <tr>
                        <td><code>captain</code></td>
                        <td>${captain}</td>
                        <td><strong>${typeof captain}</strong> (quirk!)</td>
                    </tr>
                    <tr>
                        <td><code>secretary</code></td>
                        <td>${secretary}</td>
                        <td><strong>${typeof secretary}</strong></td>
                    </tr>
                    <tr>
                        <td><code>residents</code></td>
                        <td>[Array]</td>
                        <td><strong>${typeof residents}</strong></td>
                    </tr>
                    <tr>
                        <td><code>barangayInfo</code></td>
                        <td>{Object}</td>
                        <td><strong>${typeof barangayInfo}</strong></td>
                    </tr>
                </tbody>
            </table>
            
            <h3>Important Notes:</h3>
            <p>⚠️ <code>typeof null</code> returns "object" (JavaScript quirk/bug)</p>
            <p>⚠️ Arrays show as "object" (arrays are special objects in JavaScript)</p>
        `;
        
        document.getElementById('output').innerHTML = html;
    </script>
</body>
</html>
```

---

## Activity 7: Barangay Resident Registration Form

**Goal:** Combine all data types in a practical example.

**Create:** `resident-registration.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resident Registration</title>
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
        h1 {
            color: #1a73e8;
            text-align: center;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
        input, select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }
        button {
            width: 100%;
            padding: 15px;
            background-color: #1a73e8;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
        }
        button:hover {
            background-color: #1557b0;
        }
        .output {
            margin-top: 30px;
            padding: 20px;
            background-color: #e3f2fd;
            border-radius: 5px;
            display: none;
        }
        .output h2 {
            color: #1a73e8;
            margin-top: 0;
        }
        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid #bbdefb;
        }
        .info-row:last-child {
            border-bottom: none;
        }
        .label { font-weight: bold; color: #1565c0; }
        .value { color: #333; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏛️ Barangay Resident Registration</h1>
        
        <form id="registrationForm">
            <div class="form-group">
                <label>Full Name (String):</label>
                <input type="text" id="fullName" required>
            </div>
            
            <div class="form-group">
                <label>Age (Number):</label>
                <input type="number" id="age" required>
            </div>
            
            <div class="form-group">
                <label>Address:</label>
                <input type="text" id="address" required>
            </div>
            
            <div class="form-group">
                <label>Registered Voter (Boolean):</label>
                <select id="isVoter">
                    <option value="true">Yes</option>
                    <option value="false">No</option>
                </select>
            </div>
            
            <div class="form-group">
                <label>Senior Citizen (Boolean):</label>
                <select id="isSenior">
                    <option value="false">No</option>
                    <option value="true">Yes</option>
                </select>
            </div>
            
            <div class="form-group">
                <label>Contact Number:</label>
                <input type="tel" id="contactNumber" required>
            </div>
            
            <button type="submit">Register Resident</button>
        </form>
        
        <div class="output" id="output">
            <h2>Registration Successful!</h2>
            <div id="residentInfo"></div>
        </div>
    </div>
    
    <script>
        const form = document.getElementById('registrationForm');
        
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Collect form data with proper data types
            const fullName = document.getElementById('fullName').value;  // String
            const age = Number(document.getElementById('age').value);    // Number
            const address = document.getElementById('address').value;    // String
            const isVoter = document.getElementById('isVoter').value === 'true';  // Boolean
            const isSenior = document.getElementById('isSenior').value === 'true'; // Boolean
            const contactNumber = document.getElementById('contactNumber').value;  // String
            
            // Calculate discount (seniors get 20% discount)
            const clearanceFee = 50;
            const discount = isSenior ? 0.20 : 0;
            const finalPrice = clearanceFee - (clearanceFee * discount);
            
            // Generate resident ID
            const residentId = `BRGY-${Date.now()}`;
            
            // Display information
            const outputDiv = document.getElementById('output');
            const infoDiv = document.getElementById('residentInfo');
            
            infoDiv.innerHTML = `
                <div class="info-row">
                    <span class="label">Resident ID:</span>
                    <span class="value">${residentId} <em>(${typeof residentId})</em></span>
                </div>
                <div class="info-row">
                    <span class="label">Full Name:</span>
                    <span class="value">${fullName} <em>(${typeof fullName})</em></span>
                </div>
                <div class="info-row">
                    <span class="label">Age:</span>
                    <span class="value">${age} years old <em>(${typeof age})</em></span>
                </div>
                <div class="info-row">
                    <span class="label">Address:</span>
                    <span class="value">${address} <em>(${typeof address})</em></span>
                </div>
                <div class="info-row">
                    <span class="label">Registered Voter:</span>
                    <span class="value">${isVoter ? '✅ Yes' : '❌ No'} <em>(${typeof isVoter})</em></span>
                </div>
                <div class="info-row">
                    <span class="label">Senior Citizen:</span>
                    <span class="value">${isSenior ? '✅ Yes' : '❌ No'} <em>(${typeof isSenior})</em></span>
                </div>
                <div class="info-row">
                    <span class="label">Contact Number:</span>
                    <span class="value">${contactNumber} <em>(${typeof contactNumber})</em></span>
                </div>
                <div class="info-row">
                    <span class="label">Clearance Fee:</span>
                    <span class="value">₱${finalPrice.toFixed(2)} ${isSenior ? '(20% senior discount)' : ''} <em>(${typeof finalPrice})</em></span>
                </div>
            `;
            
            outputDiv.style.display = 'block';
            
            // Log to console
            console.log('=== Resident Registration ===');
            console.log('Full Name:', fullName, typeof fullName);
            console.log('Age:', age, typeof age);
            console.log('Is Voter:', isVoter, typeof isVoter);
            console.log('Is Senior:', isSenior, typeof isSenior);
            console.log('Final Price:', finalPrice, typeof finalPrice);
        });
    </script>
</body>
</html>
```

**Practice:** Fill out the form and see how different data types work together!

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## JavaScript Variables and Data Types Reference

### Variable Declarations

**let - Reassignable, Block-Scoped:**
```javascript
let name = "Juan";
name = "Maria";  // ✅ Can reassign
```

**const - Cannot Reassign, Block-Scoped:**
```javascript
const PI = 3.14159;
// PI = 3.14;  // ❌ Error! Cannot reassign

const person = { name: "Juan" };
person.name = "Maria";  // ✅ Can modify object properties
```

**var - Old Way (Avoid):**
```javascript
var age = 25;  // ⚠️ Function-scoped, hoisted, avoid in modern code
```

**Best Practice:**
- Use `const` by default
- Use `let` when you need to reassign
- Never use `var`

---

### Data Types

**1. String (text):**
```javascript
let name = "Juan Dela Cruz";
let address = 'San Miguel, San Pablo';
let message = `Hello, ${name}!`;  // Template literal (best!)

// String methods
name.length           // 14
name.toUpperCase()    // "JUAN DELA CRUZ"
name.toLowerCase()    // "juan dela cruz"
name.includes("Juan") // true
```

**2. Number (integers and decimals):**
```javascript
let age = 35;
let price = 50.00;
let percentage = 0.15;

// Math operations
10 + 5    // 15 (addition)
10 - 5    // 5  (subtraction)
10 * 5    // 50 (multiplication)
10 / 5    // 2  (division)
10 % 3    // 1  (modulo/remainder)
10 ** 2   // 100 (exponentiation)
```

**3. Boolean (true/false):**
```javascript
let isRegistered = true;
let hasUnpaidFees = false;

// Comparisons return booleans
5 > 3     // true
5 < 3     // false
5 === 5   // true
5 !== 3   // true
```

**4. undefined (no value assigned):**
```javascript
let middleName;       // undefined (declared but not assigned)
let person = {};
person.age            // undefined (property doesn't exist)
```

**5. null (intentionally empty):**
```javascript
let appointmentDate = null;  // Explicitly "no value"
let previousAddress = null;  // Intentionally empty
```

**6. Object (collections of data):**
```javascript
let person = {
    name: "Juan",
    age: 35,
    city: "San Pablo"
};
```

**7. Array (ordered lists):**
```javascript
let residents = ["Juan", "Maria", "Pedro"];
let numbers = [1, 2, 3, 4, 5];
```

---

### typeof Operator

```javascript
typeof "Juan"           // "string"
typeof 25               // "number"
typeof true             // "boolean"
typeof undefined        // "undefined"
typeof null             // "object" (JavaScript quirk!)
typeof {}               // "object"
typeof []               // "object" (arrays are objects)
typeof function() {}    // "function"
```

---

### Type Conversion

**String to Number:**
```javascript
let str = "123";
let num = Number(str);     // 123
let num2 = parseInt(str);  // 123
let num3 = parseFloat("12.34");  // 12.34
```

**Number to String:**
```javascript
let num = 123;
let str = String(num);     // "123"
let str2 = num.toString(); // "123"
```

**To Boolean:**
```javascript
Boolean(1)        // true
Boolean(0)        // false
Boolean("")       // false
Boolean("text")   // true
Boolean(null)     // false
Boolean(undefined)// false
```

---

### Template Literals

**Best way to create strings:**
```javascript
let name = "Juan";
let age = 35;

// Old way (concatenation)
let msg1 = "Hello, " + name + "! You are " + age + " years old.";

// Modern way (template literal)
let msg2 = `Hello, ${name}! You are ${age} years old.`;

// Multi-line
let html = `
    <div>
        <h1>${name}</h1>
        <p>Age: ${age}</p>
    </div>
`;

// Expressions inside ${}
let total = `Total: ₱${50 * 10}`;  // "Total: ₱500"
```

---

### Variable Naming Rules

**Valid:**
```javascript
let firstName = "Juan";        // camelCase (recommended)
let first_name = "Juan";       // snake_case
let firstName2 = "Juan";       // Can include numbers (not at start)
let _private = "Juan";         // Can start with underscore
let $jquery = "Juan";          // Can start with $
```

**Invalid:**
```javascript
let 2name = "Juan";      // ❌ Can't start with number
let first-name = "Juan"; // ❌ Can't use hyphen
let let = "Juan";        // ❌ Can't use reserved words
```

**Best Practices:**
```javascript
// Use descriptive names
let n = 10;              // ❌ Not clear
let numberOfResidents = 10;  // ✅ Clear

// Use camelCase for variables
let barangayName = "San Miguel";  // ✅

// Use UPPERCASE for constants
const MAX_RESIDENTS = 1000;       // ✅
const PI = 3.14159;               // ✅
```

---

### Common Mistakes

**1. Forgetting quotes for strings:**
```javascript
let name = Juan;  // ❌ Error! Juan is undefined
let name = "Juan"; // ✅ Correct
```

**2. Comparing with = instead of ===:**
```javascript
if (age = 18) { }   // ❌ Assignment, not comparison!
if (age === 18) { } // ✅ Comparison
```

**3. Type confusion:**
```javascript
"5" + 5    // "55" (string concatenation)
"5" - 5    // 0 (number subtraction)
"5" * 2    // 10 (number multiplication)
```

---

### Console Methods

```javascript
console.log("Hello");           // Print to console
console.error("Error message"); // Print error
console.warn("Warning");        // Print warning
console.table([1, 2, 3]);      // Print as table
console.clear();               // Clear console
```

---

### Quick Reference Table

| Type      | Example                  | typeof Result |
|-----------|--------------------------|---------------|
| String    | `"Juan"`                 | "string"      |
| Number    | `25` or `25.5`           | "number"      |
| Boolean   | `true` or `false`        | "boolean"     |
| undefined | `undefined`              | "undefined"   |
| null      | `null`                   | "object"*     |
| Object    | `{name: "Juan"}`         | "object"      |
| Array     | `[1, 2, 3]`              | "object"      |

*JavaScript quirk: `typeof null` returns "object"

</details>

---

**Congratulations!** You've learned JavaScript variables and data types!

**Next Lesson:** Operators and Expressions!
