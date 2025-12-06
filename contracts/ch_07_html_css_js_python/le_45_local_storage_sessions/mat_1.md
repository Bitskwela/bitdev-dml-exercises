## Background Story

The secure barangay portal had been live for two weeks. Residents were using it regularly, submitting complaints and checking statuses. But Tian started receiving consistent feedback that revealed a user experience problem.

Maria Santos, a frequent user, complained: "Every single time I refresh the page, I have to log in again. I was looking at my complaint details, accidentally hit F5, and suddenly I'm at the login screen. Ang hassle!"

Pedro Reyes echoed: "I set the text size to large because my eyes aren't great, pero when I come back the next day, it's back to default. The site doesn't remember my preferences."

Ms. Reyes from the barangay office added: "I was editing a long complaint description, my browser crashed, and when I reopened it, everything I typed was gone. There's no auto-save or draft feature."

Tian realized the application had a fundamental problem: **zero client-side persistence**. Every page refresh, every browser tab close, every accidental navigation away—users lost their state. Login status, preferences, form data, everything reset.

He demonstrated the problem to Rhea Joy: "Watch. I log in, browse to the complaints page, refresh—logged out. I change the theme to dark mode, refresh—back to light mode. I start typing a complaint, close the tab, reopen—lost everything."

Rhea Joy tested her own experience: "Even worse—I have three browser tabs open, logged in on one. But the other two tabs don't know I'm logged in. Each tab thinks I'm a different user. There's no shared state across tabs."

They called Kuya Miguel to explain the usability problems. "Kuya, our users keep losing their state. They log in, refresh, logged out. They set preferences, refresh, preferences reset. There's no persistence on the client side. How do real websites handle this?"

Miguel understood immediately. "You've discovered the importance of client-side state management. Right now, everything exists in JavaScript memory, which gets cleared on refresh. You need to use **browser storage APIs**—localStorage for long-term persistence and sessionStorage for temporary data."

He demonstrated by opening Twitter. "Watch what happens when I log into Twitter and refresh the page. Still logged in, right? Twitter stores my authentication token in localStorage. The browser remembers it even after refresh, even after closing the browser. That's client-side persistence."

He opened YouTube and changed the video quality to 1080p. "YouTube saves my preference to localStorage. Tomorrow, when I come back, videos will still play in 1080p. The site remembers."

Tian was taking notes. "So localStorage is like a mini-database in the browser? JavaScript can save data there, and it persists across page reloads and browser sessions?"

"Exactly," Miguel confirmed. "localStorage stores key-value pairs. You can save strings, numbers, objects (as JSON), arrays—anything. The data persists until explicitly deleted. Perfect for user preferences, authentication tokens, cached data, and anything that should survive page refreshes."

Rhea Joy asked, "What about sessionStorage? How is that different?"

"sessionStorage is similar, pero data only lasts for the current tab session," Miguel explained. "Close the tab, data is gone. Perfect for temporary state—form drafts, current filters, pagination state. Stuff you want to persist during navigation pero not permanently."

He pulled up a comparison:

```
localStorage:
- Persists forever (until manually cleared)
- ~5-10MB storage limit
- Shared across all tabs of the same site
- Survives browser restart
- Use for: auth tokens, user preferences, cached data

sessionStorage:
- Persists until tab closes
- ~5-10MB storage limit
- Isolated per tab
- Lost on browser restart
- Use for: form drafts, temporary state, tab-specific data
```

Tian immediately saw applications: "So for the barangay portal:

- **localStorage**: Save auth token after login, so users stay logged in across refreshes. Save theme preference (light/dark). Save text size preference. Save language preference. Cache frequently accessed data like complaint categories.

- **sessionStorage**: Save form drafts as users type, so accidental refresh doesn't lose data. Save current filter/search terms. Save scroll position. Temporary state that shouldn't persist forever."

"Perfect understanding," Miguel said. "And there's a third option—**cookies**—pero localStorage and sessionStorage are easier to use and more storage capacity. Cookies are mainly for server communication and authentication."

