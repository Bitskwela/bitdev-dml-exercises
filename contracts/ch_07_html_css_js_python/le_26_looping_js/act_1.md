# Lesson 26 Activities: Looping and Iteration

## Repeating Code Efficiently

Master loops to repeat code blocks without writing the same code multiple times!

---

## Activity 1: for Loop Basics

**Goal:** Use for loops to repeat code a specific number of times.

**Create:** `for-loop.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>for Loop Basics</title>
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
            padding: 15px;
            margin: 10px 0;
            border-radius: 5px;
            border-left: 4px solid #1a73e8;
        }
        .code-box {
            background-color: #272822;
            color: #f8f8f2;
            padding: 15px;
            border-radius: 5px;
            font-family: 'Courier New', monospace;
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔄 for Loop Basics</h1>
        <div id="output"></div>
    </div>
    
    <script>
        let output = '';
        
        // Example 1: Print numbers 1-5
        output += '<h2>Example 1: Print Numbers 1-5</h2>';
        output += '<div class="card">';
        for (let i = 1; i <= 5; i++) {
            output += `<p>Iteration ${i}</p>`;
        }
        output += '</div>';
        
        // Example 2: Resident queue numbers
        output += '<h2>Example 2: Resident Queue Numbers</h2>';
        output += '<div class="card">';
        for (let queueNum = 1; queueNum <= 10; queueNum++) {
            output += `<p>🎫 Queue Number: ${queueNum}</p>`;
        }
        output += '</div>';
        
        // Example 3: Multiplication table
        const number = 5;
        output += `<h2>Example 3: Multiplication Table for ${number}</h2>`;
        output += '<div class="card">';
        for (let i = 1; i <= 10; i++) {
            const result = number * i;
            output += `<p>${number} × ${i} = ${result}</p>`;
        }
        output += '</div>';
        
        // Example 4: Clearance fee calculation
        output += '<h2>Example 4: Monthly Clearance Report</h2>';
        output += '<div class="card">';
        let totalRevenue = 0;
        for (let month = 1; month <= 12; month++) {
            const clearances = Math.floor(Math.random() * 20) + 10;
            const revenue = clearances * 50;
            totalRevenue += revenue;
            output += `<p>Month ${month}: ${clearances} clearances = ₱${revenue}</p>`;
        }
        output += `<p><strong>Total Annual Revenue: ₱${totalRevenue}</strong></p>`;
        output += '</div>';
        
        // Code structure
        output += '<h2>for Loop Structure</h2>';
        output += `<div class="code-box">
for (initialization; condition; increment) {
    // Code to repeat
}

// Example:
for (let i = 0; i < 5; i++) {
    console.log(i);  // 0, 1, 2, 3, 4
}
</div>`;
        
        output += `
            <div class="card">
                <p><strong>Parts:</strong></p>
                <ul>
                    <li><strong>initialization:</strong> let i = 0 (runs once at start)</li>
                    <li><strong>condition:</strong> i < 5 (checked before each iteration)</li>
                    <li><strong>increment:</strong> i++ (runs after each iteration)</li>
                </ul>
            </div>
        `;
        
        document.getElementById('output').innerHTML = output;
    </script>
</body>
</html>
```

---

## Activity 2: while Loop

**Goal:** Use while loops to repeat code while a condition is true.

**Create:** `while-loop.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>while Loop</title>
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
            padding: 15px;
            margin: 10px 0;
            border-radius: 5px;
            border-left: 4px solid #2196f3;
        }
        .warning {
            background-color: #fff3cd;
            border-left-color: #ff9800;
            padding: 15px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>⚡ while Loop</h1>
        <div id="output"></div>
    </div>
    
    <script>
        let output = '';
        
        // Example 1: Countdown
        output += '<h2>Example 1: Queue Countdown</h2>';
        output += '<div class="card">';
        let queue = 5;
        while (queue > 0) {
            output += `<p>⏳ ${queue} people waiting...</p>`;
            queue--;
        }
        output += '<p>✅ Queue cleared!</p>';
        output += '</div>';
        
        // Example 2: Payment installment
        output += '<h2>Example 2: Payment Installments</h2>';
        output += '<div class="card">';
        let balance = 500;
        let payment = 100;
        let month = 1;
        
        while (balance > 0) {
            balance -= payment;
            if (balance < 0) balance = 0;
            output += `<p>Month ${month}: Paid ₱${payment} | Remaining: ₱${balance}</p>`;
            month++;
        }
        output += '<p><strong>✅ Fully paid!</strong></p>';
        output += '</div>';
        
        // Example 3: Collecting residents (unknown count)
        output += '<h2>Example 3: Resident Registration</h2>';
        output += '<div class="card">';
        const residents = ['Juan', 'Maria', 'Pedro', 'Ana', 'Jose'];
        let index = 0;
        
        while (index < residents.length) {
            output += `<p>✓ Registered: ${residents[index]}</p>`;
            index++;
        }
        output += `<p><strong>Total registered: ${residents.length}</strong></p>`;
        output += '</div>';
        
        // Warning about infinite loops
        output += `
            <div class="warning">
                <h3>⚠️ Warning: Infinite Loops!</h3>
                <pre><code>// ❌ BAD - Never stops!
