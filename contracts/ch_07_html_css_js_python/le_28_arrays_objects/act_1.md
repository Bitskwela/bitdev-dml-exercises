# Lesson 28 Activities: Arrays and Methods

## Working with Collections

Master JavaScript arrays and powerful array methods for data manipulation!

---

## Activity 1: Array Basics

**Goal:** Create and access arrays.

**Create:** `array-basics.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Array Basics</title>
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
        .item {
            padding: 10px;
            margin: 5px 0;
            background-color: white;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📚 Array Basics</h1>
        <div id="output"></div>
    </div>
    
    <script>
        // Create arrays
        const residents = ['Juan', 'Maria', 'Pedro', 'Ana', 'Jose'];
        const ages = [25, 30, 65, 28, 45];
        const zones = ['A', 'A', 'B', 'B', 'C'];
        const fees = [50, 50, 40, 50, 40];
        
        let output = '';
        
        // Example 1: Array creation and access
        output += '<div class="card">';
        output += '<h2>Example 1: Creating and Accessing Arrays</h2>';
        output += `<p><strong>Residents array:</strong> ${residents}</p>`;
        output += `<p><strong>First resident:</strong> ${residents[0]}</p>`;
        output += `<p><strong>Last resident:</strong> ${residents[residents.length - 1]}</p>`;
        output += `<p><strong>Array length:</strong> ${residents.length}</p>`;
        output += '</div>';
        
        // Example 2: Loop through array
        output += '<div class="card">';
        output += '<h2>Example 2: Looping Through Array</h2>';
        for (let i = 0; i < residents.length; i++) {
            output += `
                <div class="item">
                    <strong>${i + 1}. ${residents[i]}</strong> - Age: ${ages[i]}, Zone: ${zones[i]}, Fee: ₱${fees[i]}
                </div>
            `;
        }
        output += '</div>';
        
        // Example 3: Array methods
        output += '<div class="card">';
        output += '<h2>Example 3: Common Array Properties</h2>';
        output += `<p>Total residents: ${residents.length}</p>`;
        output += `<p>First resident: ${residents[0]}</p>`;
        output += `<p>Second resident: ${residents[1]}</p>`;
        output += `<p>Last resident: ${residents[residents.length - 1]}</p>`;
        output += '</div>';
        
        // Syntax
        output += `
            <div class="card">
                <h2>Array Syntax</h2>
                <pre><code>// Create array
const names = ['Juan', 'Maria', 'Pedro'];

// Access elements (0-indexed)
names[0]  // 'Juan' (first)
names[1]  // 'Maria' (second)
names[2]  // 'Pedro' (third)

// Array length
names.length  // 3

// Last element
names[names.length - 1]  // 'Pedro'</code></pre>
            </div>
        `;
        
        document.getElementById('output').innerHTML = output;
    </script>
</body>
</html>
```

---

## Activity 2: Adding and Removing Elements

**Goal:** Modify arrays with push, pop, shift, unshift.

