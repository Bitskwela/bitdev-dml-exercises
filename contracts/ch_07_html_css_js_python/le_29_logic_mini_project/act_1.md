# Lesson 29 Activities: JavaScript Logic Mini Project

## Barangay Clearance Application System

Apply all JavaScript logic concepts to build a complete clearance application system!

---

## Activity 1: Application Form Validation

**Goal:** Validate user input with conditionals.

**Create:** `validation-system.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Application Validation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 600px;
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
        input.error {
            border-color: #f44336;
        }
        .error-message {
            color: #f44336;
            font-size: 14px;
            margin-top: 5px;
        }
        button {
            width: 100%;
            padding: 15px;
            background-color: #1a73e8;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 20px;
        }
        button:hover {
            background-color: #1557b0;
        }
        .result {
            margin-top: 20px;
            padding: 20px;
            border-radius: 8px;
        }
        .success {
            background-color: #e8f5e9;
            border-left: 5px solid #4caf50;
        }
        .error {
            background-color: #ffebee;
            border-left: 5px solid #f44336;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏢 Barangay Clearance Application</h1>
        
        <form id="applicationForm">
            <div class="form-group">
                <label for="fullName">Full Name:</label>
                <input type="text" id="fullName" required>
                <div id="nameError" class="error-message"></div>
            </div>
            
            <div class="form-group">
                <label for="age">Age:</label>
                <input type="number" id="age" required>
                <div id="ageError" class="error-message"></div>
            </div>
            
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" required>
                <div id="addressError" class="error-message"></div>
            </div>
            
            <div class="form-group">
                <label for="purpose">Purpose:</label>
                <select id="purpose" required>
                    <option value="">-- Select Purpose --</option>
                    <option value="employment">Employment</option>
                    <option value="business">Business</option>
                    <option value="travel">Travel</option>
                    <option value="other">Other</option>
                </select>
                <div id="purposeError" class="error-message"></div>
            </div>
            
            <div class="form-group">
                <label>
                    <input type="checkbox" id="isPWD"> Person with Disability (PWD)
                </label>
            </div>
            
            <div class="form-group">
                <label>
                    <input type="checkbox" id="terms"> I agree to the terms and conditions
                </label>
                <div id="termsError" class="error-message"></div>
            </div>
            
            <button type="submit">Submit Application</button>
        </form>
        
        <div id="result"></div>
    </div>
    
    <script>
        const form = document.getElementById('applicationForm');
        
        function validateName(name) {
            if (name.trim() === '') {
                return { valid: false, message: 'Name is required' };
            }
            if (name.length < 3) {
                return { valid: false, message: 'Name must be at least 3 characters' };
            }
            if (!/^[a-zA-Z\s]+$/.test(name)) {
                return { valid: false, message: 'Name can only contain letters and spaces' };
            }
            return { valid: true, message: '' };
        }
        
        function validateAge(age) {
            if (age === '' || age === null) {
                return { valid: false, message: 'Age is required' };
            }
            const ageNum = parseInt(age);
            if (isNaN(ageNum)) {
                return { valid: false, message: 'Age must be a number' };
            }
            if (ageNum < 18) {
                return { valid: false, message: 'Must be 18 years or older' };
            }
            if (ageNum > 120) {
                return { valid: false, message: 'Please enter a valid age' };
            }
            return { valid: true, message: '' };
        }
        
        function validateAddress(address) {
            if (address.trim() === '') {
                return { valid: false, message: 'Address is required' };
            }
            if (address.length < 10) {
                return { valid: false, message: 'Please enter complete address (min 10 characters)' };
            }
            return { valid: true, message: '' };
        }
        
        function validatePurpose(purpose) {
            if (purpose === '') {
                return { valid: false, message: 'Please select a purpose' };
            }
            return { valid: true, message: '' };
        }
        
        function validateTerms(checked) {
            if (!checked) {
                return { valid: false, message: 'You must agree to the terms and conditions' };
            }
            return { valid: true, message: '' };
        }
        
        function calculateFee(age, isPWD) {
            const baseFee = 50;
            if (age >= 60 || isPWD) {
                return baseFee * 0.80;  // 20% discount
            }
            return baseFee;
        }
        
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Get form values
            const fullName = document.getElementById('fullName').value;
            const age = document.getElementById('age').value;
            const address = document.getElementById('address').value;
            const purpose = document.getElementById('purpose').value;
            const isPWD = document.getElementById('isPWD').checked;
            const terms = document.getElementById('terms').checked;
            
            // Clear previous errors
            document.querySelectorAll('.error-message').forEach(el => el.textContent = '');
            document.querySelectorAll('input, select').forEach(el => el.classList.remove('error'));
            
            // Validate all fields
            const nameValidation = validateName(fullName);
            const ageValidation = validateAge(age);
            const addressValidation = validateAddress(address);
            const purposeValidation = validatePurpose(purpose);
            const termsValidation = validateTerms(terms);
            
            let isValid = true;
            
            if (!nameValidation.valid) {
                document.getElementById('nameError').textContent = nameValidation.message;
                document.getElementById('fullName').classList.add('error');
                isValid = false;
            }
            
            if (!ageValidation.valid) {
                document.getElementById('ageError').textContent = ageValidation.message;
                document.getElementById('age').classList.add('error');
                isValid = false;
            }
            
            if (!addressValidation.valid) {
                document.getElementById('addressError').textContent = addressValidation.message;
                document.getElementById('address').classList.add('error');
                isValid = false;
            }
            
            if (!purposeValidation.valid) {
                document.getElementById('purposeError').textContent = purposeValidation.message;
                document.getElementById('purpose').classList.add('error');
                isValid = false;
            }
            
            if (!termsValidation.valid) {
                document.getElementById('termsError').textContent = termsValidation.message;
                isValid = false;
            }
            
            // Display result
            const resultDiv = document.getElementById('result');
            
            if (isValid) {
                const fee = calculateFee(parseInt(age), isPWD);
                const discountApplied = (parseInt(age) >= 60 || isPWD);
                
                resultDiv.className = 'result success';
                resultDiv.innerHTML = `
                    <h2>✅ Application Approved!</h2>
                    <p><strong>Name:</strong> ${fullName}</p>
                    <p><strong>Age:</strong> ${age}</p>
                    <p><strong>Address:</strong> ${address}</p>
                    <p><strong>Purpose:</strong> ${purpose}</p>
                    ${discountApplied ? '<p><strong>Discount Applied:</strong> 20% (Senior/PWD)</p>' : ''}
                    <p><strong>Fee:</strong> ₱${fee.toFixed(2)}</p>
                    <p>Please proceed to payment counter.</p>
                `;
            } else {
                resultDiv.className = 'result error';
                resultDiv.innerHTML = `
                    <h2>❌ Application Invalid</h2>
                    <p>Please correct the errors above and try again.</p>
                `;
            }
        });
    </script>
</body>
</html>
```