let i = 0;
while (i < 10) {
    console.log(i);
    // Forgot to increment i!
}

// ✅ GOOD - Stops at 10
let i = 0;
while (i < 10) {
    console.log(i);
    i++;  // Don't forget this!
}</code></pre>
            </div>
        `;
        
        // Code structure
        output += `
            <h2>while Loop Structure</h2>
            <div class="card">
                <pre><code>while (condition) {
    // Code to repeat
    // Don't forget to update the condition!
}

// Example:
let count = 0;
while (count < 5) {
    console.log(count);
    count++;  // Important!
}</code></pre>
            </div>
        `;
        
        document.getElementById('output').innerHTML = output;
    </script>
</body>
</html>
```

---

## Activity 3: do-while Loop

**Goal:** Execute code at least once, then repeat while condition is true.

**Create:** `do-while-loop.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>do-while Loop</title>
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
            padding: 15px;
            margin: 10px 0;
            border-radius: 5px;
            border-left: 4px solid #4caf50;
        }
        .comparison {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin: 20px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔁 do-while Loop</h1>
        <div id="output"></div>
    </div>
    
    <script>
        let output = '';
        
        // Example 1: Menu system (runs at least once)
        output += '<h2>Example 1: Service Menu</h2>';
        output += '<div class="card">';
        output += '<p><em>Menu displays at least once, even if user wants to exit</em></p>';
        
        let showMenu = false;  // User doesn't want menu
        let menuCount = 0;
        
        do {
            menuCount++;
            output += `
                <div style="margin: 10px 0; padding: 10px; background-color: white; border-radius: 5px;">
                    <p><strong>Barangay Services Menu</strong></p>
                    <p>1. Barangay Clearance</p>
                    <p>2. Barangay ID</p>
                    <p>3. Business Permit</p>
                    <p>0. Exit</p>
                </div>
            `;
        } while (showMenu);  // False, so stops after 1 iteration
        
        output += `<p>Menu shown ${menuCount} time(s)</p>`;
        output += '</div>';
        
        // Example 2: Password retry
        output += '<h2>Example 2: Password Validation</h2>';
        output += '<div class="card">';
        
        const correctPassword = "barangay123";
        const attempts = ["wrong1", "wrong2", "barangay123"];
        let attemptNum = 0;
        let passwordCorrect = false;
        
        do {
            const enteredPassword = attempts[attemptNum];
            attemptNum++;
            output += `<p>Attempt ${attemptNum}: Trying "${enteredPassword}"...</p>`;
            
            if (enteredPassword === correctPassword) {
                passwordCorrect = true;
                output += '<p style="color: #4caf50;">✅ Correct password!</p>';
            } else {
                output += '<p style="color: #f44336;">❌ Wrong password. Try again.</p>';
            }
        } while (!passwordCorrect && attemptNum < attempts.length);
        
        output += '</div>';
        
        // Comparison: while vs do-while
        output += '<h2>Comparison: while vs do-while</h2>';
        output += '<div class="comparison">';
        
        // while loop (might not run)
        output += '<div class="card">';
        output += '<h3>while Loop</h3>';
        output += '<p><em>Checks condition BEFORE running</em></p>';
        let whileCount = 0;
        let whileCondition = false;
        
        while (whileCondition) {
            whileCount++;
        }
        output += `<p>Ran ${whileCount} times (condition was false)</p>`;
        output += '<pre><code>let i = 0;\nwhile (false) {\n    i++;\n}\n// Never runs!</code></pre>';
        output += '</div>';
        
        // do-while loop (runs at least once)
        output += '<div class="card">';
        output += '<h3>do-while Loop</h3>';
        output += '<p><em>Checks condition AFTER running</em></p>';
        let doWhileCount = 0;
        let doWhileCondition = false;
        
        do {
            doWhileCount++;
        } while (doWhileCondition);
        
        output += `<p>Ran ${doWhileCount} time(s) (runs at least once!)</p>`;
        output += '<pre><code>let i = 0;\ndo {\n    i++;\n} while (false);\n// Runs once!</code></pre>';
        output += '</div>';
        
        output += '</div>';
        
        // Code structure
        output += `
            <h2>do-while Structure</h2>
            <div class="card">
                <pre><code>do {
    // Code runs at least once
} while (condition);