**Create:** `array-modify.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modify Arrays</title>
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
        }
        .operation {
            background-color: white;
            padding: 15px;
            margin: 10px 0;
            border-radius: 5px;
            border-left: 4px solid #4caf50;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>➕ Adding and Removing Elements</h1>
        <div id="output"></div>
    </div>
    
    <script>
        let output = '';
        
        // Example 1: push() - Add to end
        output += '<div class="card">';
        output += '<h2>Example 1: push() - Add to End</h2>';
        let queue = ['Juan', 'Maria'];
        output += `<p>Initial: [${queue}]</p>`;
        
        queue.push('Pedro');
        output += `<div class="operation">push('Pedro') → [${queue}]</div>`;
        
        queue.push('Ana');
        output += `<div class="operation">push('Ana') → [${queue}]</div>`;
        output += '</div>';
        
        // Example 2: pop() - Remove from end
        output += '<div class="card">';
        output += '<h2>Example 2: pop() - Remove from End</h2>';
        let stack = ['Juan', 'Maria', 'Pedro', 'Ana'];
        output += `<p>Initial: [${stack}]</p>`;
        
        const removed1 = stack.pop();
        output += `<div class="operation">pop() removed '${removed1}' → [${stack}]</div>`;
        
        const removed2 = stack.pop();
        output += `<div class="operation">pop() removed '${removed2}' → [${stack}]</div>`;
        output += '</div>';
        
        // Example 3: unshift() - Add to start
        output += '<div class="card">';
        output += '<h2>Example 3: unshift() - Add to Start</h2>';
        let priority = ['Pedro', 'Ana'];
        output += `<p>Initial: [${priority}]</p>`;
        
        priority.unshift('Maria');
        output += `<div class="operation">unshift('Maria') → [${priority}]</div>`;
        
        priority.unshift('Juan');
        output += `<div class="operation">unshift('Juan') → [${priority}]</div>`;
        output += '</div>';
        
        // Example 4: shift() - Remove from start
        output += '<div class="card">';
        output += '<h2>Example 4: shift() - Remove from Start</h2>';
        let processing = ['Juan', 'Maria', 'Pedro', 'Ana'];
        output += `<p>Initial: [${processing}]</p>`;
        
        const processed1 = processing.shift();
        output += `<div class="operation">shift() removed '${processed1}' → [${processing}]</div>`;
        
        const processed2 = processing.shift();
        output += `<div class="operation">shift() removed '${processed2}' → [${processing}]</div>`;
        output += '</div>';
        
        // Visual summary
        output += `
            <div class="card">
                <h2>Method Summary</h2>
                <table style="width: 100%; border-collapse: collapse;">
                    <tr style="background-color: #1a73e8; color: white;">
                        <th style="padding: 10px;">Method</th>
                        <th>Action</th>
                        <th>Returns</th>
                    </tr>
                    <tr style="border-bottom: 1px solid #ddd;">
                        <td style="padding: 10px;"><code>push(item)</code></td>
                        <td>Add to end</td>
                        <td>New length</td>
                    </tr>
                    <tr style="border-bottom: 1px solid #ddd;">
                        <td style="padding: 10px;"><code>pop()</code></td>
                        <td>Remove from end</td>
                        <td>Removed item</td>
                    </tr>
                    <tr style="border-bottom: 1px solid #ddd;">
                        <td style="padding: 10px;"><code>unshift(item)</code></td>
                        <td>Add to start</td>
                        <td>New length</td>
                    </tr>
                    <tr>
                        <td style="padding: 10px;"><code>pop()</code></td>
                        <td>Remove from start</td>
                        <td>Removed item</td>
                    </tr>
                </table>
            </div>
        `;
        
        document.getElementById('output').innerHTML = output;
    </script>
</body>
</html>
```

---

## Activity 3: Array Iteration Methods

**Goal:** Use forEach, map, filter methods.

