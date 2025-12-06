# Quiz: JSON, APIs, and Fetch

---

## Quiz 1

**1. What does JSON stand for?**

a) Java Serialized Object Notation  
b) JavaScript Object Notation  
c) JavaScript Online Network  
d) Java Standard Object Names

**Answer: b**

JSON stands for JavaScript Object Notation - a lightweight data format for storing and transmitting structured data.

---

**2. How do you convert a JavaScript object to JSON string?**

a) `JSON.parse(object)`  
b) `JSON.stringify(object)`  
c) `object.toJSON()`  
d) `String(object)`

**Answer: b**

Use `JSON.stringify(object)` to convert a JavaScript object into a JSON string.

---

**3. What does `fetch()` return?**

a) Data directly  
b) A Promise  
c) A callback  
d) An error

**Answer: b**

`fetch()` returns a Promise that resolves to the Response object. Use `.then()` or `await` to get the data.

---

**4. How do you send data to a server with fetch?**

a) Use GET method  
b) Use POST method with body  
c) Use DELETE method  
d) Fetch can't send data

**Answer: b**

Use POST method with `body` containing JSON data to send data to the server.

---

**5. What's the difference between `.then()` and `async/await`?**

a) No difference, just syntax  
b) async/await is faster  
c) .then() is deprecated  
d) async/await doesn't work with fetch

**Answer: a**

No functional difference, just syntax preference. `async/await` makes asynchronous code look more synchronous and readable.

---

## Quiz 2

**6. What does `response.json()` do?**

a) Creates JSON file  
b) Parses response body as JSON  
c) Sends JSON to server  
d) Validates JSON format

**Answer: b**

`response.json()` parses the response body as JSON and returns a Promise that resolves to the parsed data.

---

**7. How do you handle fetch errors?**

a) `try/catch` block  
b) `.catch()` method  
c) Both a and b  
d) Errors can't be caught

**Answer: c**

Both `try/catch` (with async/await) and `.catch()` method (with .then()) can handle fetch errors.

---

**8. What HTTP method is used to get data?**

a) POST  
b) GET  
c) PUT  
d) DELETE

**Answer: b**

GET is the HTTP method used to retrieve/read data from a server.

---

**9. What does `response.ok` check?**

a) If JSON is valid  
b) If HTTP status is 200-299  
c) If data exists  
d) If server is online

**Answer: b**

`response.ok` is `true` if the HTTP status code is in the 200-299 range (successful response).

---

**10. What's an API endpoint?**

a) The end of the code  
b) A URL where you can request data  
c) A JavaScript function  
d) A database connection

**Answer: b**

An API endpoint is a specific URL where you can send requests to access or manipulate data.

---

## Detailed Explanations

### Question 1: JSON Definition

**Correct Answer: b) JavaScript Object Notation**

JSON is a lightweight data format for storing and transmitting structured data.

```json
{
    "name": "Juan Dela Cruz",
    "age": 30,
    "barangay": "San Antonio",
    "services": ["Clearance", "ID"],
    "isActive": true
}
```

**Key rules:**
- Property names in double quotes
- Strings in double quotes
- No functions, comments, or trailing commas
- Data types: string, number, boolean, array, object, null

**Barangay example:**
```json
{
    "applicationId": "APP-001",
    "applicant": {
        "name": "Maria Santos",
        "age": 28,
        "isPWD": false
    },
    "services": [
        {"name": "Clearance", "fee": 50},
        {"name": "ID", "fee": 30}
    ],
    "totalFee": 80,
    "status": "pending"
}
```

---

### Question 2: Object to JSON

**Correct Answer: b) `JSON.stringify(object)`**

```javascript
let resident = {
    name: 'Juan Dela Cruz',
    age: 30,
    barangay: 'San Antonio'
};

// Convert to JSON string
let jsonString = JSON.stringify(resident);
console.log(jsonString);
// {"name":"Juan Dela Cruz","age":30,"barangay":"San Antonio"}

// Save to localStorage
localStorage.setItem('resident', jsonString);

// Pretty print (indented)
let pretty = JSON.stringify(resident, null, 2);
console.log(pretty);
/*
{
  "name": "Juan Dela Cruz",
  "age": 30,
  "barangay": "San Antonio"
}
*/
```

