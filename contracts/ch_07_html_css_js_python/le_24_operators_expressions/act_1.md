# Lesson 24 Activities: JavaScript Operators and Expressions

## Performing Operations with Data

Operators let you perform calculations, comparisons, and logical operations on your data!

---

## Activity 1: Arithmetic Operators

**Goal:** Perform math operations in JavaScript.

**Create:** `arithmetic-operators.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Arithmetic Operators</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .calculator {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        h1 { color: #1a73e8; text-align: center; }
        .operation {
            background-color: #f9f9f9;
            padding: 15px;
            margin: 10px 0;
            border-left: 4px solid #1a73e8;
            border-radius: 5px;
        }
        .result {
            color: #4caf50;
            font-weight: bold;
            font-size: 1.2em;
        }
    </style>
</head>
<body>
    <div class="calculator">
        <h1>🧮 Arithmetic Operators</h1>
        <div id="output"></div>
    </div>
    
    <script>
        let a = 100;
        let b = 30;
        
        let operations = [
            {
                name: 'Addition (+)',
                expression: `${a} + ${b}`,
                result: a + b,
                description: 'Adds two numbers'
            },
            {
                name: 'Subtraction (-)',
                expression: `${a} - ${b}`,
                result: a - b,
                description: 'Subtracts second from first'
            },
            {
                name: 'Multiplication (*)',
                expression: `${a} * ${b}`,
                result: a * b,
                description: 'Multiplies two numbers'
            },
            {
                name: 'Division (/)',
                expression: `${a} / ${b}`,
                result: a / b,
                description: 'Divides first by second'
            },
            {
                name: 'Modulo (%)',
                expression: `${a} % ${b}`,
                result: a % b,
                description: 'Returns remainder of division'
            },
            {
                name: 'Exponentiation (**)',
                expression: `5 ** 3`,
                result: 5 ** 3,
                description: '5 to the power of 3'
            }
        ];
        
        let html = '';
        operations.forEach(op => {
            html += `
                <div class="operation">
                    <h3>${op.name}</h3>
                    <p>${op.description}</p>
                    <p><code>${op.expression}</code> = <span class="result">${op.result}</span></p>
                </div>
            `;
        });
        
        // Barangay example
        const clearanceFee = 50;
        const numberOfClearances = 15;
        const totalRevenue = clearanceFee * numberOfClearances;
        
        html += `
            <div class="operation" style="border-left-color: #4caf50;">
                <h3>💰 Barangay Example</h3>
                <p>Clearance Fee: ₱${clearanceFee} × ${numberOfClearances} applications</p>
                <p><strong>Total Revenue: ₱${totalRevenue}</strong></p>
            </div>
        `;
        
        document.getElementById('output').innerHTML = html;
    </script>
</body>
</html>
```

---

## Activity 2: Comparison Operators

**Goal:** Compare values and get true/false results.

