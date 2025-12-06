## Background Story

Tian sat back in his chair, looking at the collection of JavaScript files spread across his VS Code workspace. Over the past few weeks, he and Rhea Joy had learned an incredible amount: HTML structure, CSS styling, JavaScript fundamentals, DOM manipulation, event handling, modern ES6+ syntax, modular code organization, Fetch API, JSON, async/await, responsive design with Grid and Flexbox, mobile-first methodology.

Each lesson had taught him a specific skill. Each exercise had demonstrated a particular concept. But they were all isolated pieces.

"Kuya Miguel," Tian said during their weekly video call, "I feel like I've learned all the individual instruments in an orchestra, pero I haven't played a complete symphony yet. Each skill makes sense on its own, but how do they all work together in a real application?"

Rhea Joy nodded enthusiastically. "Exactly! Like, I know how to fetch data from an API. I know how to manipulate the DOM. I know how to handle events. I know how to style with CSS. But building an actual, functional web application that combines ALL of these seamlessly? That feels like a big jump."

Miguel smiled knowingly. "You've reached the integration milestone. You have all the tools; now you need to build something complete that uses them together. That's the difference between learning syntax and becoming a developer."

He shared his screen showing a professional-looking barangay information portal. It had a clean header with the barangay name and logo, a search bar for filtering services, organized service cards displaying information beautifully, a modal system for viewing details, a fee calculator with interactive inputs, loading spinners while data fetched, error messages when things went wrong, and smooth animations throughout.

"This is what we're building today," Miguel said. "A **Dynamic Barangay Information Page** that demonstrates every single skill you've learned, working together in harmony."

Tian's eyes widened. "That looks... professional. Like a real website someone would actually use."

"Because it IS a real website," Miguel confirmed. "It fetches data from an API, displays it dynamically, handles user interactions, updates the interface in real-time, validates inputs, manages state, shows loading indicators, handles errors gracefully, and works beautifully on mobile and desktop."

Rhea Joy was already taking notes. "What specific technologies does it use?"

Miguel enumerated: "HTML for semantic structure. CSS with Grid and Flexbox for layout, custom properties for theming, and mobile-first responsive design. JavaScript using ES6+ arrow functions, template literals, destructuring, async/await, modular functions, event delegation. Fetch API to get data from a mock API endpoint. DOM manipulation to create and update elements dynamically. Event handling for interactivity. Error handling for robustness."

Tian realized this was everything they'd learned, organized into a cohesive system. "So it's like the final exam that tests every topic?"

"More like the capstone project that demonstrates you can integrate knowledge," Miguel said. "Anyone can learn concepts in isolation. Professional developers know how to combine them into working applications."

Miguel walked them through the project structure:

```
barangay-portal/
├── index.html         # Semantic HTML structure
├── styles.css         # Mobile-first, responsive CSS
├── app.js             # Main application logic
├── api.js             # API interaction module
├── ui.js              # DOM manipulation module
└── utils.js           # Utility functions
```

"Notice the modular organization," Miguel pointed out. "We're not putting everything in one file. The API module handles data fetching. The UI module manages DOM updates. The utils module provides helpers. The main app file orchestrates everything."

Rhea Joy sketched the user experience flow: "User loads page → JavaScript fetches services from API → Display loading spinner → When data arrives, dynamically create service cards → User types in search box → Filter displayed services in real-time → User clicks a service card → Open modal with details → User enters age in fee calculator → Calculate and display fee with discounts → Everything updates without page reload."

"Perfect understanding," Miguel said. "That flow demonstrates: Fetch API, DOM manipulation, event handling, conditional logic, template literals for creating HTML, CSS transitions for animations, and state management."

Tian thought about how this compared to their earlier work. "When we built the first simple HTML pages, everything was static. Then we learned JavaScript and made things interactive with button clicks. Then we learned fetch and could get external data. Now we're putting it all together—data flows from API → JavaScript → DOM → User sees beautiful interface."

