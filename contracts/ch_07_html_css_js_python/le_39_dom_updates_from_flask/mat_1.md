## Background Story

Tian successfully connected his JavaScript frontend to his Flask backend. He could send data from forms to Flask endpoints, and Flask would respond with JSON. But there was a critical missing piece that became painfully obvious when he tested the application.

He'd added a "View Applications" button that fetched all barangay clearance applications from Flask. When clicked, he saw the Flask response in the browser console:

```javascript
[
  {id: 1, name: 'Juan Dela Cruz', service: 'Clearance', status: 'pending'},
  {id: 2, name: 'Maria Santos', service: 'ID', status: 'approved'},
  {id: 3, name: 'Pedro Reyes', service: 'Permit', status: 'processing'}
]
```

Perfect! The data was arriving from Flask. But when he looked at the actual webpage, it was just... blank. The data existed in JavaScript memory, logged beautifully in the console, pero walang nakikita sa actual page.

"What's the point of fetching data if users can't see it?" Tian muttered, frustrated.

Rhea Joy was experiencing the same disconnect. She'd fetched a list of barangay residents from Flask, could see all 50 resident objects in the console, but the webpage showed nothing. "It's like the data is invisible. It exists, but only developers looking at the console can see it. Regular users just see an empty page."

She tried a desperate hack—manually copying the data from the console and hardcoding it into HTML. It worked, but obviously wasn't a solution. "There has to be a way to automatically convert JSON data into visible HTML elements, right?"

They video called Miguel, sharing their screens showing data in the console but blank pages. "Kuya, we successfully fetch data from Flask, pero how do we actually DISPLAY it? How do we turn JSON objects into HTML elements that users can see?"

Miguel understood immediately. "Ah, you've mastered fetch but haven't connected it to DOM manipulation. Let me show you what happens when you visit any modern website."

He opened Instagram as an example. "When you load Instagram:

1. The HTML page loads—mostly empty containers
2. JavaScript immediately fetches your feed data from Instagram's servers
3. **This is where the magic happens**: JavaScript takes that JSON data and dynamically creates HTML elements—post containers, images, captions, comment sections—and inserts them into the DOM
4. You see a beautiful feed, even though the actual HTML file was nearly empty

That step 3 is what you're missing—turning data into DOM elements."

Tian watched as Miguel demonstrated with their barangay data:

```javascript
// Fetch from Flask
const response = await fetch('/api/applications');
const applications = await response.json();

// Now what? The data is in the `applications` variable.
// But users can't see JavaScript variables.
// We need to CREATE HTML ELEMENTS.

const container = document.getElementById('applications-list');

applications.forEach(app => {
    // Create elements for each application
    const card = document.createElement('div');
    card.className = 'application-card';
    
    card.innerHTML = `
        <h3>${app.name}</h3>
        <p>Service: ${app.service}</p>
        <span class="status ${app.status}">${app.status}</span>
    `;
    
    // Add to page
    container.appendChild(card);
});
```

"THAT'S what we were missing!" Tian exclaimed. "We fetch the data, pero then we need to loop through it, create HTML elements for each item, and append them to the DOM. That's how data becomes visible!"

Rhea Joy was having a revelation. "So every dynamic website—Facebook, Twitter, YouTube, Netflix—they all follow this pattern:

1. Fetch data from backend
2. Loop through the data array
3. Create HTML elements for each item
4. Append to the page

That's why Netflix can show thousands of shows without having thousands of HTML files. They fetch a JSON array, then dynamically create the thumbnails!"

"Exactly!" Miguel confirmed. "The HTML page is just a template with empty containers. JavaScript fills those containers with data from the backend. That's the foundation of modern web applications."

Tian thought about the implications. "So when I load our barangay portal:

- The HTML loads first—header, empty containers, loading spinners
- JavaScript runs `fetch('/api/services')`
- Flask responds with JSON array of services
- JavaScript loops through that array
- For each service, JavaScript creates a card element
- JavaScript appends all cards to the services container
- User sees a grid of beautiful service cards

All happening in milliseconds!"

"That's web development," Miguel said. "The HTML is the skeleton. The data is the content. JavaScript is the muscle that places content into the skeleton."

Rhea Joy was already refactoring her code. "And if the data changes on the backend—new residents added, applications updated—we just fetch again and re-render. The page updates to match the database automatically."

Miguel showed them a pattern he called "fetch-render-display":