**Create:** `comparison-operators.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Comparison Operators</title>
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
        .comparison {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            margin: 10px 0;
            background-color: #f9f9f9;
            border-radius: 5px;
        }
        .true { border-left: 5px solid #4caf50; }
        .false { border-left: 5px solid #f44336; }
        .result {
            font-weight: bold;
            padding: 8px 16px;
            border-radius: 5px;
            color: white;
        }
        .result.true { background-color: #4caf50; }
        .result.false { background-color: #f44336; }
    </style>
</head>
<body>
    <div class="container">
        <h1>⚖️ Comparison Operators</h1>
        <div id="output"></div>
    </div>
    
    <script>
        let a = 10;
        let b = 20;
        let c = "10";
        
        const comparisons = [
            { expr: `${a} === ${b}`, result: a === b, desc: 'Strictly equal (value and type)' },
            { expr: `${a} === ${c}`, result: a === c, desc: 'Strictly equal (10 vs "10")' },
            { expr: `${a} == "${c}"`, result: a == c, desc: 'Loosely equal (converts types)' },
            { expr: `${a} !== ${b}`, result: a !== b, desc: 'Not strictly equal' },
            { expr: `${a} > ${b}`, result: a > b, desc: 'Greater than' },
            { expr: `${a} < ${b}`, result: a < b, desc: 'Less than' },
            { expr: `${b} >= 20`, result: b >= 20, desc: 'Greater than or equal' },
            { expr: `${a} <= 10`, result: a <= 10, desc: 'Less than or equal' }
        ];
        
        let html = '';
        comparisons.forEach(comp => {
            html += `
                <div class="comparison ${comp.result}">
                    <div>
                        <code>${comp.expr}</code>
                        <p style="margin: 5px 0 0 0; color: #666; font-size: 0.9em;">${comp.desc}</p>
                    </div>
                    <span class="result ${comp.result}">${comp.result}</span>
                </div>
            `;
        });
        
        // Barangay example
        const age = 65;
        const seniorAge = 60;
        const isSenior = age >= seniorAge;
        
        html += `
            <div style="margin-top: 30px; padding: 20px; background-color: #e3f2fd; border-radius: 5px;">
                <h3>👴 Barangay Senior Citizen Check</h3>
                <p>Age: ${age}</p>
                <p>Senior Citizen Age: ${seniorAge}</p>
                <p><code>${age} >= ${seniorAge}</code> = <strong>${isSenior}</strong></p>
                <p>${isSenior ? '✅ Eligible for senior discount!' : '❌ Not a senior citizen'}</p>
            </div>
        `;
        
        // Important note
        html += `
            <div style="margin-top: 20px; padding: 15px; background-color: #fff3cd; border-left: 4px solid #ff9800; border-radius: 5px;">
                <p><strong>⚠️ Important:</strong> Always use <code>===</code> instead of <code>==</code></p>
                <p><code>===</code> checks value AND type (safer!)</p>
                <p><code>==</code> converts types (can cause bugs)</p>
            </div>
        `;
        
        document.getElementById('output').innerHTML = html;
    </script>
</body>
</html>
```

**Rule:** Always use `===` and `!==` (strict comparison)!

---

## Activity 3: Logical Operators

**Goal:** Combine conditions with AND, OR, NOT.

