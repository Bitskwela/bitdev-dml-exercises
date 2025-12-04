# Lesson 25 Activities: Conditional Branching

## Making Decisions in Code

Control the flow of your program based on conditions using if, else, and switch statements!

---

## Activity 1: Basic if Statement

**Goal:** Execute code only when a condition is true.

**Create:** `basic-if.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Basic if Statement</title>
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
        .result {
            background-color: #e3f2fd;
            padding: 20px;
            margin: 20px 0;
            border-left: 4px solid #1a73e8;
            border-radius: 5px;
        }
        .success { border-left-color: #4caf50; background-color: #e8f5e9; }
        .error { border-left-color: #f44336; background-color: #ffebee; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔍 Basic if Statement</h1>
        <div id="output"></div>
    </div>
    
    <script>
        const age = 65;
        const isSenior = age >= 60;
        
        let output = `<p>Age: ${age}</p>`;
        
        // Basic if statement
        if (isSenior) {
            output += `<div class="result success">
                <h3>✅ Senior Citizen Discount Applied!</h3>
                <p>You are eligible for 20% discount on barangay services.</p>
            </div>`;
        }
        
        // Another example
        const clearanceFee = 50;
        let message = `<p>Clearance Fee: ₱${clearanceFee}</p>`;
        
        if (isSenior) {
            const discount = clearanceFee * 0.20;
            const finalPrice = clearanceFee - discount;
            message += `
                <p>Discount: -₱${discount.toFixed(2)}</p>
                <p><strong>Final Price: ₱${finalPrice.toFixed(2)}</strong></p>
            `;
        }
        
        output += `<div class="result">${message}</div>`;
        
        // Code explanation
        output += `
            <div class="result">
                <h3>Code Structure:</h3>
                <pre><code>if (condition) {
    // Code runs only if condition is true
}</code></pre>
                <p>The code inside { } only runs when the condition is true.</p>
            </div>
        `;
        
        document.getElementById('output').innerHTML = output;
    </script>
</body>
</html>
```

---

## Activity 2: if-else Statement

**Goal:** Execute different code based on a condition.

**Create:** `if-else.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>if-else Statement</title>
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
            background-color: white;
            border: 2px solid #ddd;
            padding: 20px;
            margin: 15px 0;
            border-radius: 8px;
        }
        .approved { border-color: #4caf50; background-color: #e8f5e9; }
        .denied { border-color: #f44336; background-color: #ffebee; }
    </style>
</head>
<body>
    <div class="container">
        <h1>📋 if-else Statement</h1>
        <div id="output"></div>
    </div>
    
    <script>
        function checkEligibility(name, age, isResident, hasUnpaidFees) {
            let status, message, cssClass;
            
            // if-else statement
            if (age >= 18 && isResident && !hasUnpaidFees) {
                status = "APPROVED";
                message = "Your barangay clearance application is approved!";
                cssClass = "approved";
            } else {
                status = "DENIED";
                message = "Application denied. Please check requirements.";
                cssClass = "denied";
                
                // Explain why denied
                if (age < 18) message += "<br>Reason: Must be 18 years or older.";
                if (!isResident) message += "<br>Reason: Must be a registered resident.";
                if (hasUnpaidFees) message += "<br>Reason: Must settle unpaid fees.";
            }
            
            return { name, age, isResident, hasUnpaidFees, status, message, cssClass };
        }
        
        // Test different scenarios
        const applicants = [
            checkEligibility("Juan Dela Cruz", 25, true, false),
            checkEligibility("Maria Santos", 17, true, false),
            checkEligibility("Pedro Garcia", 30, false, false),
            checkEligibility("Ana Reyes", 35, true, true)
        ];
        
        let output = '';
        applicants.forEach(app => {
            output += `
                <div class="card ${app.cssClass}">
                    <h3>${app.name} - ${app.status}</h3>
                    <p><strong>Age:</strong> ${app.age}</p>
                    <p><strong>Resident:</strong> ${app.isResident ? 'Yes' : 'No'}</p>
                    <p><strong>Unpaid Fees:</strong> ${app.hasUnpaidFees ? 'Yes' : 'No'}</p>
                    <p>${app.message}</p>
                </div>
            `;
        });
        
        // Code explanation
        output += `
            <div class="card">
                <h3>Code Structure:</h3>
                <pre><code>if (condition) {
    // Runs if true
} else {
    // Runs if false
}</code></pre>
            </div>
        `;
        
        document.getElementById('output').innerHTML = output;
    </script>
</body>
</html>
```