Rhea Joy was already thinking about the implementation: "So when a user logs in successfully, instead of just showing them the dashboard, we also save their auth token to localStorage:

```javascript
const response = await fetch('/api/login', {...});
const data = await response.json();

if (data.success) {
    localStorage.setItem('authToken', data.token);
    localStorage.setItem('username', data.username);
    // Now redirect to dashboard
}
```

Then when the page loads, we check localStorage:

```javascript
window.addEventListener('DOMContentLoaded', () => {
    const token = localStorage.getItem('authToken');
    if (token) {
        // User is logged in, show dashboard
        loadDashboard();
    } else {
        // No token, show login page
        showLogin();
    }
});
```

No more forced re-login on every refresh!"

Miguel applauded. "Exactly! And you can extend this to every preference:"

```javascript
// Save theme preference
document.getElementById('themeToggle').addEventListener('click', () => {
    const currentTheme = document.body.classList.contains('dark') ? 'dark' : 'light';
    const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
    
    document.body.classList.toggle('dark');
    localStorage.setItem('theme', newTheme);
});

// Load theme preference on page load
const savedTheme = localStorage.getItem('theme') || 'light';
if (savedTheme === 'dark') {
    document.body.classList.add('dark');
}
```

Tian saw the dramatic improvement in user experience. "Users set preferences once, and the site remembers forever. That's how professional websites work!"

Miguel showed them the form autosave pattern:

```javascript
// Auto-save form draft to sessionStorage
const complaintForm = document.getElementById('complaintForm');
complaintForm.addEventListener('input', () => {
    const formData = {
        name: document.getElementById('name').value,
        category: document.getElementById('category').value,
        description: document.getElementById('description').value
    };
    sessionStorage.setItem('complaintDraft', JSON.stringify(formData));
});

// Restore draft on page load
const draft = sessionStorage.getItem('complaintDraft');
if (draft) {
    const data = JSON.parse(draft);
    document.getElementById('name').value = data.name;
    document.getElementById('category').value = data.category;
    document.getElementById('description').value = data.description;
    
    // Ask user if they want to restore draft
    if (confirm('Found unsaved complaint. Restore it?')) {
        // Keep the data
    } else {
        sessionStorage.removeItem('complaintDraft');
    }
}
```

"Now if the browser crashes while typing, the draft is safe!" Rhea Joy said excitedly.

Miguel demonstrated more patterns:

**Remember logged-in status across tabs:**
```javascript
// Tab 1: User logs in
localStorage.setItem('authToken', token);

// Tab 2: Listen for storage changes
window.addEventListener('storage', (e) => {
    if (e.key === 'authToken') {
        if (e.newValue) {
            // User logged in on another tab, update this tab
            loadDashboard();
        } else {
            // User logged out on another tab, update this tab
            showLogin();
        }
    }
});
```

**Cache API responses:**
```javascript
// Fetch complaint categories
const cached = localStorage.getItem('categories');
if (cached) {
    // Use cached data
    displayCategories(JSON.parse(cached));
} else {
    // Fetch from API
    const response = await fetch('/api/categories');
    const categories = await response.json();
    
    // Cache for next time
    localStorage.setItem('categories', JSON.stringify(categories));
    displayCategories(categories);
}
```

Tian was amazed at how much localStorage improved user experience. "This solves so many annoyances: stay logged in, remember preferences, save drafts, cache data, sync state across tabs. All with just localStorage and sessionStorage!"

Miguel gave important security warnings: "**Never store sensitive data in localStorage**—like full passwords or credit card numbers. Authentication tokens are okay if they're short-lived and properly secured. But localStorage is accessible to any JavaScript on your page, including malicious scripts. So: tokens yes, passwords no. Preferences yes, private data no."

Rhea Joy created a comprehensive storage plan for the barangay portal:

**localStorage (persistent):**
- authToken (for staying logged in)
- username (for displaying welcome message)
- theme (light/dark preference)
- textSize (accessibility preference)
- language (Tagalog/English)
- cachedCategories (complaint categories list)

