# Activity 1: JSON, APIs, Fetch, and Promises

In this activity, you'll learn how to work with **JSON data**, communicate with **APIs**, use the **Fetch API** to make HTTP requests, and handle asynchronous operations with **Promises**. These are essential skills for modern web development.

---

## Activity 1: Understanding JSON

**JSON (JavaScript Object Notation)** is a text format for storing and transporting data. It looks very similar to JavaScript objects.

### JavaScript Object vs JSON:

```javascript
// JavaScript Object (in code)
const resident = {
    name: "Juan Dela Cruz",
    age: 65,
    services: ["Clearance", "ID"]
};

// JSON (text string)
const residentJSON = '{"name":"Juan Dela Cruz","age":65,"services":["Clearance","ID"]}';
```

### Converting Between JavaScript and JSON:

```javascript
// JavaScript object
const resident = {
    name: "Juan Dela Cruz",
    age: 65,
    barangay: "San Jose"
};

// Convert JavaScript object to JSON string
const jsonString = JSON.stringify(resident);
console.log(jsonString);
// '{"name":"Juan Dela Cruz","age":65,"barangay":"San Jose"}'

// Convert JSON string back to JavaScript object
const jsonObject = JSON.parse(jsonString);
console.log(jsonObject.name);  // "Juan Dela Cruz"
```

### HTML Example:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>JSON Example</title>
</head>
<body>
    <h1>Resident Data</h1>
    <button id="showJSON">Show as JSON</button>
    <button id="parseJSON">Parse JSON</button>
    <pre id="output"></pre>

    <script>
        const resident = {
            name: "Maria Santos",
            age: 45,
            address: "123 Main St",
            clearances: ["Barangay", "Police"]
        };
        
        document.getElementById('showJSON').addEventListener('click', () => {
            const json = JSON.stringify(resident, null, 2); // null, 2 adds formatting
            document.getElementById('output').textContent = json;
        });
        
        document.getElementById('parseJSON').addEventListener('click', () => {
            const jsonString = '{"name":"Pedro Reyes","age":70,"barangay":"San Jose"}';
            const obj = JSON.parse(jsonString);
            document.getElementById('output').textContent = 
                `Name: ${obj.name}\nAge: ${obj.age}\nBarangay: ${obj.barangay}`;
        });
    </script>
</body>
</html>
```

**Key JSON Rules:**
- Property names must be in double quotes: `"name"`
- Strings use double quotes: `"Juan"`
- No trailing commas
- No functions or undefined values
- Can have: strings, numbers, booleans, arrays, objects, null

---

## Activity 2: What is an API?

**API (Application Programming Interface)** is a way for different software to communicate. Web APIs let your JavaScript code get data from servers.

### Common API Example - JSONPlaceholder (Free Test API):

```javascript
// API endpoint URL
const apiUrl = 'https://jsonplaceholder.typicode.com/users';

// This API returns fake user data in JSON format
```

### Types of HTTP Methods:

| Method | Purpose | Example |
|--------|---------|---------|
| GET | Retrieve data | Get list of residents |
| POST | Create new data | Add new resident |
| PUT | Update data (full) | Update entire resident record |
| PATCH | Update data (partial) | Update resident's age only |
| DELETE | Delete data | Remove resident |

---

## Activity 3: Introduction to Promises

A **Promise** represents a value that may not be available yet but will be in the future. Perfect for operations that take time (like fetching data from an API).

### Promise States:

```javascript
// Promise has 3 states:
// 1. Pending - Still waiting
// 2. Fulfilled - Completed successfully
// 3. Rejected - Failed with an error

// Creating a Promise
const myPromise = new Promise((resolve, reject) => {
    // Simulate async operation
    setTimeout(() => {
        const success = true;
        if (success) {
            resolve("Data received!");  // Success
        } else {
            reject("Error occurred!");   // Failure
        }
    }, 2000);
});

// Using the Promise
myPromise
    .then(result => {
        console.log(result);  // "Data received!"
    })
    .catch(error => {
        console.error(error);
    });
