# Quiz: Barangay Complaint System (Lesson 42)

Test your understanding of building a complete full-stack CRUD application!

---

## Question 1
What does a complete CRUD application include?

A) Only Create and Read operations
B) Create, Read, Update, Delete operations
C) Only frontend without backend
D) Only backend without frontend

**Answer: B**
CRUD stands for Create, Read, Update, Delete - all four operations are needed for a complete system.

---

## Question 2
What is the correct Flask route structure for a complaint system?

A)
```python
@app.route('/api/complaints', methods=['GET', 'POST'])
@app.route('/api/complaints/<int:id>', methods=['GET', 'PUT', 'DELETE'])
```

B)
```python
@app.route('/complaints', methods=['ALL'])
```

C)
```python
@app.get('/complaints')
@app.post('/complaints')
```

D)
```python
/complaints?action=create
/complaints?action=delete
```

**Answer: A**
Use RESTful routes: collection endpoint for GET/POST, single resource endpoint with ID for GET/PUT/DELETE.

---

## Question 3
How should you validate a complaint submission?

A) Only validate on frontend
B) Only validate on backend
C) Validate on both frontend and backend
D) No validation needed

**Answer: C**
Always validate on both: frontend for better UX, backend for security.

---

## Question 4
What information should a barangay complaint include?

A) Only the complaint text
B) Name, contact, category, description, status, date
C) Just name and date
D) Only category and status

**Answer: B**
A complete complaint record needs: resident info (name, contact), category, description, status tracking, and timestamp.

---

## Question 5
What HTTP status code should be returned when creating a complaint?

A) 200 OK
B) 201 Created
C) 400 Bad Request
D) 404 Not Found

**Answer: B**
201 Created specifically indicates a new resource was successfully created.

---

## Question 6
How do you display all complaints dynamically?

A) Hardcode them in HTML
B) Fetch from Flask, map to HTML, update DOM
C) Reload the entire page
D) Use PHP

**Answer: B**
Fetch data from Flask API, use `.map()` to create HTML for each complaint, update `innerHTML`.

---

## Question 7
How should you handle complaint status updates?

A) Create a new complaint
B) DELETE and recreate
C) Use PUT/PATCH to update status field
D) Status cannot be changed

**Answer: C**
Use PUT or PATCH request to update only the status field of existing complaint.

---

## Question 8
What should happen before deleting a complaint?

A) Delete immediately
B) Show confirmation dialog
C) No action needed
D) Reload page first

**Answer: B**
Always show confirmation dialog before destructive actions like DELETE.

---

## Question 9
How do you filter complaints by category?

A) Create separate Flask routes for each category
B) Fetch all complaints, filter in JavaScript
C) Reload page with query parameter
D) Cannot filter

**Answer: B**
Fetch all complaints once, then use JavaScript `.filter()` to show only selected category.

---

## Question 10
What is the best way to show loading state while fetching complaints?

A) Do nothing, let it load silently
B) Show loading spinner/message before fetch, hide after data arrives
C) Disable the entire page
D) Show alert box

**Answer: B**
Display loading indicator before fetch, hide it after data is received and displayed.

---

## Question 11
How do you handle form submission for new complaints?

A)
```javascript
form.addEventListener('submit', async (e) => {
    e.preventDefault();
    const data = getFormData();
    await createComplaint(data);
    form.reset();
    loadComplaints();
});
```

B)
```javascript
form.submit();
```

C)
```javascript
<form action="/submit">
```

D)
```javascript
location.reload();
```

**Answer: A**
Prevent default, get form data, send to API, clear form, reload display - all asynchronously.

---

## Question 12
What Flask data structure should you use for storing complaints?

A) Just variables
B) List of dictionaries or database
C) JSON file only
D) Text file

**Answer: B**
Use a list of dictionaries (simple) or connect to a database (production). Each complaint is a dictionary.

---

## Question 13
How do you implement search functionality?