**sessionStorage (temporary):**
- complaintDraft (form autosave)
- searchQuery (current search term)
- filterStatus (current filter)
- scrollPosition (where user was on the page)

Tian and Rhea Joy spent the afternoon implementing localStorage and sessionStorage throughout the barangay portal. When they tested it:

- Log in, refresh page → Still logged in! ✓
- Change to dark mode, close browser, reopen → Still dark! ✓
- Start typing complaint, accidentally refresh → Draft restored! ✓
- Log in on one tab, switch to another tab → Automatically logged in there too! ✓
- Close tab with unsaved form → Draft lost (as intended with sessionStorage) ✓
- Clear localStorage → Logged out and preferences reset (as expected) ✓

Maria Santos tested the updated portal: "Wow! I don't have to log in every time now. And it remembered my text size preference! This is so much better!"

Pedro Reyes was thrilled: "I started writing a complaint, got distracted, closed the tab accidentally. When I came back, it asked if I wanted to restore my draft. Saved me so much retyping!"

Tian felt proud. "We didn't change any core functionality, pero the user experience improved dramatically. That's the power of client-side persistence."

Miguel smiled through the video call. "You've learned that great applications aren't just about features—they're about user experience. localStorage and sessionStorage are simple APIs, pero they make websites feel professional, polished, and user-friendly. Remember: users judge your app not by your code quality, but by how it feels to use. And persisting state makes it feel smooth, seamless, and respectful of their time."

---

## Theory & Lecture Content

## Client-Side Storage Options

### Comparison

| Feature | localStorage | sessionStorage | Cookies | IndexedDB |
|---------|-------------|----------------|---------|-----------|
| **Capacity** | ~5-10MB | ~5-10MB | ~4KB | ~50MB+ |
| **Persistence** | Until cleared | Until tab closed | Has expiration | Until cleared |
| **Accessibility** | Same origin | Same tab only | Server + Client | Same origin |
| **Use Case** | User preferences | Temporary data | Authentication | Large datasets |

For this lesson, we focus on **localStorage** and **sessionStorage**.

## localStorage Basics

### What is localStorage?

**localStorage** stores data in the browser with no expiration time. Data persists even after closing the browser.

### Basic Operations

```javascript
// Store data
localStorage.setItem('username', 'tian');
localStorage.setItem('theme', 'dark');
localStorage.setItem('fontSize', '16');

// Retrieve data
const username = localStorage.getItem('username');  // "tian"
const theme = localStorage.getItem('theme');        // "dark"

// Remove specific item
localStorage.removeItem('theme');

// Clear all localStorage
localStorage.clear();

// Check if key exists
if (localStorage.getItem('username')) {
    console.log('Username is set');
}

// Get number of items
const count = localStorage.length;

// Get key by index
const firstKey = localStorage.key(0);
```

### Storing Objects

localStorage only stores **strings**. For objects, use JSON:

```javascript
// Store object
const user = {
    id: 123,
    username: 'tian',
    email: 'tian@barangay.ph',
    preferences: {
        theme: 'dark',
        notifications: true
    }
};

localStorage.setItem('user', JSON.stringify(user));

// Retrieve object
const storedUser = JSON.parse(localStorage.getItem('user'));
console.log(storedUser.username);  // "tian"
console.log(storedUser.preferences.theme);  // "dark"

// Handle null values
const user = JSON.parse(localStorage.getItem('user') || '{}');
```

## sessionStorage Basics

### What is sessionStorage?

**sessionStorage** stores data for one session (until browser tab is closed). Each tab has separate storage.

### Basic Operations

```javascript
// Exact same API as localStorage
sessionStorage.setItem('tempData', 'value');
const data = sessionStorage.getItem('tempData');
sessionStorage.removeItem('tempData');
sessionStorage.clear();
```

### When to Use Each

**Use localStorage for:**
- User preferences (theme, language, font size)
- Shopping cart items
- Form draft data (auto-save)
- Recently viewed items
- Non-sensitive user settings

**Use sessionStorage for:**
- Multi-step form data
- Temporary filters/search queries
- Current page state
- Wizard/stepper progress
- Non-persistent UI state

