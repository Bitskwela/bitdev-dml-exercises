# Quiz: DOM Updates from Flask (Lesson 39)

Test your understanding of displaying Flask data dynamically on web pages!

---

## Question 1
What is the correct way to fetch data from a Flask endpoint and display it?

A) Use `innerHTML` directly without fetching
B) Fetch data, then update DOM with response
C) Refresh the entire page to get new data
D) Store data in localStorage only

**Answer: B**
Fetch data from Flask using `fetch()`, then update the DOM with the response data.

---

## Question 2
What method should you use to display an array of announcements dynamically?

```javascript
async function loadAnnouncements() {
    const response = await fetch('/api/announcements');
    const announcements = await response.json();
    // What goes here?
}
```

A) `announcements.forEach()` to loop and create HTML
B) `alert(announcements)`
C) `console.log(announcements)` only
D) Nothing, it displays automatically

**Answer: A**
Use `.forEach()` or `.map()` to loop through the array and create HTML for each announcement.

---

## Question 3
How do you show a loading indicator while fetching data?

```javascript
async function loadData() {
    // Step 1: ?
    const response = await fetch('/api/data');
    const data = await response.json();
    // Step 2: ?
}
```

A) No need for loading indicators
B) Show loading before fetch, hide after data arrives
C) Show loading after data arrives
D) Use `setTimeout()` only

**Answer: B**
Show loading indicator before fetch, hide it after data arrives and is displayed.

---

## Question 4
What's the correct way to handle errors when fetching data?

A) Ignore errors
B) Only use `console.log()`
C) Use `try/catch` and display user-friendly error messages
D) Reload the page on error

**Answer: C**
Always use `try/catch` to handle errors and display meaningful messages to users.

---

## Question 5
How do you filter announcements by category on the frontend?

```python
# Flask endpoint
@app.route('/api/announcements')
def get_announcements():
    return jsonify(announcements)
```

A) Create separate Flask endpoints for each category
B) Fetch all data, then filter in JavaScript using `.filter()`
C) Reload the page with different parameters
D) Filtering is not possible

**Answer: B**
Fetch all announcements once, then use JavaScript's `.filter()` method to filter by category dynamically.

---

## Question 6
What's the correct HTML structure for displaying fetched data?

```javascript
container.innerHTML = announcements.map(ann => `
    <div class="card">
        <h3>${ann.title}</h3>
        <p>${ann.content}</p>
    </div>
`).join('');
```

What does `.join('')` do?

A) Connects to the database
B) Joins array elements into a single string
C) Fetches more data
D) Creates JSON

**Answer: B**
`.join('')` converts the array of HTML strings into a single string for `innerHTML`.

---

## Question 7
How do you implement a search feature for announcements?

A) Search on Flask backend only
B) Listen to input events, filter data in JavaScript
C) Reload page with search query
D) Search is too complex

**Answer: B**
Listen to input events on the search box, then filter the data array in JavaScript and re-display results.

---

## Question 8
What HTTP method does `fetch()` use by default?

A) POST
B) PUT
C) DELETE
D) GET

**Answer: D**
`fetch()` uses GET method by default, which is perfect for reading data.

---

## Question 9
How do you display a "No data found" message?

```javascript
function displayAnnouncements(announcements) {
    const container = document.querySelector('#list');
    
    if (/* What condition? */) {
        container.innerHTML = '<p>No announcements yet.</p>';
        return;
    }
    
    // Display announcements...
}
```

A) `announcements === null`
B) `announcements.length === 0`
C) `announcements === undefined`
D) Never check, always assume data exists

**Answer: B**
Check if `announcements.length === 0` to determine if the array is empty.

---

## Question 10
What's the correct order of operations for loading and displaying data?

1. Update DOM with data
2. Fetch data from Flask
3. Show loading indicator
4. Hide loading indicator
5. Parse JSON response

A) 3 → 2 → 5 → 1 → 4
B) 2 → 3 → 5 → 1 → 4
C) 1 → 2 → 3 → 4 → 5
D) 5 → 4 → 3 → 2 → 1

**Answer: A**
Show loading → Fetch data → Parse JSON → Update DOM → Hide loading

---

## Question 11
How do you create a filter button for "Events" category?

```html
<button onclick="filterByCategory('events')">Events</button>
```

```javascript
function filterByCategory(category) {
    // What goes here?
}
```

A) Reload the page
B) Filter the announcements array and re-display
C) Create new Flask endpoint
D) Do nothing

**Answer: B**
Filter the original announcements array using `.filter()` and call `displayAnnouncements()` with filtered results.

---

## Question 12
What's wrong with this code?

```javascript
async function loadData() {
    const response = fetch('/api/data');
    const data = response.json();
    displayData(data);
}
```

A) Nothing, it's correct
B) Missing `await` keywords
C) Wrong HTTP method
D) Missing error handling

**Answer: B** (and D is also true!)
Missing `await` before `fetch()` and `response.json()`. Also missing error handling with `try/catch`.

---

## Question 13
How do you display statistics from Flask data?

```javascript
const stats = {
    total: announcements.length,
    events: announcements.filter(a => a.category === 'event').length
};
```

How to display this?

A) `alert(stats)`
B) Update DOM elements with `textContent` or `innerHTML`
C) `console.log(stats)` only
D) Send back to Flask

**Answer: B**
Update specific DOM elements with the calculated statistics using `textContent` or `innerHTML`.

---

## Question 14
What does this code do?

```javascript
searchInput.addEventListener('input', (e) => {
    const query = e.target.value.toLowerCase();
    const filtered = announcements.filter(ann => 
        ann.title.toLowerCase().includes(query)
    );
    displayAnnouncements(filtered);
});
```

A) Deletes announcements
B) Creates new announcements
C) Filters and displays announcements as user types
D) Sends data to Flask

**Answer: C**
Implements real-time search: filters announcements as the user types in the search box.

---

## Question 15
Best practice for updating DOM after fetching data?

A) Use `document.write()`
B) Clear container, then append new elements or use `innerHTML`
C) Never update DOM
D) Reload entire page

**Answer: B**
Clear the container first (to remove old data), then append new elements or use `innerHTML` to display fresh data.

---

## Practical Challenge

Build a simple barangay announcements page that:
1. Fetches announcements from `/api/announcements`
2. Displays them in cards with title, content, and date
3. Shows loading indicator while fetching
4. Implements search by title
5. Shows "No announcements" if empty
6. Handles errors gracefully

**Example Flask endpoint:**
```python
@app.route('/api/announcements')
def get_announcements():
    return jsonify([
        {'id': 1, 'title': 'Barangay Meeting', 'content': 'Meeting on Friday', 'date': '2024-01-15'},
        {'id': 2, 'title': 'Garbage Collection', 'content': 'Collection schedule changed', 'date': '2024-01-16'}
    ])
```

Can you implement the JavaScript to fetch and display this data?

---

## Summary

Key Concepts:
- Fetch data from Flask using `fetch()` and `await`
- Parse JSON response with `.json()`
- Update DOM dynamically with `innerHTML` or `textContent`
- Show loading states for better UX
- Handle errors with `try/catch`
- Filter and search data on the frontend
- Display "no data" messages when appropriate

Next: Learn CRUD Create and Read operations!