**Barangay example - saving form data:**
```javascript
let application = {
    id: 'APP-' + Date.now(),
    applicant: document.querySelector('#name').value,
    service: document.querySelector('#service').value,
    date: new Date().toISOString()
};

// Save to localStorage
let saved = JSON.stringify(application);
localStorage.setItem('lastApplication', saved);

// Retrieve later
let retrieved = localStorage.getItem('lastApplication');
let app = JSON.parse(retrieved);
console.log(app.applicant); // Access properties
```

---

### Question 3: Fetch Return Value

**Correct Answer: b) A Promise**

`fetch()` returns a Promise that resolves to a Response object.

```javascript
let promise = fetch('https://api.example.com/data');

// Handle with .then()
promise
    .then(response => response.json())
    .then(data => console.log(data));

// Or with async/await
async function getData() {
    let response = await fetch('https://api.example.com/data');
    let data = await response.json();
    return data;
}
```

**Barangay example:**
```javascript
async function getBarangayServices() {
    try {
        // fetch returns Promise
        let response = await fetch('https://api.barangay.gov.ph/services');
        
        // response.json() also returns Promise
        let services = await response.json();
        
        console.log(services);
        return services;
        
    } catch (error) {
        console.error('Error loading services:', error);
    }
}
```

---

### Question 4: Sending Data

**Correct Answer: b) Use POST method with body**

```javascript
async function submitApplication(data) {
    let response = await fetch('https://api.barangay.gov.ph/applications', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    });
    
    let result = await response.json();
    return result;
}

// Usage
let application = {
    name: 'Juan Dela Cruz',
    service: 'Clearance',
    fee: 50
};

submitApplication(application);
```

**Barangay example - form submission:**
```javascript
document.querySelector('#submitBtn').addEventListener('click', async () => {
    let formData = {
        applicant: document.querySelector('#name').value,
        age: parseInt(document.querySelector('#age').value),
        service: document.querySelector('#service').value,
        isSenior: document.querySelector('#senior').checked
    };
    
    try {
        let response = await fetch('https://api.barangay.gov.ph/apply', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(formData)
        });
        
        let result = await response.json();
        
        alert(`Application submitted! ID: ${result.id}`);
    } catch (error) {
        alert('Submission failed: ' + error.message);
    }
});
```

---

### Question 5: .then() vs async/await

**Correct Answer: a) No difference, just syntax**

Both handle Promises, async/await is just cleaner syntax:

```javascript
// Using .then()
function getDataThen() {
    fetch(url)
        .then(response => response.json())
        .then(data => {
            console.log(data);
            return data;
        })
        .catch(error => {
            console.error(error);
        });
}

// Using async/await (cleaner)
async function getDataAsync() {
    try {
        let response = await fetch(url);
        let data = await response.json();
        console.log(data);
        return data;
    } catch (error) {
        console.error(error);
    }
}
```

**Barangay example - both styles:**
```javascript
// Style 1: .then() chaining
function loadServices() {
    fetch('https://api.barangay.gov.ph/services')
        .then(response => response.json())
        .then(services => {
            displayServices(services);
        })
        .catch(error => {
            showError(error.message);
        });
}

// Style 2: async/await (preferred)
async function loadServices() {
    try {
        let response = await fetch('https://api.barangay.gov.ph/services');
        let services = await response.json();
        displayServices(services);
    } catch (error) {
        showError(error.message);
    }
}
```

---

### Question 6: response.json()

**Correct Answer: b) Parses response body as JSON**

```javascript
let response = await fetch(url);

// response is Response object, not data yet
console.log(response); // Response {status: 200, ...}

// Extract JSON from response body
let data = await response.json();
console.log(data); // Actual data {name: "Juan", ...}
```

**Other methods:**
```javascript
await response.text();  // Get as plain text
await response.blob();  // Get as binary data (images, files)
await response.json();  // Parse as JSON
```

**Barangay example:**
```javascript
async function getServiceDetails(id) {
    let response = await fetch(`https://api.barangay.gov.ph/services/${id}`);
    
    // Check if successful
    if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
    }
    
    // Parse JSON
    let service = await response.json();
    /*
    {
        "id": 1,
        "name": "Barangay Clearance",
        "fee": 50,
        "available": true
    }
    */
    
    return service;
}
```

---

### Question 7: Error Handling

**Correct Answer: c) Both a and b**

```javascript
// Method 1: try/catch with async/await
async function getData() {
    try {
        let response = await fetch(url);
        let data = await response.json();
        return data;
    } catch (error) {
        console.error('Error:', error);
    }
}

