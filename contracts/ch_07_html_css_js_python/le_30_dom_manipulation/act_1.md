# Lesson 30 Activities: DOM Manipulation

## Controlling the Web Page with JavaScript

Master the Document Object Model (DOM) to dynamically change HTML and CSS!

---

## Activity 1: Selecting Elements

**Goal:** Select HTML elements using querySelector methods.

**Create:** `selecting-elements.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Selecting Elements</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        h1 { color: #1a73e8; }
        .resident {
            background-color: #f9f9f9;
            padding: 15px;
            margin: 10px 0;
            border-radius: 5px;
            border-left: 4px solid #1a73e8;
        }
        .highlight {
            background-color: #fff3cd;
            border-left-color: #ff9800;
        }
        button {
            padding: 10px 20px;
            margin: 5px;
            background-color: #1a73e8;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #1557b0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎯 Selecting Elements</h1>
        
        <div id="mainContent">
            <h2>Barangay Residents</h2>
            <p class="info">Click buttons to select and highlight elements</p>
            
            <div class="resident" data-zone="A">
                <h3>Juan Dela Cruz</h3>
                <p>Zone A - Age 25</p>
            </div>
            
            <div class="resident" data-zone="B">
                <h3>Maria Santos</h3>
                <p>Zone B - Age 65</p>
            </div>
            
            <div class="resident" data-zone="A">
                <h3>Pedro Garcia</h3>
                <p>Zone A - Age 30</p>
            </div>
        </div>
        
        <div style="margin-top: 20px;">
            <button onclick="selectById()">Select by ID</button>
            <button onclick="selectByClass()">Select by Class</button>
            <button onclick="selectByTag()">Select by Tag</button>
            <button onclick="selectByAttribute()">Select by Attribute</button>
            <button onclick="reset()">Reset</button>
        </div>
        
        <div id="output" style="margin-top: 20px; padding: 15px; background-color: #e3f2fd; border-radius: 5px;"></div>
    </div>
    
    <script>
        function selectById() {
            // querySelector('#id') - selects first element with that id
            const element = document.querySelector('#mainContent');
            element.style.border = '3px solid #4caf50';
            
            document.getElementById('output').innerHTML = `
                <h3>Selected by ID</h3>
                <p><strong>Method:</strong> document.querySelector('#mainContent')</p>
                <p><strong>Result:</strong> Selected the main content div</p>
            `;
        }
        
        function selectByClass() {
            // querySelectorAll('.class') - selects all elements with that class
            const elements = document.querySelectorAll('.resident');
            
            elements.forEach((element, index) => {
                element.classList.add('highlight');
            });
            
            document.getElementById('output').innerHTML = `
                <h3>Selected by Class</h3>
                <p><strong>Method:</strong> document.querySelectorAll('.resident')</p>
                <p><strong>Result:</strong> Selected ${elements.length} resident cards</p>
            `;
        }
        
        function selectByTag() {
            // querySelector('tag') - selects first element with that tag
            const firstH3 = document.querySelector('h3');
            firstH3.style.color = '#f44336';
            
            // querySelectorAll('tag') - selects all elements with that tag
            const allH3 = document.querySelectorAll('h3');
            
            document.getElementById('output').innerHTML = `
                <h3>Selected by Tag</h3>
                <p><strong>Method:</strong> document.querySelector('h3')</p>
                <p><strong>Result:</strong> First h3 changed to red</p>
                <p><strong>Note:</strong> Found ${allH3.length} total h3 elements</p>
            `;
        }
        
        function selectByAttribute() {
            // querySelector('[attribute="value"]') - selects by attribute
            const zoneA = document.querySelectorAll('[data-zone="A"]');
            
            zoneA.forEach(element => {
                element.style.backgroundColor = '#e8f5e9';
                element.style.borderLeftColor = '#4caf50';
            });
            
            document.getElementById('output').innerHTML = `
                <h3>Selected by Attribute</h3>
                <p><strong>Method:</strong> document.querySelectorAll('[data-zone="A"]')</p>
                <p><strong>Result:</strong> Highlighted ${zoneA.length} Zone A residents</p>
            `;
        }
        
        function reset() {
            // Remove all highlights and styles
            document.querySelectorAll('.resident').forEach(element => {
                element.classList.remove('highlight');
                element.style.backgroundColor = '';
                element.style.borderLeftColor = '';
            });
            
            document.querySelectorAll('h3').forEach(element => {
                element.style.color = '';
            });
            
            document.querySelector('#mainContent').style.border = '';
            document.getElementById('output').innerHTML = '';
        }
    </script>
</body>
</html>
```