// Example:
let count = 0;
do {
    console.log(count);
    count++;
} while (count < 5);</code></pre>
                <p><strong>Key difference:</strong> Condition checked AFTER code runs</p>
            </div>
        `;
        
        document.getElementById('output').innerHTML = output;
    </script>
</body>
</html>
```

---

## Activity 4: break and continue

**Goal:** Control loop flow with break and continue statements.

**Create:** `break-continue.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>break and continue</title>
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
            padding: 15px;
            margin: 10px 0;
            border-radius: 5px;
            border-left: 4px solid #ff9800;
        }
        .skipped {
            color: #ff9800;
            font-style: italic;
        }
        .stopped {
            color: #f44336;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🛑 break and continue</h1>
        <div id="output"></div>
    </div>
    
    <script>
        let output = '';
        
        // Example 1: break - Stop loop entirely
        output += '<h2>Example 1: break Statement</h2>';
        output += '<div class="card">';
        output += '<p><strong>Find first senior citizen in queue</strong></p>';
        
        const residents = [
            { name: 'Juan', age: 25 },
            { name: 'Maria', age: 30 },
            { name: 'Pedro', age: 65 },
            { name: 'Ana', age: 28 },
            { name: 'Jose', age: 70 }
        ];
        
        let foundSenior = null;
        for (let i = 0; i < residents.length; i++) {
            output += `<p>Checking ${residents[i].name} (${residents[i].age} years old)...</p>`;
            
            if (residents[i].age >= 60) {
                foundSenior = residents[i];
                output += `<p class="stopped">🛑 Found senior citizen! Breaking loop...</p>`;
                break;  // Exit loop immediately
            }
        }
        
        output += `<p><strong>Result:</strong> ${foundSenior.name} gets priority</p>`;
        output += '</div>';
        
        // Example 2: continue - Skip to next iteration
        output += '<h2>Example 2: continue Statement</h2>';
        output += '<div class="card">';
        output += '<p><strong>Process only approved applications</strong></p>';
        
        const applications = [
            { id: 1, status: 'approved' },
            { id: 2, status: 'pending' },
            { id: 3, status: 'approved' },
            { id: 4, status: 'rejected' },
            { id: 5, status: 'approved' }
        ];
        
        let processed = 0;
        for (let i = 0; i < applications.length; i++) {
            const app = applications[i];
            
            if (app.status !== 'approved') {
                output += `<p class="skipped">⏭️ Application ${app.id}: ${app.status} - skipping...</p>`;
                continue;  // Skip to next iteration
            }
            
            output += `<p>✅ Processing application ${app.id}</p>`;
            processed++;
        }
        
        output += `<p><strong>Processed:</strong> ${processed} approved applications</p>`;
        output += '</div>';
        
        // Example 3: Skip weekends
        output += '<h2>Example 3: Skip Weekends</h2>';
        output += '<div class="card">';
        output += '<p><strong>Office hours (weekdays only)</strong></p>';
        
        const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
        let workDays = 0;
        
        for (let i = 0; i < days.length; i++) {
            if (i === 0 || i === 6) {  // Sunday or Saturday
                output += `<p class="skipped">⏭️ ${days[i]}: Office closed - skipping</p>`;
                continue;
            }
            
            output += `<p>🏢 ${days[i]}: Office open 8AM-5PM</p>`;
            workDays++;
        }
        
        output += `<p><strong>Work days:</strong> ${workDays}</p>`;
        output += '</div>';
        
        // Example 4: Find maximum (break when found)
        output += '<h2>Example 4: First Perfect Score</h2>';
        output += '<div class="card">';
        
        const scores = [85, 92, 100, 78, 100];
        let perfectScoreIndex = -1;
        
        for (let i = 0; i < scores.length; i++) {
            output += `<p>Score ${i + 1}: ${scores[i]}</p>`;
            
            if (scores[i] === 100) {
                perfectScoreIndex = i;
                output += '<p class="stopped">🎉 Perfect score found! Stopping search...</p>';
                break;
            }
        }
        
        output += `<p><strong>First perfect score at index ${perfectScoreIndex}</strong></p>`;
        output += '</div>';
        
        // Code structure
        output += `
            <h2>break and continue Syntax</h2>
            <div class="card">
                <h3>break</h3>
                <pre><code>for (let i = 0; i < 10; i++) {
    if (condition) {
        break;  // Exit loop immediately
    }
}</code></pre>
                
                <h3>continue</h3>
                <pre><code>for (let i = 0; i < 10; i++) {
    if (condition) {
        continue;  // Skip to next iteration
    }
    // This code is skipped when continue runs
}</code></pre>
            </div>
        `;
        
        document.getElementById('output').innerHTML = output;
    </script>
</body>
</html>
```