// Method 2: .catch() with .then()
fetch(url)
    .then(response => response.json())
    .then(data => console.log(data))
    .catch(error => console.error('Error:', error));
```

**Barangay example - comprehensive error handling:**
```javascript
async function loadBarangayData() {
    try {
        let response = await fetch('https://api.barangay.gov.ph/data');
        
        // Check HTTP status
        if (!response.ok) {
            if (response.status === 404) {
                throw new Error('Data not found');
            } else if (response.status === 500) {
                throw new Error('Server error');
            } else {
                throw new Error(`HTTP error! Status: ${response.status}`);
            }
        }
        
        let data = await response.json();
        return data;
        
    } catch (error) {
        // Network error or JSON parse error
        console.error('Failed to load data:', error);
        showErrorMessage(error.message);
        return null;
    }
}
```

---

### Question 8: HTTP GET Method

**Correct Answer: b) GET**

**HTTP Methods:**
- **GET** - Retrieve data (default)
- **POST** - Create new data
- **PUT** - Update entire resource
- **PATCH** - Update part of resource
- **DELETE** - Delete resource

```javascript
// GET (default)
fetch('https://api.barangay.gov.ph/services'); // Gets all services

// POST
fetch(url, {method: 'POST', body: data}); // Creates new

// PUT
fetch(url + '/1', {method: 'PUT', body: data}); // Updates ID 1

// DELETE
fetch(url + '/1', {method: 'DELETE'}); // Deletes ID 1
```

**Barangay example:**
```javascript
// GET - retrieve services
async function getServices() {
    let response = await fetch('https://api.barangay.gov.ph/services');
    return await response.json();
}

// POST - create application
async function createApplication(data) {
    let response = await fetch('https://api.barangay.gov.ph/applications', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify(data)
    });
    return await response.json();
}

// PUT - update application
async function updateApplication(id, data) {
    let response = await fetch(`https://api.barangay.gov.ph/applications/${id}`, {
        method: 'PUT',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify(data)
    });
    return await response.json();
}

// DELETE - cancel application
async function deleteApplication(id) {
    await fetch(`https://api.barangay.gov.ph/applications/${id}`, {
        method: 'DELETE'
    });
}
```

---

### Question 9: response.ok

**Correct Answer: b) If HTTP status is 200-299**

```javascript
let response = await fetch(url);

if (response.ok) {
    // Status 200-299 (success)
    let data = await response.json();
} else {
    // Status 400+, 500+ (error)
    console.error('HTTP error:', response.status);
}
```

**Status codes:**
- **200-299** - Success (ok = true)
- **400-499** - Client error (404 Not Found)
- **500-599** - Server error

**Barangay example:**
```javascript
async function getResident(id) {
    let response = await fetch(`https://api.barangay.gov.ph/residents/${id}`);
    
    if (response.ok) {
        // Success (200-299)
        let resident = await response.json();
        displayResident(resident);
    } else {
        // Error (400+, 500+)
        if (response.status === 404) {
            alert('Resident not found');
        } else if (response.status === 500) {
            alert('Server error. Please try again later.');
        } else {
            alert(`Error: ${response.status}`);
        }
    }
}
```

---

### Question 10: API Endpoint

**Correct Answer: b) A URL where you can request data**

**API endpoint = specific URL for a resource**

```
Base URL: https://api.barangay.gov.ph

Endpoints:
GET    /services              - Get all services
GET    /services/1            - Get service with ID 1
POST   /applications          - Create application
GET    /applications/APP-001  - Get specific application
PUT    /applications/APP-001  - Update application
DELETE /applications/APP-001  - Delete application
```

**Barangay example:**
```javascript
const API_BASE = 'https://api.barangay.gov.ph';

// Different endpoints
async function getAllServices() {
    let response = await fetch(`${API_BASE}/services`);
    return await response.json();
}

async function getServiceById(id) {
    let response = await fetch(`${API_BASE}/services/${id}`);
    return await response.json();
}

async function searchResidents(name) {
    let response = await fetch(`${API_BASE}/residents?search=${name}`);
    return await response.json();
}

async function getApplicationsByStatus(status) {
    let response = await fetch(`${API_BASE}/applications?status=${status}`);
    return await response.json();
}
```

---