---

## Activity 2: Changing Content

**Goal:** Modify element content using textContent and innerHTML.

**Create:** `changing-content.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Changing Content</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        h1 { color: #1a73e8; }
        .announcement {
            background-color: #fff3cd;
            padding: 20px;
            margin: 20px 0;
            border-radius: 8px;
            border-left: 5px solid #ff9800;
        }
        .info-box {
            background-color: #e3f2fd;
            padding: 20px;
            margin: 20px 0;
            border-radius: 8px;
        }
        button {
            padding: 10px 20px;
            margin: 5px;
            background-color: #1a73e8;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #1557b0;
        }
        input {
            padding: 10px;
            margin: 5px;
            border: 1px solid #ddd;
            border-radius: 5px;
            width: 300px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>✏️ Changing Content</h1>
        
        <div class="announcement">
            <h2 id="announcementTitle">Barangay Announcement</h2>
            <p id="announcementText">No announcements yet.</p>
        </div>
        
        <div class="info-box">
            <h3>Resident Information</h3>
            <div id="residentInfo">
                <p>No resident selected</p>
            </div>
        </div>
        
        <div style="margin-top: 20px;">
            <h3>Change Title (textContent):</h3>
            <input type="text" id="titleInput" placeholder="Enter new title">
            <button onclick="changeTitle()">Update Title</button>
            
            <h3>Change Announcement (innerHTML):</h3>
            <input type="text" id="messageInput" placeholder="Enter message">
            <button onclick="changeAnnouncement()">Update Message</button>
            
            <h3>Display Resident (innerHTML with HTML):</h3>
            <button onclick="displayResident('Juan Dela Cruz', 25, 'Zone A')">Show Juan</button>
            <button onclick="displayResident('Maria Santos', 65, 'Zone B')">Show Maria</button>
            <button onclick="displayResident('Pedro Garcia', 30, 'Zone A')">Show Pedro</button>
        </div>
        
        <div style="margin-top: 20px; padding: 15px; background-color: #f9f9f9; border-radius: 5px;">
            <h3>Difference: textContent vs innerHTML</h3>
            <p><strong>textContent:</strong> Sets plain text only (safe, faster)</p>
            <p><strong>innerHTML:</strong> Can include HTML tags (powerful, use carefully)</p>
        </div>
    </div>
    
    <script>
        function changeTitle() {
            const input = document.getElementById('titleInput').value;
            const titleElement = document.getElementById('announcementTitle');
            
            // textContent - sets text only, no HTML
            titleElement.textContent = input || 'Barangay Announcement';
        }
        
        function changeAnnouncement() {
            const input = document.getElementById('messageInput').value;
            const textElement = document.getElementById('announcementText');
            
            // innerHTML - can include HTML tags
            textElement.innerHTML = `<strong>📢 ${input || 'No message'}</strong>`;
        }
        
        function displayResident(name, age, zone) {
            const infoDiv = document.getElementById('residentInfo');
            
            // innerHTML - creating HTML structure
            infoDiv.innerHTML = `
                <h4>${name}</h4>
                <p><strong>Age:</strong> ${age}</p>
                <p><strong>Zone:</strong> ${zone}</p>
                <p><strong>Status:</strong> ${age >= 60 ? '👴 Senior Citizen' : '👤 Regular'}</p>
            `;
        }
        
        // Example: Security issue with innerHTML
        function demonstrateSecurity() {
            const userInput = '<img src="x" onerror="alert(\'XSS Attack!\')">';
            
            // ❌ BAD - innerHTML with user input (XSS risk)
            // element.innerHTML = userInput;
            
            // ✅ GOOD - textContent with user input (safe)
            // element.textContent = userInput;
        }
    </script>
</body>
</html>
```