```

### Practical Example:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Promises Example</title>
</head>
<body>
    <h1>Clearance Processing</h1>
    <button id="processBtn">Process Clearance</button>
    <p id="status">Click to start processing...</p>

    <script>
        function processClearance(name) {
            return new Promise((resolve, reject) => {
                document.getElementById('status').textContent = 'Processing...';
                
                // Simulate processing delay
                setTimeout(() => {
                    const random = Math.random();
                    if (random > 0.2) {  // 80% success rate
                        resolve({
                            name: name,
                            status: "Approved",
                            referenceNumber: "BR-" + Date.now()
                        });
                    } else {
                        reject("Processing failed. Please try again.");
                    }
                }, 2000);
            });
        }
        
        document.getElementById('processBtn').addEventListener('click', () => {
            processClearance("Juan Dela Cruz")
                .then(result => {
                    document.getElementById('status').innerHTML = `
                        <strong>Success!</strong><br>
                        Name: ${result.name}<br>
                        Status: ${result.status}<br>
                        Reference: ${result.referenceNumber}
                    `;
                    document.getElementById('status').style.color = 'green';
                })
                .catch(error => {
                    document.getElementById('status').textContent = error;
                    document.getElementById('status').style.color = 'red';
                });
        });
    </script>
</body>
</html>
```

---

## Activity 4: The Fetch API - Making HTTP Requests

The **Fetch API** is the modern way to make HTTP requests in JavaScript. It returns a Promise.

### Basic GET Request:

```javascript
// Fetch data from API
fetch('https://jsonplaceholder.typicode.com/users/1')
    .then(response => response.json())  // Convert to JavaScript object
    .then(data => {
        console.log(data.name);  // User's name
        console.log(data.email); // User's email
    })
    .catch(error => {
        console.error('Error:', error);
    });
```

### HTML Example:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Fetch Example</title>
    <style>
        .user-card {
            padding: 20px;
            background: #f5f5f5;
            border-radius: 8px;
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <h1>Fetch User Data</h1>
    <button id="fetchBtn">Fetch Users</button>
    <div id="userList"></div>

    <script>
        document.getElementById('fetchBtn').addEventListener('click', () => {
            // Show loading
            document.getElementById('userList').innerHTML = '<p>Loading...</p>';
            
            // Fetch data from API
            fetch('https://jsonplaceholder.typicode.com/users')
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(users => {
                    // Display users
                    const html = users.map(user => `
                        <div class="user-card">
                            <h3>${user.name}</h3>
                            <p>Email: ${user.email}</p>
                            <p>Phone: ${user.phone}</p>
                            <p>City: ${user.address.city}</p>
                        </div>
                    `).join('');
                    
                    document.getElementById('userList').innerHTML = html;
                })
                .catch(error => {
                    document.getElementById('userList').innerHTML = 
                        `<p style="color: red;">Error: ${error.message}</p>`;
                });
        });
    </script>
</body>
</html>
```

---

## Activity 5: POST Request - Sending Data to API

Use POST to send data to a server.

```javascript
// Data to send
const newResident = {
    name: "Juan Dela Cruz",
    age: 65,
    clearanceType: "Barangay Clearance"
};

// POST request
fetch('https://jsonplaceholder.typicode.com/posts', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json'
    },
    body: JSON.stringify(newResident)  // Convert to JSON string
})
    .then(response => response.json())
    .then(data => {
        console.log('Success:', data);
    })
    .catch(error => {
        console.error('Error:', error);
    });
