# Activity 1: Dynamic Barangay Information Page

In this activity, you'll create a complete dynamic barangay information page that combines HTML, CSS, and JavaScript with data fetching, DOM manipulation, and interactive features.

---

## Activity 1: Project Overview

You'll build a **Dynamic Barangay Information Portal** that displays:
- Barangay officials information
- Available services with fees
- Announcements/news
- Contact information
- Search and filter functionality

**Technologies:**
- HTML5 for structure
- CSS3 for styling
- Vanilla JavaScript for interactivity
- JSON for data storage
- Fetch API for loading data

---

## Activity 2: Creating the Data File

First, create a JSON file to store barangay data.

### data/barangay-data.json:
```json
{
  "barangay": {
    "name": "Barangay San Jose",
    "address": "123 Main Street, Manila",
    "phone": "(02) 1234-5678",
    "email": "info@sanjose.barangay.ph",
    "hours": "Monday - Friday: 8:00 AM - 5:00 PM"
  },
  "officials": [
    {
      "id": 1,
      "name": "Juan Dela Cruz",
      "position": "Barangay Captain",
      "photo": "https://via.placeholder.com/150",
      "email": "captain@sanjose.barangay.ph",
      "phone": "0912-345-6789"
    },
    {
      "id": 2,
      "name": "Maria Santos",
      "position": "Barangay Kagawad - Health",
      "photo": "https://via.placeholder.com/150",
      "email": "maria.santos@sanjose.barangay.ph",
      "phone": "0923-456-7890"
    },
    {
      "id": 3,
      "name": "Pedro Reyes",
      "position": "Barangay Kagawad - Education",
      "photo": "https://via.placeholder.com/150",
      "email": "pedro.reyes@sanjose.barangay.ph",
      "phone": "0934-567-8901"
    },
    {
      "id": 4,
      "name": "Ana Garcia",
      "position": "Barangay Secretary",
      "photo": "https://via.placeholder.com/150",
      "email": "secretary@sanjose.barangay.ph",
      "phone": "0945-678-9012"
    },
    {
      "id": 5,
      "name": "Jose Rizal",
      "position": "Barangay Treasurer",
      "photo": "https://via.placeholder.com/150",
      "email": "treasurer@sanjose.barangay.ph",
      "phone": "0956-789-0123"
    }
  ],
  "services": [
    {
      "id": 1,
      "name": "Barangay Clearance",
      "description": "Certificate of residency for various purposes",
      "fee": 50,
      "requirements": [
        "Valid ID",
        "Proof of Residency",
        "1x1 Photo"
      ],
      "processingTime": "3-5 business days",
      "category": "Certificates"
    },
    {
      "id": 2,
      "name": "Business Permit",
      "description": "Permit to operate business within the barangay",
      "fee": 150,
      "requirements": [
        "Business Registration",
        "Valid ID",
        "Barangay Clearance",
        "Tax Identification Number"
      ],
      "processingTime": "7-10 business days",
      "category": "Permits"
    },
    {
      "id": 3,
      "name": "Barangay ID",
      "description": "Official identification card for residents",
      "fee": 30,
      "requirements": [
        "Valid ID",
        "Proof of Residency",
        "2x2 Photo"
      ],
      "processingTime": "7-14 business days",
      "category": "Identification"
    },
    {
      "id": 4,
      "name": "Certificate of Indigency",
      "description": "Certificate for low-income families",
      "fee": 0,
      "requirements": [
        "Valid ID",
        "Proof of Income",
        "Barangay Clearance"
      ],
      "processingTime": "3-5 business days",
      "category": "Certificates"
    },
    {
      "id": 5,
      "name": "Cedula",
      "description": "Community tax certificate",
      "fee": 100,
      "requirements": [
        "Valid ID",
        "Proof of Income"
      ],
      "processingTime": "Same day",
      "category": "Certificates"
    }
  ],
  "announcements": [
    {
      "id": 1,
      "title": "Community Clean-up Drive",
      "date": "2024-02-15",
      "content": "Join us for our monthly barangay clean-up drive this Saturday at 7:00 AM. Meet at the barangay hall.",
      "type": "event"
    },
    {
      "id": 2,
      "title": "Free Medical Check-up",
      "date": "2024-02-20",
      "content": "Free medical check-up and consultation available at the barangay health center every Wednesday.",
      "type": "health"
    },
    {
      "id": 3,
      "title": "New Office Hours",
      "date": "2024-02-01",
      "content": "Effective February 1, the barangay hall will be open Monday to Friday, 8:00 AM to 5:00 PM.",
      "type": "announcement"
    },
    {
      "id": 4,
      "title": "Senior Citizens Program",
      "date": "2024-02-10",
      "content": "Monthly cash assistance and free medicines for senior citizens. Claim at the barangay hall.",
      "type": "program"
    }
  ]
}
```

