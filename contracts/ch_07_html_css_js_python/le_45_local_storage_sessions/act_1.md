# Activity 1: Local Storage and Sessions

In this activity, you'll learn how to store data in the browser using Local Storage and Session Storage. This allows your application to persist data even after the page is refreshed.

---

## Activity 1: Understanding Browser Storage

**Three types of browser storage:**

| Storage Type | Scope | Persistence | Size Limit | Use Case |
|--------------|-------|-------------|------------|----------|
| **Local Storage** | Domain-wide | Permanent (until manually cleared) | ~5-10MB | User preferences, auth tokens |
| **Session Storage** | Tab-specific | Until tab closes | ~5-10MB | Temporary data, form drafts |
| **Cookies** | Domain-wide | Set expiration | ~4KB | Server communication |

---

## Activity 2: Local Storage Basics

**Basic Operations:**

```javascript
// WRITE (Store data)
localStorage.setItem('key', 'value');
localStorage.setItem('username', 'Juan');
localStorage.setItem('theme', 'dark');

// READ (Retrieve data)
const username = localStorage.getItem('username');
console.log(username);  // "Juan"

// CHECK if exists
if (localStorage.getItem('username')) {
    console.log('User is logged in');
}

// DELETE (Remove single item)
localStorage.removeItem('username');

// CLEAR ALL
localStorage.clear();
```

---

## Activity 3: Storing Objects and Arrays

**Problem:** localStorage only stores strings!

**Solution:** Use JSON.stringify() and JSON.parse()

```javascript
// Storing an object
const user = {
    id: 1,
    name: 'Juan Dela Cruz',
    email: 'juan@example.com',
    role: 'admin'
};

// Convert to JSON string before storing
localStorage.setItem('user', JSON.stringify(user));

// Retrieve and parse back to object
const storedUser = JSON.parse(localStorage.getItem('user'));
console.log(storedUser.name);  // "Juan Dela Cruz"

// Storing an array
const favorites = ['Barangay Clearance', 'Business Permit', 'Barangay ID'];
localStorage.setItem('favorites', JSON.stringify(favorites));

// Retrieve array
const storedFavorites = JSON.parse(localStorage.getItem('favorites'));
console.log(storedFavorites[0]);  // "Barangay Clearance"
```

---

## Activity 4: Complete User Preferences System