---

## Activity 3: else-if Chain

**Goal:** Check multiple conditions in sequence.

**Create:** `else-if-chain.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>else-if Chain</title>
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
        .badge {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: bold;
            color: white;
            margin: 5px;
        }
        .excellent { background-color: #4caf50; }
        .good { background-color: #2196f3; }
        .fair { background-color: #ff9800; }
        .poor { background-color: #f44336; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎯 else-if Chain</h1>
        <div id="output"></div>
    </div>
    
    <script>
        function getGrade(score) {
            let grade, remark, badgeClass;
            
            if (score >= 90) {
                grade = "A";
                remark = "Excellent";
                badgeClass = "excellent";
            } else if (score >= 80) {
                grade = "B";
                remark = "Very Good";
                badgeClass = "good";
            } else if (score >= 70) {
                grade = "C";
                remark = "Good";
                badgeClass = "good";
            } else if (score >= 60) {
                grade = "D";
                remark = "Fair";
                badgeClass = "fair";
            } else {
                grade = "F";
                remark = "Needs Improvement";
                badgeClass = "poor";
            }
            
            return { score, grade, remark, badgeClass };
        }
        
        function getDiscountRate(age, isPWD, isSenior) {
            let discount, reason;
            
            if (isSenior && isPWD) {
                discount = 0.30;  // 30% for senior + PWD
                reason = "Senior Citizen + PWD";
            } else if (isSenior) {
                discount = 0.20;  // 20% for seniors
                reason = "Senior Citizen";
            } else if (isPWD) {
                discount = 0.20;  // 20% for PWD
                reason = "Person with Disability";
            } else {
                discount = 0;     // No discount
                reason = "Regular Rate";
            }
            
            return { discount, reason };
        }
        
        // Test grading system
        const students = [95, 85, 75, 65, 55];
        let output = '<h2>📚 Student Grading System</h2>';
        
        students.forEach((score, index) => {
            const result = getGrade(score);
            output += `
                <div style="padding: 15px; margin: 10px 0; background-color: #f9f9f9; border-radius: 5px;">
                    <p><strong>Student ${index + 1}:</strong> Score ${result.score}</p>
                    <span class="badge ${result.badgeClass}">Grade ${result.grade} - ${result.remark}</span>
                </div>
            `;
        });
        
        // Test discount system
        output += '<h2>💰 Barangay Fee Discount System</h2>';
        const clearanceFee = 50;
        
        const cases = [
            { age: 65, isPWD: false, isSenior: true },
            { age: 65, isPWD: true, isSenior: true },
            { age: 30, isPWD: true, isSenior: false },
            { age: 30, isPWD: false, isSenior: false }
        ];
        
        cases.forEach((c, index) => {
            const result = getDiscountRate(c.age, c.isPWD, c.isSenior);
            const finalPrice = clearanceFee * (1 - result.discount);
            
            output += `
                <div style="padding: 15px; margin: 10px 0; background-color: #f9f9f9; border-radius: 5px;">
                    <p><strong>Case ${index + 1}:</strong> Age ${c.age}, ${c.isPWD ? 'PWD' : 'Not PWD'}, ${c.isSenior ? 'Senior' : 'Not Senior'}</p>
                    <p><strong>Category:</strong> ${result.reason}</p>
                    <p><strong>Discount:</strong> ${result.discount * 100}%</p>
                    <p><strong>Original:</strong> ₱${clearanceFee} → <strong>Final:</strong> ₱${finalPrice.toFixed(2)}</p>
                </div>
            `;
        });
        
        // Code explanation
        output += `
            <div style="margin-top: 30px; padding: 20px; background-color: #e3f2fd; border-radius: 5px;">
                <h3>Code Structure:</h3>
                <pre><code>if (condition1) {
    // Runs if condition1 is true
} else if (condition2) {
    // Runs if condition1 is false and condition2 is true
} else if (condition3) {
    // Runs if condition1 and condition2 are false, condition3 is true
} else {
    // Runs if all conditions are false
}</code></pre>
                <p><strong>Note:</strong> Only ONE block executes (the first true condition)</p>
            </div>
        `;
        
        document.getElementById('output').innerHTML = output;
    </script>
</body>
</html>
```