**Create:** `array-methods.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Array Methods</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 900px;
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
        .resident-card {
            background-color: white;
            padding: 15px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔄 Array Iteration Methods</h1>
        <div id="output"></div>
    </div>
    
    <script>
        const residents = [
            { name: 'Juan', age: 25, zone: 'A', fee: 50 },
            { name: 'Maria', age: 65, zone: 'B', fee: 40 },
            { name: 'Pedro', age: 30, zone: 'A', fee: 50 },
            { name: 'Ana', age: 70, zone: 'C', fee: 35 },
            { name: 'Jose', age: 28, zone: 'B', fee: 50 }
        ];
        
        let output = '';
        
        // Example 1: forEach() - Loop through array
        output += '<div class="card">';
        output += '<h2>Example 1: forEach() - Execute for Each</h2>';
        output += '<p><strong>All Residents:</strong></p>';
        
        residents.forEach((resident, index) => {
            output += `
                <div class="resident-card">
                    ${index + 1}. <strong>${resident.name}</strong> - Age: ${resident.age}, Zone: ${resident.zone}
                </div>
            `;
        });
        output += '</div>';
        
        // Example 2: map() - Transform array
        output += '<div class="card">';
        output += '<h2>Example 2: map() - Transform Array</h2>';
        
        const names = residents.map(r => r.name);
        output += `<p><strong>Just names:</strong> ${names.join(', ')}</p>`;
        
        const upperNames = residents.map(r => r.name.toUpperCase());
        output += `<p><strong>Uppercase names:</strong> ${upperNames.join(', ')}</p>`;
        
        const greetings = residents.map(r => `Hello, ${r.name}!`);
        output += '<p><strong>Greetings:</strong></p>';
        greetings.forEach(g => {
            output += `<p>  • ${g}</p>`;
        });
        output += '</div>';
        
        // Example 3: filter() - Filter array
        output += '<div class="card">';
        output += '<h2>Example 3: filter() - Filter Array</h2>';
        
        const seniors = residents.filter(r => r.age >= 60);
        output += `<p><strong>Seniors (age ≥ 60):</strong></p>`;
        seniors.forEach(s => {
            output += `<div class="resident-card">${s.name} - ${s.age} years old</div>`;
        });
        
        const zoneA = residents.filter(r => r.zone === 'A');
        output += `<p><strong>Zone A residents:</strong></p>`;
        zoneA.forEach(r => {
            output += `<div class="resident-card">${r.name}</div>`;
        });
        output += '</div>';
        
        // Example 4: Chaining methods
        output += '<div class="card">';
        output += '<h2>Example 4: Chaining Methods</h2>';
        
        const seniorNames = residents
            .filter(r => r.age >= 60)
            .map(r => r.name);
        
        output += `<p><strong>Senior names only:</strong> ${seniorNames.join(', ')}</p>`;
        
        const discountedFees = residents
            .filter(r => r.age >= 60)
            .map(r => ({
                name: r.name,
                originalFee: r.fee,
                discountedFee: r.fee * 0.80
            }));
        
        output += '<p><strong>Senior discounts:</strong></p>';
        discountedFees.forEach(r => {
            output += `
                <div class="resident-card">
                    ${r.name}: ₱${r.originalFee} → ₱${r.discountedFee.toFixed(2)} (20% off)
                </div>
            `;
        });
        output += '</div>';
        
        // Syntax reference
        output += `
            <div class="card">
                <h2>Method Syntax</h2>
                <pre><code>// forEach - Execute for each element
array.forEach((item, index) => {
    console.log(item);
});

// map - Transform each element
const newArray = array.map(item => item * 2);

// filter - Keep elements that pass test
const filtered = array.filter(item => item > 10);</code></pre>
            </div>
        `;
        
        document.getElementById('output').innerHTML = output;
    </script>
</body>
</html>
```

---

## Activity 4: find, includes, and More

**Goal:** Use additional array methods.