**Don't store in localStorage/sessionStorage:**
- Passwords or auth tokens (use httpOnly cookies)
- Personal/sensitive data (PII)
- Credit card info
- Large files (use IndexedDB instead)

## Practical Example: Theme Persistence

```javascript
// theme.js

// Load saved theme on page load
document.addEventListener('DOMContentLoaded', () => {
    const savedTheme = localStorage.getItem('theme') || 'light';
    applyTheme(savedTheme);
});

// Theme toggle button
document.getElementById('theme-toggle').addEventListener('click', () => {
    const currentTheme = localStorage.getItem('theme') || 'light';
    const newTheme = currentTheme === 'light' ? 'dark' : 'light';
    
    localStorage.setItem('theme', newTheme);
    applyTheme(newTheme);
});

function applyTheme(theme) {
    if (theme === 'dark') {
        document.body.classList.add('dark-mode');
        document.getElementById('theme-toggle').textContent = 'Light Mode';
    } else {
        document.body.classList.remove('dark-mode');
        document.getElementById('theme-toggle').textContent = 'Dark Mode';
    }
}
```

```css
/* styles.css */
body {
    background-color: white;
    color: black;
    transition: all 0.3s ease;
}

body.dark-mode {
    background-color: #1a1a1a;
    color: #ffffff;
}
```

## Practical Example: Form Auto-Save

```html
<!-- complaint-form.html -->
<form id="complaint-form">
    <input type="text" id="name" placeholder="Your Name">
    <textarea id="description" placeholder="Describe the issue"></textarea>
    <input type="text" id="location" placeholder="Location">
    <button type="submit">Submit</button>
    <button type="button" id="clear-draft">Clear Draft</button>
</form>
<p id="autosave-status"></p>

<script>
// Auto-save form data as user types
const form = document.getElementById('complaint-form');
const fields = ['name', 'description', 'location'];

// Load saved draft on page load
window.addEventListener('DOMContentLoaded', () => {
    fields.forEach(field => {
        const savedValue = localStorage.getItem(`draft_${field}`);
        if (savedValue) {
            document.getElementById(field).value = savedValue;
            showStatus('Draft restored');
        }
    });
});

// Save on input
fields.forEach(field => {
    const element = document.getElementById(field);
    element.addEventListener('input', (e) => {
        localStorage.setItem(`draft_${field}`, e.target.value);
        showStatus('Draft saved');
    });
});

// Clear draft button
document.getElementById('clear-draft').addEventListener('click', () => {
    fields.forEach(field => {
        localStorage.removeItem(`draft_${field}`);
        document.getElementById(field).value = '';
    });
    showStatus('Draft cleared');
});

// Clear draft on successful submit
form.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    // Submit form data...
    const response = await submitComplaint();
    
    if (response.ok) {
        // Clear draft on success
        fields.forEach(field => localStorage.removeItem(`draft_${field}`));
        form.reset();
        showStatus('Submitted successfully!');
    }
});

function showStatus(message) {
    const status = document.getElementById('autosave-status');
    status.textContent = message;
    status.style.opacity = 1;
    setTimeout(() => status.style.opacity = 0, 2000);
}
</script>
```

## Combining localStorage with Flask Sessions

### Backend: Flask Session

```python
# Flask session - server-side, secure
from flask import session

@app.route('/login', methods=['POST'])
def login():
    # ... verify credentials ...
    
    # Store in Flask session (server-side)
    session['user_id'] = user.id
    session['username'] = user.username
    session['role'] = user.role  # 'admin' or 'resident'
    
    return jsonify({
        'user': {
            'id': user.id,
            'username': user.username,
            'role': user.role
        }
    }), 200
```

### Frontend: localStorage for Preferences