---

## Activity 5: Nested Loops

**Goal:** Use loops inside loops for multi-dimensional iterations.

**Create:** `nested-loops.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nested Loops</title>
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 15px 0;
        }
        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }
        th {
            background-color: #1a73e8;
            color: white;
        }
        .grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 10px;
            margin: 15px 0;
        }
        .cell {
            padding: 20px;
            background-color: #e3f2fd;
            border-radius: 5px;
            text-align: center;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔄🔄 Nested Loops</h1>
        <div id="output"></div>
    </div>
    
    <script>
        let output = '';
        
        // Example 1: Multiplication table
        output += '<h2>Example 1: Multiplication Table</h2>';
        output += '<table>';
        output += '<thead><tr><th>×</th>';
        for (let i = 1; i <= 5; i++) {
            output += `<th>${i}</th>`;
        }
        output += '</tr></thead><tbody>';
        
        for (let row = 1; row <= 5; row++) {
            output += `<tr><th>${row}</th>`;
            for (let col = 1; col <= 5; col++) {
                const product = row * col;
                output += `<td>${product}</td>`;
            }
            output += '</tr>';
        }
        output += '</tbody></table>';
        
        // Example 2: Barangay zones and households
        output += '<h2>Example 2: Barangay Zones</h2>';
        output += '<div style="background-color: #f9f9f9; padding: 20px; border-radius: 5px;">';
        
        const zones = ['Zone A', 'Zone B', 'Zone C'];
        const householdsPerZone = 3;
        
        for (let zone = 0; zone < zones.length; zone++) {
            output += `<h3>${zones[zone]}</h3>`;
            
            for (let household = 1; household <= householdsPerZone; household++) {
                const residentCount = Math.floor(Math.random() * 5) + 1;
                output += `<p>  🏠 Household ${household}: ${residentCount} residents</p>`;
            }
        }
        output += '</div>';
        
        // Example 3: Grid pattern
        output += '<h2>Example 3: Seating Arrangement</h2>';
        output += '<div class="grid">';
        
        const rows = 3;
        const cols = 5;
        let seatNumber = 1;
        
        for (let row = 0; row < rows; row++) {
            for (let col = 0; col < cols; col++) {
                output += `<div class="cell">Seat ${seatNumber}</div>`;
                seatNumber++;
            }
        }
        output += '</div>';
        
        // Example 4: Services and requirements
        output += '<h2>Example 4: Services Checklist</h2>';
        output += '<div style="background-color: #f9f9f9; padding: 20px; border-radius: 5px;">';
        
        const services = [
            {
                name: 'Barangay Clearance',
                requirements: ['Valid ID', 'Proof of Residency', 'Cedula']
            },
            {
                name: 'Business Permit',
                requirements: ['DTI Registration', 'Mayor\'s Permit', 'Fire Clearance']
            },
            {
                name: 'Barangay ID',
                requirements: ['Birth Certificate', '1x1 Photo', 'Proof of Address']
            }
        ];
        
        for (let i = 0; i < services.length; i++) {
            output += `<h3>${services[i].name}</h3>`;
            output += '<ul>';
            
            for (let j = 0; j < services[i].requirements.length; j++) {
                output += `<li>✓ ${services[i].requirements[j]}</li>`;
            }
            
            output += '</ul>';
        }
        output += '</div>';
        
        // Code structure
        output += `
            <h2>Nested Loop Structure</h2>
            <div style="background-color: #e3f2fd; padding: 20px; border-radius: 5px; margin: 20px 0;">
                <pre><code>for (let outer = 0; outer < 3; outer++) {
    console.log("Outer:", outer);
    
    for (let inner = 0; inner < 2; inner++) {
        console.log("  Inner:", inner);
    }
}