**Create:** `array-search.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Array Search Methods</title>
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
        }
        .found {
            background-color: #e8f5e9;
            border-left: 4px solid #4caf50;
        }
        .not-found {
            background-color: #ffebee;
            border-left: 4px solid #f44336;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔍 Array Search Methods</h1>
        <div id="output"></div>
    </div>
    
    <script>
        const residents = [
            { id: 1, name: 'Juan Dela Cruz', age: 25, zone: 'A' },
            { id: 2, name: 'Maria Santos', age: 65, zone: 'B' },
            { id: 3, name: 'Pedro Garcia', age: 30, zone: 'A' },
            { id: 4, name: 'Ana Reyes', age: 70, zone: 'C' },
            { id: 5, name: 'Jose Mendoza', age: 28, zone: 'B' }
        ];
        
        let output = '';
        
        // Example 1: find() - Find first match
        output += '<div class="card">';
        output += '<h2>Example 1: find() - Find First Match</h2>';
        
        const senior = residents.find(r => r.age >= 60);
        output += `<div class="found">First senior found: <strong>${senior.name}</strong> (${senior.age})</div>`;
        
        const zoneA = residents.find(r => r.zone === 'A');
        output += `<div class="found">First in Zone A: <strong>${zoneA.name}</strong></div>`;
        
        const young = residents.find(r => r.age < 20);
        output += `<div class="not-found">Under 20: ${young ? young.name : 'Not found'}</div>`;
        output += '</div>';
        
        // Example 2: findIndex() - Find index
        output += '<div class="card">';
        output += '<h2>Example 2: findIndex() - Find Index</h2>';
        
        const seniorIndex = residents.findIndex(r => r.age >= 60);
        output += `<p>First senior at index: <strong>${seniorIndex}</strong> (${residents[seniorIndex].name})</p>`;
        
        const juanIndex = residents.findIndex(r => r.name === 'Juan Dela Cruz');
        output += `<p>Juan at index: <strong>${juanIndex}</strong></p>`;
        output += '</div>';
        
        // Example 3: includes() - Check if exists
        output += '<div class="card">';
        output += '<h2>Example 3: includes() - Check Existence</h2>';
        
        const zones = ['A', 'B', 'C'];
        output += `<p>Zones: [${zones}]</p>`;
        output += `<p>Has Zone 'A'? ${zones.includes('A')}</p>`;
        output += `<p>Has Zone 'D'? ${zones.includes('D')}</p>`;
        
        const names = residents.map(r => r.name);
        output += `<p>Has 'Maria Santos'? ${names.includes('Maria Santos')}</p>`;
        output += `<p>Has 'Unknown Person'? ${names.includes('Unknown Person')}</p>`;
        output += '</div>';
        
        // Example 4: some() and every()
        output += '<div class="card">';
        output += '<h2>Example 4: some() and every()</h2>';
        
        const hasSeniors = residents.some(r => r.age >= 60);
        output += `<p>Has any seniors? ${hasSeniors}</p>`;
        
        const hasMinors = residents.some(r => r.age < 18);
        output += `<p>Has any minors? ${hasMinors}</p>`;
        
        const allAdults = residents.every(r => r.age >= 18);
        output += `<p>All adults (18+)? ${allAdults}</p>`;
        
        const allSeniors = residents.every(r => r.age >= 60);
        output += `<p>All seniors (60+)? ${allSeniors}</p>`;
        output += '</div>';
        
        // Example 5: indexOf() and lastIndexOf()
        output += '<div class="card">';
        output += '<h2>Example 5: indexOf() and lastIndexOf()</h2>';
        
        const zonesList = ['A', 'B', 'A', 'C', 'B', 'A'];
        output += `<p>Zones: [${zonesList}]</p>`;
        output += `<p>First 'A' at index: ${zonesList.indexOf('A')}</p>`;
        output += `<p>Last 'A' at index: ${zonesList.lastIndexOf('A')}</p>`;
        output += `<p>First 'B' at index: ${zonesList.indexOf('B')}</p>`;
        output += `<p>'D' at index: ${zonesList.indexOf('D')} (not found = -1)</p>`;
        output += '</div>';
        
        // Method reference
        output += `
            <div class="card">
                <h2>Search Methods Reference</h2>
                <pre><code>// find() - Returns first match or undefined
const item = array.find(item => item.age > 60);

// findIndex() - Returns index or -1
const index = array.findIndex(item => item.age > 60);

// includes() - Returns true/false
const hasItem = array.includes('Juan');

// some() - Returns true if ANY pass test
const hasMatch = array.some(item => item.age > 60);

// every() - Returns true if ALL pass test
const allMatch = array.every(item => item.age > 18);

// indexOf() - Returns first index or -1
const index = array.indexOf('Juan');</code></pre>
            </div>
        `;
        
        document.getElementById('output').innerHTML = output;
    </script>
</body>
</html>
```

---

## Activity 5: reduce() Method

**Goal:** Reduce array to single value.

**Create:** `array-reduce.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Array reduce()</title>
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
        .result {
            background-color: #e3f2fd;
            padding: 15px;
            border-radius: 5px;
            margin: 10px 0;
            font-size: 1.2em;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔢 Array reduce() Method</h1>
        <div id="output"></div>
    </div>
    
    <script>
        const fees = [50, 40, 50, 35, 50, 40];
        const residents = [
            { name: 'Juan', age: 25, fee: 50 },
            { name: 'Maria', age: 65, fee: 40 },
            { name: 'Pedro', age: 30, fee: 50 },
            { name: 'Ana', age: 70, fee: 35 }
        ];
        
        let output = '';
        
        // Example 1: Sum numbers
        output += '<div class="card">';
        output += '<h2>Example 1: Sum All Fees</h2>';
        output += `<p>Fees: [${fees}]</p>`;
        
        const totalFees = fees.reduce((sum, fee) => sum + fee, 0);
        output += `<div class="result">Total Revenue: ₱${totalFees}</div>`;
        output += '</div>';
        
        // Example 2: Find maximum
        output += '<div class="card">';
        output += '<h2>Example 2: Find Maximum</h2>';
        const ages = residents.map(r => r.age);
        output += `<p>Ages: [${ages}]</p>`;
        
        const maxAge = ages.reduce((max, age) => age > max ? age : max, 0);
        output += `<div class="result">Oldest resident: ${maxAge} years</div>`;
        output += '</div>';
        
        // Example 3: Count occurrences
        output += '<div class="card">';
        output += '<h2>Example 3: Count by Zone</h2>';
        const zones = ['A', 'B', 'A', 'C', 'B', 'A', 'C', 'A'];
        output += `<p>Zones: [${zones}]</p>`;
        
        const zoneCounts = zones.reduce((counts, zone) => {
            counts[zone] = (counts[zone] || 0) + 1;
            return counts;
        }, {});
        
        output += '<div class="result">';
        for (let zone in zoneCounts) {
            output += `<p>Zone ${zone}: ${zoneCounts[zone]} residents</p>`;
        }
        output += '</div>';
        output += '</div>';
        
        // Example 4: Calculate total with object array
        output += '<div class="card">';
        output += '<h2>Example 4: Total Fees from Objects</h2>';
        
        const totalResidentFees = residents.reduce((total, resident) => {
            return total + resident.fee;
        }, 0);
        
        output += `<div class="result">Total collected: ₱${totalResidentFees}</div>`;
        output += '</div>';
        
        // Syntax
        output += `
            <div class="card">
                <h2>reduce() Syntax</h2>
                <pre><code>array.reduce((accumulator, currentValue) => {
    // Return new accumulator value
    return accumulator + currentValue;
}, initialValue);