---

## Activity 3: Creating and Appending Elements

**Goal:** Create new elements and add them to the page.

**Create:** `creating-elements.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Creating Elements</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        h1 { color: #1a73e8; }
        .form-group {
            margin: 15px 0;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        button {
            padding: 12px 24px;
            background-color: #4caf50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: 10px 5px 10px 0;
        }
        button:hover {
            background-color: #45a049;
        }
        button.danger {
            background-color: #f44336;
        }
        button.danger:hover {
            background-color: #d32f2f;
        }
        .resident-card {
            background-color: #f9f9f9;
            padding: 15px;
            margin: 10px 0;
            border-radius: 8px;
            border-left: 5px solid #1a73e8;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .resident-card button {
            padding: 8px 16px;
            margin: 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>➕ Creating New Elements</h1>
        
        <div class="form-group">
            <label for="residentName">Resident Name:</label>
            <input type="text" id="residentName" placeholder="Enter full name">
        </div>
        
        <div class="form-group">
            <label for="residentAge">Age:</label>
            <input type="number" id="residentAge" placeholder="Enter age">
        </div>
        
        <div class="form-group">
            <label for="residentZone">Zone:</label>
            <input type="text" id="residentZone" placeholder="Enter zone (A, B, C)">
        </div>
        
        <button onclick="addResident()">Add Resident</button>
        <button onclick="clearAll()" class="danger">Clear All</button>
        
        <h2 style="margin-top: 30px;">Resident List</h2>
        <div id="residentList"></div>
        
        <div style="margin-top: 20px; padding: 15px; background-color: #e3f2fd; border-radius: 5px;">
            <h3>Steps to Create Elements:</h3>
            <ol>
                <li><strong>createElement():</strong> Create the element</li>
                <li><strong>Set properties:</strong> textContent, innerHTML, classList, etc.</li>
                <li><strong>appendChild():</strong> Add to parent element</li>
            </ol>
        </div>
    </div>
    
    <script>
        let residentCount = 0;
        
        function addResident() {
            // Get input values
            const name = document.getElementById('residentName').value;
            const age = document.getElementById('residentAge').value;
            const zone = document.getElementById('residentZone').value;
            
            // Validate
            if (!name || !age || !zone) {
                alert('Please fill in all fields');
                return;
            }
            
            residentCount++;
            
            // Step 1: Create elements
            const card = document.createElement('div');
            const infoDiv = document.createElement('div');
            const nameEl = document.createElement('h3');
            const detailsEl = document.createElement('p');
            const deleteBtn = document.createElement('button');
            
            // Step 2: Set content and properties
            card.className = 'resident-card';
            card.id = `resident-${residentCount}`;
            
            nameEl.textContent = name;
            detailsEl.textContent = `Age: ${age} | Zone: ${zone}`;
            
            deleteBtn.textContent = 'Delete';
            deleteBtn.className = 'danger';
            deleteBtn.onclick = function() {
                removeResident(card.id);
            };
            
            // Step 3: Append elements (build structure)
            infoDiv.appendChild(nameEl);
            infoDiv.appendChild(detailsEl);
            card.appendChild(infoDiv);
            card.appendChild(deleteBtn);
            
            // Step 4: Add to page
            document.getElementById('residentList').appendChild(card);
            
            // Clear inputs
            document.getElementById('residentName').value = '';
            document.getElementById('residentAge').value = '';
            document.getElementById('residentZone').value = '';
        }
        
        function removeResident(cardId) {
            const card = document.getElementById(cardId);
            card.remove(); // Modern way to remove element
        }
        
        function clearAll() {
            if (confirm('Remove all residents?')) {
                document.getElementById('residentList').innerHTML = '';
                residentCount = 0;
            }
        }
    </script>
</body>
</html>
```

---

## Activity 4: Modifying Classes and Styles

**Goal:** Change element appearance using classList and style properties.