// Output:
// Outer: 0
//   Inner: 0
//   Inner: 1
// Outer: 1
//   Inner: 0
//   Inner: 1
// Outer: 2
//   Inner: 0
//   Inner: 1</code></pre>
                <p><strong>Note:</strong> Inner loop completes fully for each outer loop iteration</p>
            </div>
        `;
        
        document.getElementById('output').innerHTML = output;
    </script>
</body>
</html>
```

---

## Activity 6: Complete Resident Processing System

**Goal:** Build a complete system using all loop types.

**Create:** `resident-system.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resident Processing System</title>
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
        .section {
            background-color: #f9f9f9;
            padding: 20px;
            margin: 20px 0;
            border-radius: 8px;
            border-left: 5px solid #1a73e8;
        }
        .resident-card {
            background-color: white;
            padding: 15px;
            margin: 10px 0;
            border-radius: 5px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
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
        .priority {
            background-color: #fff3cd;
            border-left-color: #ff9800;
        }
        .approved {
            background-color: #e8f5e9;
            border-left-color: #4caf50;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏘️ Barangay Resident Processing System</h1>
        <div id="output"></div>
    </div>
    
    <script>
        // Sample data
        const residents = [
            { name: 'Juan Dela Cruz', age: 65, isPWD: false, hasClearance: false, zone: 'A' },
            { name: 'Maria Santos', age: 30, isPWD: false, hasClearance: true, zone: 'A' },
            { name: 'Pedro Garcia', age: 70, isPWD: true, hasClearance: false, zone: 'B' },
            { name: 'Ana Reyes', age: 25, isPWD: false, hasClearance: false, zone: 'B' },
            { name: 'Jose Mendoza', age: 45, isPWD: true, hasClearance: true, zone: 'C' },
            { name: 'Carmen Lopez', age: 62, isPWD: false, hasClearance: false, zone: 'C' },
            { name: 'Ricardo Cruz', age: 35, isPWD: false, hasClearance: true, zone: 'A' },
            { name: 'Elena Fernandez', age: 68, isPWD: false, hasClearance: false, zone: 'B' }
        ];
        
        let output = '';
        
        // TASK 1: Priority queue (for loop with continue)
        output += '<div class="section priority">';
        output += '<h2>📋 Priority Queue (Seniors & PWD First)</h2>';
        
        let priorityCount = 0;
        for (let i = 0; i < residents.length; i++) {
            const r = residents[i];
            
            // Skip non-priority residents
            if (r.age < 60 && !r.isPWD) {
                continue;
            }
            
            priorityCount++;
            const badges = [];
            if (r.age >= 60) badges.push('👴 Senior');
            if (r.isPWD) badges.push('♿ PWD');
            
            output += `
                <div class="resident-card">
                    <p><strong>${priorityCount}. ${r.name}</strong></p>
                    <p>Age: ${r.age} | Zone ${r.zone}</p>
                    <p>${badges.join(' | ')}</p>
                </div>
            `;
        }
        output += '</div>';
        
        // TASK 2: Find first person needing clearance (break)
        output += '<div class="section">';
        output += '<h2>🔍 First Person Needing Clearance</h2>';
        
        let needsClearance = null;
        for (let i = 0; i < residents.length; i++) {
            if (!residents[i].hasClearance) {
                needsClearance = residents[i];
                output += `<p>Searching... Found: <strong>${needsClearance.name}</strong></p>`;
                break;  // Stop at first match
            }
        }
        output += '</div>';
        
        // TASK 3: Process by zone (nested loops)
        output += '<div class="section approved">';
        output += '<h2>🗺️ Residents by Zone</h2>';
        
        const zones = ['A', 'B', 'C'];
        for (let zone of zones) {
            output += `<h3>Zone ${zone}</h3>`;
            
            let zoneCount = 0;
            for (let resident of residents) {
                if (resident.zone === zone) {
                    zoneCount++;
                    const clearanceStatus = resident.hasClearance ? '✅' : '❌';
                    output += `
                        <div class="resident-card">
                            <p><strong>${resident.name}</strong> (${resident.age})</p>
                            <p>Clearance: ${clearanceStatus}</p>
                        </div>
                    `;
                }
            }
            output += `<p><em>Total in Zone ${zone}: ${zoneCount}</em></p>`;
        }
        output += '</div>';
        
        // TASK 4: Statistics (while loop for calculations)
        output += '<div class="section">';
        output += '<h2>📊 Statistics</h2>';
        
        let totalAge = 0;
        let seniors = 0;
        let pwdCount = 0;
        let withClearance = 0;
        let index = 0;
        
        while (index < residents.length) {
            const r = residents[index];
            totalAge += r.age;
            if (r.age >= 60) seniors++;
            if (r.isPWD) pwdCount++;
            if (r.hasClearance) withClearance++;
            index++;
        }
        
        const averageAge = (totalAge / residents.length).toFixed(1);
        
        output += '<div class="stats">';
        output += `
            <div class="stat-card">
                <div class="stat-number">${residents.length}</div>
                <p>Total Residents</p>
            </div>
            <div class="stat-card">
                <div class="stat-number">${averageAge}</div>
                <p>Average Age</p>
            </div>
            <div class="stat-card">
                <div class="stat-number">${seniors}</div>
                <p>Senior Citizens</p>
            </div>
            <div class="stat-card">
                <div class="stat-number">${pwdCount}</div>
                <p>PWD Residents</p>
            </div>
            <div class="stat-card">
                <div class="stat-number">${withClearance}</div>
                <p>With Clearance</p>
            </div>
        `;
        output += '</div>';
        output += '</div>';
        
        // TASK 5: Batch processing (do-while)
        output += '<div class="section">';
        output += '<h2>⚡ Batch Clearance Processing</h2>';
        
        let processedBatch = 0;
        let batchSize = 3;
        let startIndex = 0;
        
        do {
            processedBatch++;
            output += `<h3>Batch ${processedBatch}</h3>`;
            
            let endIndex = Math.min(startIndex + batchSize, residents.length);
            for (let i = startIndex; i < endIndex; i++) {
                output += `<p>✓ Processed clearance for ${residents[i].name}</p>`;
            }
            
            startIndex += batchSize;
        } while (startIndex < residents.length);
        
        output += `<p><strong>Total batches: ${processedBatch}</strong></p>`;
        output += '</div>';
        
        document.getElementById('output').innerHTML = output;
    </script>
</body>
</html>
```