**HTML:**

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Preferences with Local Storage</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: Arial, sans-serif;
            padding: 40px;
            transition: background 0.3s, color 0.3s;
        }
        
        body.light-theme {
            background: #ffffff;
            color: #333333;
        }
        
        body.dark-theme {
            background: #1a1a1a;
            color: #ffffff;
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
        }
        
        .preferences {
            background: rgba(0,0,0,0.1);
            padding: 30px;
            border-radius: 10px;
            margin-bottom: 30px;
        }
        
        .pref-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }
        
        select, input {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 2px solid #ddd;
            font-size: 16px;
        }
        
        button {
            padding: 12px 24px;
            background: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-right: 10px;
        }
        
        button:hover {
            background: #2980b9;
        }
        
        .storage-info {
            background: rgba(0,0,0,0.1);
            padding: 20px;
            border-radius: 10px;
            margin-top: 30px;
        }
        
        .storage-item {
            padding: 10px;
            margin: 5px 0;
            background: rgba(255,255,255,0.1);
            border-radius: 5px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>⚙️ User Preferences</h1>
        <p>Settings are saved automatically using Local Storage</p>
        
        <div class="preferences">
            <div class="pref-group">
                <label for="theme">Theme:</label>
                <select id="theme" onchange="changeTheme()">
                    <option value="light">Light</option>
                    <option value="dark">Dark</option>
                </select>
            </div>
            
            <div class="pref-group">
                <label for="language">Language:</label>
                <select id="language" onchange="changeLanguage()">
                    <option value="en">English</option>
                    <option value="fil">Filipino</option>
                </select>
            </div>
            
            <div class="pref-group">
                <label for="fontSize">Font Size:</label>
                <select id="fontSize" onchange="changeFontSize()">
                    <option value="14">Small (14px)</option>
                    <option value="16">Medium (16px)</option>
                    <option value="18">Large (18px)</option>
                    <option value="20">Extra Large (20px)</option>
                </select>
            </div>
            
            <div class="pref-group">
                <label for="notifications">Enable Notifications:</label>
                <input type="checkbox" id="notifications" onchange="toggleNotifications()">
            </div>
            
            <button onclick="resetPreferences()">Reset to Defaults</button>
            <button onclick="exportPreferences()">Export Settings</button>
        </div>
        
        <div class="storage-info">
            <h2>📦 Local Storage Contents</h2>
            <div id="storageList"></div>
            <button onclick="displayStorage()">Refresh Storage View</button>
        </div>
    </div>

    <script>
        // Default preferences
        const DEFAULT_PREFS = {
            theme: 'light',
            language: 'en',
            fontSize: 16,
            notifications: false
        };
        
        // Load preferences on page load
        document.addEventListener('DOMContentLoaded', () => {
            loadPreferences();
            displayStorage();
        });
        
        // Load preferences from localStorage
        function loadPreferences() {
            const prefs = getPreferences();
            
            // Apply theme
            document.body.className = `${prefs.theme}-theme`;
            document.getElementById('theme').value = prefs.theme;
            
            // Apply language
            document.getElementById('language').value = prefs.language;
            
            // Apply font size
            document.body.style.fontSize = `${prefs.fontSize}px`;
            document.getElementById('fontSize').value = prefs.fontSize;
            
            // Apply notifications
            document.getElementById('notifications').checked = prefs.notifications;
        }
        
        // Get preferences (with fallback to defaults)
        function getPreferences() {
            const stored = localStorage.getItem('userPreferences');
            return stored ? JSON.parse(stored) : DEFAULT_PREFS;
        }
        
        // Save preferences
        function savePreferences(prefs) {
            localStorage.setItem('userPreferences', JSON.stringify(prefs));
        }
        
        // Change theme
        function changeTheme() {
            const prefs = getPreferences();
            prefs.theme = document.getElementById('theme').value;
            savePreferences(prefs);
            document.body.className = `${prefs.theme}-theme`;
        }
        
        // Change language
        function changeLanguage() {
            const prefs = getPreferences();
            prefs.language = document.getElementById('language').value;
            savePreferences(prefs);
            alert(`Language changed to: ${prefs.language}`);
        }
        
        // Change font size
        function changeFontSize() {
            const prefs = getPreferences();
            prefs.fontSize = parseInt(document.getElementById('fontSize').value);
            savePreferences(prefs);
            document.body.style.fontSize = `${prefs.fontSize}px`;
        }
        
        // Toggle notifications
        function toggleNotifications() {
            const prefs = getPreferences();
            prefs.notifications = document.getElementById('notifications').checked;
            savePreferences(prefs);
        }
        
        // Reset to defaults
        function resetPreferences() {
            if (confirm('Reset all preferences to default?')) {
                savePreferences(DEFAULT_PREFS);
                loadPreferences();
                alert('Preferences reset to defaults!');
            }
        }
        
        // Export preferences
        function exportPreferences() {
            const prefs = getPreferences();
            const blob = new Blob([JSON.stringify(prefs, null, 2)], { type: 'application/json' });
            const url = URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = 'preferences.json';
            a.click();
        }
        
        // Display localStorage contents
        function displayStorage() {
            const list = document.getElementById('storageList');
            list.innerHTML = '';
            
            if (localStorage.length === 0) {
                list.innerHTML = '<p>Local Storage is empty</p>';
                return;
            }
            
            for (let i = 0; i < localStorage.length; i++) {
                const key = localStorage.key(i);
                const value = localStorage.getItem(key);
                
                const item = document.createElement('div');
                item.className = 'storage-item';
                item.innerHTML = `
                    <div>
                        <strong>${key}:</strong><br>
                        <small>${value}</small>
                    </div>
                    <button onclick="deleteStorageItem('${key}')">Delete</button>
                `;
                list.appendChild(item);
            }
        }
        
        // Delete storage item
        function deleteStorageItem(key) {
            localStorage.removeItem(key);
            displayStorage();
        }
    </script>
</body>
</html>
```

---

## Activity 5: Session Storage for Form Drafts

**Auto-save form data:**

```javascript
// Auto-save form data as user types
document.querySelectorAll('input, textarea, select').forEach(input => {
    input.addEventListener('input', () => {
        saveFormDraft();
    });
});

// Save form data to sessionStorage
function saveFormDraft() {
    const formData = {
        name: document.getElementById('name').value,
        email: document.getElementById('email').value,
        message: document.getElementById('message').value,
        timestamp: new Date().toISOString()
    };
    
    sessionStorage.setItem('formDraft', JSON.stringify(formData));
}

// Load form draft
function loadFormDraft() {
    const draft = sessionStorage.getItem('formDraft');
    
    if (draft) {
        const data = JSON.parse(draft);
        
        document.getElementById('name').value = data.name || '';
        document.getElementById('email').value = data.email || '';
        document.getElementById('message').value = data.message || '';
        
        console.log('Draft loaded from:', data.timestamp);
    }
}

// Clear draft after successful submission
function clearFormDraft() {
    sessionStorage.removeItem('formDraft');
}

// Load draft on page load
document.addEventListener('DOMContentLoaded', () => {
    loadFormDraft();
});

// Clear draft on successful form submission
document.getElementById('myForm').addEventListener('submit', (e) => {
    e.preventDefault();
    
    // Submit form...
    
    clearFormDraft();
    alert('Form submitted! Draft cleared.');
});
```

---

## Activity 6: Shopping Cart with Local Storage

```javascript
// Shopping cart manager
const CartManager = {
    // Get cart
    getCart() {
        const cart = localStorage.getItem('shoppingCart');
        return cart ? JSON.parse(cart) : [];
    },
    
    // Save cart
    saveCart(cart) {
        localStorage.setItem('shoppingCart', JSON.stringify(cart));
    },
    
    // Add item
    addItem(item) {
        const cart = this.getCart();
        
        // Check if item already exists
        const existingItem = cart.find(i => i.id === item.id);
        
        if (existingItem) {
            existingItem.quantity += 1;
        } else {
            cart.push({ ...item, quantity: 1 });
        }
        
        this.saveCart(cart);
        this.updateCartDisplay();
    },
    
    // Remove item
    removeItem(itemId) {
        let cart = this.getCart();
        cart = cart.filter(item => item.id !== itemId);
        this.saveCart(cart);
        this.updateCartDisplay();
    },
    
    // Update quantity
    updateQuantity(itemId, quantity) {
        const cart = this.getCart();
        const item = cart.find(i => i.id === itemId);
        
        if (item) {
            item.quantity = parseInt(quantity);
            if (item.quantity <= 0) {
                this.removeItem(itemId);
            } else {
                this.saveCart(cart);
                this.updateCartDisplay();
            }
        }
    },
    
    // Get total
    getTotal() {
        const cart = this.getCart();
        return cart.reduce((total, item) => total + (item.price * item.quantity), 0);
    },
    
    // Get item count
    getItemCount() {
        const cart = this.getCart();
        return cart.reduce((count, item) => count + item.quantity, 0);
    },
    
    // Clear cart
    clearCart() {
        localStorage.removeItem('shoppingCart');
        this.updateCartDisplay();
    },
    
    // Update cart display
    updateCartDisplay() {
        const count = this.getItemCount();
        const total = this.getTotal();
        
        document.getElementById('cartCount').textContent = count;
        document.getElementById('cartTotal').textContent = `₱${total.toFixed(2)}`;
        
        this.displayCartItems();
    },
    
    // Display cart items
    displayCartItems() {
        const cart = this.getCart();
        const container = document.getElementById('cartItems');
        
        if (cart.length === 0) {
            container.innerHTML = '<p>Cart is empty</p>';
            return;
        }
        
        const html = cart.map(item => `
            <div class="cart-item">
                <h4>${item.name}</h4>
                <p>Price: ₱${item.price}</p>
                <input type="number" 
                       value="${item.quantity}" 
                       min="0" 
                       onchange="CartManager.updateQuantity(${item.id}, this.value)">
                <button onclick="CartManager.removeItem(${item.id})">Remove</button>
                <p>Subtotal: ₱${(item.price * item.quantity).toFixed(2)}</p>
            </div>
        `).join('');
        
        container.innerHTML = html;
    }
};

// Usage:
// CartManager.addItem({ id: 1, name: 'Barangay Clearance', price: 50 });
// CartManager.getCart();
// CartManager.clearCart();
```

---

## Activity 7: Authentication Token Storage

```javascript
// Auth token manager
const AuthManager = {
    // Save token
    saveToken(token) {
        localStorage.setItem('authToken', token);
    },
    
    // Get token
    getToken() {
        return localStorage.getItem('authToken');
    },
    
    // Check if logged in
    isLoggedIn() {
        return !!this.getToken();
    },
    
    // Save user info
    saveUser(user) {
        localStorage.setItem('currentUser', JSON.stringify(user));
    },
    
    // Get user info
    getUser() {
        const user = localStorage.getItem('currentUser');
        return user ? JSON.parse(user) : null;
    },
    
    // Logout (clear all auth data)
    logout() {
        localStorage.removeItem('authToken');
        localStorage.removeItem('currentUser');
    },
    
    // Make authenticated request
    async fetchWithAuth(url, options = {}) {
        const token = this.getToken();
        
        if (!token) {
            throw new Error('No authentication token');
        }
        
        options.headers = {
            ...options.headers,
            'Authorization': `Bearer ${token}`
        };
        
        const response = await fetch(url, options);
        
        // If unauthorized, logout
        if (response.status === 401) {
            this.logout();
            window.location.href = '/login';
        }
        
        return response;
    }
};

// Usage:
// AuthManager.saveToken('jwt-token-here');
// AuthManager.saveUser({ id: 1, username: 'juan' });
// const user = AuthManager.getUser();
// AuthManager.logout();
```

---

## Activity 8: Storage Events (Sync Across Tabs)

```javascript
// Listen for storage changes in other tabs
window.addEventListener('storage', (e) => {
    if (e.key === 'authToken') {
        if (!e.newValue) {
            // Token was removed in another tab - logout
            alert('You have been logged out in another tab');
            window.location.href = '/login';
        } else {
            // Token was updated
            console.log('Auth token updated in another tab');
        }
    }
    
    if (e.key === 'theme') {
        // Theme changed in another tab
        applyTheme(e.newValue);
    }
});
```

---

## Activity 9: Storage Size Check

```javascript
// Check localStorage size
function getStorageSize() {
    let total = 0;
    
    for (let key in localStorage) {
        if (localStorage.hasOwnProperty(key)) {
            total += localStorage[key].length + key.length;
        }
    }
    
    return (total / 1024).toFixed(2);  // KB
}

console.log(`localStorage size: ${getStorageSize()} KB`);

// Check if storage is available
function isStorageAvailable() {
    try {
        const test = '__storage_test__';
        localStorage.setItem(test, test);
        localStorage.removeItem(test);
        return true;
    } catch (e) {
        return false;
    }
}

if (!isStorageAvailable()) {
    alert('localStorage is not available. Some features may not work.');
}
```

---

## 📚 Key Takeaways

1. **Local Storage** persists data permanently
2. **Session Storage** persists only for the session
3. Always use `JSON.stringify()` and `JSON.parse()` for objects
4. Storage limit is about 5-10MB per domain
5. Storage is **synchronous** (can block UI)
6. Always check if storage is available
7. Never store sensitive data in plain text
8. Use storage events to sync across tabs

---

## 🚀 Best Practices

1. **Namespace your keys** to avoid conflicts:
```javascript
localStorage.setItem('myApp.user', data);
localStorage.setItem('myApp.preferences', data);
```

2. **Handle errors**:
```javascript
try {
    localStorage.setItem('key', 'value');
} catch (e) {
    if (e.name === 'QuotaExceededError') {
        alert('Storage quota exceeded!');
    }
}
```

3. **Encrypt sensitive data**:
```javascript
// Use a library like crypto-js
const encrypted = CryptoJS.AES.encrypt(data, secretKey);
localStorage.setItem('sensitive', encrypted.toString());
```

4. **Set expiration times**:
```javascript
function setWithExpiry(key, value, ttl) {
    const item = {
        value: value,
        expiry: new Date().getTime() + ttl
    };
    localStorage.setItem(key, JSON.stringify(item));
}

function getWithExpiry(key) {
    const item = localStorage.getItem(key);
    if (!item) return null;
    
    const parsed = JSON.parse(item);
    if (new Date().getTime() > parsed.expiry) {
        localStorage.removeItem(key);
        return null;
    }
    
    return parsed.value;
}
```

Great job mastering browser storage!