---

## Activity 4: Nested if Statements

**Goal:** Place if statements inside other if statements.

**Create:** `nested-if.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nested if Statements</title>
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
        .result {
            padding: 20px;
            margin: 15px 0;
            border-radius: 8px;
            border-left: 5px solid #1a73e8;
        }
        .approved { background-color: #e8f5e9; border-left-color: #4caf50; }
        .denied { background-color: #ffebee; border-left-color: #f44336; }
        .pending { background-color: #fff3cd; border-left-color: #ff9800; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔄 Nested if Statements</h1>
        <div id="output"></div>
    </div>
    
    <script>
        function processApplication(name, age, isResident, hasValidID, hasUnpaidFees, documents) {
            let status, message, cssClass, fee = 50;
            
            // Outer if: Check age
            if (age >= 18) {
                // Inner if: Check residency
                if (isResident) {
                    // Inner if: Check valid ID
                    if (hasValidID) {
                        // Inner if: Check unpaid fees
                        if (!hasUnpaidFees) {
                            // Inner if: Check documents
                            if (documents >= 2) {
                                status = "APPROVED";
                                message = "Application approved! Proceed to payment.";
                                cssClass = "approved";
                                
                                // Apply senior discount
                                if (age >= 60) {
                                    fee = fee * 0.80;  // 20% off
                                    message += `<br>Senior discount applied: ₱${fee.toFixed(2)}`;
                                }
                            } else {
                                status = "PENDING";
                                message = `Incomplete documents. You have ${documents}/2 required documents.`;
                                cssClass = "pending";
                            }
                        } else {
                            status = "DENIED";
                            message = "Please settle unpaid fees first.";
                            cssClass = "denied";
                        }
                    } else {
                        status = "DENIED";
                        message = "Valid ID required.";
                        cssClass = "denied";
                    }
                } else {
                    status = "DENIED";
                    message = "Must be a registered resident.";
                    cssClass = "denied";
                }
            } else {
                status = "DENIED";
                message = "Must be 18 years or older.";
                cssClass = "denied";
            }
            
            return { name, age, isResident, hasValidID, hasUnpaidFees, documents, status, message, cssClass, fee };
        }
        
        // Test different scenarios
        const applications = [
            processApplication("Juan Dela Cruz", 65, true, true, false, 2),
            processApplication("Maria Santos", 17, true, true, false, 2),
            processApplication("Pedro Garcia", 25, false, true, false, 2),
            processApplication("Ana Reyes", 30, true, false, false, 2),
            processApplication("Jose Mendoza", 35, true, true, true, 2),
            processApplication("Carmen Lopez", 28, true, true, false, 1)
        ];
        
        let output = '';
        applications.forEach((app, index) => {
            output += `
                <div class="result ${app.cssClass}">
                    <h3>${app.name} - ${app.status}</h3>
                    <p><strong>Age:</strong> ${app.age}</p>
                    <p><strong>Resident:</strong> ${app.isResident ? 'Yes' : 'No'}</p>
                    <p><strong>Valid ID:</strong> ${app.hasValidID ? 'Yes' : 'No'}</p>
                    <p><strong>Unpaid Fees:</strong> ${app.hasUnpaidFees ? 'Yes' : 'No'}</p>
                    <p><strong>Documents:</strong> ${app.documents}/2</p>
                    ${app.status === 'APPROVED' ? `<p><strong>Fee:</strong> ₱${app.fee.toFixed(2)}</p>` : ''}
                    <p><em>${app.message}</em></p>
                </div>
            `;
        });
        
        // Code explanation
        output += `
            <div style="margin-top: 30px; padding: 20px; background-color: #e3f2fd; border-radius: 5px;">
                <h3>Nested if Structure:</h3>
                <pre><code>if (condition1) {
    if (condition2) {
        if (condition3) {
            // Runs only if all 3 conditions are true
        }
    }
}</code></pre>
                <p><strong>Alternative:</strong> Use && to combine conditions</p>
                <pre><code>if (condition1 && condition2 && condition3) {
    // Same result, cleaner code!
}</code></pre>
            </div>
        `;
        
        document.getElementById('output').innerHTML = output;
    </script>
</body>
</html>
```