---

## Activity 2: Fee Calculator with Loops

**Goal:** Calculate fees for multiple applicants.

**Create:** `fee-calculator.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Batch Fee Calculator</title>
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
        button {
            padding: 12px 24px;
            background-color: #4caf50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin: 5px;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>💰 Batch Fee Calculator</h1>
        
        <button onclick="calculateAllFees()">Calculate All Fees</button>
        <button onclick="showDiscountedOnly()">Show Discounted Only</button>
        <button onclick="showByZone()">Group by Zone</button>
        
        <div id="output"></div>
    </div>
    
    <script>
        const applicants = [
            { name: 'Juan Dela Cruz', age: 25, zone: 'A', isPWD: false, service: 'clearance' },
            { name: 'Maria Santos', age: 65, zone: 'B', isPWD: false, service: 'clearance' },
            { name: 'Pedro Garcia', age: 30, zone: 'A', isPWD: true, service: 'id' },
            { name: 'Ana Reyes', age: 70, zone: 'C', isPWD: false, service: 'clearance' },
            { name: 'Jose Mendoza', age: 28, zone: 'B', isPWD: false, service: 'permit' },
            { name: 'Carmen Lopez', age: 62, zone: 'C', isPWD: true, service: 'clearance' },
            { name: 'Ricardo Cruz', age: 35, zone: 'A', isPWD: false, service: 'id' },
            { name: 'Elena Fernandez', age: 68, zone: 'B', isPWD: false, service: 'clearance' }
        ];
        
        const servicePrices = {
            clearance: 50,
            id: 30,
            permit: 500
        };
        
        function calculateFee(applicant) {
            const basePrice = servicePrices[applicant.service];
            const isSenior = applicant.age >= 60;
            
            let discount = 0;
            let discountReason = 'None';
            
            if (isSenior && applicant.isPWD) {
                discount = 0.30;
                discountReason = 'Senior + PWD';
            } else if (isSenior) {
                discount = 0.20;
                discountReason = 'Senior';
            } else if (applicant.isPWD) {
                discount = 0.20;
                discountReason = 'PWD';
            }
            
            const finalPrice = basePrice * (1 - discount);
            
            return {
                ...applicant,
                basePrice: basePrice,
                discount: discount * 100,
                discountReason: discountReason,
                finalPrice: finalPrice
            };
        }
        
        function calculateAllFees() {
            let html = '<h2>All Applicants with Fees</h2>';
            html += '<table>';
            html += '<thead><tr><th>Name</th><th>Age</th><th>Zone</th><th>Service</th><th>Base</th><th>Discount</th><th>Final</th></tr></thead>';
            html += '<tbody>';
            
            let totalBase = 0;
            let totalFinal = 0;
            let totalDiscount = 0;
            
            for (let i = 0; i < applicants.length; i++) {
                const result = calculateFee(applicants[i]);
                
                totalBase += result.basePrice;
                totalFinal += result.finalPrice;
                totalDiscount += (result.basePrice - result.finalPrice);
                
                html += `
                    <tr>
                        <td>${result.name}</td>
                        <td>${result.age}</td>
                        <td>${result.zone}</td>
                        <td>${result.service}</td>
                        <td>₱${result.basePrice}</td>
                        <td>${result.discount}%${result.discountReason !== 'None' ? ` (${result.discountReason})` : ''}</td>
                        <td><strong>₱${result.finalPrice.toFixed(2)}</strong></td>
                    </tr>
                `;
            }
            
            html += '</tbody></table>';
            
            html += '<div class="stats">';
            html += `
                <div class="stat-card">
                    <div class="stat-number">${applicants.length}</div>
                    <p>Total Applicants</p>
                </div>
                <div class="stat-card">
                    <div class="stat-number">₱${totalBase.toFixed(2)}</div>
                    <p>Total Base</p>
                </div>
                <div class="stat-card">
                    <div class="stat-number">₱${totalDiscount.toFixed(2)}</div>
                    <p>Total Discount</p>
                </div>
                <div class="stat-card">
                    <div class="stat-number">₱${totalFinal.toFixed(2)}</div>
                    <p>Total Revenue</p>
                </div>
            `;
            html += '</div>';
            
            document.getElementById('output').innerHTML = html;
        }
        
        function showDiscountedOnly() {
            let html = '<h2>Applicants with Discounts</h2>';
            html += '<table>';
            html += '<thead><tr><th>Name</th><th>Age</th><th>Discount</th><th>Reason</th><th>Savings</th></tr></thead>';
            html += '<tbody>';
            
            let count = 0;
            for (let applicant of applicants) {
                const result = calculateFee(applicant);
                
                if (result.discount > 0) {
                    count++;
                    const savings = result.basePrice - result.finalPrice;
                    
                    html += `
                        <tr>
                            <td>${result.name}</td>
                            <td>${result.age}</td>
                            <td>${result.discount}%</td>
                            <td>${result.discountReason}</td>
                            <td>₱${savings.toFixed(2)}</td>
                        </tr>
                    `;
                }
            }
            
            html += '</tbody></table>';
            html += `<p><strong>Total with discounts: ${count} applicants</strong></p>`;
            
            document.getElementById('output').innerHTML = html;
        }
        
        function showByZone() {
            let html = '<h2>Applicants Grouped by Zone</h2>';
            
            const zones = ['A', 'B', 'C'];
            
            for (let zone of zones) {
                html += `<h3>Zone ${zone}</h3>`;
                html += '<table>';
                html += '<thead><tr><th>Name</th><th>Age</th><th>Service</th><th>Final Fee</th></tr></thead>';
                html += '<tbody>';
                
                let zoneTotal = 0;
                let zoneCount = 0;
                
                for (let applicant of applicants) {
                    if (applicant.zone === zone) {
                        const result = calculateFee(applicant);
                        zoneTotal += result.finalPrice;
                        zoneCount++;
                        
                        html += `
                            <tr>
                                <td>${result.name}</td>
                                <td>${result.age}</td>
                                <td>${result.service}</td>
                                <td>₱${result.finalPrice.toFixed(2)}</td>
                            </tr>
                        `;
                    }
                }
                
                html += '</tbody></table>';
                html += `<p><strong>Zone ${zone} Total: ${zoneCount} applicants, ₱${zoneTotal.toFixed(2)} revenue</strong></p>`;
            }
            
            document.getElementById('output').innerHTML = html;
        }
        
        // Show all by default
        calculateAllFees();
    </script>
</body>
</html>
```

