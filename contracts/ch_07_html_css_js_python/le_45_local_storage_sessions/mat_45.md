# Lesson 45: Using Local Storage and Sessions

## Background Story

Residents started using the barangay portal, but they kept complaining: "Every time I refresh the page, I have to login again!" and "Why doesn't the site remember my dark mode preference?"

Tian realized the app had no client-side persistence. Every refresh was like starting from scratch.

Kuya Miguel introduced two solutions: "For preferences and non-sensitive data, use **localStorage**. For temporary session data, use **sessionStorage**. And for server-side sessions, we already have Flask sessions. Let's combine them for the best user experience."

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
        document.getElementById('theme-toggle').textContent = '☀️ Light Mode';
    } else {
        document.body.classList.remove('dark-mode');
        document.getElementById('theme-toggle').textContent = '🌙 Dark Mode';
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

_Next up: Lesson 46—Frontend JS + Flask Deployment!_ 🚀