```javascript
// PATTERN: Fetch data, render elements, display on page

async function loadResidents() {
    // 1. FETCH: Get data from Flask
    const response = await fetch('/api/residents');
    const residents = await response.json();
    
    // 2. RENDER: Create HTML elements from data
    const residentCards = residents.map(resident => {
        return `
            <div class="resident-card">
                <h3>${resident.name}</h3>
                <p>Age: ${resident.age}</p>
                <p>Address: ${resident.address}</p>
            </div>
        `;
    }).join('');
    
    // 3. DISPLAY: Insert into page
    document.getElementById('residents').innerHTML = residentCards;
}

// Run when page loads
window.addEventListener('DOMContentLoaded', loadResidents);
```

Tian saw the elegance: "Fetch gets the data. Render creates the HTML. Display puts it on the page. Three clear steps."

"And you can reuse this pattern everywhere," Miguel added. "Loading services? Fetch-render-display. Loading applications? Fetch-render-display. Search results? Fetch-render-display. It's the universal pattern for dynamic content."

Rhea Joy noticed something important. "This means our pages load faster! Instead of Flask generating full HTML pages with all the data (which is slow), Flask just sends lean JSON data. JavaScript on the client side does the rendering work. The server stays fast."

"That's one of the key benefits of this architecture," Miguel confirmed. "It's called client-side rendering. The backend focuses on data. The frontend focuses on presentation. Separation of concerns."

Tian tested the pattern with their barangay applications:

```javascript
async function loadApplications() {
    try {
        const response = await fetch('/api/applications');
        const applications = await response.json();
        
        const container = document.getElementById('applications');
        container.innerHTML = '';  // Clear previous content
        
        applications.forEach(app => {
            const card = document.createElement('div');
            card.className = 'application-card';
            card.innerHTML = `
                <div class="app-header">
                    <h3>${app.name}</h3>
                    <span class="status status-${app.status}">
                        ${app.status}
                    </span>
                </div>
                <p><strong>Service:</strong> ${app.service}</p>
                <p><strong>Date:</strong> ${new Date(app.date).toLocaleDateString()}</p>
                <button onclick="viewDetails(${app.id})">View Details</button>
            `;
            container.appendChild(card);
        });
        
    } catch (error) {
        console.error('Error loading applications:', error);
        document.getElementById('applications').innerHTML = 
            '<p class="error">Failed to load applications. Please try again.</p>';
    }
}
```

When he clicked "Load Applications" and saw his empty page suddenly populate with beautifully formatted cards showing all the data from Flask, he felt a surge of accomplishment.

"It works! The data flows from Flask database → Flask API → JavaScript fetch → DOM manipulation → Visible webpage!"

Rhea Joy tested it by adding a new application through the form, then clicking "Load Applications" again. The new entry appeared instantly. "This is incredible! It's truly dynamic. Add data in Flask, display it instantly in the browser."

Miguel gave them the final challenge: "Now make it automatic. Don't make users click 'Load Applications'. Run the fetch when the page loads using `DOMContentLoaded`. Show a loading spinner while fetching. Display an error message if fetch fails. Handle edge cases like empty arrays. Make it feel professional."

Tian added the event listener:

```javascript
window.addEventListener('DOMContentLoaded', async () => {
    showLoadingSpinner();
    await loadApplications();
    hideLoadingSpinner();
});
```

When he refreshed the page, he saw: loading spinner appears → 1 second pause → spinner disappears → applications appear. Smooth, professional, automatic.

"This is how real applications work," he said with satisfaction. "Data from backend, rendered dynamically on frontend, no page refreshes, seamless user experience."

Miguel smiled. "You've mastered the full-stack data flow. Frontend fetches from backend, backend responds with data, frontend renders it beautifully. That's modern web development. Now every interactive website you visit, you'll understand exactly how it works."

---

## Theory & Lecture Content

## Displaying Flask Data Dynamically

When you fetch data from Flask, you get JSON. Now you need to display it on the page using DOM manipulation.

### Basic Pattern

**Flask Backend (app.py):**
```python
from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/api/residents')
def get_residents():
    residents = [
        {'id': 1, 'name': 'Juan Dela Cruz', 'age': 30, 'status': 'active'},
        {'id': 2, 'name': 'Maria Santos', 'age': 25, 'status': 'active'},
        {'id': 3, 'name': 'Pedro Reyes', 'age': 65, 'status': 'senior'}
    ]
    return jsonify(residents)
```