---

## Activity 5: switch Statement

**Goal:** Choose between many options efficiently.

**Create:** `switch-statement.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>switch Statement</title>
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
        .service-card {
            background-color: #f9f9f9;
            padding: 20px;
            margin: 15px 0;
            border-radius: 8px;
            border-left: 5px solid #1a73e8;
        }
        .price {
            color: #4caf50;
            font-size: 1.5em;
            font-weight: bold;
        }
        select, button {
            width: 100%;
            padding: 15px;
            font-size: 16px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
        button {
            background-color: #1a73e8;
            color: white;
            border: none;
            cursor: pointer;
            font-weight: bold;
        }
        button:hover {
            background-color: #1557b0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏢 Barangay Service Selection</h1>
        
        <label for="serviceSelect"><strong>Select Service:</strong></label>
        <select id="serviceSelect">
            <option value="">-- Choose a service --</option>
            <option value="clearance">Barangay Clearance</option>
            <option value="id">Barangay ID</option>
            <option value="permit">Business Permit</option>
            <option value="certificate">Certificate of Residency</option>
            <option value="indigency">Indigency Certificate</option>
            <option value="tax">Community Tax Certificate</option>
        </select>
        
        <button onclick="getServiceInfo()">Get Service Info</button>
        
        <div id="output"></div>
    </div>
    
    <script>
        function getServiceInfo() {
            const service = document.getElementById('serviceSelect').value;
            let name, price, processing, requirements;
            
            switch (service) {
                case 'clearance':
                    name = "Barangay Clearance";
                    price = 50;
                    processing = "1-2 business days";
                    requirements = ["Valid ID", "Proof of Residency"];
                    break;
                    
                case 'id':
                    name = "Barangay ID";
                    price = 30;
                    processing = "3-5 business days";
                    requirements = ["Birth Certificate", "1x1 Photo", "Proof of Residency"];
                    break;
                    
                case 'permit':
                    name = "Business Permit";
                    price = 500;
                    processing = "5-7 business days";
                    requirements = ["DTI Registration", "Mayor's Permit", "Tax Clearance"];
                    break;
                    
                case 'certificate':
                    name = "Certificate of Residency";
                    price = 30;
                    processing = "1 business day";
                    requirements = ["Valid ID", "Proof of Residency"];
                    break;
                    
                case 'indigency':
                    name = "Indigency Certificate";
                    price = 0;  // Free
                    processing = "1-2 business days";
                    requirements = ["Valid ID", "Barangay Clearance"];
                    break;
                    
                case 'tax':
                    name = "Community Tax Certificate (Cedula)";
                    price = 5;
                    processing = "Same day";
                    requirements = ["Valid ID"];
                    break;
                    
                default:
                    document.getElementById('output').innerHTML = `
                        <div style="padding: 20px; background-color: #fff3cd; border-radius: 5px; margin-top: 20px;">
                            <p>⚠️ Please select a service</p>
                        </div>
                    `;
                    return;
            }
            
            // Display service info
            const reqList = requirements.map(req => `<li>${req}</li>`).join('');
            
            document.getElementById('output').innerHTML = `
                <div class="service-card">
                    <h2>${name}</h2>
                    <p class="price">₱${price}${price === 0 ? ' (Free)' : ''}</p>
                    <p><strong>Processing Time:</strong> ${processing}</p>
                    <p><strong>Requirements:</strong></p>
                    <ul>${reqList}</ul>
                </div>
                
                <div style="margin-top: 30px; padding: 20px; background-color: #e3f2fd; border-radius: 5px;">
                    <h3>switch Statement Structure:</h3>
                    <pre><code>switch (expression) {
    case value1:
        // Code for value1
        break;
    case value2:
        // Code for value2
        break;
    default:
        // Code if no match
}</code></pre>
                    <p><strong>Important:</strong> Don't forget <code>break;</code> or it will fall through!</p>
                </div>
            `;
        }
        
        // Day of week example
        function getDayMessage(day) {
            let message;
            
            switch (day) {
                case 0:
                    message = "Sunday - Office Closed";
                    break;
                case 1:
                case 2:
                case 3:
                case 4:
                case 5:
                    message = "Monday-Friday - Office Hours: 8AM-5PM";
                    break;
                case 6:
                    message = "Saturday - Half Day: 8AM-12PM";
                    break;
                default:
                    message = "Invalid day";
            }
            
            return message;
        }
        
        const today = new Date().getDay();
        console.log("Today:", getDayMessage(today));
    </script>
</body>
</html>
```

