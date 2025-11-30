## Background Story

Tian's barangay website displayed resident information, service lists, and announcements. But all the data was hardcoded in the JavaScript file:

```javascript
let residents = [
    { name: "Juan Dela Cruz", age: 34, service: "Clearance" },
    { name: "Maria Santos", age: 28, service: "Barangay ID" },
    // ...45 more hardcoded objects
];

let announcements = [
    { title: "Community Meeting", date: "May 15", description: "..." },
    { title: "Health Program", date: "May 20", description: "..." },
    // ...10 more hardcoded announcements
];
```

Every time the barangay office updated resident records or posted new announcements, Tian had to manually edit the JavaScript file, find the correct array, add or modify objects, save, and redeploy. It was tedious, error-prone, and completely impractical for a real system.

Worse, the data wasn't dynamic. When a new resident applied for a service, the website wouldn't show it until Tian manually added it to the code. The website was essentially a static snapshot, not a live system connected to actual data.

Rhea Joy was building a weather widget for the barangay website—showing current temperature and conditions in Batangas City. She needed real-time weather data, but she only had:

```javascript
let weather = {
    temperature: "28°C",
    condition: "Partly Cloudy",
    humidity: "75%"
};
```

Hardcoded fake data. The "current weather" would be the same whether it was actually sunny, rainy, or stormy outside. She'd seen weather websites that showed real, live data. How did they do it?

Both of them realized a fundamental limitation: their JavaScript could only work with data that existed in the code itself. They couldn't fetch data from databases, APIs, or external sources. Their applications were isolated, static, and disconnected from the real world.

It was Sunday afternoon, and they were researching "how to get data from server JavaScript." Every answer mentioned the same concepts:

- **API**: Application Programming Interface—a way for applications to communicate
- **JSON**: JavaScript Object Notation—a data format for transferring information
- **Fetch**: JavaScript's built-in method for making network requests
- **Promises**: A way to handle asynchronous operations

They found a free weather API and saw an example:

```javascript
fetch('https://api.weather.com/current?city=Batangas')
    .then(response => response.json())
    .then(data => {
        console.log(data.temperature);
    });
```

They copied it, modified the URL, and ran it. The console logged real, live temperature data from an actual weather service. For the first time, their JavaScript had communicated with an external server and retrieved dynamic data.

Rhea Joy's eyes widened. "This is how real apps work! They don't hardcode data. They fetch it from APIs!"

"And that means," Tian added excitedly, "when we build the backend with Flask, our frontend JavaScript can fetch data from our own API instead of having hardcoded arrays. The website will be live—connected to a real database."

But they'd just copied code without understanding it. What's an API? What's JSON? How does `fetch()` work? What are Promises and why the `.then()` syntax? How do you handle errors? How do you send data to servers, not just receive it?

They called Kuya Miguel.

"Kuya, we've been using hardcoded data, but real apps fetch data from servers. We discovered the Fetch API and got it working, but we don't understand how it works. Can you teach us APIs, JSON, Fetch, Promises, and how to properly communicate with servers from JavaScript?"

Miguel smiled. "You've reached the bridge between frontend and backend—the moment when your isolated JavaScript application becomes connected to the wider world. Today we're learning JSON data format, what APIs are, how to use the Fetch API, Promises and async/await, handling responses and errors, and making GET and POST requests. By the end of this lesson, your barangay website will be ready to communicate with any API—including the Flask backend you'll build soon."

---

## Theory & Lecture Content

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

---

## Closing Story

Tian fetched data from a real API using `fetch()`. The response came back in JSON. Parsed it, displayed it on the page. The barangay portal was no longer using hardcoded datait was pulling from external sources.

"APIs are how the web communicates," Kuya Miguel said. "Every app fetches data from servers. Weather apps, social media, e-commerceall API-driven."

Tian handled promises, async/await, error catching. The code was robust. Production-ready. This was full-stack thinking.

_Next up: Dynamic Barangay Info Pagemini project!_