"That's the modern web development cycle," Miguel confirmed. "And you'll see this pattern EVERYWHERE. Facebook feed? Fetch posts from API, display in DOM. Twitter timeline? Same thing. GCash transaction history? Same. Gmail inbox? Same. Online shopping cart? Same pattern. This is how web applications work."

Rhea Joy was excited but slightly nervous. "This sounds complex. Where do we even start?"

Miguel broke it down: "We'll build it step by step:

1. **Structure first**: Create HTML with containers for services, search, modals
2. **Style next**: Make it look professional with CSS Grid, responsive design
3. **API integration**: Fetch data from a mock API endpoint
4. **Dynamic rendering**: Loop through data, create cards, append to DOM
5. **Search functionality**: Filter displayed services based on input
6. **Modal system**: Show/hide details when users click cards
7. **Fee calculator**: Take inputs, calculate with discounts, display results
8. **Loading states**: Show spinners while fetching
9. **Error handling**: Display friendly messages if API fails

Each step builds on the previous one. By the end, you'll have a complete, functional application."

Tian opened a new project folder, feeling both excited and challenged. "This is different from following a tutorial. We're building something real."

"Exactly," Miguel said. "And here's the key difference: in tutorials, you copy code and hope it works. In real development, you THINK about what you need, PLAN the architecture, IMPLEMENT the features, TEST the functionality, and DEBUG when things break. This project teaches you that workflow."

Rhea Joy pulled up the requirements doc Miguel had shared:

**Barangay Information Page Requirements:**
- Display list of barangay services fetched from API
- Each service shows: name, description, fee, processing time, requirements
- Search box filters services in real-time
- Clicking a service opens a modal with full details
- Fee calculator applies senior/PWD discounts automatically
- Loading spinner while data fetches
- Error message if API fails
- Fully responsive (mobile-first)
- Smooth animations and transitions
- Accessible and semantic HTML

"These are real-world requirements," Miguel said. "Like what a client or barangay official would actually request. You'll learn to translate requirements into technical implementation."

Tian thought about Ms. Reyes at the barangay hall. "She could actually use this. When residents come asking about services, she could show them this page instead of explaining everything verbally."

"That's the goal," Miguel confirmed. "Build things people can actually use. That's when coding becomes meaningful."

Miguel shared a starter template with comments indicating where each feature would go:

```html
<!-- index.html -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Services Portal</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <!-- Header section -->
    <!-- Search and filter section -->
    <!-- Services grid (populated dynamically) -->
    <!-- Modal for service details -->
    <!-- Fee calculator section -->
    
    <script type="module" src="app.js"></script>
</body>
</html>
```

"Start with semantic HTML," Miguel instructed. "Then style it mobile-first. Then add JavaScript functionality piece by piece. Test each feature as you build it."

Rhea Joy was already sketching the layout. "Header at top with logo and title. Search bar below. Grid of service cards. Each card has icon, name, fee, and 'View Details' button."

Tian was planning the JavaScript architecture. "I'll create a `services` array to hold the fetched data. A `displayServices()` function to render them. A `filterServices()` function for search. An `openModal()` function for details. A `calculateFee()` function for the calculator."

"Perfect planning," Miguel said. "That's exactly the mindset you need. Break the big project into small, manageable functions. Implement one at a time. Test thoroughly."

Miguel gave them one final piece of advice: "This project might take you several hours. You'll encounter bugs. You'll get stuck. You'll need to debug. That's NORMAL. Professional developers spend most of their time debugging and problem-solving, not just writing new code. Embrace the struggle—that's where the real learning happens."

Tian saved the starter template and cracked his knuckles. "Time to build something real. Time to put everything together."

Rhea Joy opened her design file. "I'll make it look amazing. You make it work perfectly. Together, we'll build something the barangay can actually use."

Miguel smiled. "That's the developer partnership. Design and functionality working together. When you finish this project, you won't just have learned more code—you'll have proven to yourselves that you can build real, functional web applications. That's the confidence that transforms students into developers."

Tian looked at the blank `app.js` file, ready to write the first line of integrated, purposeful, real-world JavaScript. The training was over. It was time to build.

---

## Theory & Lecture Content

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