---

## Activity 3: HTML Structure

Create the main HTML structure for the page.

### index.html:
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay San Jose - Information Portal</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <div class="header-content">
                <div class="logo">
                    <h1>🏘️ Barangay San Jose</h1>
                    <p class="tagline">Serving the Community Since 1950</p>
                </div>
                <nav class="nav">
                    <a href="#home" class="nav-link active">Home</a>
                    <a href="#officials" class="nav-link">Officials</a>
                    <a href="#services" class="nav-link">Services</a>
                    <a href="#announcements" class="nav-link">News</a>
                    <a href="#contact" class="nav-link">Contact</a>
                </nav>
            </div>
        </div>
    </header>

    <!-- Hero Section -->
    <section id="home" class="hero">
        <div class="container">
            <h2>Welcome to Our Community</h2>
            <p>Your trusted partner for barangay services and community development</p>
            <button class="btn btn-primary" onclick="scrollToSection('services')">
                View Services
            </button>
        </div>
    </section>

    <!-- Loading Indicator -->
    <div id="loading" class="loading">
        <div class="spinner"></div>
        <p>Loading barangay information...</p>
    </div>

    <!-- Officials Section -->
    <section id="officials" class="section">
        <div class="container">
            <h2 class="section-title">Barangay Officials</h2>
            <div id="officialsList" class="officials-grid"></div>
        </div>
    </section>

    <!-- Services Section -->
    <section id="services" class="section section-gray">
        <div class="container">
            <h2 class="section-title">Available Services</h2>
            
            <!-- Filter Controls -->
            <div class="filter-controls">
                <input type="text" id="serviceSearch" class="search-input" 
                       placeholder="Search services...">
                
                <select id="categoryFilter" class="filter-select">
                    <option value="all">All Categories</option>
                    <option value="Certificates">Certificates</option>
                    <option value="Permits">Permits</option>
                    <option value="Identification">Identification</option>
                </select>
            </div>
            
            <div id="servicesList" class="services-grid"></div>
        </div>
    </section>

    <!-- Announcements Section -->
    <section id="announcements" class="section">
        <div class="container">
            <h2 class="section-title">Latest News & Announcements</h2>
            <div id="announcementsList" class="announcements-list"></div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="section section-gray">
        <div class="container">
            <h2 class="section-title">Contact Us</h2>
            <div id="contactInfo" class="contact-info"></div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <p>&copy; 2024 Barangay San Jose. All rights reserved.</p>
            <p>Built with ❤️ for the community</p>
        </div>
    </footer>

    <script src="script.js"></script>
</body>
</html>
```

---

## Activity 4: CSS Styling

Create comprehensive styling for the page.

### styles.css:
```css
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

:root {
    --primary-color: #2c3e50;
    --secondary-color: #3498db;
    --accent-color: #e74c3c;
    --success-color: #27ae60;
    --text-color: #333;
    --light-bg: #f8f9fa;
    --border-color: #dee2e6;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    line-height: 1.6;
    color: var(--text-color);
}

.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
}

/* Header */
.header {
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    color: white;
    padding: 1rem 0;
    position: sticky;
    top: 0;
    z-index: 1000;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.header-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.logo h1 {
    font-size: 1.8rem;
    margin-bottom: 0.2rem;
}

.tagline {
    font-size: 0.9rem;
    opacity: 0.9;
}

.nav {
    display: flex;
    gap: 2rem;
}

.nav-link {
    color: white;
    text-decoration: none;
    padding: 0.5rem 1rem;
    border-radius: 5px;
    transition: background 0.3s;
}

.nav-link:hover,
.nav-link.active {
    background: rgba(255,255,255,0.2);
}

/* Hero Section */
.hero {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    text-align: center;
    padding: 4rem 0;
}

.hero h2 {
    font-size: 2.5rem;
    margin-bottom: 1rem;
}

.hero p {
    font-size: 1.2rem;
    margin-bottom: 2rem;
}

/* Buttons */
.btn {
    padding: 0.75rem 2rem;
    border: none;
    border-radius: 5px;
    font-size: 1rem;
    cursor: pointer;
    transition: transform 0.2s, box-shadow 0.2s;
}

.btn-primary {
    background: white;
    color: var(--primary-color);
    font-weight: bold;
}

.btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

/* Loading */
.loading {
    text-align: center;
    padding: 3rem;
    display: none;
}

.loading.show {
    display: block;
}

.spinner {
    width: 50px;
    height: 50px;
    border: 5px solid var(--light-bg);
    border-top-color: var(--secondary-color);
    border-radius: 50%;
    animation: spin 1s linear infinite;
    margin: 0 auto 1rem;
}

@keyframes spin {
    to { transform: rotate(360deg); }
}

/* Sections */
.section {
    padding: 4rem 0;
}

.section-gray {
    background: var(--light-bg);
}

.section-title {
    text-align: center;
    font-size: 2rem;
    color: var(--primary-color);
    margin-bottom: 2rem;
}

/* Officials Grid */
.officials-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 2rem;
}