```

### Complete Example:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>POST Request Example</title>
    <style>
        form {
            max-width: 500px;
            padding: 20px;
            background: #f9f9f9;
            border-radius: 8px;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        
        input {
            width: 100%;
            padding: 8px;
            border: 2px solid #ddd;
            border-radius: 5px;
        }
        
        button {
            padding: 10px 20px;
            background: #4caf50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        
        #result {
            margin-top: 20px;
            padding: 15px;
            border-radius: 5px;
        }
        
        .success {
            background: #e8f5e9;
            color: #2e7d32;
        }
        
        .error {
            background: #ffebee;
            color: #c62828;
        }
    </style>
</head>
<body>
    <h1>Submit Clearance Application</h1>
    
    <form id="applicationForm">
        <div class="form-group">
            <label for="name">Name:</label>
            <input type="text" id="name" required>
        </div>
        
        <div class="form-group">
            <label for="age">Age:</label>
            <input type="number" id="age" required>
        </div>
        
        <div class="form-group">
            <label for="clearanceType">Clearance Type:</label>
            <input type="text" id="clearanceType" value="Barangay Clearance" required>
        </div>
        
        <button type="submit">Submit</button>
    </form>
    
    <div id="result"></div>

    <script>
        document.getElementById('applicationForm').addEventListener('submit', (event) => {
            event.preventDefault();
            
            // Get form data
            const applicationData = {
                name: document.getElementById('name').value,
                age: parseInt(document.getElementById('age').value),
                clearanceType: document.getElementById('clearanceType').value,
                date: new Date().toISOString()
            };
            
            // Show loading
            const resultDiv = document.getElementById('result');
            resultDiv.textContent = 'Submitting...';
            resultDiv.className = '';
            
            // Send POST request
            fetch('https://jsonplaceholder.typicode.com/posts', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(applicationData)
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Submission failed');
                    }
                    return response.json();
                })
                .then(data => {
                    resultDiv.innerHTML = `
                        <strong>✅ Application Submitted Successfully!</strong><br>
                        Reference ID: ${data.id}<br>
                        Name: ${applicationData.name}<br>
                        Age: ${applicationData.age}<br>
                        Type: ${applicationData.clearanceType}
                    `;
                    resultDiv.className = 'success';
                    
                    // Reset form
                    event.target.reset();
                })
                .catch(error => {
                    resultDiv.textContent = `❌ Error: ${error.message}`;
                    resultDiv.className = 'error';
                });
        });
    </script>
</body>
</html>
```

---

## Activity 6: Async/Await - Cleaner Promise Syntax

**async/await** makes Promise code look synchronous and easier to read.

### Promise Chain vs Async/Await:

```javascript
// Using .then() (older style)
function fetchUserData() {
    fetch('https://jsonplaceholder.typicode.com/users/1')
        .then(response => response.json())
        .then(data => {
            console.log(data.name);
        })
        .catch(error => {
            console.error(error);
        });
}

// Using async/await (modern style)
async function fetchUserData() {
    try {
        const response = await fetch('https://jsonplaceholder.typicode.com/users/1');
        const data = await response.json();
        console.log(data.name);
    } catch (error) {
        console.error(error);
    }
}
```

### Complete Example with Async/Await:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Async/Await Example</title>
    <style>
        .resident-card {
            padding: 15px;
            background: #e8f5e9;
            border-radius: 8px;
            margin: 10px 0;
            border-left: 4px solid #4caf50;
        }
        
        .loading {
            color: #1976d2;
            font-style: italic;
        }
        
        .error {
            color: #c62828;
            background: #ffebee;
            padding: 15px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <h1>Barangay Resident Directory</h1>
    <button id="loadBtn">Load Residents</button>
    <button id="addBtn">Add New Resident</button>
    <div id="residentList"></div>

    <script>
        const API_URL = 'https://jsonplaceholder.typicode.com/users';
        
        // GET request with async/await
        async function loadResidents() {
            const listDiv = document.getElementById('residentList');
            
            try {
                listDiv.innerHTML = '<p class="loading">Loading residents...</p>';
                
                const response = await fetch(API_URL);
                
                if (!response.ok) {
                    throw new Error(`HTTP error! Status: ${response.status}`);
                }
                
                const residents = await response.json();
                
                // Display residents
                const html = residents.slice(0, 5).map(resident => `
                    <div class="resident-card">
                        <h3>${resident.name}</h3>
                        <p><strong>Email:</strong> ${resident.email}</p>
                        <p><strong>Phone:</strong> ${resident.phone}</p>
                        <p><strong>Address:</strong> ${resident.address.street}, ${resident.address.city}</p>
                    </div>
                `).join('');
                
                listDiv.innerHTML = html;
                
            } catch (error) {
                listDiv.innerHTML = `<div class="error">Error loading residents: ${error.message}</div>`;
            }
        }
        
        // POST request with async/await
        async function addResident() {
            const listDiv = document.getElementById('residentList');
            
            try {
                listDiv.innerHTML = '<p class="loading">Adding resident...</p>';
                
                const newResident = {
                    name: "Juan Dela Cruz",
                    email: "juan@barangay.ph",
                    phone: "0912-345-6789",
                    address: {
                        street: "123 Main St",
                        city: "Manila"
                    }
                };
                
                const response = await fetch('https://jsonplaceholder.typicode.com/users', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(newResident)
                });
                
                if (!response.ok) {
                    throw new Error('Failed to add resident');
                }
                
                const result = await response.json();
                
                listDiv.innerHTML = `
                    <div class="resident-card">
                        <h3>✅ Resident Added Successfully!</h3>
                        <p><strong>ID:</strong> ${result.id}</p>
                        <p><strong>Name:</strong> ${newResident.name}</p>
                        <p><strong>Email:</strong> ${newResident.email}</p>
                    </div>
                `;
                
            } catch (error) {
                listDiv.innerHTML = `<div class="error">Error: ${error.message}</div>`;
            }
        }
        
        // Event listeners
        document.getElementById('loadBtn').addEventListener('click', loadResidents);
        document.getElementById('addBtn').addEventListener('click', addResident);
    </script>
