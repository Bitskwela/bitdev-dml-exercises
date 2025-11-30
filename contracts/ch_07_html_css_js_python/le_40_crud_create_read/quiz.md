# Quiz: CRUD Create & Read (Lesson 40)

Test your understanding of creating and reading data with Flask and JavaScript!

---

## Question 1
What HTTP method is used for CREATE operations?

A) GET
B) POST
C) PUT
D) DELETE

**Answer: B**
POST method is used to create new records in the database.

---

## Question 2
What's the correct fetch syntax for creating a new application?

```javascript
const newApp = { name: 'Juan', age: 30, service: 'Clearance' };
```

A)
```javascript
fetch('/api/applications', {
    method: 'GET',
    body: newApp
});
```

B)
```javascript
fetch('/api/applications', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify(newApp)
});
```

C)
```javascript
fetch('/api/applications', newApp);
```

D)
```javascript
fetch('/api/applications?data=' + newApp);
```

**Answer: B**
Use POST method, set Content-Type header, and stringify the JSON body.

---

## Question 3
What HTTP status code should Flask return for successful CREATE?

A) 200 OK
B) 201 Created
C) 400 Bad Request
D) 404 Not Found

**Answer: B**
201 Created indicates a resource was successfully created.

---

## Question 4
How do you validate form data before sending to Flask?

```javascript
form.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const name = document.querySelector('#name').value;
    
    // What should you check?
});
```

A) Nothing, Flask will handle it
B) Check if fields are empty, valid format, etc.
C) Only check in Flask
D) Validation is optional

**Answer: B**
Always validate on both frontend (better UX) and backend (security).

---

## Question 5
What does `e.preventDefault()` do in a form submit handler?

A) Deletes the form
B) Stops the default form submission (page reload)
C) Sends data to Flask
D) Validates the form

**Answer: B**
Prevents the default form behavior (page reload) so you can handle submission with JavaScript.

---

## Question 6
What's the correct Flask route for reading all applications?

A)
```python
@app.route('/api/applications', methods=['GET'])
def get_all():
    return jsonify(applications)
```

B)
```python
@app.route('/api/applications', methods=['POST'])
def get_all():
    return jsonify(applications)
```

C)
```python
@app.route('/api/applications')
def get_all():
    return applications
```

D)
```python
def get_all():
    return jsonify(applications)
```

**Answer: A**
Use GET method and return jsonified data. (Note: `methods=['GET']` is default, so can be omitted)

---

## Question 7
How do you get JSON data from the request body in Flask?

A) `request.json()`
B) `request.get_json()`
C) `request.data`
D) `request.body.json()`

**Answer: B**
`request.get_json()` parses the JSON body and returns a Python dictionary.

---

## Question 8
What should you do after successfully creating a new application?

A) Do nothing
B) Show success message, clear form, reload the list
C) Close the browser
D) Redirect to another website

**Answer: B**
Provide feedback to user, clear the form for next entry, and refresh the display.

---

## Question 9
How do you read a single application by ID?

Flask route:
```python
@app.route('/api/applications/<int:app_id>', methods=['GET'])
def get_one(app_id):
    # Find application with this ID
```

JavaScript:
```javascript
const response = await fetch(/* What URL? */);
```

A) `/api/applications`
B) `/api/applications/1`
C) `/api/applications?id=1`
D) `/api/applications/id/1`

**Answer: B**
Use `/api/applications/1` where 1 is the ID (matches `<int:app_id>` in Flask route).

---

## Question 10
What's wrong with this Flask CREATE endpoint?

```python
@app.route('/api/applications', methods=['POST'])
def create():
    data = request.get_json()
    applications.append(data)
    return jsonify({'message': 'Created'})
```

A) Nothing wrong
B) No validation of input data
C) Should return 201 status code
D) Both B and C

**Answer: D**
Missing input validation (security issue) and should return 201 status code for CREATE.

---

## Question 11
How do you display a list of applications fetched from Flask?

```javascript
async function loadApplications() {
    const response = await fetch('/api/applications');
    const apps = await response.json();
    
    // What's the best approach?
}
```

A) `alert(apps)`
B) `console.log(apps)`
C) Loop through apps, create HTML for each, update DOM
D) Do nothing

**Answer: C**
Loop through the array using `.map()` or `.forEach()`, create HTML cards, and update the DOM.

---

## Question 12
What does `form.reset()` do?

A) Deletes the form
B) Clears all form input values
C) Submits the form
D) Reloads the page

**Answer: B**
Clears all form fields back to their default values.

---

## Question 13
How do you handle validation errors from Flask?

```python
# Flask returns
return jsonify({'errors': ['Name required', 'Age must be positive']}), 400
```

```javascript
// JavaScript should...
```

A) Ignore errors
B) Check response.ok, parse errors, display to user
C) Reload the page
D) Always assume success

**Answer: B**
Check if response is not ok, parse the errors array, and display user-friendly messages.

---

## Question 14
What's the correct way to search for applications?

Flask:
```python
@app.route('/api/applications/search', methods=['GET'])
def search():
    query = request.args.get('q')  # Get query parameter
    # Filter applications by query
```

JavaScript:
```javascript
const response = await fetch(/* What URL? */);
```

A) `/api/applications/search?q=Juan`
B) `/api/applications/Juan`
C) `/api/applications?search=Juan`
D) `/api/search?applications=Juan`

**Answer: A**
Use query parameters: `/api/applications/search?q=searchTerm`

---

## Question 15
Best practice for CREATE operations?

A) No validation needed
B) Validate on frontend only
C) Validate on backend only
D) Validate on both frontend (UX) and backend (security)

**Answer: D**
Always validate on both sides: frontend for better user experience, backend for security.

---

## Practical Challenge

Build a complete CREATE and READ system for barangay residents:

**Requirements:**
1. Create an HTML form with fields: name, age, address, contact
2. Validate that all fields are filled
3. Send POST request to `/api/residents` to create resident
4. Display success/error messages
5. Clear form after successful creation
6. Fetch and display all residents from `/api/residents` (GET)
7. Show "No residents yet" if empty
8. Implement search by name

**Flask endpoints to implement:**
```python
@app.route('/api/residents', methods=['POST'])  # CREATE
@app.route('/api/residents', methods=['GET'])   # READ ALL
@app.route('/api/residents/<int:id>', methods=['GET'])  # READ ONE
```

Can you build this complete CRUD Create/Read system?

---

## Summary

Key Concepts:
- **CREATE**: Use POST method, validate input, return 201 status
- **READ**: Use GET method, fetch all or by ID
- **Validation**: Always validate on frontend and backend
- **Form Handling**: Prevent default, get form data, send to Flask
- **Error Handling**: Check response status, display user-friendly errors
- **User Feedback**: Show success/error messages, clear forms
- **Display Data**: Fetch, loop, create HTML, update DOM
- **Search/Filter**: Use query parameters or filter on frontend

Next: Learn CRUD Update and Delete operations!