.official-card {
    background: white;
    border-radius: 10px;
    padding: 1.5rem;
    text-align: center;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    transition: transform 0.3s, box-shadow 0.3s;
}

.official-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 5px 20px rgba(0,0,0,0.15);
}

.official-photo {
    width: 150px;
    height: 150px;
    border-radius: 50%;
    object-fit: cover;
    margin-bottom: 1rem;
    border: 4px solid var(--secondary-color);
}

.official-name {
    font-size: 1.2rem;
    color: var(--primary-color);
    margin-bottom: 0.5rem;
}

.official-position {
    color: var(--secondary-color);
    font-weight: bold;
    margin-bottom: 1rem;
}

.official-contact {
    font-size: 0.9rem;
    color: #666;
}

/* Services */
.filter-controls {
    display: flex;
    gap: 1rem;
    margin-bottom: 2rem;
    justify-content: center;
}

.search-input,
.filter-select {
    padding: 0.75rem 1rem;
    border: 2px solid var(--border-color);
    border-radius: 5px;
    font-size: 1rem;
}

.search-input {
    flex: 1;
    max-width: 400px;
}

.services-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 2rem;
}

.service-card {
    background: white;
    border-radius: 10px;
    padding: 1.5rem;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    transition: transform 0.3s;
}

.service-card:hover {
    transform: translateY(-5px);
}

.service-header {
    display: flex;
    justify-content: space-between;
    align-items: start;
    margin-bottom: 1rem;
}

.service-name {
    font-size: 1.3rem;
    color: var(--primary-color);
}

.service-fee {
    background: var(--success-color);
    color: white;
    padding: 0.3rem 0.8rem;
    border-radius: 20px;
    font-weight: bold;
}

.service-description {
    color: #666;
    margin-bottom: 1rem;
}

.service-requirements {
    margin: 1rem 0;
}

.service-requirements h4 {
    font-size: 0.9rem;
    color: var(--primary-color);
    margin-bottom: 0.5rem;
}

.service-requirements ul {
    list-style-position: inside;
    color: #666;
    font-size: 0.9rem;
}

.service-meta {
    display: flex;
    justify-content: space-between;
    font-size: 0.85rem;
    color: #999;
    padding-top: 1rem;
    border-top: 1px solid var(--border-color);
}

/* Announcements */
.announcements-list {
    display: grid;
    gap: 1.5rem;
    max-width: 800px;
    margin: 0 auto;
}

.announcement-card {
    background: white;
    border-left: 4px solid var(--secondary-color);
    padding: 1.5rem;
    border-radius: 5px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.announcement-card.event {
    border-left-color: #9b59b6;
}

.announcement-card.health {
    border-left-color: #27ae60;
}

.announcement-card.program {
    border-left-color: #f39c12;
}

.announcement-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 0.5rem;
}

.announcement-title {
    font-size: 1.2rem;
    color: var(--primary-color);
}

.announcement-date {
    color: #999;
    font-size: 0.9rem;
}

.announcement-content {
    color: #666;
    line-height: 1.8;
}

.announcement-type {
    display: inline-block;
    padding: 0.2rem 0.8rem;
    border-radius: 15px;
    font-size: 0.8rem;
    margin-top: 0.5rem;
    background: var(--light-bg);
    color: var(--text-color);
}