**Create:** `logical-operators.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logical Operators</title>
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
        .true { color: #4caf50; font-weight: bold; }
        .false { color: #f44336; font-weight: bold; }
        .example {
            background-color: #f9f9f9;
            padding: 20px;
            margin: 20px 0;
            border-left: 4px solid #1a73e8;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔗 Logical Operators</h1>
        
        <h2>AND Operator (&&)</h2>
        <p>Both conditions must be true</p>
        <table>
            <thead>
                <tr>
                    <th>A</th>
                    <th>B</th>
                    <th>A && B</th>
                </tr>
            </thead>
            <tbody>
                <tr><td class="true">true</td><td class="true">true</td><td class="true">true</td></tr>
                <tr><td class="true">true</td><td class="false">false</td><td class="false">false</td></tr>
                <tr><td class="false">false</td><td class="true">true</td><td class="false">false</td></tr>
                <tr><td class="false">false</td><td class="false">false</td><td class="false">false</td></tr>
            </tbody>
        </table>
        
        <h2>OR Operator (||)</h2>
        <p>At least one condition must be true</p>
        <table>
            <thead>
                <tr>
                    <th>A</th>
                    <th>B</th>
                    <th>A || B</th>
                </tr>
            </thead>
            <tbody>
                <tr><td class="true">true</td><td class="true">true</td><td class="true">true</td></tr>
                <tr><td class="true">true</td><td class="false">false</td><td class="true">true</td></tr>
                <tr><td class="false">false</td><td class="true">true</td><td class="true">true</td></tr>
                <tr><td class="false">false</td><td class="false">false</td><td class="false">false</td></tr>
            </tbody>
        </table>
        
        <h2>NOT Operator (!)</h2>
        <p>Reverses the boolean value</p>
        <table>
            <thead>
                <tr>
                    <th>A</th>
                    <th>!A</th>
                </tr>
            </thead>
            <tbody>
                <tr><td class="true">true</td><td class="false">false</td></tr>
                <tr><td class="false">false</td><td class="true">true</td></tr>
            </tbody>
        </table>
        
        <div id="examples"></div>
    </div>
    
    <script>
        // Barangay clearance eligibility
        const age = 25;
        const isResident = true;
        const hasUnpaidFees = false;
        
        // AND: Must be 18+ AND be a resident
        const canApply = (age >= 18) && isResident;
        
        // OR: Senior (60+) OR PWD gets discount
        const isSenior = age >= 60;
        const isPWD = false;
        const getsDiscount = isSenior || isPWD;
        
        // NOT: No unpaid fees
        const canGetClearance = !hasUnpaidFees;
        
        // Complex condition
        const eligible = (age >= 18) && isResident && !hasUnpaidFees;
        
        document.getElementById('examples').innerHTML = `
            <div class="example">
                <h3>🏛️ Barangay Clearance Eligibility</h3>
                <p><strong>Applicant Info:</strong></p>
                <p>Age: ${age}</p>
                <p>Is Resident: ${isResident}</p>
                <p>Has Unpaid Fees: ${hasUnpaidFees}</p>
                
                <hr style="margin: 20px 0;">
                
                <p><strong>Checks:</strong></p>
                <p><code>(age >= 18) && isResident</code> = ${canApply}</p>
                <p>Explanation: Must be 18+ AND a resident</p>
                
                <p style="margin-top: 15px;"><code>isSenior || isPWD</code> = ${getsDiscount}</p>
                <p>Explanation: Senior OR PWD gets discount</p>
                
                <p style="margin-top: 15px;"><code>!hasUnpaidFees</code> = ${canGetClearance}</p>
                <p>Explanation: No unpaid fees (NOT true = false)</p>
                
                <p style="margin-top: 15px;"><code>(age >= 18) && isResident && !hasUnpaidFees</code> = ${eligible}</p>
                <p><strong>${eligible ? '✅ ELIGIBLE for clearance!' : '❌ NOT ELIGIBLE'}</strong></p>
            </div>
        `;
    </script>
</body>
</html>
```

---

## Activity 4: Assignment Operators

**Goal:** Use shorthand operators to update variables.