```javascript
// After successful login
async function login(username, password) {
    const response = await fetch('/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include',  // Important: send cookies
        body: JSON.stringify({ username, password })
    });
    
    if (response.ok) {
        const data = await response.json();
        
        // Store non-sensitive data in localStorage
        localStorage.setItem('username', data.user.username);
        localStorage.setItem('role', data.user.role);
        
        // Redirect to dashboard
        window.location.href = '/dashboard.html';
    }
}

// Check auth on protected pages
async function checkAuth() {
    // First, check if user data exists in localStorage
    const username = localStorage.getItem('username');
    
    if (!username) {
        window.location.href = '/login.html';
        return;
    }
    
    // Verify with server (Flask session)
    const response = await fetch('/me', {
        credentials: 'include'
    });
    
    if (!response.ok) {
        // Session expired - clear localStorage
        localStorage.removeItem('username');
        localStorage.removeItem('role');
        window.location.href = '/login.html';
    }
}
```

## Advanced: User Preferences System

```javascript
// preferences.js

class UserPreferences {
    constructor() {
        this.defaults = {
            theme: 'light',
            language: 'en',
            fontSize: 16,
            notifications: true,
            autoSave: true
        };
    }
    
    // Get preference with fallback to default
    get(key) {
        const stored = localStorage.getItem(`pref_${key}`);
        if (stored !== null) {
            // Parse boolean values
            if (stored === 'true') return true;
            if (stored === 'false') return false;
            // Parse numbers
            if (!isNaN(stored)) return parseFloat(stored);
            return stored;
        }
        return this.defaults[key];
    }
    
    // Set preference
    set(key, value) {
        localStorage.setItem(`pref_${key}`, value.toString());
        this.apply(key, value);
    }
    
    // Apply preference to UI
    apply(key, value) {
        switch(key) {
            case 'theme':
                document.body.classList.toggle('dark-mode', value === 'dark');
                break;
            case 'fontSize':
                document.documentElement.style.fontSize = `${value}px`;
                break;
            case 'language':
                // Load appropriate language file
                this.loadLanguage(value);
                break;
        }
    }
    
    // Load all preferences
    loadAll() {
        Object.keys(this.defaults).forEach(key => {
            const value = this.get(key);
            this.apply(key, value);
        });
    }
    
    // Reset to defaults
    reset() {
        Object.keys(this.defaults).forEach(key => {
            localStorage.removeItem(`pref_${key}`);
        });
        this.loadAll();
    }
}

// Usage
const prefs = new UserPreferences();
prefs.loadAll();  // Load on page load

// Settings page
document.getElementById('theme-select').addEventListener('change', (e) => {
    prefs.set('theme', e.target.value);
});

document.getElementById('font-size').addEventListener('input', (e) => {
    prefs.set('fontSize', e.target.value);
});
```

## Storage Events

Listen for storage changes across tabs:

```javascript
// Listen for storage changes in other tabs
window.addEventListener('storage', (e) => {
    if (e.key === 'theme') {
        console.log('Theme changed in another tab:', e.newValue);
        applyTheme(e.newValue);
    }
    
    if (e.key === null) {
        console.log('localStorage was cleared in another tab');
        location.reload();
    }
});
```

## Security Considerations

### What NOT to Store

```javascript
// NEVER store sensitive data in localStorage
localStorage.setItem('password', 'mypassword');  // DON'T!
localStorage.setItem('creditCard', '1234-5678');  // DON'T!
localStorage.setItem('authToken', 'Bearer abc123');  // DON'T!

// OK to store
localStorage.setItem('theme', 'dark');  // OK
localStorage.setItem('lastVisited', new Date().toISOString());  // OK
```

### XSS Protection

```javascript
// Sanitize user input before storing
function sanitize(input) {
    const div = document.createElement('div');
    div.textContent = input;
    return div.innerHTML;
}

const userInput = document.getElementById('bio').value;
localStorage.setItem('bio', sanitize(userInput));
```

## Debugging localStorage

### View in DevTools

**Chrome/Edge:**
1. F12 → Application tab
2. Storage → Local Storage
3. Select your domain

**Firefox:**
1. F12 → Storage tab
2. Local Storage

### Console Commands