---

## Activity 6: Truthy and Falsy Values

**Goal:** Understand which values are treated as true/false.

**Create:** `truthy-falsy.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Truthy and Falsy Values</title>
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
        .truthy { color: #4caf50; font-weight: bold; }
        .falsy { color: #f44336; font-weight: bold; }
        .example {
            background-color: #f9f9f9;
            padding: 20px;
            margin: 15px 0;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>✅❌ Truthy and Falsy Values</h1>
        
        <h2>Falsy Values (treated as false)</h2>
        <table>
            <thead>
                <tr>
                    <th>Value</th>
                    <th>Type</th>
                    <th>Result</th>
                </tr>
            </thead>
            <tbody id="falsyTable"></tbody>
        </table>
        
        <h2>Truthy Values (treated as true)</h2>
        <table>
            <thead>
                <tr>
                    <th>Value</th>
                    <th>Type</th>
                    <th>Result</th>
                </tr>
            </thead>
            <tbody id="truthyTable"></tbody>
        </table>
        
        <div id="examples"></div>
    </div>
    
    <script>
        // Falsy values
        const falsyValues = [
            { value: false, display: 'false' },
            { value: 0, display: '0' },
            { value: '', display: '""' },
            { value: null, display: 'null' },
            { value: undefined, display: 'undefined' },
            { value: NaN, display: 'NaN' }
        ];
        
        let falsyHTML = '';
        falsyValues.forEach(item => {
            falsyHTML += `
                <tr>
                    <td><code>${item.display}</code></td>
                    <td>${typeof item.value}</td>
                    <td class="falsy">${Boolean(item.value)}</td>
                </tr>
            `;
        });
        document.getElementById('falsyTable').innerHTML = falsyHTML;
        
        // Truthy values
        const truthyValues = [
            { value: true, display: 'true' },
            { value: 1, display: '1' },
            { value: -1, display: '-1' },
            { value: 'hello', display: '"hello"' },
            { value: '0', display: '"0"' },
            { value: [], display: '[]' },
            { value: {}, display: '{}' }
        ];
        
        let truthyHTML = '';
        truthyValues.forEach(item => {
            truthyHTML += `
                <tr>
                    <td><code>${item.display}</code></td>
                    <td>${typeof item.value}</td>
                    <td class="truthy">${Boolean(item.value)}</td>
                </tr>
            `;
        });
        document.getElementById('truthyTable').innerHTML = truthyHTML;
        
        // Practical examples
        const name = "";
        const age = 0;
        const residents = [];
        
        document.getElementById('examples').innerHTML = `
            <h2>Practical Examples</h2>
            
            <div class="example">
                <h3>Example 1: Checking if name exists</h3>
                <pre><code>let name = "";