**Create:** `assignment-operators.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assignment Operators</title>
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
        code {
            background-color: #f5f5f5;
            padding: 2px 6px;
            border-radius: 3px;
            color: #e91e63;
        }
        .demo {
            background-color: #e3f2fd;
            padding: 20px;
            margin: 20px 0;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📝 Assignment Operators</h1>
        
        <table>
            <thead>
                <tr>
                    <th>Operator</th>
                    <th>Example</th>
                    <th>Same As</th>
                    <th>Description</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><code>=</code></td>
                    <td><code>x = 5</code></td>
                    <td><code>x = 5</code></td>
                    <td>Assignment</td>
                </tr>
                <tr>
                    <td><code>+=</code></td>
                    <td><code>x += 3</code></td>
                    <td><code>x = x + 3</code></td>
                    <td>Add and assign</td>
                </tr>
                <tr>
                    <td><code>-=</code></td>
                    <td><code>x -= 2</code></td>
                    <td><code>x = x - 2</code></td>
                    <td>Subtract and assign</td>
                </tr>
                <tr>
                    <td><code>*=</code></td>
                    <td><code>x *= 4</code></td>
                    <td><code>x = x * 4</code></td>
                    <td>Multiply and assign</td>
                </tr>
                <tr>
                    <td><code>/=</code></td>
                    <td><code>x /= 2</code></td>
                    <td><code>x = x / 2</code></td>
                    <td>Divide and assign</td>
                </tr>
                <tr>
                    <td><code>++</code></td>
                    <td><code>x++</code></td>
                    <td><code>x = x + 1</code></td>
                    <td>Increment by 1</td>
                </tr>
                <tr>
                    <td><code>--</code></td>
                    <td><code>x--</code></td>
                    <td><code>x = x - 1</code></td>
                    <td>Decrement by 1</td>
                </tr>
            </tbody>
        </table>
        
        <div id="demo"></div>
    </div>
    
    <script>
        // Barangay clearance counter
        let clearanceCount = 10;
        
        let steps = [];
        
        steps.push(`Initial count: ${clearanceCount}`);
        
        // Add 5 more clearances
        clearanceCount += 5;
        steps.push(`After clearanceCount += 5: ${clearanceCount}`);
        
        // 3 clearances were cancelled
        clearanceCount -= 3;
        steps.push(`After clearanceCount -= 3: ${clearanceCount}`);
        
        // Increment by 1 (new clearance)
        clearanceCount++;
        steps.push(`After clearanceCount++: ${clearanceCount}`);
        
        // Decrement by 1 (cancelled clearance)
        clearanceCount--;
        steps.push(`After clearanceCount--: ${clearanceCount}`);
        
        // Revenue calculation
        let revenue = 0;
        const clearanceFee = 50;
        
        revenue += clearanceFee * clearanceCount;
        
        document.getElementById('demo').innerHTML = `
            <div class="demo">
                <h3>💼 Barangay Clearance Counter</h3>
                ${steps.map(step => `<p>${step}</p>`).join('')}
                <hr style="margin: 20px 0;">
                <p><strong>Final Count: ${clearanceCount} clearances</strong></p>
                <p><strong>Total Revenue: ₱${revenue}</strong></p>
            </div>
        `;
    </script>
</body>
</html>
```

---

## Activity 5: Ternary Operator

**Goal:** Write compact if-else statements.

**Create:** `ternary-operator.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ternary Operator</title>
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
        .comparison {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin: 20px 0;
        }
        .code-block {
            background-color: #f5f5f5;
            padding: 15px;
            border-radius: 5px;
            font-family: 'Courier New', monospace;
        }
        .example {
            background-color: #e3f2fd;
            padding: 20px;
            margin: 20px 0;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>❓ Ternary Operator</h1>
        
        <p><strong>Syntax:</strong> <code>condition ? valueIfTrue : valueIfFalse</code></p>
        
        <h2>Traditional if-else vs Ternary</h2>
        <div class="comparison">
            <div>
                <h3>❌ Long Way (if-else)</h3>
                <div class="code-block">
let age = 65;<br>
let discount;<br>
<br>
if (age >= 60) {<br>
&nbsp;&nbsp;discount = 0.20;<br>
} else {<br>
&nbsp;&nbsp;discount = 0;<br>
}
                </div>
            </div>
            
            <div>
                <h3>✅ Short Way (ternary)</h3>
                <div class="code-block">
let age = 65;<br>
<br>
let discount = age >= 60 ? 0.20 : 0;
                </div>
            </div>
        </div>
        
        <div id="examples"></div>
    </div>
    
    <script>
        // Examples
        const age = 65;
        const discount = age >= 60 ? 0.20 : 0;
        
        const isResident = true;
        const status = isResident ? "Resident" : "Non-Resident";
        
        const clearanceFee = 50;
        const finalPrice = clearanceFee - (clearanceFee * discount);
        
        const hasUnpaidFees = false;
        const message = hasUnpaidFees ? "Please settle fees first" : "You can proceed";
        
        // Nested ternary (use sparingly!)
        const score = 85;
        const grade = score >= 90 ? "Excellent" :
                     score >= 80 ? "Very Good" :
                     score >= 70 ? "Good" :
                     "Needs Improvement";
        
        document.getElementById('examples').innerHTML = `
            <div class="example">
                <h3>👴 Senior Citizen Discount</h3>
                <p>Age: ${age}</p>
                <p><code>let discount = age >= 60 ? 0.20 : 0;</code></p>
                <p>Discount: ${discount * 100}%</p>
                <p>Original Price: ₱${clearanceFee}</p>
                <p><strong>Final Price: ₱${finalPrice}</strong></p>
            </div>
            
            <div class="example">
                <h3>📝 Resident Status</h3>
                <p><code>let status = isResident ? "Resident" : "Non-Resident";</code></p>
                <p><strong>Status: ${status}</strong></p>
            </div>
            
            <div class="example">
                <h3>💳 Fee Status Check</h3>
                <p>Has Unpaid Fees: ${hasUnpaidFees}</p>
                <p><code>let message = hasUnpaidFees ? "Please settle fees first" : "You can proceed";</code></p>
                <p><strong>${message}</strong></p>
            </div>
            
            <div class="example">
                <h3>🎯 Nested Ternary (Advanced)</h3>
                <p>Score: ${score}</p>
                <p><code>let grade = score >= 90 ? "Excellent" : score >= 80 ? "Very Good" : score >= 70 ? "Good" : "Needs Improvement";</code></p>
                <p><strong>Grade: ${grade}</strong></p>
                <p><em>⚠️ Use sparingly - can be hard to read!</em></p>
            </div>
        `;
    </script>
</body>
</html>
```