**Create:** `modifying-styles.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifying Styles</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        h1 { color: #1a73e8; }
        .card {
            background-color: #f9f9f9;
            padding: 20px;
            margin: 15px 0;
            border-radius: 8px;
            border-left: 5px solid #1a73e8;
            transition: all 0.3s ease;
        }
        .card.active {
            background-color: #e8f5e9;
            border-left-color: #4caf50;
            transform: scale(1.05);
        }
        .card.highlight {
            background-color: #fff3cd;
            border-left-color: #ff9800;
        }
        .card.danger {
            background-color: #ffebee;
            border-left-color: #f44336;
        }
        .hidden {
            display: none;
        }
        button {
            padding: 10px 20px;
            margin: 5px;
            background-color: #1a73e8;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #1557b0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎨 Modifying Classes and Styles</h1>
        
        <div id="serviceCard" class="card">
            <h2>Barangay Clearance</h2>
            <p>Processing fee: ₱50</p>
            <p id="status">Status: Pending</p>
        </div>
        
        <div style="margin: 20px 0;">
            <h3>classList Methods:</h3>
            <button onclick="addClass()">Add Active Class</button>
            <button onclick="removeClass()">Remove Active Class</button>
            <button onclick="toggleClass()">Toggle Highlight</button>
            <button onclick="replaceClass()">Replace with Danger</button>
            <button onclick="checkClass()">Check Classes</button>
        </div>
        
        <div style="margin: 20px 0;">
            <h3>Style Property (Direct CSS):</h3>
            <button onclick="changeColor()">Change Color</button>
            <button onclick="changeSize()">Change Size</button>
            <button onclick="addBorder()">Add Border</button>
            <button onclick="resetStyles()">Reset Styles</button>
        </div>
        
        <div style="margin: 20px 0;">
            <h3>Toggle Visibility:</h3>
            <button onclick="toggleVisibility()">Show/Hide Card</button>
        </div>
        
        <div id="output" style="margin-top: 20px; padding: 15px; background-color: #e3f2fd; border-radius: 5px;"></div>
    </div>
    
    <script>
        const card = document.getElementById('serviceCard');
        const output = document.getElementById('output');
        
        function addClass() {
            card.classList.add('active');
            updateOutput('Added "active" class');
        }
        
        function removeClass() {
            card.classList.remove('active');
            updateOutput('Removed "active" class');
        }
        
        function toggleClass() {
            card.classList.toggle('highlight');
            const hasClass = card.classList.contains('highlight');
            updateOutput(`Toggled "highlight" class - Now ${hasClass ? 'ON' : 'OFF'}`);
        }
        
        function replaceClass() {
            // Remove all status classes
            card.classList.remove('active', 'highlight');
            // Add danger class
            card.classList.add('danger');
            document.getElementById('status').textContent = 'Status: Rejected';
            updateOutput('Replaced classes with "danger"');
        }
        
        function checkClass() {
            const classes = Array.from(card.classList).join(', ');
            const hasActive = card.classList.contains('active');
            updateOutput(`Current classes: ${classes}<br>Has "active"? ${hasActive}`);
        }
        
        function changeColor() {
            // Direct style manipulation
            card.style.backgroundColor = '#e3f2fd';
            card.style.color = '#1a73e8';
            updateOutput('Changed background and text color using style property');
        }
        
        function changeSize() {
            card.style.fontSize = '1.2em';
            card.style.padding = '30px';
            updateOutput('Changed font size and padding using style property');
        }
        
        function addBorder() {
            card.style.border = '3px solid #4caf50';
            card.style.boxShadow = '0 4px 12px rgba(0,0,0,0.2)';
            updateOutput('Added border and shadow using style property');
        }
        
        function resetStyles() {
            // Remove all classes except 'card'
            card.className = 'card';
            // Reset inline styles
            card.style.backgroundColor = '';
            card.style.color = '';
            card.style.fontSize = '';
            card.style.padding = '';
            card.style.border = '';
            card.style.boxShadow = '';
            document.getElementById('status').textContent = 'Status: Pending';
            updateOutput('Reset all classes and styles');
        }
        
        function toggleVisibility() {
            card.classList.toggle('hidden');
            const isHidden = card.classList.contains('hidden');
            updateOutput(`Card is now ${isHidden ? 'hidden' : 'visible'}`);
        }
        
        function updateOutput(message) {
            output.innerHTML = `<strong>Action:</strong> ${message}`;
        }
    </script>
</body>
</html>
```

