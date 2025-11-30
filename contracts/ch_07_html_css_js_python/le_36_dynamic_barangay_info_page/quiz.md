# Quiz: Dynamic Barangay Information Page Mini Project

---

## Quiz 1

**1. What's the purpose of state management (like `allServices` variable)?**

a) To style the page  
b) To store and track application data  
c) To connect to database  
d) To create animations

**Answer: b**

State management stores and tracks application data, representing the current condition of your application.

---

**2. Why separate `allServices` and `filteredServices`?**

a) No reason, redundant  
b) To preserve original data while showing filtered results  
c) For better performance  
d) Required by JavaScript

**Answer: b**

Separating arrays preserves original data (allServices) while allowing filtered views (filteredServices) for search/filter functionality.

---

**3. What does `dataset.id` do in `card.dataset.id = service.id`?**

a) Creates a CSS ID  
b) Stores custom data attribute on HTML element  
c) Assigns JavaScript variable  
d) Causes an error

**Answer: b**

`dataset.id` stores a custom data attribute (`data-id`) on the HTML element, accessible in JavaScript.

---

**4. Why use `innerHTML = ''` before adding new cards?**

a) For styling  
b) Clear previous content to avoid duplicates  
c) Required by browsers  
d) No specific reason

**Answer: b**

Clearing with `innerHTML = ''` removes previous content to avoid duplicates when re-rendering.

---

**5. What's the purpose of try/catch in fetchServices()?**

a) Speed up fetching  
b) Handle errors gracefully  
c) Validate data  
d) Format responses

**Answer: b**

`try/catch` handles errors gracefully, allowing you to show user-friendly error messages instead of crashes.

---

## Quiz 2

**6. Why use `finally` block?**

a) To fetch data  
b) Code that runs whether success or error  
c) To catch errors  
d) To return data

**Answer: b**

The `finally` block executes code regardless of success or error (e.g., hiding loading spinner).

---

**7. What does `grid-template-columns: repeat(auto-fill, minmax(300px, 1fr))` do?**

a) Creates 3 columns  
b) Creates responsive grid that adapts to screen size  
c) Fixes column width  
d) Causes layout errors

**Answer: b**

This creates a responsive grid where columns automatically adjust based on available space (min 300px, max 1fr).

---

**8. Why use `event delegation` vs individual listeners?**

a) No difference  
b) Better performance for many elements  
c) Easier to write  
d) Required by browsers

**Answer: b**

Event delegation attaches one listener to a parent instead of many to children, improving performance.

---

**9. What's the purpose of `currentService` variable?**

a) Fetch data  
b) Store selected service for modal calculations  
c) Display all services  
d) Filter services

**Answer: b**

`currentService` stores the selected service data for use in modal displays and calculations.

---

**10. Best practice for updating multiple stats?**

a) Update DOM directly each time  
b) Collect data, then update DOM once  
c) Use intervals  
d) Doesn't matter

**Answer: b**

Collect all data first, then update the DOM once to minimize reflows and improve performance.

---

## Detailed Explanations

### Question 1: State Management

**Correct Answer: b) To store and track application data**

State = data that represents current condition of your application.

```javascript
// Application state
let allServices = [];        // All services from API
let filteredServices = [];   // Currently displayed services
let currentService = null;   // Selected service for modal

// When data changes, update UI
function updateState(newServices) {
    allServices = newServices;
    filteredServices = [...allServices];
    displayServices(); // Re-render UI
}
```

**Barangay example:**
```javascript
// State tracks everything
let state = {
    services: [],
    searchTerm: '',
    statusFilter: 'all',
    isLoading: false,
    error: null
};

// Single source of truth
function updateSearch(term) {
    state.searchTerm = term;
    applyFilters();
    render();
}
```

---

### Question 2: Separate Arrays

**Correct Answer: b) To preserve original data while showing filtered results**

```javascript
// Original data (never modified)
let allServices = [
    {name: 'Clearance', fee: 50, available: true},
    {name: 'ID', fee: 30, available: true},
    {name: 'Permit', fee: 200, available: false}
];

// Filtered view (changes based on search/filter)
let filteredServices = [...allServices];

// Search
searchInput.addEventListener('input', (e) => {
    let term = e.target.value.toLowerCase();
    
    // Filter from original, not filtered
    filteredServices = allServices.filter(service => 
        service.name.toLowerCase().includes(term)
    );
    
    displayServices(); // Show filtered results
});

// Clear search - restore all services
function clearSearch() {
    filteredServices = [...allServices]; // Copy from original
    displayServices();
}
```

**Without separation:**
```javascript
// BAD: Modifying original array
let services = [...]; // Original data

// Filtering modifies original!
services = services.filter(...);

// Can't restore original data!
```

---

### Question 3: Dataset Attribute

**Correct Answer: b) Stores custom data attribute on HTML element**

`dataset` provides access to `data-*` attributes:

