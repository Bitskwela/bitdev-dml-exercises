# Lesson 36: Mini Project - Dynamic Barangay Information Page

---

## Combining Everything You've Learned

"Kuya Miguel, we've learned DOM, events, styling, modern JavaScript, modules, and APIs. Time to build something real?" Tian asked excitedly.

Rhea Joy added, "A complete barangay system that fetches real data and displays it dynamically?"

Kuya Miguel smiled. "Exactly! Let's build a **Dynamic Barangay Information Page** that combines all these skills. You'll fetch data from an API, display services, handle user interactions, and update the page in real-time!"

---

## Project Overview

**Features:**
1. Fetch barangay services from API
2. Display services in organized cards
3. Search/filter functionality
4. Service details modal
5. Fee calculator with discounts
6. Loading states and error handling
7. Responsive design

**Technologies:**
- HTML structure
- CSS styling
- JavaScript (ES6+)
- Fetch API
- DOM manipulation
- Event handling

---

## Complete Project Code

### index.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay San Antonio - Services</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>🏛️ Barangay San Antonio</h1>
            <p class="subtitle">Online Service Information System</p>
        </header>
        
        <div class="search-section">
            <input 
                type="text" 
                id="searchInput" 
                placeholder="Search services..."
                class="search-input"
            >
            <select id="filterStatus" class="filter-select">
                <option value="all">All Services</option>
                <option value="available">Available Only</option>
                <option value="unavailable">Unavailable</option>
            </select>
        </div>
        
        <div class="stats">
            <div class="stat-card">
                <div class="stat-number" id="totalServices">-</div>
                <div class="stat-label">Total Services</div>
            </div>
            <div class="stat-card">
                <div class="stat-number" id="availableServices">-</div>
                <div class="stat-label">Available</div>
            </div>
            <div class="stat-card">
                <div class="stat-number" id="avgFee">-</div>
                <div class="stat-label">Average Fee</div>
            </div>
        </div>
        
        <div id="servicesContainer" class="services-grid">
            <!-- Services will be inserted here -->
        </div>
        
        <div id="loadingSpinner" class="loading">
            <div class="spinner"></div>
            <p>Loading services...</p>
        </div>
        
        <div id="errorMessage" class="error-message" style="display: none;">
            <p id="errorText"></p>
            <button id="retryBtn">Retry</button>
        </div>
    </div>
    
    <!-- Modal for service details -->
    <div id="serviceModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2 id="modalTitle"></h2>
            <div id="modalBody"></div>
            <div class="fee-calculator">
                <h3>Fee Calculator</h3>
                <label>
                    <input type="checkbox" id="seniorCheck">
                    Senior Citizen (20% off)
                </label>
                <label>
                    <input type="checkbox" id="pwdCheck">
                    PWD (10% off)
                </label>
                <div class="calculated-fee">
                    Final Fee: <span id="finalFee">₱0</span>
                </div>
            </div>
        </div>
    </div>
    
    <script type="module" src="app.js"></script>
</body>
</html>
```

---

### styles.css

```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    padding: 20px;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
}

header {
    text-align: center;
    color: white;
    margin-bottom: 30px;
}

header h1 {
    font-size: 2.5rem;
    margin-bottom: 10px;
}

.subtitle {
    font-size: 1.1rem;
    opacity: 0.9;
}

.search-section {
    display: flex;
    gap: 15px;
    margin-bottom: 30px;
}

.search-input, .filter-select {
    padding: 12px 20px;
    border: none;
    border-radius: 8px;
    font-size: 1rem;
}

.search-input {
    flex: 1;
}

.filter-select {
    background: white;
    cursor: pointer;
}

.stats {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
}

.stat-card {
    background: white;
    padding: 25px;
    border-radius: 10px;
    text-align: center;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
}

.stat-number {
    font-size: 2.5rem;
    font-weight: bold;
    color: #667eea;
}

.stat-label {
    color: #666;
    margin-top: 10px;
}

.services-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 20px;
}

.service-card {
    background: white;
    border-radius: 10px;
    padding: 25px;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    transition: transform 0.3s, box-shadow 0.3s;
    cursor: pointer;
}

.service-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 12px rgba(0,0,0,0.15);
}

.service-name {
    font-size: 1.3rem;
    font-weight: bold;
    margin-bottom: 10px;
    color: #333;
}

.service-fee {
    font-size: 1.5rem;
    color: #667eea;
    font-weight: bold;
    margin: 10px 0;
}

.service-status {
    display: inline-block;
    padding: 5px 15px;
    border-radius: 20px;
    font-size: 0.9rem;
    font-weight: bold;
}

.status-available {
    background: #d4edda;
    color: #155724;
}

.status-unavailable {
    background: #f8d7da;
    color: #721c24;
}