</body>
</html>
```

---

## Activity 7: Complete Barangay System with API

Let's build a complete system that fetches, displays, and manages residents using an API.

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Barangay Management System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            background: #f5f5f5;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        h1 {
            color: #2c3e50;
            margin-bottom: 20px;
        }
        
        .controls {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        
        button {
            padding: 10px 20px;
            background: #4caf50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }
        
        button:hover {
            background: #45a049;
        }
        
        button:disabled {
            background: #cccccc;
            cursor: not-allowed;
        }
        
        .search-box {
            flex: 1;
            padding: 10px;
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        
        .resident-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        
        .resident-card {
            padding: 20px;
            background: #e8f5e9;
            border-radius: 8px;
            border-left: 4px solid #4caf50;
            transition: transform 0.2s;
        }
        
        .resident-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .resident-card h3 {
            color: #2e7d32;
            margin-bottom: 10px;
        }
        
        .resident-card p {
            margin: 5px 0;
            color: #555;
        }
        
        .loading {
            text-align: center;
            padding: 40px;
            color: #1976d2;
            font-size: 18px;
        }
        
        .error {
            background: #ffebee;
            color: #c62828;
            padding: 20px;
            border-radius: 5px;
            margin: 20px 0;
        }
        
        .stats {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .stat-card {
            flex: 1;
            padding: 20px;
            background: #e3f2fd;
            border-radius: 8px;
            text-align: center;
        }
        
        .stat-card h2 {
            color: #1976d2;
            font-size: 2em;
            margin-bottom: 5px;
        }
        
        .stat-card p {
            color: #666;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏘️ Barangay Resident Management System</h1>
        
        <div class="stats" id="stats"></div>
        
        <div class="controls">
            <input type="text" class="search-box" id="searchBox" placeholder="Search residents by name...">
            <button id="loadBtn">Load All</button>
            <button id="refreshBtn">Refresh</button>
        </div>
        
        <div id="residentList"></div>
    </div>

    <script>
        const API_URL = 'https://jsonplaceholder.typicode.com/users';
        let allResidents = [];
        
        // Load residents from API
        async function loadResidents() {
            const listDiv = document.getElementById('residentList');
            const loadBtn = document.getElementById('loadBtn');
            
            try {
                // Disable button and show loading
                loadBtn.disabled = true;
                listDiv.innerHTML = '<div class="loading">🔄 Loading residents from API...</div>';
                
                // Fetch data
                const response = await fetch(API_URL);
                
                if (!response.ok) {
                    throw new Error(`HTTP Error: ${response.status}`);
                }
                
                const data = await response.json();
                allResidents = data;
                
                // Display residents
                displayResidents(allResidents);
                updateStats(allResidents);
                
            } catch (error) {
                listDiv.innerHTML = `<div class="error">❌ Error loading residents: ${error.message}</div>`;
            } finally {
                loadBtn.disabled = false;
            }
        }
        
        // Display residents
        function displayResidents(residents) {
            const listDiv = document.getElementById('residentList');
            
            if (residents.length === 0) {
                listDiv.innerHTML = '<p style="text-align: center; color: #999;">No residents found</p>';
                return;
            }
            
            const html = residents.map(resident => `
                <div class="resident-card">
                    <h3>${resident.name}</h3>
                    <p><strong>📧 Email:</strong> ${resident.email}</p>
                    <p><strong>📞 Phone:</strong> ${resident.phone}</p>
                    <p><strong>🏠 Address:</strong> ${resident.address.street}</p>
                    <p><strong>🌆 City:</strong> ${resident.address.city}</p>
                    <p><strong>💼 Company:</strong> ${resident.company.name}</p>
                </div>
            `).join('');
            
            listDiv.innerHTML = `<div class="resident-grid">${html}</div>`;
        }
        
        // Update statistics
        function updateStats(residents) {
            const statsDiv = document.getElementById('stats');
            
            const totalResidents = residents.length;
            const totalCities = new Set(residents.map(r => r.address.city)).size;
            const totalCompanies = new Set(residents.map(r => r.company.name)).size;
            
            statsDiv.innerHTML = `
                <div class="stat-card">
                    <h2>${totalResidents}</h2>
                    <p>Total Residents</p>
                </div>
                <div class="stat-card">
                    <h2>${totalCities}</h2>
                    <p>Cities</p>
                </div>
                <div class="stat-card">
                    <h2>${totalCompanies}</h2>
                    <p>Companies</p>
                </div>
            `;
        }
        
        // Search residents
        function searchResidents(query) {
            if (!query.trim()) {
                displayResidents(allResidents);
                return;
            }
            
            const filtered = allResidents.filter(resident => 
                resident.name.toLowerCase().includes(query.toLowerCase()) ||
                resident.email.toLowerCase().includes(query.toLowerCase()) ||
                resident.address.city.toLowerCase().includes(query.toLowerCase())
            );
            
            displayResidents(filtered);
        }
        
        // Event listeners
        document.getElementById('loadBtn').addEventListener('click', loadResidents);
        document.getElementById('refreshBtn').addEventListener('click', loadResidents);
        
        document.getElementById('searchBox').addEventListener('input', (e) => {
            searchResidents(e.target.value);
        });
        
        // Auto-load on page load
        loadResidents();
    </script>
</body>
</html>
```