```javascript
// Set data attribute
card.dataset.id = service.id;
card.dataset.fee = service.fee;
// Creates: <div data-id="1" data-fee="50">

// Read data attribute
let id = card.dataset.id;    // "1"
let fee = card.dataset.fee;  // "50"

// In HTML
<div data-id="1" data-fee="50" data-available="true">
```

**Barangay example:**
```javascript
function createServiceCard(service) {
    let card = document.createElement('div');
    
    // Store service data
    card.dataset.id = service.id;
    card.dataset.name = service.name;
    card.dataset.fee = service.fee;
    card.dataset.available = service.available;
    
    card.addEventListener('click', function() {
        // Retrieve stored data
        let serviceId = parseInt(this.dataset.id);
        let serviceFee = parseInt(this.dataset.fee);
        let isAvailable = this.dataset.available === 'true';
        
        showDetails(serviceId, serviceFee, isAvailable);
    });
    
    return card;
}
```

---

### Question 4: Clear Content

**Correct Answer: b) Clear previous content to avoid duplicates**

```javascript
// WRONG: Doesn't clear
function displayServices() {
    // Appends without clearing
    services.forEach(service => {
        container.appendChild(createCard(service));
    });
}
// Calling twice = duplicates!

// CORRECT: Clear first
function displayServices() {
    container.innerHTML = ''; // Clear previous
    
    services.forEach(service => {
        container.appendChild(createCard(service));
    });
}
```

**Barangay example:**
```javascript
function updateServiceList() {
    let container = document.querySelector('#serviceList');
    
    // Clear old content
    container.innerHTML = '';
    
    // Add updated content
    filteredServices.forEach(service => {
        container.appendChild(createServiceCard(service));
    });
}

// Called multiple times without duplicates
searchInput.addEventListener('input', updateServiceList);
filterSelect.addEventListener('change', updateServiceList);
```

---

### Question 5: Try/Catch

**Correct Answer: b) Handle errors gracefully**

```javascript
async function fetchServices() {
    try {
        // Attempt operation
        let response = await fetch(url);
        
        if (!response.ok) {
            throw new Error('Failed to fetch');
        }
        
        let data = await response.json();
        displayServices(data);
        
    } catch (error) {
        // Handle error gracefully
        console.error('Error:', error);
        showErrorMessage(error.message);
        // App continues running
    }
}
```

**Without try/catch:**
```javascript
// BAD: Unhandled error crashes app
async function fetchServices() {
    let response = await fetch(url); // Might fail!
    let data = await response.json(); // Never reached if error
    // User sees blank page with error in console
}
```

**Barangay example:**
```javascript
async function loadBarangayData() {
    showLoading(true);
    
    try {
        let response = await fetch('https://api.barangay.gov.ph/data');
        
        if (!response.ok) {
            throw new Error(`Server error: ${response.status}`);
        }
        
        let data = await response.json();
        displayData(data);
        showSuccess('Data loaded successfully!');
        
    } catch (error) {
        // Graceful error handling
        if (error.message.includes('NetworkError')) {
            showError('No internet connection. Please check your network.');
        } else {
            showError('Failed to load data. Please try again.');
        }
        
        // Load cached data as fallback
        let cached = localStorage.getItem('cachedData');
        if (cached) {
            displayData(JSON.parse(cached));
            showInfo('Showing cached data');
        }
        
    } finally {
        showLoading(false); // Always hide loading
    }
}
```

---

### Questions 6-10: Rapid-Fire Explanations

**Q6: Finally block** - Runs whether success or error. Perfect for cleanup:
```javascript
try {
    await fetchData();
} catch (error) {
    showError(error);
} finally {
    hideLoading(); // Always runs
}
```

**Q7: CSS Grid Auto-Fill** - Creates responsive columns:
```css
grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
/* Fills row with as many 300px+ columns as fit */
```

**Q8: Event Delegation** - One listener vs many:
```javascript
// Better: One listener on parent
container.addEventListener('click', (e) => {
    if (e.target.matches('.service-card')) {
        handleClick(e.target);
    }
});

// Worse: Individual listeners
cards.forEach(card => {
    card.addEventListener('click', handleClick);
});
```

**Q9: Current Service** - Stores context for modal:
```javascript
let currentService = null;

function showModal(service) {
    currentService = service; // Store for calculator
    modalTitle.textContent = service.name;
}

function calculateFee() {
    let fee = currentService.fee; // Use stored service
    if (isSenior) fee *= 0.8;
    displayFee(fee);
}
```

**Q10: Batch DOM Updates** - More efficient:
```javascript
// GOOD: Calculate first, update once
function updateStats() {
    let total = services.length;
    let available = services.filter(s => s.available).length;
    let avg = services.reduce((sum, s) => sum + s.fee, 0) / total;
    
    // Update DOM once
    totalEl.textContent = total;
    availableEl.textContent = available;
    avgEl.textContent = avg;
}

// BAD: Multiple DOM updates during calculation
function updateStats() {
    totalEl.textContent = services.length; // Update
    let count = 0;
    services.forEach(s => {
        if (s.available) {
            count++;
            availableEl.textContent = count; // Update each iteration!
        }
    });
}
```

---