---

## Activity 5: Working with Attributes

**Goal:** Get, set, and remove HTML attributes.

**Create:** `working-attributes.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Working with Attributes</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        h1 { color: #1a73e8; }
        .service-link {
            display: block;
            padding: 15px;
            margin: 10px 0;
            background-color: #e3f2fd;
            color: #1a73e8;
            text-decoration: none;
            border-radius: 5px;
            border-left: 5px solid #1a73e8;
        }
        .service-link:hover {
            background-color: #bbdefb;
        }
        .service-link.disabled {
            background-color: #f5f5f5;
            color: #999;
            pointer-events: none;
            border-left-color: #999;
        }
        img {
            max-width: 200px;
            border-radius: 8px;
            margin: 10px 0;
        }
        button {
            padding: 10px 20px;
            margin: 5px;
            background-color: #1a73e8;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #1557b0;
        }
        input {
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
            width: 300px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏷️ Working with Attributes</h1>
        
        <h2>Barangay Services</h2>
        <a href="#clearance" class="service-link" id="clearanceLink" data-price="50" data-zone="all">
            Barangay Clearance - ₱50
        </a>
        
        <a href="#id" class="service-link" id="idLink" data-price="30" data-zone="all">
            Barangay ID - ₱30
        </a>
        
        <a href="#permit" class="service-link" id="permitLink" data-price="500" data-zone="commercial">
            Business Permit - ₱500
        </a>
        
        <h2 style="margin-top: 30px;">Logo</h2>
        <img id="logo" src="https://via.placeholder.com/200x100?text=Barangay+Logo" alt="Barangay Logo">
        
        <div style="margin-top: 20px;">
            <h3>Get Attributes:</h3>
            <button onclick="getAttributes()">Show All Attributes</button>
            <button onclick="getDataAttributes()">Show Data Attributes</button>
            
            <h3>Set Attributes:</h3>
            <input type="text" id="newUrl" placeholder="Enter new image URL">
            <button onclick="changeImage()">Change Logo</button>
            <button onclick="disableService()">Disable Permit Service</button>
            <button onclick="enableService()">Enable Permit Service</button>
            
            <h3>Remove Attributes:</h3>
            <button onclick="removeDataAttr()">Remove Data Attributes</button>
        </div>
        
        <div id="output" style="margin-top: 20px; padding: 15px; background-color: #f9f9f9; border-radius: 5px;"></div>
    </div>
    
    <script>
        function getAttributes() {
            const link = document.getElementById('clearanceLink');
            
            // getAttribute() - get attribute value
            const href = link.getAttribute('href');
            const price = link.getAttribute('data-price');
            const zone = link.getAttribute('data-zone');
            
            document.getElementById('output').innerHTML = `
                <h3>Clearance Link Attributes:</h3>
                <p><strong>href:</strong> ${href}</p>
                <p><strong>data-price:</strong> ₱${price}</p>
                <p><strong>data-zone:</strong> ${zone}</p>
            `;
        }
        
        function getDataAttributes() {
            // dataset property - access data-* attributes
            const links = document.querySelectorAll('.service-link');
            let output = '<h3>All Service Data:</h3>';
            
            links.forEach((link, index) => {
                output += `
                    <div style="background-color: white; padding: 10px; margin: 5px 0; border-radius: 5px;">
                        <strong>Service ${index + 1}:</strong>
                        Price: ₱${link.dataset.price}, 
                        Zone: ${link.dataset.zone}
                    </div>
                `;
            });
            
            document.getElementById('output').innerHTML = output;
        }
        
        function changeImage() {
            const newUrl = document.getElementById('newUrl').value;
            const img = document.getElementById('logo');
            
            if (newUrl) {
                // setAttribute() - set attribute value
                img.setAttribute('src', newUrl);
                img.setAttribute('alt', 'Updated Logo');
                
                document.getElementById('output').innerHTML = `
                    <h3>Image Updated!</h3>
                    <p>New URL: ${newUrl}</p>
                `;
            } else {
                alert('Please enter a URL');
            }
        }
        
        function disableService() {
            const link = document.getElementById('permitLink');
            
            // Add disabled class
            link.classList.add('disabled');
            
            // Set aria-disabled for accessibility
            link.setAttribute('aria-disabled', 'true');
            
            // Store original href
            link.setAttribute('data-original-href', link.getAttribute('href'));
            
            // Remove href to disable link
            link.removeAttribute('href');
            
            document.getElementById('output').innerHTML = `
                <h3>Service Disabled</h3>
                <p>Business Permit service is now disabled</p>
            `;
        }
        
        function enableService() {
            const link = document.getElementById('permitLink');
            
            // Remove disabled class
            link.classList.remove('disabled');
            
            // Remove aria-disabled
            link.removeAttribute('aria-disabled');
            
            // Restore original href
            const originalHref = link.getAttribute('data-original-href');
            if (originalHref) {
                link.setAttribute('href', originalHref);
                link.removeAttribute('data-original-href');
            }
            
            document.getElementById('output').innerHTML = `
                <h3>Service Enabled</h3>
                <p>Business Permit service is now active</p>
            `;
        }
        
        function removeDataAttr() {
            const links = document.querySelectorAll('.service-link');
            
            links.forEach(link => {
                // removeAttribute() - remove attribute
                link.removeAttribute('data-price');
                link.removeAttribute('data-zone');
            });
            
            document.getElementById('output').innerHTML = `
                <h3>Data Attributes Removed</h3>
                <p>All data-price and data-zone attributes have been removed</p>
                <p><em>Note: Removed attributes don't affect visual appearance</em></p>
            `;
        }
    </script>
</body>
</html>
```