/* Contact */
.contact-info {
    max-width: 600px;
    margin: 0 auto;
    background: white;
    padding: 2rem;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.contact-item {
    display: flex;
    align-items: center;
    gap: 1rem;
    padding: 1rem 0;
    border-bottom: 1px solid var(--border-color);
}

.contact-item:last-child {
    border-bottom: none;
}

.contact-icon {
    font-size: 1.5rem;
}

.contact-details h3 {
    color: var(--primary-color);
    margin-bottom: 0.3rem;
}

.contact-details p {
    color: #666;
}

/* Footer */
.footer {
    background: var(--primary-color);
    color: white;
    text-align: center;
    padding: 2rem 0;
}

/* Responsive */
@media (max-width: 768px) {
    .header-content {
        flex-direction: column;
        gap: 1rem;
    }
    
    .nav {
        flex-wrap: wrap;
        justify-content: center;
        gap: 0.5rem;
    }
    
    .hero h2 {
        font-size: 1.8rem;
    }
    
    .filter-controls {
        flex-direction: column;
    }
    
    .search-input {
        max-width: 100%;
    }
}
```

---

## Activity 5: JavaScript Implementation

Create the dynamic functionality with JavaScript.

### script.js:
```javascript
// State
let barangayData = null;
let filteredServices = [];

// DOM Elements
const loading = document.getElementById('loading');
const officialsList = document.getElementById('officialsList');
const servicesList = document.getElementById('servicesList');
const announcementsList = document.getElementById('announcementsList');
const contactInfo = document.getElementById('contactInfo');
const serviceSearch = document.getElementById('serviceSearch');
const categoryFilter = document.getElementById('categoryFilter');

// Load data on page load
document.addEventListener('DOMContentLoaded', () => {
    loadBarangayData();
    setupEventListeners();
});

// Load barangay data from JSON file
async function loadBarangayData() {
    try {
        showLoading();
        
        const response = await fetch('data/barangay-data.json');
        
        if (!response.ok) {
            throw new Error('Failed to load barangay data');
        }
        
        barangayData = await response.json();
        filteredServices = barangayData.services;
        
        // Render all sections
        renderOfficials();
        renderServices();
        renderAnnouncements();
        renderContact();
        
        hideLoading();
        
    } catch (error) {
        console.error('Error loading data:', error);
        hideLoading();
        showError('Failed to load barangay information. Please try again later.');
    }
}

// Show loading indicator
function showLoading() {
    loading.classList.add('show');
}

// Hide loading indicator
function hideLoading() {
    loading.classList.remove('show');
}

// Show error message
function showError(message) {
    const errorDiv = document.createElement('div');
    errorDiv.className = 'error-message';
    errorDiv.textContent = message;
    errorDiv.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background: #e74c3c;
        color: white;
        padding: 1rem 2rem;
        border-radius: 5px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        z-index: 2000;
    `;
    document.body.appendChild(errorDiv);
    
    setTimeout(() => {
        errorDiv.remove();
    }, 5000);
}

// Render officials
function renderOfficials() {
    if (!barangayData || !barangayData.officials) return;
    
    const html = barangayData.officials.map(official => `
        <div class="official-card">
            <img src="${official.photo}" alt="${official.name}" class="official-photo">
            <h3 class="official-name">${official.name}</h3>
            <p class="official-position">${official.position}</p>
            <div class="official-contact">
                <p>📧 ${official.email}</p>
                <p>📱 ${official.phone}</p>
            </div>
        </div>
    `).join('');
    
    officialsList.innerHTML = html;
}

// Render services
function renderServices() {
    if (!filteredServices || filteredServices.length === 0) {
        servicesList.innerHTML = '<p style="text-align: center; color: #999;">No services found</p>';
        return;
    }
    
    const html = filteredServices.map(service => `
        <div class="service-card">
            <div class="service-header">
                <h3 class="service-name">${service.name}</h3>
                <span class="service-fee">₱${service.fee === 0 ? 'FREE' : service.fee}</span>
            </div>
            <p class="service-description">${service.description}</p>
            
            <div class="service-requirements">
                <h4>Requirements:</h4>
                <ul>
                    ${service.requirements.map(req => `<li>${req}</li>`).join('')}
                </ul>
            </div>
            
            <div class="service-meta">
                <span>📂 ${service.category}</span>
                <span>⏱️ ${service.processingTime}</span>
            </div>
        </div>
    `).join('');
    
    servicesList.innerHTML = html;
}

// Render announcements
function renderAnnouncements() {
    if (!barangayData || !barangayData.announcements) return;
    
    // Sort by date (newest first)
    const sorted = [...barangayData.announcements].sort((a, b) => 
        new Date(b.date) - new Date(a.date)
    );
    
    const html = sorted.map(announcement => `
        <div class="announcement-card ${announcement.type}">
            <div class="announcement-header">
                <h3 class="announcement-title">${announcement.title}</h3>
                <span class="announcement-date">${formatDate(announcement.date)}</span>
            </div>
            <p class="announcement-content">${announcement.content}</p>
            <span class="announcement-type">${announcement.type}</span>
        </div>
    `).join('');
    
    announcementsList.innerHTML = html;
}

// Render contact information
function renderContact() {
    if (!barangayData || !barangayData.barangay) return;
    
    const info = barangayData.barangay;
    
    contactInfo.innerHTML = `
        <div class="contact-item">
            <span class="contact-icon">📍</span>
            <div class="contact-details">
                <h3>Address</h3>
                <p>${info.address}</p>
            </div>
        </div>
        
        <div class="contact-item">
            <span class="contact-icon">📞</span>
            <div class="contact-details">
                <h3>Phone</h3>
                <p>${info.phone}</p>
            </div>
        </div>
        
        <div class="contact-item">
            <span class="contact-icon">📧</span>
            <div class="contact-details">
                <h3>Email</h3>
                <p>${info.email}</p>
            </div>
        </div>
        
        <div class="contact-item">
            <span class="contact-icon">🕐</span>
            <div class="contact-details">
                <h3>Office Hours</h3>
                <p>${info.hours}</p>
            </div>
        </div>
    `;
}

// Setup event listeners
function setupEventListeners() {
    // Service search
    if (serviceSearch) {
        serviceSearch.addEventListener('input', filterServices);
    }
    
    // Category filter
    if (categoryFilter) {
        categoryFilter.addEventListener('change', filterServices);
    }
    
    // Navigation smooth scroll
    document.querySelectorAll('.nav-link').forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            const targetId = link.getAttribute('href').substring(1);
            scrollToSection(targetId);
            
            // Update active link
            document.querySelectorAll('.nav-link').forEach(l => l.classList.remove('active'));
            link.classList.add('active');
        });
    });
}

// Filter services
function filterServices() {
    if (!barangayData || !barangayData.services) return;
    
    const searchTerm = serviceSearch.value.toLowerCase();
    const category = categoryFilter.value;
    
    filteredServices = barangayData.services.filter(service => {
        const matchesSearch = service.name.toLowerCase().includes(searchTerm) ||
                            service.description.toLowerCase().includes(searchTerm);
        
        const matchesCategory = category === 'all' || service.category === category;
        
        return matchesSearch && matchesCategory;
    });
    
    renderServices();
}

// Smooth scroll to section
function scrollToSection(sectionId) {
    const section = document.getElementById(sectionId);
    if (section) {
        section.scrollIntoView({ behavior: 'smooth' });
    }
}

// Format date
function formatDate(dateString) {
    const date = new Date(dateString);
    const options = { year: 'numeric', month: 'long', day: 'numeric' };
    return date.toLocaleDateString('en-US', options);
}
```

---

## Activity 6: Testing the Application

1. Create folder structure:
```
project/
├── index.html
├── styles.css
├── script.js
└── data/
    └── barangay-data.json
```

2. Open `index.html` in a browser
3. Test all features:
   - Navigation links
   - Service search
   - Category filter
   - Smooth scrolling
   - Responsive design

---

## Activity 7: Enhancement Ideas

Add these features to improve the application:

```javascript
// 1. Add sorting for services
function sortServices(sortBy) {
    if (sortBy === 'fee-low') {
        filteredServices.sort((a, b) => a.fee - b.fee);
    } else if (sortBy === 'fee-high') {
        filteredServices.sort((a, b) => b.fee - a.fee);
    } else if (sortBy === 'name') {
        filteredServices.sort((a, b) => a.name.localeCompare(b.name));
    }
    renderServices();
}

// 2. Add service details modal
function showServiceDetails(serviceId) {
    const service = barangayData.services.find(s => s.id === serviceId);
    // Create and show modal with full details
}

// 3. Add dark mode toggle
function toggleDarkMode() {
    document.body.classList.toggle('dark-mode');
    localStorage.setItem('darkMode', document.body.classList.contains('dark-mode'));
}

// 4. Add print functionality for services
function printService(serviceId) {
    window.print();
}

// 5. Add email subscription for announcements
async function subscribeToAnnouncements(email) {
    // Send email to backend for subscription
}
```

---

## 📚 Key Takeaways

1. **Data-driven** - All content loaded from JSON file
2. **Dynamic rendering** - DOM created with JavaScript
3. **Interactive filters** - Real-time search and filtering
4. **Responsive design** - Works on all devices
5. **Clean code** - Separated concerns (HTML, CSS, JS)
6. **User experience** - Loading states, smooth scrolling, hover effects
7. **Maintainable** - Easy to update data without changing code

---

## 🚀 Challenge

Enhance the application by adding:
1. Contact form with validation
2. Service request tracking system
3. Photo gallery for barangay events
4. Interactive map showing barangay location
5. Feedback/comments section
6. Mobile app-like navigation
7. Offline support with Service Workers

Congratulations! You've built a complete dynamic barangay information portal! 🎉