.loading {
    text-align: center;
    padding: 50px;
    color: white;
}

.spinner {
    border: 4px solid rgba(255,255,255,0.3);
    border-top: 4px solid white;
    border-radius: 50%;
    width: 50px;
    height: 50px;
    animation: spin 1s linear infinite;
    margin: 0 auto 20px;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

.error-message {
    background: #f8d7da;
    color: #721c24;
    padding: 20px;
    border-radius: 10px;
    text-align: center;
}

.error-message button {
    margin-top: 15px;
    padding: 10px 30px;
    background: #dc3545;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 1rem;
}

.error-message button:hover {
    background: #c82333;
}

/* Modal */
.modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.5);
}

.modal-content {
    background: white;
    margin: 50px auto;
    padding: 30px;
    border-radius: 10px;
    max-width: 600px;
    position: relative;
}

.close {
    position: absolute;
    right: 20px;
    top: 20px;
    font-size: 2rem;
    cursor: pointer;
    color: #666;
}

.close:hover {
    color: #000;
}

.fee-calculator {
    margin-top: 30px;
    padding: 20px;
    background: #f8f9fa;
    border-radius: 8px;
}

.fee-calculator label {
    display: block;
    margin: 10px 0;
}

.calculated-fee {
    margin-top: 20px;
    font-size: 1.5rem;
    font-weight: bold;
    color: #667eea;
}
```

---

### app.js

```javascript
// State
let allServices = [];
let filteredServices = [];

// DOM Elements
const servicesContainer = document.querySelector('#servicesContainer');
const loadingSpinner = document.querySelector('#loadingSpinner');
const errorMessage = document.querySelector('#errorMessage');
const errorText = document.querySelector('#errorText');
const searchInput = document.querySelector('#searchInput');
const filterStatus = document.querySelector('#filterStatus');
const modal = document.querySelector('#serviceModal');
const closeModal = document.querySelector('.close');

// Stats elements
const totalServicesEl = document.querySelector('#totalServices');
const availableServicesEl = document.querySelector('#availableServices');
const avgFeeEl = document.querySelector('#avgFee');

// Modal elements
const modalTitle = document.querySelector('#modalTitle');
const modalBody = document.querySelector('#modalBody');
const seniorCheck = document.querySelector('#seniorCheck');
const pwdCheck = document.querySelector('#pwdCheck');
const finalFeeEl = document.querySelector('#finalFee');

// Current service for calculator
let currentService = null;

// Fetch services from API
async function fetchServices() {
    showLoading(true);
    hideError();
    
    try {
        // Using JSONPlaceholder as demo API
        const response = await fetch('https://jsonplaceholder.typicode.com/posts?_limit=12');
        
        if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
        }
        
        const data = await response.json();
        
        // Transform API data to barangay services
        allServices = data.map((post, index) => ({
            id: post.id,
            name: `Service ${post.id}: ${post.title.substring(0, 30)}...`,
            description: post.body,
            fee: 30 + (index * 15),
            available: Math.random() > 0.3
        }));
        
        filteredServices = [...allServices];
        
        displayServices();
        updateStats();
        
    } catch (error) {
        showError(error.message);
    } finally {
        showLoading(false);
    }
}

// Display services
function displayServices() {
    servicesContainer.innerHTML = '';
    
    if (filteredServices.length === 0) {
        servicesContainer.innerHTML = `
            <div style="grid-column: 1/-1; text-align: center; color: white; padding: 50px;">
                <h2>No services found</h2>
                <p>Try adjusting your search or filter</p>
            </div>
        `;
        return;
    }
    
    filteredServices.forEach(service => {
        const card = createServiceCard(service);
        servicesContainer.appendChild(card);
    });
}

// Create service card
function createServiceCard(service) {
    const card = document.createElement('div');
    card.className = 'service-card';
    card.dataset.id = service.id;
    
    card.innerHTML = `
        <div class="service-name">${service.name}</div>
        <div class="service-fee">₱${service.fee}</div>
        <span class="service-status ${service.available ? 'status-available' : 'status-unavailable'}">
            ${service.available ? '✓ Available' : '✗ Unavailable'}
        </span>
    `;
    
    card.addEventListener('click', () => showServiceModal(service));
    
    return card;
}

// Show service modal
function showServiceModal(service) {
    currentService = service;
    
    modalTitle.textContent = service.name;
    modalBody.innerHTML = `
        <p><strong>Description:</strong> ${service.description}</p>
        <p><strong>Base Fee:</strong> ₱${service.fee}</p>
        <p><strong>Status:</strong> ${service.available ? 'Available' : 'Unavailable'}</p>
    `;
    
    seniorCheck.checked = false;
    pwdCheck.checked = false;
    calculateFee();
    
    modal.style.display = 'block';
}