---

## Activity 6: Complete Announcement Board

**Goal:** Build a complete dynamic announcement system.

**Create:** `announcement-board.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Announcement Board</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            padding: 20px;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        h1 {
            color: #1a73e8;
            margin-bottom: 30px;
        }
        .form-section {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        .form-group {
            margin: 15px 0;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input, textarea, select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            font-family: Arial, sans-serif;
        }
        textarea {
            min-height: 100px;
            resize: vertical;
        }
        button {
            padding: 12px 24px;
            background-color: #4caf50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-right: 10px;
        }
        button:hover {
            background-color: #45a049;
        }
        button.secondary {
            background-color: #1a73e8;
        }
        button.secondary:hover {
            background-color: #1557b0;
        }
        .filters {
            margin: 20px 0;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        .filters button {
            background-color: #666;
            padding: 8px 16px;
        }
        .filters button:hover {
            background-color: #555;
        }
        .filters button.active {
            background-color: #1a73e8;
        }
        .announcements-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .announcement-card {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            border-left: 5px solid #1a73e8;
            position: relative;
        }
        .announcement-card.urgent {
            border-left-color: #f44336;
            background-color: #ffebee;
        }
        .announcement-card.event {
            border-left-color: #ff9800;
            background-color: #fff3cd;
        }
        .announcement-card.info {
            border-left-color: #2196f3;
            background-color: #e3f2fd;
        }
        .announcement-card h3 {
            color: #333;
            margin-bottom: 10px;
        }
        .announcement-card p {
            color: #666;
            margin-bottom: 10px;
            line-height: 1.6;
        }
        .announcement-meta {
            font-size: 14px;
            color: #999;
            margin-top: 10px;
        }
        .announcement-actions {
            margin-top: 15px;
            display: flex;
            gap: 10px;
        }
        .announcement-actions button {
            padding: 6px 12px;
            font-size: 14px;
            background-color: #f44336;
        }
        .announcement-actions button:hover {
            background-color: #d32f2f;
        }
        .badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
            color: white;
            margin-right: 5px;
        }
        .badge.urgent { background-color: #f44336; }
        .badge.event { background-color: #ff9800; }
        .badge.info { background-color: #2196f3; }
        .empty-state {
            text-align: center;
            padding: 40px;
            color: #999;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📢 Barangay Announcement Board</h1>
        
        <div class="form-section">
            <h2>Create New Announcement</h2>
            <div class="form-group">
                <label for="title">Title:</label>
                <input type="text" id="title" placeholder="Enter announcement title">
            </div>
            
            <div class="form-group">
                <label for="message">Message:</label>
                <textarea id="message" placeholder="Enter announcement details"></textarea>
            </div>
            
            <div class="form-group">
                <label for="category">Category:</label>
                <select id="category">
                    <option value="info">Information</option>
                    <option value="event">Event</option>
                    <option value="urgent">Urgent</option>
                </select>
            </div>
            
            <button onclick="addAnnouncement()">Post Announcement</button>
            <button onclick="clearForm()" class="secondary">Clear Form</button>
        </div>
        
        <div class="filters">
            <button class="active" onclick="filterAnnouncements('all')">All</button>
            <button onclick="filterAnnouncements('info')">Information</button>
            <button onclick="filterAnnouncements('event')">Events</button>
            <button onclick="filterAnnouncements('urgent')">Urgent</button>
        </div>
        
        <div class="announcements-grid" id="announcementsContainer">
            <div class="empty-state">
                <p>No announcements yet. Create one to get started!</p>
            </div>
        </div>
    </div>
    
    <script>
        let announcements = [];
        let currentFilter = 'all';
        
        function addAnnouncement() {
            const title = document.getElementById('title').value.trim();
            const message = document.getElementById('message').value.trim();
            const category = document.getElementById('category').value;
            
            if (!title || !message) {
                alert('Please fill in all fields');
                return;
            }
            
            const announcement = {
                id: Date.now(),
                title: title,
                message: message,
                category: category,
                date: new Date().toLocaleString('en-PH')
            };
            
            announcements.push(announcement);
            displayAnnouncements();
            clearForm();
        }
        
        function displayAnnouncements() {
            const container = document.getElementById('announcementsContainer');
            
            // Filter announcements
            let filtered = announcements;
            if (currentFilter !== 'all') {
                filtered = announcements.filter(a => a.category === currentFilter);
            }
            
            if (filtered.length === 0) {
                container.innerHTML = '<div class="empty-state"><p>No announcements in this category.</p></div>';
                return;
            }
            
            // Clear container
            container.innerHTML = '';
            
            // Create cards for each announcement
            filtered.forEach(announcement => {
                const card = createAnnouncementCard(announcement);
                container.appendChild(card);
            });
        }
        
        function createAnnouncementCard(announcement) {
            // Create card element
            const card = document.createElement('div');
            card.className = `announcement-card ${announcement.category}`;
            card.setAttribute('data-id', announcement.id);
            
            // Create badge
            const badge = document.createElement('span');
            badge.className = `badge ${announcement.category}`;
            badge.textContent = announcement.category.toUpperCase();
            
            // Create title
            const title = document.createElement('h3');
            title.textContent = announcement.title;
            
            // Create message
            const message = document.createElement('p');
            message.textContent = announcement.message;
            
            // Create meta info
            const meta = document.createElement('div');
            meta.className = 'announcement-meta';
            meta.textContent = `Posted on: ${announcement.date}`;
            
            // Create actions
            const actions = document.createElement('div');
            actions.className = 'announcement-actions';
            
            const deleteBtn = document.createElement('button');
            deleteBtn.textContent = 'Delete';
            deleteBtn.onclick = () => deleteAnnouncement(announcement.id);
            
            actions.appendChild(deleteBtn);
            
            // Assemble card
            card.appendChild(badge);
            card.appendChild(title);
            card.appendChild(message);
            card.appendChild(meta);
            card.appendChild(actions);
            
            return card;
        }
        
        function deleteAnnouncement(id) {
            if (confirm('Delete this announcement?')) {
                announcements = announcements.filter(a => a.id !== id);
                displayAnnouncements();
            }
        }
        
        function filterAnnouncements(category) {
            currentFilter = category;
            
            // Update active button
            document.querySelectorAll('.filters button').forEach(btn => {
                btn.classList.remove('active');
            });
            event.target.classList.add('active');
            
            displayAnnouncements();
        }
        
        function clearForm() {
            document.getElementById('title').value = '';
            document.getElementById('message').value = '';
            document.getElementById('category').value = 'info';
        }
        
        // Load sample data
        function loadSampleData() {
            announcements = [
                {
                    id: 1,
                    title: 'Community Clean-up Drive',
                    message: 'Join us this Saturday for our monthly clean-up activity. Meeting at the barangay hall at 7:00 AM.',
                    category: 'event',
                    date: new Date('2024-12-01').toLocaleString('en-PH')
                },
                {
                    id: 2,
                    title: 'Water Interruption Notice',
                    message: 'Water supply will be interrupted tomorrow from 8AM to 5PM due to maintenance.',
                    category: 'urgent',
                    date: new Date('2024-12-02').toLocaleString('en-PH')
                },
                {
                    id: 3,
                    title: 'New Office Hours',
                    message: 'The barangay office will now be open from 8:00 AM to 5:00 PM, Monday to Friday.',
                    category: 'info',
                    date: new Date('2024-12-03').toLocaleString('en-PH')
                }
            ];
            displayAnnouncements();
        }
        
        // Load sample data on page load
        loadSampleData();
    </script>
</body>
</html>
```

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## DOM Manipulation Reference