---

## Activity 3: Queue Management System

**Goal:** Manage applicant queue with arrays.

**Create:** `queue-system.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Queue Management</title>
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
        .controls {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 10px;
            margin: 20px 0;
        }
        button {
            padding: 15px;
            background-color: #1a73e8;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #1557b0;
        }
        button.priority {
            background-color: #ff9800;
        }
        button.priority:hover {
            background-color: #f57c00;
        }
        button.danger {
            background-color: #f44336;
        }
        button.danger:hover {
            background-color: #d32f2f;
        }
        .queue-display {
            display: grid;
            gap: 10px;
            margin: 20px 0;
        }
        .queue-item {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 5px;
            border-left: 5px solid #1a73e8;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .queue-item.priority {
            border-left-color: #ff9800;
            background-color: #fff3cd;
        }
        .queue-item.current {
            border-left-color: #4caf50;
            background-color: #e8f5e9;
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
    </style>
</head>
<body>
    <div class="container">
        <h1>🎫 Queue Management System</h1>
        
        <div class="controls">
            <button onclick="addRegular()">Add Regular</button>
            <button onclick="addPriority()" class="priority">Add Priority (Senior/PWD)</button>
            <button onclick="processNext()">Process Next</button>
            <button onclick="skipCurrent()">Skip Current</button>
            <button onclick="clearQueue()" class="danger">Clear Queue</button>
        </div>
        
        <div id="stats"></div>
        <div id="queue"></div>
        <div id="processed"></div>
    </div>
    
    <script>
        let queue = [];
        let processed = [];
        let queueNumber = 1;
        
        const sampleNames = [
            'Juan Dela Cruz', 'Maria Santos', 'Pedro Garcia', 'Ana Reyes',
            'Jose Mendoza', 'Carmen Lopez', 'Ricardo Cruz', 'Elena Fernandez'
        ];
        
        function getRandomName() {
            return sampleNames[Math.floor(Math.random() * sampleNames.length)];
        }
        
        function addRegular() {
            const person = {
                number: queueNumber++,
                name: getRandomName(),
                type: 'regular',
                time: new Date().toLocaleTimeString()
            };
            queue.push(person);
            updateDisplay();
        }
        
        function addPriority() {
            const person = {
                number: queueNumber++,
                name: getRandomName(),
                type: 'priority',
                time: new Date().toLocaleTimeString()
            };
            
            // Find first non-priority position
            let insertPos = 0;
            while (insertPos < queue.length && queue[insertPos].type === 'priority') {
                insertPos++;
            }
            
            queue.splice(insertPos, 0, person);
            updateDisplay();
        }
        
        function processNext() {
            if (queue.length === 0) {
                alert('Queue is empty!');
                return;
            }
            
            const person = queue.shift();
            person.processedTime = new Date().toLocaleTimeString();
            processed.push(person);
            updateDisplay();
        }
        
        function skipCurrent() {
            if (queue.length === 0) {
                alert('Queue is empty!');
                return;
            }
            
            const person = queue.shift();
            queue.push(person);
            updateDisplay();
        }
        
        function clearQueue() {
            if (confirm('Clear entire queue?')) {
                queue = [];
                processed = [];
                queueNumber = 1;
                updateDisplay();
            }
        }
        
        function updateDisplay() {
            // Stats
            const priorityCount = queue.filter(p => p.type === 'priority').length;
            const regularCount = queue.filter(p => p.type === 'regular').length;
            
            document.getElementById('stats').innerHTML = `
                <div class="stats">
                    <div class="stat-card">
                        <div class="stat-number">${queue.length}</div>
                        <p>In Queue</p>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">${priorityCount}</div>
                        <p>Priority</p>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">${regularCount}</div>
                        <p>Regular</p>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number">${processed.length}</div>
                        <p>Processed</p>
                    </div>
                </div>
            `;
            
            // Queue display
            let queueHTML = '<h2>Current Queue</h2>';
            if (queue.length === 0) {
                queueHTML += '<p><em>Queue is empty</em></p>';
            } else {
                queueHTML += '<div class="queue-display">';
                queue.forEach((person, index) => {
                    const className = index === 0 ? 'queue-item current' : 
                                    person.type === 'priority' ? 'queue-item priority' : 'queue-item';
                    const badge = person.type === 'priority' ? '⭐ ' : '';
                    const status = index === 0 ? ' (NOW SERVING)' : '';
                    
                    queueHTML += `
                        <div class="${className}">
                            <div>
                                <strong>${badge}#${person.number} - ${person.name}${status}</strong>
                                <div style="font-size: 0.9em; color: #666;">Queued at ${person.time}</div>
                            </div>
                            <div>${person.type === 'priority' ? 'Priority' : 'Regular'}</div>
                        </div>
                    `;
                });
                queueHTML += '</div>';
            }
            document.getElementById('queue').innerHTML = queueHTML;
            
            // Processed display
            let processedHTML = '<h2>Recently Processed (Last 5)</h2>';
            if (processed.length === 0) {
                processedHTML += '<p><em>No processed applications yet</em></p>';
            } else {
                const recent = processed.slice(-5).reverse();
                processedHTML += '<div class="queue-display">';
                recent.forEach(person => {
                    processedHTML += `
                        <div class="queue-item" style="border-left-color: #4caf50; background-color: #e8f5e9;">
                            <div>
                                <strong>✅ #${person.number} - ${person.name}</strong>
                                <div style="font-size: 0.9em; color: #666;">Processed at ${person.processedTime}</div>
                            </div>
                        </div>
                    `;
                });
                processedHTML += '</div>';
            }
            document.getElementById('processed').innerHTML = processedHTML;
        }
        
        // Initialize
        updateDisplay();
    </script>
</body>
</html>
```

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## Mini Project Components