if (name) {
    console.log("Name exists");
} else {
    console.log("Name is empty");  // This runs!
}</code></pre>
                <p>Result: ${name ? 'Name exists' : '<strong>Name is empty</strong>'}</p>
            </div>
            
            <div class="example">
                <h3>Example 2: Default values</h3>
                <pre><code>let userName = userName || "Guest";  // If userName is falsy, use "Guest"</code></pre>
                <p>Useful for providing default values!</p>
            </div>
            
            <div class="example">
                <h3>Example 3: Checking arrays</h3>
                <pre><code>let residents = [];

if (residents.length) {
    console.log("Has residents");
} else {
    console.log("No residents");  // This runs! (0 is falsy)
}</code></pre>
                <p>Result: ${residents.length ? 'Has residents' : '<strong>No residents</strong>'}</p>
            </div>
            
            <div class="example">
                <h3>⚠️ Common Gotcha: "0" vs 0</h3>
                <pre><code>if ("0") {
    console.log("String '0' is truthy!");  // This runs!
}

if (0) {
    console.log("Number 0 is falsy");  // This doesn't run
}</code></pre>
                <p><strong>"0"</strong> (string) is ${'<span class="truthy">truthy</span>'}</p>
                <p><strong>0</strong> (number) is ${'<span class="falsy">falsy</span>'}</p>
            </div>
        `;
    </script>
</body>
</html>
```

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## Conditional Branching Reference

### if Statement

```javascript
if (condition) {
    // Runs only if condition is true
}

// Example
let age = 65;
if (age >= 60) {
    console.log("Senior discount applied");
}
```

---

### if-else Statement

```javascript
if (condition) {
    // Runs if condition is true
} else {
    // Runs if condition is false
}

// Example
let age = 25;
if (age >= 18) {
    console.log("Adult");
} else {
    console.log("Minor");
}
```

---

### else-if Chain

```javascript
if (condition1) {
    // Runs if condition1 is true
} else if (condition2) {
    // Runs if condition2 is true
} else if (condition3) {
    // Runs if condition3 is true
} else {
    // Runs if all conditions are false
}

// Example
let score = 85;
if (score >= 90) {
    console.log("A");
} else if (score >= 80) {
    console.log("B");  // This runs
} else if (score >= 70) {
    console.log("C");
} else {
    console.log("D or F");
}
```

---

### Nested if Statements

```javascript
if (condition1) {
    if (condition2) {
        if (condition3) {
            // Runs if all 3 are true
        }
    }
}

// Better: Use && to combine
if (condition1 && condition2 && condition3) {
    // Same result, cleaner!
}

// Example
let age = 25;
let isResident = true;

if (age >= 18) {
    if (isResident) {
        console.log("Eligible");
    }
}

// Better:
if (age >= 18 && isResident) {
    console.log("Eligible");
}
```

---

### switch Statement

```javascript
switch (expression) {
    case value1:
        // Code for value1
        break;
    case value2:
        // Code for value2
        break;
    default:
        // Code if no match
}

// Example
let day = 1;
switch (day) {
    case 0:
        console.log("Sunday");
        break;
    case 1:
        console.log("Monday");  // This runs
        break;
    case 2:
        console.log("Tuesday");
        break;
    default:
        console.log("Other day");
}

// Fall-through (multiple cases)
switch (day) {
    case 1:
    case 2:
    case 3:
    case 4:
    case 5:
        console.log("Weekday");
        break;
    case 0:
    case 6:
        console.log("Weekend");
        break;
}
```