A)
```javascript
const filtered = complaints.filter(c => 
    c.name.toLowerCase().includes(query.toLowerCase())
);
```

B) Reload page with search parameter
C) Create new Flask route
D) Cannot implement search

**Answer: A**
Filter complaints array in JavaScript by checking if name/description includes search query (case-insensitive).

---

## Question 14
What is the complete workflow for updating a complaint?

A) Click Edit → Show modal with current data → Update fields → Submit PUT request → Reload complaints
B) Delete and create new one
C) Just change status
D) Cannot update complaints

**Answer: A**
Full update workflow: open edit modal, populate with current data, allow changes, send PUT request, refresh display.

---

## Question 15
How should error messages be displayed?

A) Console.log only
B) Alert boxes for every error
C) Display user-friendly messages in the UI
D) Ignore errors

**Answer: C**
Display clear, user-friendly error messages in the UI (not just console), explaining what went wrong.

---

## Question 16
What categories should a barangay complaint system include?

A) Only one "General" category
B) Noise, Garbage, Infrastructure, Public Safety, Others
C) Just "Complaint"
D) Categories are not needed

**Answer: B**
Multiple relevant categories help organize and route complaints appropriately.

---

## Question 17
What status values should complaints have?

A) Only "Open" and "Closed"
B) Pending, In Progress, Resolved, Rejected
C) Just "Pending"
D) Status is not needed

**Answer: B**
Multiple statuses track the complaint lifecycle from submission to resolution.

---

## Question 18
How do you display complaint statistics?

A)
```javascript
const stats = {
    total: complaints.length,
    pending: complaints.filter(c => c.status === 'pending').length,
    resolved: complaints.filter(c => c.status === 'resolved').length
};
```

B) Count manually
C) Cannot calculate stats
D) Reload page to show stats

**Answer: A**
Calculate statistics from complaints array using `.length` and `.filter()` methods.

---

## Question 19
What is the correct way to structure the Flask backend?

A) All code in one file
B) Organize into: app.py (routes), models (data structures), utils (helpers)
C) Just use HTML forms
D) No structure needed

**Answer: B**
Organize code into separate files/modules for better maintainability and scalability.

---

## Question 20
What should the complaint submission response include?

A) Only success message
B) Success message, created complaint data, and new complaint ID
C) Nothing
D) Only error if failed

**Answer: B**
Return success message, the created complaint data (with generated ID), so frontend can display it immediately.

---

## Practical Challenge

Build a complete Barangay Complaint System with:

**Features:**
1. Submit complaint form (name, contact, category, description)
2. Display all complaints in cards
3. Filter by category
4. Search by name/description
5. Update complaint status
6. Delete complaint (with confirmation)
7. Show statistics (total, by status)
8. Loading states and error handling

**Flask Backend:**
- POST `/api/complaints` - Create complaint
- GET `/api/complaints` - Get all complaints
- GET `/api/complaints/<id>` - Get one complaint
- PUT `/api/complaints/<id>` - Update complaint
- DELETE `/api/complaints/<id>` - Delete complaint

**JavaScript Frontend:**
- Form submission with validation
- Dynamic display of complaints
- Filter and search functionality
- Edit and delete actions
- Statistics dashboard

Can you implement this complete system?

---

## Summary

Key Concepts:
- **Complete CRUD**: Create, Read, Update, Delete operations
- **RESTful Routes**: Proper HTTP methods for each operation
- **Validation**: Frontend + Backend validation
- **Data Structure**: List of dictionaries or database
- **Dynamic UI**: Fetch data, filter/search, update DOM
- **Error Handling**: Try/catch, user-friendly messages
- **Loading States**: Show feedback during async operations
- **Confirmation**: Ask before destructive actions
- **Organization**: Separate files for routes, models, helpers
- **Best Practices**: Status codes, proper responses, clean code

You now have the skills to build complete full-stack applications!