---

## 🎯 Interactive Coding Challenges

> **Note for Reviewers:** Validation prototype for loops.

---

### Challenge 1: Sum Numbers

**Scenario:** Calculate total from 1 to N.

**Your Task:**
Sum all numbers from 1 to n using a for loop.

**Starter Code:**
```javascript
function sumToN(n) {
    // Use for loop
    // Sum 1 + 2 + 3 + ... + n
    
    
    
}
```

**Requirements:**
- ✅ Use for loop
- ✅ Return the sum

**Test Cases:**
```javascript
console.assert(sumToN(5) === 15);    // 1+2+3+4+5
console.assert(sumToN(10) === 55);   // 1+2+...+10
console.assert(sumToN(1) === 1);
console.assert(sumToN(0) === 0);
console.assert(sumToN(100) === 5050);
```

**Validation Criteria:**
- ⚠️ Points: 10

---

### Challenge 2: Count Down Array

**Scenario:** Create countdown array.

**Your Task:**
Return array counting from n down to 1 using while loop.

**Starter Code:**
```javascript
function countDown(n) {
    // Use while loop
    // Return array [n, n-1, ..., 2, 1]
    
    
    
}
```

**Requirements:**
- ✅ Use while loop
- ✅ Return array

**Test Cases:**
```javascript
console.assert(JSON.stringify(countDown(5)) === JSON.stringify([5,4,3,2,1]));
console.assert(JSON.stringify(countDown(3)) === JSON.stringify([3,2,1]));
console.assert(JSON.stringify(countDown(1)) === JSON.stringify([1]));
```

**Validation Criteria:**
- ⚠️ Points: 15

---

### Challenge 3: Find First Even

**Scenario:** Find first even number in array.

**Your Task:**
Return first even number, or -1 if none found. Use break.

**Starter Code:**
```javascript
function findFirstEven(numbers) {
    // Loop through array
    // Return first even number
    // Use break to exit early
    
    
    
}
```

**Requirements:**
- ✅ Use loop with break
- ✅ Return -1 if no even found