### Selecting Elements

```javascript
// By ID
document.getElementById('myId')
document.querySelector('#myId')

// By class
document.getElementsByClassName('myClass')
document.querySelectorAll('.myClass')

// By tag
document.getElementsByTagName('div')
document.querySelectorAll('div')

// By attribute
document.querySelector('[data-id="123"]')

// CSS selectors
document.querySelector('.class > div')
document.querySelectorAll('div.class, div.other')
```

### Changing Content

```javascript
// Text only (safe)
element.textContent = 'New text';

// HTML content (careful with user input!)
element.innerHTML = '<strong>Bold text</strong>';

// Value (for inputs)
input.value = 'New value';
```

### Creating Elements

```javascript
// Create element
const div = document.createElement('div');

// Set properties
div.textContent = 'Content';
div.className = 'my-class';
div.id = 'myId';

// Append to parent
parent.appendChild(div);

// Remove element
element.remove();
```

### Classes

```javascript
// Add class
element.classList.add('active');

// Remove class
element.classList.remove('active');

// Toggle class
element.classList.toggle('active');

// Check if has class
if (element.classList.contains('active')) { }

// Replace class
element.classList.replace('old', 'new');
```

### Styles

```javascript
// Single property
element.style.color = 'red';
element.style.backgroundColor = 'blue';

// Multiple properties
element.style.cssText = 'color: red; background: blue;';

// Get computed style
const style = window.getComputedStyle(element);
const color = style.color;
```