```javascript
// View all localStorage
for (let i = 0; i < localStorage.length; i++) {
    const key = localStorage.key(i);
    console.log(key, localStorage.getItem(key));
}

// Or as object
console.table(localStorage);

// Check size
const size = new Blob(Object.values(localStorage)).size;
console.log(`localStorage size: ${(size / 1024).toFixed(2)} KB`);
```

## Best Practices

### 1. Namespace Your Keys

```javascript
// Avoid key collisions
localStorage.setItem('barangay_theme', 'dark');
localStorage.setItem('barangay_username', 'tian');

// Or use prefix function
function setItem(key, value) {
    localStorage.setItem(`barangay_${key}`, value);
}
```

### 2. Handle Quota Exceeded Errors

```javascript
function safeSetItem(key, value) {
    try {
        localStorage.setItem(key, value);
        return true;
    } catch (e) {
        if (e.name === 'QuotaExceededError') {
            console.error('localStorage quota exceeded');
            // Clear old data or show error to user
            return false;
        }
        throw e;
    }
}
```

### 3. Validate Retrieved Data

```javascript
function getObject(key, fallback = {}) {
    try {
        const item = localStorage.getItem(key);
        return item ? JSON.parse(item) : fallback;
    } catch (e) {
        console.error('Failed to parse localStorage item:', e);
        return fallback;
    }
}
```

## Real-World Philippine Context

### Multi-Language Support

```javascript
// Store user's language preference
const languages = {
    'en': 'English',
    'tl': 'Tagalog',
    'ceb': 'Cebuano',
    'ilo': 'Ilocano'
};

function setLanguage(code) {
    localStorage.setItem('language', code);
    loadTranslations(code);
}

// Load on page load
const savedLang = localStorage.getItem('language') || 'tl';
setLanguage(savedLang);
```

### Recent Searches

```javascript
function addRecentSearch(query) {
    const recent = JSON.parse(localStorage.getItem('recentSearches') || '[]');
    
    // Add to front, remove duplicates
    const updated = [query, ...recent.filter(q => q !== query)].slice(0, 10);
    
    localStorage.setItem('recentSearches', JSON.stringify(updated));
}

function getRecentSearches() {
    return JSON.parse(localStorage.getItem('recentSearches') || '[]');
}
```

## Testing localStorage

```javascript
// Check if localStorage is available
function isLocalStorageAvailable() {
    try {
        const test = '__localStorage_test__';
        localStorage.setItem(test, test);
        localStorage.removeItem(test);
        return true;
    } catch (e) {
        return false;
    }
}

if (!isLocalStorageAvailable()) {
    console.warn('localStorage not available. Using fallback.');
    // Use in-memory storage or cookies as fallback
}
```

## Summary

**localStorage:**
- Persists until manually cleared
- ~5-10MB capacity
- Use for user preferences, drafts, non-sensitive data

**sessionStorage:**
- Persists until tab closed
- Same API as localStorage
- Use for temporary data within a session

**Best Practices:**
- Never store sensitive data
- Namespace your keys
- Handle quota exceeded errors
- Validate retrieved data
- Combine with server-side sessions for security

**Use Cases:**
- Theme preferences
- Form auto-save
- Recent searches
- User settings
- Shopping cart items

Next lesson: Deploying your Flask + JS app to production!

---

## Closing Story

Tian implemented localStorage for theme persistence and form auto-save. Tested it. Worked perfectly. Refresh the page? Theme stayed dark. Close browser and reopen? Draft complaint still there.

Residents noticed immediately. "The site remembers me now!" one commented. "I started writing a complaint yesterday and it's still here!" another said.

Kuya Miguel reviewed the implementation. "Good use of localStorage. You're thinking about user experience now, not just functionality. That's the mark of a mature developer."

But Miguel had one more suggestion: "Now let's deploy this to a real server. No more localhost. Time to make it accessible to everyone in the barangay."

Tian felt a surge of nervousness mixed with excitement. This was it. The final step. From localhost to production. From personal project to public service.

Tomorrow, the barangay portal would go live. Real users. Real data. Real impact.

The journey was almost complete.

_Next up: Lesson 46 - Frontend JS + Flask Deployment!_