**JavaScript Frontend:**
```javascript
// Fetch data when page loads
window.addEventListener('DOMContentLoaded', async () => {
    await loadResidents();
});

async function loadResidents() {
    try {
        // Fetch from Flask
        const response = await fetch('/api/residents');
        const residents = await response.json();
        
        // Display on page
        displayResidents(residents);
        
    } catch (error) {
        console.error('Error loading residents:', error);
    }
}

function displayResidents(residents) {
    const container = document.querySelector('#residentsContainer');
    
    // Clear existing content
    container.innerHTML = '';
    
    // Create HTML for each resident
    residents.forEach(resident => {
        const card = document.createElement('div');
        card.className = 'resident-card';
        
        card.innerHTML = `
            <h3>${resident.name}</h3>
            <p>Age: ${resident.age}</p>
            <span class="badge ${resident.status}">${resident.status}</span>
        `;
        
        container.appendChild(card);
    });
}
```

**HTML:**
```html
<div id="residentsContainer"></div>
```

---

## Complete Barangay Announcements Example

**Flask Backend:**
```python
@app.route('/api/announcements')
def get_announcements():
    announcements = [
        {
            'id': 1,
            'title': 'Barangay Assembly',
            'content': 'Mayroon pong assembly sa Sabado, 2 PM sa covered court.',
            'category': 'event',
            'date': '2025-01-15'
        },
        {
            'id': 2,
            'title': 'Garbage Collection Schedule',
            'content': 'Tuwing Martes at Biyernes ang garbage collection.',
            'category': 'info',
            'date': '2025-01-10'
        },
        {
            'id': 3,
            'title': 'Flood Warning',
            'content': 'Malakas na ulan ngayong linggo. Mag-ingat po tayo.',
            'category': 'warning',
            'date': '2025-01-12'
        }
    ]
    return jsonify(announcements)
```

**JavaScript:**
```javascript
async function loadAnnouncements() {
    const response = await fetch('/api/announcements');
    const announcements = await response.json();
    
    const container = document.querySelector('#announcementsContainer');
    container.innerHTML = '';
    
    announcements.forEach(announcement => {
        const announcementDiv = document.createElement('div');
        announcementDiv.className = `announcement ${announcement.category}`;
        
        announcementDiv.innerHTML = `
            <div class="announcement-header">
                <h3>${announcement.title}</h3>
                <span class="category-badge ${announcement.category}">
                    ${announcement.category.toUpperCase()}
                </span>
            </div>
            <p class="announcement-content">${announcement.content}</p>
            <small class="announcement-date">${formatDate(announcement.date)}</small>
        `;
        
        container.appendChild(announcementDiv);
    });
}

function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-PH', {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    });
}

// Load on page load
window.addEventListener('DOMContentLoaded', loadAnnouncements);
```

**CSS:**
```css
.announcement {
    background: white;
    padding: 20px;
    margin: 15px 0;
    border-radius: 8px;
    border-left: 5px solid #ccc;
}

.announcement.event {
    border-left-color: #1a73e8;
}

.announcement.info {
    border-left-color: #34a853;
}

.announcement.warning {
    border-left-color: #dc3545;
}

.category-badge {
    padding: 5px 10px;
    border-radius: 5px;
    font-size: 12px;
    font-weight: bold;
}

.category-badge.event {
    background: #e3f2fd;
    color: #1a73e8;
}

.category-badge.info {
    background: #e8f5e9;
    color: #34a853;
}

.category-badge.warning {
    background: #ffebee;
    color: #dc3545;
}
```

---

## Loading States and Error Handling

**Show loading indicator:**
```javascript
async function loadResidents() {
    const container = document.querySelector('#residentsContainer');
    
    // Show loading
    container.innerHTML = '<p class="loading">Loading residents...</p>';
    
    try {
        const response = await fetch('/api/residents');
        
        if (!response.ok) {
            throw new Error('Failed to load residents');
        }
        
        const residents = await response.json();
        displayResidents(residents);
        
    } catch (error) {
        // Show error message
        container.innerHTML = `
            <p class="error">Error loading residents: ${error.message}</p>
            <button onclick="loadResidents()">Try Again</button>
        `;
    }
}
```

---

## Filtering and Searching Data

