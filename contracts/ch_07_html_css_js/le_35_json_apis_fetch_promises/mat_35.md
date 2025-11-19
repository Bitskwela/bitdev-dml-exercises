# Lesson 35: JSON, APIs, and Fetch - Getting Data from Servers

---

## Connecting to External Data

"Kuya Miguel, all our data is hardcoded. How do real apps get data from servers?" Tian asked.

Rhea Joy added, "Like weather apps, news feeds, barangay records from a database?"

Kuya Miguel nodded. "Using **APIs** (Application Programming Interfaces) and the **Fetch API**. You request data from a server, it responds with JSON, and you display it. Let's learn!"

---

## What is JSON?

**JSON = JavaScript Object Notation**

Data format for storing and transmitting structured data.

**Example:**
```json
{
    "name": "Juan Dela Cruz",
    "age": 30,
    "barangay": "San Antonio",
    "services": ["Clearance", "ID"],
    "isPWD": false
}
```

**Looks like JavaScript object, but:**
- Property names in double quotes
- Strings in double quotes
- No functions or comments
- Used across all programming languages

---

## JSON Methods

### JSON.stringify() - Object to JSON string

```javascript
let person = {
    name: 'Juan',
    age: 30,
    barangay: 'San Antonio'
};

let jsonString = JSON.stringify(person);
console.log(jsonString);
// {"name":"Juan","age":30,"barangay":"San Antonio"}

// Save to localStorage
localStorage.setItem('resident', jsonString);
```

### JSON.parse() - JSON string to Object

```javascript
let jsonString = '{"name":"Juan","age":30}';

let person = JSON.parse(jsonString);
console.log(person.name); // Juan
console.log(person.age);  // 30

// Get from localStorage
let stored = localStorage.getItem('resident');
let resident = JSON.parse(stored);
```

---

## What is an API?

**API = Application Programming Interface**

A way for programs to communicate with each other.

**Web API:** Server provides data via URLs (endpoints)

**Example API endpoints:**
```
GET https://api.barangay.gov.ph/services
GET https://api.barangay.gov.ph/services/1
POST https://api.barangay.gov.ph/applications
```

**Response (JSON):**
```json
{
    "success": true,
    "data": [
        {"id": 1, "name": "Clearance", "fee": 50},
        {"id": 2, "name": "ID", "fee": 30}
    ]
}
```

---

## The Fetch API

**Modern way to make HTTP requests:**

```javascript
fetch('https://api.example.com/data')
    .then(response => response.json())
    .then(data => {
        console.log(data);
    })
    .catch(error => {
        console.error('Error:', error);
    });
```

**Fetch returns a Promise** (asynchronous operation)

---

## Basic GET Request

```javascript
// Get barangay services
fetch('https://api.barangay.gov.ph/services')
    .then(response => {
        if (!response.ok) {
            throw new Error('Network error');
        }
        return response.json(); // Parse JSON
    })
    .then(data => {
        console.log(data); // Use the data
        displayServices(data);
    })
    .catch(error => {
        console.error('Fetch error:', error);
    });
```

---

## Async/Await Syntax (Cleaner)

```javascript
async function getServices() {
    try {
        let response = await fetch('https://api.barangay.gov.ph/services');
        
        if (!response.ok) {
            throw new Error('Network error');
        }
        
        let data = await response.json();
        console.log(data);
        return data;
        
    } catch (error) {
        console.error('Error:', error);
    }
}

// Call the function
getServices();
```

**Benefits:**
- Reads like synchronous code
- Easier error handling with try/catch
- Cleaner than chaining `.then()`

---

## POST Request (Sending Data)

```javascript
async function submitApplication(applicationData) {
    try {
        let response = await fetch('https://api.barangay.gov.ph/applications', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(applicationData)
        });
        
        let result = await response.json();
        console.log('Success:', result);
        
    } catch (error) {
        console.error('Error:', error);
    }
}

// Usage
let application = {
    name: 'Juan Dela Cruz',
    service: 'Clearance',
    fee: 50
};

submitApplication(application);
```

---