// Calculate fee with discounts
function calculateFee() {
    if (!currentService) return;
    
    let fee = currentService.fee;
    
    if (seniorCheck.checked) {
        fee *= 0.8; // 20% discount
    }
    
    if (pwdCheck.checked) {
        fee *= 0.9; // 10% discount
    }
    
    finalFeeEl.textContent = `₱${fee.toFixed(2)}`;
}

// Search functionality
function handleSearch() {
    const searchTerm = searchInput.value.toLowerCase();
    const statusFilter = filterStatus.value;
    
    filteredServices = allServices.filter(service => {
        const matchesSearch = service.name.toLowerCase().includes(searchTerm) ||
                            service.description.toLowerCase().includes(searchTerm);
        
        const matchesStatus = statusFilter === 'all' ||
                            (statusFilter === 'available' && service.available) ||
                            (statusFilter === 'unavailable' && !service.available);
        
        return matchesSearch && matchesStatus;
    });
    
    displayServices();
    updateStats();
}

// Update statistics
function updateStats() {
    const total = filteredServices.length;
    const available = filteredServices.filter(s => s.available).length;
    const avgFee = total > 0 
        ? (filteredServices.reduce((sum, s) => sum + s.fee, 0) / total).toFixed(2)
        : 0;
    
    totalServicesEl.textContent = total;
    availableServicesEl.textContent = available;
    avgFeeEl.textContent = `₱${avgFee}`;
}

// Show/hide loading
function showLoading(show) {
    loadingSpinner.style.display = show ? 'block' : 'none';
    servicesContainer.style.display = show ? 'none' : 'grid';
}

// Show/hide error
function showError(message) {
    errorText.textContent = `Error: ${message}`;
    errorMessage.style.display = 'block';
    servicesContainer.style.display = 'none';
}

function hideError() {
    errorMessage.style.display = 'none';
}

// Event listeners
searchInput.addEventListener('input', handleSearch);
filterStatus.addEventListener('change', handleSearch);
seniorCheck.addEventListener('change', calculateFee);
pwdCheck.addEventListener('change', calculateFee);
document.querySelector('#retryBtn').addEventListener('click', fetchServices);

// Close modal
closeModal.addEventListener('click', () => {
    modal.style.display = 'none';
});

window.addEventListener('click', (e) => {
    if (e.target === modal) {
        modal.style.display = 'none';
    }
});

// Initialize
fetchServices();
```

---

## Key Features Explained

### 1. **Fetch from API**
```javascript
const response = await fetch('https://api.example.com/services');
const data = await response.json();
```

### 2. **Search & Filter**
```javascript
filteredServices = allServices.filter(service => {
    return service.name.includes(searchTerm) && 
           matchesStatusFilter(service);
});
```

### 3. **Dynamic DOM Updates**
```javascript
servicesContainer.innerHTML = '';
services.forEach(service => {
    const card = createServiceCard(service);
    servicesContainer.appendChild(card);
});
```

### 4. **Modal Dialog**
```javascript
modal.style.display = 'block'; // Show
modal.style.display = 'none';  // Hide
```

### 5. **Fee Calculator**
```javascript
let fee = baseFee;
if (isSenior) fee *= 0.8;
if (isPWD) fee *= 0.9;
```

---

## Challenges to Extend the Project

1. **Add sorting** (by name, fee, availability)
2. **Implement pagination** (10 services per page)
3. **Add favorites** (save to localStorage)
4. **Create admin mode** (add/edit/delete services)
5. **Add animations** (fade in/out, slide transitions)

---

## Summary

You've built a complete application using:
- ✅ Fetch API for data
- ✅ DOM manipulation
- ✅ Event handling
- ✅ Array methods (map, filter, reduce)
- ✅ Modern ES6+ syntax
- ✅ Responsive design
- ✅ Error handling
- ✅ Loading states

**Congratulations! You're now ready for full-stack development!**

---

## What's Next?

In **Course 13**, you'll learn to connect JavaScript to a **Flask backend**, building complete web applications with databases, authentication, and server-side logic!

---

---

## Closing Story

Tian built a dynamic barangay information page: fetch resident data from API, display in cards, filter by age, search by name, sort by address. Everything client-side. Everything interactive.

Kuya Miguel reviewed the code. "This is production-quality work. Modular. Responsive. API-driven. You've mastered modern JavaScript."

Tian deployed it. Residents tested it. It worked flawlessly. Fast. Smooth. Beautiful.

"Course 12 complete," Kuya Miguel announced. "You're a JavaScript developer now. Ready for the final challenge?"

"What's next?" Tian asked.

"Backend integration," Miguel smiled. "Time to connect frontend to Flask. Time to build a real web app."

_Next up: Course 13Pagtatahi: Weaving Front and Back!_