**Important:** Don't forget `break;` or it will fall through to next case!

---

### Truthy and Falsy Values

**Falsy values (6 total):**
```javascript
false        // Boolean false
0            // Number zero
""           // Empty string
null         // Null
undefined    // Undefined
NaN          // Not a Number

// All evaluate to false in conditions
if (0) { }          // Doesn't run
if ("") { }         // Doesn't run
if (null) { }       // Doesn't run
```

**Truthy values (everything else):**
```javascript
true         // Boolean true
1, -1, 3.14  // Any non-zero number
"hello"      // Any non-empty string
"0"          // String "0" is truthy!
[]           // Empty array is truthy
{}           // Empty object is truthy

// All evaluate to true in conditions
if (1) { }          // Runs
if ("hello") { }    // Runs
if ([]) { }         // Runs
```

---

### Ternary Operator (Shorthand)

```javascript
condition ? valueIfTrue : valueIfFalse

// Example
let age = 65;
let discount = age >= 60 ? 0.20 : 0;

// Equivalent to:
let discount;
if (age >= 60) {
    discount = 0.20;
} else {
    discount = 0;
}
```

---

### Comparison Operators in Conditions

```javascript
if (age === 18) { }      // Equal to
if (age !== 18) { }      // Not equal to
if (age > 18) { }        // Greater than
if (age < 18) { }        // Less than
if (age >= 18) { }       // Greater than or equal
if (age <= 18) { }       // Less than or equal
```

---

### Logical Operators in Conditions

```javascript
// AND (&&) - both must be true
if (age >= 18 && isResident) { }

// OR (||) - at least one must be true
if (isSenior || isPWD) { }

// NOT (!) - reverses boolean
if (!hasUnpaidFees) { }

// Complex combinations
if ((age >= 18 && isResident) || isSpecialCase) { }
```

---

### Best Practices

**1. Use strict equality (===)**
```javascript
if (age === 18) { }     // ✅ Good
if (age == 18) { }      // ❌ Avoid (type coercion)
```

**2. Keep conditions simple**
```javascript
// ❌ Too complex
if (age >= 18 && isResident && !hasUnpaidFees && hasValidID && documents >= 2) { }

// ✅ Better
let isEligible = age >= 18 && isResident && !hasUnpaidFees;
let hasDocuments = hasValidID && documents >= 2;
if (isEligible && hasDocuments) { }
```

**3. Use switch for multiple exact matches**
```javascript
// ✅ Good use of switch
switch (day) {
    case 'monday':
    case 'tuesday':
        console.log("Weekday");
        break;
}

// ❌ Bad use of switch (use if-else for ranges)
switch (true) {
    case age >= 60:
        console.log("Senior");
        break;
}
```

**4. Avoid unnecessary else**
```javascript
// ❌ Unnecessary else
function checkAge(age) {
    if (age >= 18) {
        return "Adult";
    } else {
        return "Minor";
    }
}

// ✅ Cleaner
function checkAge(age) {
    if (age >= 18) {
        return "Adult";
    }
    return "Minor";
}
```

---

### Common Patterns

**Validation:**
```javascript
if (!name) {
    console.log("Name is required");
    return;
}
if (age < 18) {
    console.log("Must be 18+");
    return;
}
// Continue with valid data
```

**Default values:**
```javascript
let userName = inputName || "Guest";
let age = inputAge || 0;
```

**Multiple conditions:**
```javascript
let eligible = age >= 18 && isResident && !hasUnpaidFees;
if (eligible) {
    console.log("Approved");
}
```

</details>

---

**Congratulations!** You've mastered conditional branching!

**Next Lesson:** Loops and Iteration!