**Filter announcements by category:**
```javascript
let allAnnouncements = [];

async function loadAnnouncements() {
    const response = await fetch('/api/announcements');
    allAnnouncements = await response.json();
    displayAnnouncements(allAnnouncements);
}

function filterByCategory(category) {
    if (category === 'all') {
        displayAnnouncements(allAnnouncements);
    } else {
        const filtered = allAnnouncements.filter(a => a.category === category);
        displayAnnouncements(filtered);
    }
}

function displayAnnouncements(announcements) {
    const container = document.querySelector('#announcementsContainer');
    
    if (announcements.length === 0) {
        container.innerHTML = '<p>No announcements found.</p>';
        return;
    }
    
    container.innerHTML = announcements.map(announcement => `
        <div class="announcement ${announcement.category}">
            <h3>${announcement.title}</h3>
            <p>${announcement.content}</p>
        </div>
    `).join('');
}
```

**HTML:**
```html
<div class="filter-buttons">
    <button onclick="filterByCategory('all')">All</button>
    <button onclick="filterByCategory('event')">Events</button>
    <button onclick="filterByCategory('info')">Info</button>
    <button onclick="filterByCategory('warning')">Warnings</button>
</div>

<div id="announcementsContainer"></div>
```

---

## Complete Dashboard Example

**Flask:**
```python
@app.route('/api/dashboard')
def get_dashboard_stats():
    stats = {
        'total_residents': 1247,
        'active_complaints': 15,
        'pending_documents': 8,
        'upcoming_events': 3,
        'recent_activities': [
            {'user': 'Juan Dela Cruz', 'action': 'Filed complaint', 'time': '2 hours ago'},
            {'user': 'Maria Santos', 'action': 'Requested clearance', 'time': '5 hours ago'},
            {'user': 'Admin', 'action': 'Posted announcement', 'time': '1 day ago'}
        ]
    }
    return jsonify(stats)
```

**JavaScript:**
```javascript
async function loadDashboard() {
    const response = await fetch('/api/dashboard');
    const data = await response.json();
    
    // Update statistics
    document.querySelector('#totalResidents').textContent = data.total_residents;
    document.querySelector('#activeComplaints').textContent = data.active_complaints;
    document.querySelector('#pendingDocuments').textContent = data.pending_documents;
    document.querySelector('#upcomingEvents').textContent = data.upcoming_events;
    
    // Display recent activities
    const activitiesContainer = document.querySelector('#recentActivities');
    activitiesContainer.innerHTML = data.recent_activities.map(activity => `
        <div class="activity">
            <strong>${activity.user}</strong> ${activity.action}
            <span class="time">${activity.time}</span>
        </div>
    `).join('');
}

window.addEventListener('DOMContentLoaded', loadDashboard);
```

**HTML:**
```html
<div class="stats-grid">
    <div class="stat-card">
        <h3 id="totalResidents">0</h3>
        <p>Total Residents</p>
    </div>
    <div class="stat-card">
        <h3 id="activeComplaints">0</h3>
        <p>Active Complaints</p>
    </div>
    <div class="stat-card">
        <h3 id="pendingDocuments">0</h3>
        <p>Pending Documents</p>
    </div>
    <div class="stat-card">
        <h3 id="upcomingEvents">0</h3>
        <p>Upcoming Events</p>
    </div>
</div>

<div id="recentActivities"></div>
```

---

## Best Practices

1. **Show loading states** - Users should know data is being fetched
2. **Handle errors gracefully** - Show user-friendly error messages
3. **Validate data** - Check if response is valid before displaying
4. **Use template literals** - Clean HTML generation
5. **Cache data when appropriate** - Reduce unnecessary API calls
6. **Provide retry options** - Let users try again if fetch fails

---

## Summary

**Pattern for displaying Flask data:**
```javascript
// 1. Fetch data from Flask
const response = await fetch('/api/endpoint');
const data = await response.json();

// 2. Clear container
container.innerHTML = '';

// 3. Loop through data and create HTML
data.forEach(item => {
    const element = document.createElement('div');
    element.innerHTML = `<h3>${item.title}</h3>`;
    container.appendChild(element);
});
```

---

## What's Next?

In the next lesson, you'll learn **CRUD - Create and Read**—sending data to Flask to create new records and reading them back!

---

---

## Closing Story

Tian wrote the code. When the page loaded, JavaScript fetched announcements from Flask and displayed them automatically. No page refresh. The data just appeared.

"This is what users expect now," Kuya Miguel said. "Dynamic content. Real-time updates. Smooth experiences."

Tian added a filter button. Clicked "Events." The page instantly showed only event announcements. No reload. Just filtered data.

Rhea Joy tested it on her phone. "Wow, parang real app na talaga!"

Tian smiled. The barangay portal was coming alive.

_Next up: CRUD Part 1 - Create and Read operations!_