**Use ternary for simple conditions, if-else for complex ones!**

---

## Activity 6: Operator Precedence

**Goal:** Understand the order of operations.

**Create:** `operator-precedence.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Operator Precedence</title>
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
        .example {
            background-color: #f9f9f9;
            padding: 15px;
            margin: 10px 0;
            border-left: 4px solid #1a73e8;
            border-radius: 5px;
        }
        .correct { color: #4caf50; font-weight: bold; }
        .wrong { color: #f44336; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <h1>📊 Operator Precedence</h1>
        
        <p>Operators are evaluated in a specific order (like PEMDAS in math):</p>
        
        <table>
            <thead>
                <tr>
                    <th>Priority</th>
                    <th>Operator</th>
                    <th>Description</th>
                </tr>
            </thead>
            <tbody>
                <tr><td>1 (Highest)</td><td><code>()</code></td><td>Parentheses</td></tr>
                <tr><td>2</td><td><code>**</code></td><td>Exponentiation</td></tr>
                <tr><td>3</td><td><code>* / %</code></td><td>Multiplication, Division, Modulo</td></tr>
                <tr><td>4</td><td><code>+ -</code></td><td>Addition, Subtraction</td></tr>
                <tr><td>5</td><td><code>< > <= >=</code></td><td>Comparison</td></tr>
                <tr><td>6</td><td><code>=== !==</code></td><td>Equality</td></tr>
                <tr><td>7</td><td><code>&&</code></td><td>Logical AND</td></tr>
                <tr><td>8</td><td><code>||</code></td><td>Logical OR</td></tr>
                <tr><td>9 (Lowest)</td><td><code>= += -=</code></td><td>Assignment</td></tr>
            </tbody>
        </table>
        
        <div id="examples"></div>
    </div>
    
    <script>
        const examples = [
            {
                expression: "10 + 5 * 2",
                result: 10 + 5 * 2,
                explanation: "Multiplication first: 10 + (5 * 2) = 10 + 10 = 20"
            },
            {
                expression: "(10 + 5) * 2",
                result: (10 + 5) * 2,
                explanation: "Parentheses first: (10 + 5) * 2 = 15 * 2 = 30"
            },
            {
                expression: "10 + 5 * 2 - 3",
                result: 10 + 5 * 2 - 3,
                explanation: "10 + (5 * 2) - 3 = 10 + 10 - 3 = 17"
            },
            {
                expression: "2 ** 3 + 5",
                result: 2 ** 3 + 5,
                explanation: "Exponent first: (2 ** 3) + 5 = 8 + 5 = 13"
            }
        ];
        
        let html = '<h2>Examples:</h2>';
        examples.forEach(ex => {
            html += `
                <div class="example">
                    <p><code>${ex.expression}</code> = <span class="correct">${ex.result}</span></p>
                    <p><em>${ex.explanation}</em></p>
                </div>
            `;
        });
        
        // Barangay example
        const clearanceQty = 10;
        const clearanceFee = 50;
        const idQty = 5;
        const idFee = 30;
        const seniorDiscount = 0.20;
        
        // Without parentheses (WRONG!)
        const wrong = clearanceQty * clearanceFee + idQty * idFee - seniorDiscount;
        
        // With parentheses (CORRECT!)
        const correct = (clearanceQty * clearanceFee + idQty * idFee) * (1 - seniorDiscount);
        
        html += `
            <h2>💰 Barangay Revenue Calculation</h2>
            
            <div class="example">
                <h3>Without Proper Parentheses:</h3>
                <p><code>clearanceQty * clearanceFee + idQty * idFee - seniorDiscount</code></p>
                <p><span class="wrong">Wrong: ₱${wrong.toFixed(2)}</span></p>
                <p><em>Discount applied incorrectly!</em></p>
            </div>
            
            <div class="example">
                <h3>With Proper Parentheses:</h3>
                <p><code>(clearanceQty * clearanceFee + idQty * idFee) * (1 - seniorDiscount)</code></p>
                <p><span class="correct">Correct: ₱${correct.toFixed(2)}</span></p>
                <p><em>Calculate total first, then apply discount</em></p>
                <p>Breakdown:</p>
                <ul>
                    <li>Clearances: ${clearanceQty} × ₱${clearanceFee} = ₱${clearanceQty * clearanceFee}</li>
                    <li>IDs: ${idQty} × ₱${idFee} = ₱${idQty * idFee}</li>
                    <li>Subtotal: ₱${clearanceQty * clearanceFee + idQty * idFee}</li>
                    <li>Senior Discount: ${seniorDiscount * 100}%</li>
                    <li><strong>Total: ₱${correct.toFixed(2)}</strong></li>
                </ul>
            </div>
        `;
        
        document.getElementById('examples').innerHTML = html;
    </script>
</body>
</html>
```