// Example: Sum array
const numbers = [1, 2, 3, 4, 5];
const sum = numbers.reduce((total, num) => total + num, 0);
// sum = 15

// accumulator: Running total (starts at initialValue)
// currentValue: Current array element
// initialValue: Starting value (0 in this case)</code></pre>
            </div>
        `;
        
        document.getElementById('output').innerHTML = output;
    </script>
</body>
</html>
```

---

## Activity 6: Complete Resident Management System

**Goal:** Build complete system using all array methods.

**Create:** `resident-manager.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resident Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 1200px;
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
        .controls {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 10px;
            margin: 20px 0;
        }
        button {
            padding: 12px 24px;
            background-color: #1a73e8;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }
        button:hover {
            background-color: #1557b0;
        }
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            margin: 20px 0;
        }
        .stat-card {
            background-color: #e3f2fd;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
        }
        .stat-number {
            font-size: 2em;
            font-weight: bold;
            color: #1a73e8;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
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
        tr:hover {
            background-color: #f5f5f5;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏘️ Resident Management System</h1>
        
        <div class="controls">
            <button onclick="showAll()">Show All</button>
            <button onclick="showSeniors()">Seniors Only</button>
            <button onclick="showByZone('A')">Zone A</button>
            <button onclick="showByZone('B')">Zone B</button>
            <button onclick="showByZone('C')">Zone C</button>
            <button onclick="showStatistics()">Statistics</button>
        </div>
        
        <div id="output"></div>
    </div>
    
    <script>
        const residents = [
            { id: 1, name: 'Juan Dela Cruz', age: 25, zone: 'A', fee: 50, paid: true },
            { id: 2, name: 'Maria Santos', age: 65, zone: 'B', fee: 40, paid: true },
            { id: 3, name: 'Pedro Garcia', age: 30, zone: 'A', fee: 50, paid: false },
            { id: 4, name: 'Ana Reyes', age: 70, zone: 'C', fee: 35, paid: true },
            { id: 5, name: 'Jose Mendoza', age: 28, zone: 'B', fee: 50, paid: true },
            { id: 6, name: 'Carmen Lopez', age: 62, zone: 'C', fee: 40, paid: false },
            { id: 7, name: 'Ricardo Cruz', age: 35, zone: 'A', fee: 50, paid: true },
            { id: 8, name: 'Elena Fernandez', age: 68, zone: 'B', fee: 40, paid: true }
        ];
        
        function displayTable(data, title) {
            let html = `<h2>${title}</h2>`;
            html += '<table>';
            html += '<thead><tr><th>ID</th><th>Name</th><th>Age</th><th>Zone</th><th>Fee</th><th>Paid</th></tr></thead>';
            html += '<tbody>';
            
            data.forEach(r => {
                const paidStatus = r.paid ? '✅' : '❌';
                html += `
                    <tr>
                        <td>${r.id}</td>
                        <td>${r.name}</td>
                        <td>${r.age}</td>
                        <td>${r.zone}</td>
                        <td>₱${r.fee}</td>
                        <td>${paidStatus}</td>
                    </tr>
                `;
            });
            
            html += '</tbody></table>';
            return html;
        }
        
        function showAll() {
            document.getElementById('output').innerHTML = displayTable(residents, 'All Residents');
        }
        
        function showSeniors() {
            const seniors = residents.filter(r => r.age >= 60);
            document.getElementById('output').innerHTML = displayTable(seniors, 'Senior Citizens (60+)');
        }
        
        function showByZone(zone) {
            const zoneResidents = residents.filter(r => r.zone === zone);
            document.getElementById('output').innerHTML = displayTable(zoneResidents, `Zone ${zone} Residents`);
        }
        
        function showStatistics() {
            // Total residents
            const total = residents.length;
            
            // Average age
            const totalAge = residents.reduce((sum, r) => sum + r.age, 0);
            const avgAge = (totalAge / total).toFixed(1);
            
            // Seniors count
            const seniorsCount = residents.filter(r => r.age >= 60).length;
            
            // Total fees
            const totalFees = residents.reduce((sum, r) => sum + r.fee, 0);
            
            // Collected (paid)
            const collected = residents
                .filter(r => r.paid)
                .reduce((sum, r) => sum + r.fee, 0);
            
            // Pending (unpaid)
            const pending = residents
                .filter(r => !r.paid)
                .reduce((sum, r) => sum + r.fee, 0);
            
            // Zone counts
            const zoneCounts = residents.reduce((counts, r) => {
                counts[r.zone] = (counts[r.zone] || 0) + 1;
                return counts;
            }, {});
            
            let html = '<h2>📊 Statistics Dashboard</h2>';
            html += '<div class="stats">';
            html += `
                <div class="stat-card">
                    <div class="stat-number">${total}</div>
                    <p>Total Residents</p>
                </div>
                <div class="stat-card">
                    <div class="stat-number">${avgAge}</div>
                    <p>Average Age</p>
                </div>
                <div class="stat-card">
                    <div class="stat-number">${seniorsCount}</div>
                    <p>Seniors</p>
                </div>
                <div class="stat-card">
                    <div class="stat-number">₱${totalFees}</div>
                    <p>Total Fees</p>
                </div>
                <div class="stat-card">
                    <div class="stat-number">₱${collected}</div>
                    <p>Collected</p>
                </div>
                <div class="stat-card">
                    <div class="stat-number">₱${pending}</div>
                    <p>Pending</p>
                </div>
            `;
            html += '</div>';
            
            html += '<h3>Residents by Zone</h3>';
            html += '<div class="stats">';
            for (let zone in zoneCounts) {
                html += `
                    <div class="stat-card">
                        <div class="stat-number">${zoneCounts[zone]}</div>
                        <p>Zone ${zone}</p>
                    </div>
                `;
            }
            html += '</div>';
            
            document.getElementById('output').innerHTML = html;
        }
        
        // Show all by default
        showAll();
    </script>
</body>
</html>
```

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## Array Methods Reference

### Creating and Accessing

```javascript
const array = [1, 2, 3];
array[0]  // 1 (first element)
array.length  // 3
array[array.length - 1]  // 3 (last element)
```

### Adding/Removing

```javascript
array.push(4)      // Add to end → [1,2,3,4]
array.pop()        // Remove from end → [1,2,3]
array.unshift(0)   // Add to start → [0,1,2,3]
array.shift()      // Remove from start → [1,2,3]
```

### Iteration

```javascript
// forEach - Execute for each
array.forEach(item => console.log(item));

// map - Transform
const doubled = array.map(x => x * 2);

// filter - Select matching
const evens = array.filter(x => x % 2 === 0);
```

### Searching

```javascript
// find - First match
const item = array.find(x => x > 10);

// includes - Check existence
array.includes(5)  // true/false

// some - Any match
array.some(x => x > 10)  // true/false

// every - All match
array.every(x => x > 0)  // true/false
```

### Reducing

```javascript
// reduce - Single value
const sum = array.reduce((total, num) => total + num, 0);
```

</details>

---

**Congratulations!** You've mastered JavaScript arrays!

**Next Lesson:** Objects and Properties!