**Test Cases:**
```javascript
console.assert(findFirstEven([1, 3, 4, 7]) === 4);
console.assert(findFirstEven([2, 3, 5]) === 2);
console.assert(findFirstEven([1, 3, 5]) === -1);
console.assert(findFirstEven([]) === -1);
```

**Validation Criteria:**
- ⚠️ Points: 15

---

### Challenge 4: Sum Only Evens

**Scenario:** Sum only even numbers from array.

**Your Task:**
Sum even numbers, skip odds using continue.

**Starter Code:**
```javascript
function sumEvens(numbers) {
    // Loop through array
    // Skip odd numbers (continue)
    // Sum even numbers
    
    
    
}
```

**Requirements:**
- ✅ Use loop with continue
- ✅ Check even with modulo

**Test Cases:**
```javascript
console.assert(sumEvens([1, 2, 3, 4, 5, 6]) === 12);  // 2+4+6
console.assert(sumEvens([2, 4, 6]) === 12);
console.assert(sumEvens([1, 3, 5]) === 0);
console.assert(sumEvens([]) === 0);
```

**Validation Criteria:**
- ⚠️ Points: 15

---

### 📊 Challenge Summary

| Challenge | Points | Difficulty | Concepts Tested |
|-----------|--------|------------|------------------|
| Sum Numbers | 10 | Easy | for loop |
| Count Down | 15 | Easy | while loop |
| Find First Even | 15 | Medium | break statement |
| Sum Only Evens | 15 | Medium | continue statement |
| **Total** | **55** | - | - |

---

## 💡 Tips for Success

**Common Mistakes:**
- ❌ Infinite loops (forgetting increment)
- ❌ Off-by-one errors
- ❌ Not initializing accumulator

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## Interactive Challenge Solutions

### Challenge 1: Sum Numbers
```javascript
function sumToN(n) {
    let sum = 0;
    for (let i = 1; i <= n; i++) {
        sum += i;
    }
    return sum;
}
```

---

### Challenge 2: Count Down
```javascript
function countDown(n) {
    const result = [];
    while (n > 0) {
        result.push(n);
        n--;
    }
    return result;
}
```

---

### Challenge 3: Find First Even
```javascript
function findFirstEven(numbers) {
    for (let i = 0; i < numbers.length; i++) {
        if (numbers[i] % 2 === 0) {
            return numbers[i];
        }
    }
    return -1;
}
```

---

### Challenge 4: Sum Only Evens
```javascript
function sumEvens(numbers) {
    let sum = 0;
    for (let i = 0; i < numbers.length; i++) {
        if (numbers[i] % 2 !== 0) {
            continue;  // Skip odd numbers
        }
        sum += numbers[i];
    }
    return sum;
}
```

---

## Looping and Iteration Reference

### for Loop

```javascript
for (initialization; condition; increment) {
    // Code to repeat
}

// Example
for (let i = 0; i < 5; i++) {
    console.log(i);  // 0, 1, 2, 3, 4
}

// Counting down
for (let i = 5; i > 0; i--) {
    console.log(i);  // 5, 4, 3, 2, 1
}

// Step by 2
for (let i = 0; i < 10; i += 2) {
    console.log(i);  // 0, 2, 4, 6, 8
}
```

---

### while Loop

```javascript
while (condition) {
    // Code to repeat
    // Update condition variable!
}

// Example
let count = 0;
while (count < 5) {
    console.log(count);  // 0, 1, 2, 3, 4
    count++;
}

// ⚠️ Infinite loop (BAD!)
let i = 0;
while (i < 10) {
    console.log(i);
    // Forgot to increment i - never stops!
}
```

---

### do-while Loop

```javascript
do {
    // Code runs at least once
} while (condition);

// Example
let num = 0;
do {
    console.log(num);  // Runs once even though condition is false
    num++;
} while (num < 0);  // False, but already ran once

// Use case: Menu systems
let choice;
do {
    choice = prompt("1. Option 1\n2. Option 2\n0. Exit");
    // Process choice
} while (choice !== "0");  // Runs at least once to show menu
```

---

### break Statement

```javascript
// Exits loop immediately
for (let i = 0; i < 10; i++) {
    if (i === 5) {
        break;  // Stop loop at 5
    }
    console.log(i);  // 0, 1, 2, 3, 4
}

// Find first match
const residents = ['Juan', 'Maria', 'Pedro'];
let found = null;
for (let i = 0; i < residents.length; i++) {
    if (residents[i] === 'Maria') {
        found = residents[i];
        break;  // Stop searching
    }
}
```

---