**Rule:** When in doubt, use parentheses to make your intention clear!

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## JavaScript Operators Reference

### Arithmetic Operators

```javascript
let a = 10;
let b = 3;

a + b    // 13 (addition)
a - b    // 7  (subtraction)
a * b    // 30 (multiplication)
a / b    // 3.333... (division)
a % b    // 1  (modulo/remainder)
a ** b   // 1000 (exponentiation: 10^3)

// Increment/Decrement
let x = 5;
x++;     // 6 (increment after use)
++x;     // 7 (increment before use)
x--;     // 6 (decrement after use)
--x;     // 5 (decrement before use)
```

---

### Comparison Operators

```javascript
// Strict equality (checks value AND type)
5 === 5      // true
5 === "5"    // false (different types)

// Strict inequality
5 !== 3      // true
5 !== "5"    // true (different types)

// Loose equality (converts types - avoid!)
5 == "5"     // true (converts string to number)

// Comparisons
5 > 3        // true (greater than)
5 < 3        // false (less than)
5 >= 5       // true (greater than or equal)
5 <= 10      // true (less than or equal)
```

**Best Practice:** Always use `===` and `!==`

---

### Logical Operators

```javascript
// AND (&&) - both must be true
true && true    // true
true && false   // false
false && true   // false
false && false  // false

// OR (||) - at least one must be true
true || true    // true
true || false   // true
false || true   // true
false || false  // false

// NOT (!) - reverses boolean
!true           // false
!false          // true

// Practical example
let age = 25;
let isResident = true;
let hasUnpaidFees = false;

let eligible = (age >= 18) && isResident && !hasUnpaidFees;  // true
```