### Validation Functions

```javascript
function validateName(name) {
    if (name.trim() === '') {
        return { valid: false, message: 'Required' };
    }
    if (name.length < 3) {
        return { valid: false, message: 'Too short' };
    }
    return { valid: true, message: '' };
}
```

### Fee Calculation

```javascript
function calculateFee(age, isPWD) {
    const baseFee = 50;
    const isSenior = age >= 60;
    
    if (isSenior && isPWD) return baseFee * 0.70;
    if (isSenior || isPWD) return baseFee * 0.80;
    return baseFee;
}
```

### Array Operations

```javascript
// Add to end
queue.push(item);

// Add to start
queue.unshift(item);

// Remove from start
const item = queue.shift();

// Filter
const seniors = applicants.filter(a => a.age >= 60);

// Map
const names = applicants.map(a => a.name);

// Reduce
const total = fees.reduce((sum, fee) => sum + fee, 0);
```

### DOM Manipulation

```javascript
// Get elements
const input = document.getElementById('name');
const form = document.getElementById('form');

// Set content
element.innerHTML = '<p>Content</p>';
element.textContent = 'Text only';

// Add/remove classes
element.classList.add('active');
element.classList.remove('error');

// Event listeners
form.addEventListener('submit', (e) => {
    e.preventDefault();
    // Handle submission
});
```

</details>

---

**Congratulations!** You've built a complete JavaScript application!

**Next Lesson:** DOM Manipulation!