### Attributes

```javascript
// Get attribute
const value = element.getAttribute('href');

// Set attribute
element.setAttribute('href', '/page');

// Remove attribute
element.removeAttribute('disabled');

// Check if has attribute
if (element.hasAttribute('required')) { }

// Data attributes
element.dataset.price = '50';
const price = element.dataset.price;
```

### Best Practices

1. **Cache DOM queries:**
```javascript
// ❌ Bad - queries DOM multiple times
document.getElementById('myDiv').textContent = 'A';
document.getElementById('myDiv').style.color = 'red';

// ✅ Good - query once, reuse
const div = document.getElementById('myDiv');
div.textContent = 'A';
div.style.color = 'red';
```

2. **Use textContent for plain text:**
```javascript
// ✅ Safe
element.textContent = userInput;

// ❌ Dangerous (XSS risk)
element.innerHTML = userInput;
```

3. **Prefer classList over className:**
```javascript
// ❌ Overwrites all classes
element.className = 'active';

// ✅ Adds without removing others
element.classList.add('active');
```

4. **Use CSS classes instead of inline styles:**
```javascript
// ❌ Hard to maintain
element.style.color = 'red';
element.style.fontSize = '20px';

// ✅ Better
element.classList.add('highlight');
```

</details>

---

**Congratulations!** You've mastered DOM manipulation!

**Next Lesson:** Event Handling!