---

### Assignment Operators

```javascript
let x = 10;

x += 5;    // x = x + 5  → 15
x -= 3;    // x = x - 3  → 12
x *= 2;    // x = x * 2  → 24
x /= 4;    // x = x / 4  → 6
x %= 4;    // x = x % 4  → 2

// Increment/Decrement
x++;       // x = x + 1
x--;       // x = x - 1
```

---

### Ternary Operator

**Syntax:** `condition ? valueIfTrue : valueIfFalse`

```javascript
let age = 65;
let discount = age >= 60 ? 0.20 : 0;  // 0.20

let status = isResident ? "Resident" : "Non-Resident";

// Equivalent to:
let discount;
if (age >= 60) {
    discount = 0.20;
} else {
    discount = 0;
}
```

**Use for:** Simple if-else conditions  
**Avoid for:** Complex logic (use regular if-else)

---

### Operator Precedence (High to Low)

1. **() Parentheses** - highest priority
2. **`**`** Exponentiation
3. **`* / %`** Multiplication, Division, Modulo
4. **`+ -`** Addition, Subtraction
5. **`< > <= >=`** Comparison
6. **`=== !==`** Equality
7. **`&&`** Logical AND
8. **`||`** Logical OR
9. **`= += -=`** Assignment - lowest priority

**Example:**
```javascript
10 + 5 * 2        // 20 (5*2 first, then +10)
(10 + 5) * 2      // 30 (parentheses first)
```

**Best Practice:** Use parentheses to make intentions clear!

---

### String Operators

```javascript
// Concatenation with +
"Hello" + " " + "World"  // "Hello World"

// Template literals (best!)
let name = "Juan";
let age = 25;
`${name} is ${age} years old`  // "Juan is 25 years old"

// += with strings
let message = "Hello";
message += " World";  // "Hello World"
```

---

### Type Coercion (Automatic Type Conversion)

```javascript
// String + Number = String (concatenation)
"5" + 2       // "52" (not 7!)

// String - Number = Number (subtraction)
"5" - 2       // 3

// String * Number = Number (multiplication)
"5" * 2       // 10

// Boolean to Number
true + 1      // 2 (true becomes 1)
false + 1     // 1 (false becomes 0)
```

**Best Practice:** Be explicit, avoid relying on type coercion!

---

### Practical Examples

**Discount Calculator:**
```javascript
const age = 65;
const price = 50;
const discount = age >= 60 ? 0.20 : 0;
const finalPrice = price * (1 - discount);  // ₱40
```

**Eligibility Check:**
```javascript
const age = 25;
const isResident = true;
const hasUnpaidFees = false;

const eligible = (age >= 18) && isResident && !hasUnpaidFees;

if (eligible) {
    console.log("You can apply for clearance");
}
```

**Counter:**
```javascript
let count = 0;
count++;  // 1
count++;  // 2
count += 5;  // 7
count *= 2;  // 14
```

---

### Common Mistakes

**1. Using = instead of ===**
```javascript
if (age = 18) { }   // ❌ Assignment, not comparison!
if (age === 18) { } // ✅ Comparison
```

**2. Confusing == and ===**
```javascript
5 == "5"   // true (type conversion)
5 === "5"  // false (different types)
// Always use ===
```

**3. String concatenation vs addition**
```javascript
"5" + 2    // "52" (string concatenation)
5 + 2      // 7 (addition)
Number("5") + 2  // 7 (convert to number first)
```

**4. Forgetting operator precedence**
```javascript
10 + 5 * 2        // 20 (not 30!)
(10 + 5) * 2      // 30 (use parentheses!)
```

</details>

---

**Congratulations!** You've mastered JavaScript operators!

**Next Lesson:** Conditional Branching (if/else statements)!