## Complete Barangay Example

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Barangay Services - Fetch API</title>
    <style>
        .service-card {
            border: 1px solid #ddd;
            padding: 15px;
            margin: 10px 0;
            border-radius: 5px;
        }
        .loading {
            color: #007bff;
            font-weight: bold;
        }
        .error {
            color: #dc3545;
            padding: 10px;
            background: #f8d7da;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <h1>Barangay Services</h1>
    
    <button id="loadBtn">Load Services</button>
    <button id="addBtn">Add Random Service</button>
    
    <div id="output"></div>
    
    <script>
        // Using JSONPlaceholder as demo API
        const API_URL = 'https://jsonplaceholder.typicode.com/posts';
        
        // Get services
        async function loadServices() {
            let output = document.querySelector('#output');
            output.innerHTML = '<p class="loading">Loading services...</p>';
            
            try {
                let response = await fetch(API_URL + '?_limit=5');
                
                if (!response.ok) {
                    throw new Error('Failed to fetch services');
                }
                
                let services = await response.json();
                
                displayServices(services);
                
            } catch (error) {
                output.innerHTML = `<div class="error">Error: ${error.message}</div>`;
            }
        }
        
        // Display services
        function displayServices(services) {
            let output = document.querySelector('#output');
            
            let html = '<h2>Available Services</h2>';
            
            html += services.map(service => `
                <div class="service-card">
                    <h3>Service ID: ${service.id}</h3>
                    <p><strong>Title:</strong> ${service.title}</p>
                    <p><strong>Description:</strong> ${service.body.substring(0, 100)}...</p>
                </div>
            `).join('');
            
            output.innerHTML = html;
        }
        
        // Add new service
        async function addService() {
            let output = document.querySelector('#output');
            output.innerHTML = '<p class="loading">Submitting application...</p>';
            
            let newService = {
                title: 'Barangay Clearance',
                body: 'Application for barangay clearance certificate',
                userId: 1
            };
            
            try {
                let response = await fetch(API_URL, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(newService)
                });
                
                if (!response.ok) {
                    throw new Error('Failed to submit');
                }
                
                let result = await response.json();
                
                output.innerHTML = `
                    <div style="background: #d4edda; padding: 15px; border-radius: 5px;">
                        <h3>✅ Application Submitted!</h3>
                        <p>Application ID: ${result.id}</p>
                        <p>Title: ${result.title}</p>
                    </div>
                `;
                
            } catch (error) {
                output.innerHTML = `<div class="error">Error: ${error.message}</div>`;
            }
        }
        
        // Event listeners
        document.querySelector('#loadBtn').addEventListener('click', loadServices);
        document.querySelector('#addBtn').addEventListener('click', addService);
        
        // Load on page load
        loadServices();
    </script>
</body>
</html>
```

---

## Error Handling Best Practices

```javascript
async function fetchData(url) {
    try {
        let response = await fetch(url);
        
        // Check HTTP status
        if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
        }
        
        let data = await response.json();
        return data;
        
    } catch (error) {
        // Network error or JSON parse error
        console.error('Fetch error:', error);
        return null;
    }
}
```

---

## Common Fetch Patterns

### 1. Loading State
```javascript
async function getData() {
    showLoading(true);
    
    try {
        let data = await fetch(url).then(r => r.json());
        displayData(data);
    } catch (error) {
        showError(error.message);
    } finally {
        showLoading(false); // Always hide loading
    }
}
```

### 2. Timeout
```javascript
async function fetchWithTimeout(url, timeout = 5000) {
    let controller = new AbortController();
    let timeoutId = setTimeout(() => controller.abort(), timeout);
    
    try {
        let response = await fetch(url, {signal: controller.signal});
        clearTimeout(timeoutId);
        return await response.json();
    } catch (error) {
        if (error.name === 'AbortError') {
            throw new Error('Request timed out');
        }
        throw error;
    }
}
```

### 3. Retry on Failure
```javascript
async function fetchWithRetry(url, retries = 3) {
    for (let i = 0; i < retries; i++) {
        try {
            let response = await fetch(url);
            return await response.json();
        } catch (error) {
            if (i === retries - 1) throw error;
            await new Promise(resolve => setTimeout(resolve, 1000)); // Wait 1s
        }
    }
}
```

---

## Summary

**JSON:**
```javascript
JSON.stringify(object); // Object → JSON string
JSON.parse(jsonString); // JSON string → Object
```

**Fetch API:**
```javascript
// GET
let data = await fetch(url).then(r => r.json());

// POST
await fetch(url, {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify(data)
});
```

**Async/Await:**
```javascript
async function getData() {
    try {
        let response = await fetch(url);
        let data = await response.json();
        return data;
    } catch (error) {
        console.error(error);
    }
}
```

---

## What's Next?

In the next lesson, you'll build a **Dynamic Barangay Info Page**—a mini project combining DOM, events, fetch, and all modern JavaScript techniques!

---