### continue Statement

```javascript
// Skips to next iteration
for (let i = 0; i < 5; i++) {
    if (i === 2) {
        continue;  // Skip 2
    }
    console.log(i);  // 0, 1, 3, 4
}

// Skip specific items
const numbers = [1, 2, 3, 4, 5];
for (let num of numbers) {
    if (num % 2 === 0) {
        continue;  // Skip even numbers
    }
    console.log(num);  // 1, 3, 5
}
```

---

### Nested Loops

```javascript
// Loop inside loop
for (let row = 0; row < 3; row++) {
    for (let col = 0; col < 3; col++) {
        console.log(`Row ${row}, Col ${col}`);
    }
}

// Multiplication table
for (let i = 1; i <= 5; i++) {
    for (let j = 1; j <= 5; j++) {
        console.log(`${i} × ${j} = ${i * j}`);
    }
}

// Break outer loop from inner loop
outerLoop:
for (let i = 0; i < 3; i++) {
    for (let j = 0; j < 3; j++) {
        if (i === 1 && j === 1) {
            break outerLoop;  // Break outer loop
        }
    }
}
```

---

### for...of Loop (Arrays)

```javascript
const residents = ['Juan', 'Maria', 'Pedro'];

// Iterate over array values
for (let resident of residents) {
    console.log(resident);  // Juan, Maria, Pedro
}

// Equivalent to:
for (let i = 0; i < residents.length; i++) {
    console.log(residents[i]);
}
```

---

### for...in Loop (Objects)

```javascript
const person = { name: 'Juan', age: 25, city: 'Manila' };

// Iterate over object keys
for (let key in person) {
    console.log(`${key}: ${person[key]}`);
}
// name: Juan
// age: 25
// city: Manila
```

---

### Loop Comparison

| Loop Type | When to Use |
|-----------|-------------|
| **for** | Known number of iterations |
| **while** | Unknown iterations, condition-based |
| **do-while** | Guaranteed at least one execution |
| **for...of** | Iterate array values |
| **for...in** | Iterate object keys |

---

### Common Loop Patterns

**Sum array:**
```javascript
const numbers = [1, 2, 3, 4, 5];
let sum = 0;
for (let num of numbers) {
    sum += num;
}
console.log(sum);  // 15
```

**Find maximum:**
```javascript
const scores = [85, 92, 78, 95, 88];
let max = scores[0];
for (let score of scores) {
    if (score > max) {
        max = score;
    }
}
console.log(max);  // 95
```

**Count occurrences:**
```javascript
const votes = ['A', 'B', 'A', 'C', 'A', 'B'];
let countA = 0;
for (let vote of votes) {
    if (vote === 'A') {
        countA++;
    }
}
console.log(countA);  // 3
```

**Filter array:**
```javascript
const ages = [15, 25, 65, 30, 70];
const seniors = [];
for (let age of ages) {
    if (age >= 60) {
        seniors.push(age);
    }
}
console.log(seniors);  // [65, 70]
```

---

### Best Practices

**1. Choose the right loop:**
```javascript
// ✅ for loop - known iterations
for (let i = 0; i < 10; i++) { }

// ✅ while loop - unknown iterations
while (hasMoreData) { }

// ✅ do-while - menu/validation
do {
    input = getInput();
} while (!isValid(input));
```

**2. Avoid infinite loops:**
```javascript
// ❌ BAD - never stops!
let i = 0;
while (i < 10) {
    console.log(i);
    // Forgot i++
}

// ✅ GOOD
let i = 0;
while (i < 10) {
    console.log(i);
    i++;  // Don't forget!
}
```

**3. Use meaningful variable names:**
```javascript
// ❌ BAD
for (let i = 0; i < r.length; i++) { }

// ✅ GOOD
for (let residentIndex = 0; residentIndex < residents.length; residentIndex++) { }

// ✅ BEST (for...of)
for (let resident of residents) { }
```

**4. Cache array length:**
```javascript
// ❌ Less efficient (calculates length each iteration)
for (let i = 0; i < array.length; i++) { }

// ✅ More efficient
const length = array.length;
for (let i = 0; i < length; i++) { }
```

**5. Break early when possible:**
```javascript
// ✅ Stop when found
for (let item of items) {
    if (item === target) {
        found = item;
        break;  // Don't waste time checking rest
    }
}
```

</details>

---

**Congratulations!** You've mastered loops and iteration!

**Next Lesson:** Functions and Scope!