---

## 📚 Answer Key: JSON, APIs, Fetch, Promises

### JSON Methods

| Method | Purpose | Example |
|--------|---------|---------|
| `JSON.stringify(obj)` | Convert JS object to JSON string | `JSON.stringify({name: "Juan"})` |
| `JSON.parse(str)` | Convert JSON string to JS object | `JSON.parse('{"name":"Juan"}')` |

### Fetch API Syntax

```javascript
// GET request
fetch(url)
    .then(response => response.json())
    .then(data => console.log(data))
    .catch(error => console.error(error));

// POST request
fetch(url, {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json'
    },
    body: JSON.stringify(data)
})
    .then(response => response.json())
    .then(data => console.log(data))
    .catch(error => console.error(error));
```

### Promise Chaining

```javascript
fetch(url)
    .then(response => response.json())     // Parse JSON
    .then(data => processData(data))       // Process data
    .then(result => displayResult(result)) // Display
    .catch(error => handleError(error))    // Handle errors
    .finally(() => hideLoading());         // Always runs
```

### Async/Await Conversion

**Promise Chain:**
```javascript
function getData() {
    fetch(url)
        .then(response => response.json())
        .then(data => console.log(data))
        .catch(error => console.error(error));
}
```

**Async/Await:**
```javascript
async function getData() {
    try {
        const response = await fetch(url);
        const data = await response.json();
        console.log(data);
    } catch (error) {
        console.error(error);
    }
}
```

### Common HTTP Status Codes

| Code | Meaning |
|------|---------|
| 200 | OK - Success |
| 201 | Created - Resource created |
| 400 | Bad Request - Invalid data |
| 401 | Unauthorized - Need authentication |
| 404 | Not Found - Resource doesn't exist |
| 500 | Server Error - Server problem |

### Error Handling

```javascript
async function fetchData() {
    try {
        const response = await fetch(url);
        
        // Check if response is OK
        if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
        }
        
        const data = await response.json();
        return data;
        
    } catch (error) {
        console.error('Fetch error:', error.message);
        throw error; // Re-throw if needed
    }
}
```

---

## 🎯 Key Takeaways

1. **JSON** is a text format for data exchange (use `JSON.stringify()` and `JSON.parse()`)
2. **APIs** let your app communicate with servers
3. **Fetch API** makes HTTP requests (returns Promises)
4. **Promises** handle asynchronous operations (.then/.catch)
5. **async/await** makes Promise code cleaner and easier to read
6. Always handle errors with try/catch or .catch()
7. Check `response.ok` before parsing JSON

---

## 🚀 Practice Challenge

Create a complete **Barangay Service Application System** that:
- Fetches list of available services from an API
- Displays services in cards
- Has a form to submit new application (POST request)
- Shows loading state while fetching
- Handles errors gracefully
- Uses async/await for all API calls
- Displays success/error messages

Good luck! 🎉
