# Quiz: CRUD Update & Delete (Lesson 41)

Test your understanding of updating and deleting data with Flask and JavaScript!

---

## Question 1
What HTTP method is used for UPDATE operations?

A) GET
B) POST
C) PUT
D) DELETE

**Answer: C**
PUT method is used to update existing records completely.

---

## Question 2
What's the correct fetch syntax for updating an application?

```javascript
const updatedData = { name: 'Juan P. Cruz', age: 31, status: 'approved' };
const id = 5;
```

A)
```javascript
fetch('/api/applications', {
    method: 'PUT',
    body: JSON.stringify(updatedData)
});
```

B)
```javascript
fetch(`/api/applications/${id}`, {
    method: 'PUT',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify(updatedData)
});
```

C)
```javascript
fetch('/api/applications?id=' + id, updatedData);
```

D)
```javascript
fetch('/api/applications/' + id, {
    method: 'POST',
    body: updatedData
});
```

**Answer: B**
Use PUT method, include ID in URL, set headers, and stringify body.

---

## Question 3
What HTTP method is used for DELETE operations?

A) GET
B) POST
C) PUT
D) DELETE

**Answer: D**
DELETE method is used to remove records permanently.

---

## Question 4
Should you confirm before deleting a record?

A) No, delete immediately
B) Yes, always confirm destructive actions
C) Only for important data
D) Confirmation is optional

**Answer: B**
Always confirm before DELETE operations—they're permanent and can't be easily undone.

---

## Question 5
How do you confirm before deleting?

```javascript
async function deleteApplication(id) {
    // What should you do first?
}
```

A) Delete immediately
B) Use `confirm()` dialog, only proceed if user confirms
C) Ask Flask to confirm
D) No confirmation needed

**Answer: B**
Use JavaScript's `confirm()` to get user confirmation before proceeding with DELETE.

---

## Question 6
What's the correct Flask route for updating an application?

A)
```python
@app.route('/api/applications', methods=['PUT'])
def update():
    # Update logic
```

B)
```python
@app.route('/api/applications/<int:app_id>', methods=['PUT'])
def update(app_id):
    # Update logic
```

C)
```python
@app.route('/api/applications/<int:app_id>', methods=['POST'])
def update(app_id):
    # Update logic
```

D)
```python
@app.route('/api/applications')
def update():
    # Update logic
```

**Answer: B**
Use PUT method and include the ID parameter in the route.

---

## Question 7
How do you open an edit modal with current data?

```javascript
async function openEditModal(id) {
    // What steps?
}
```

A) Just show the modal
B) Fetch current data by ID, populate form, show modal
C) Use hardcoded data
D) No need to fetch data

**Answer: B**
Fetch the current record by ID, populate the form fields with existing data, then display the modal.

---

## Question 8
What should you do after successfully updating a record?

A) Nothing
B) Show success message, close modal, reload data
C) Reload the entire page
D) Delete the record

**Answer: B**
Provide feedback, close the edit modal, and refresh the display to show updated data.

---

## Question 9
What's the correct Flask route for deleting an application?

A)
```python
@app.route('/api/applications/<int:app_id>', methods=['DELETE'])
def delete(app_id):
    # Delete logic
```

B)
```python
@app.route('/api/applications', methods=['DELETE'])
def delete():
    # Delete logic
```

C)
```python
@app.route('/api/applications/<int:app_id>')
def delete(app_id):
    # Delete logic
```

D)
```python
@app.route('/delete/<int:app_id>')
def delete(app_id):
    # Delete logic
```

**Answer: A**
Use DELETE method and include ID parameter in the route.

---

## Question 10
What should Flask do before updating a record?

```python
@app.route('/api/applications/<int:app_id>', methods=['PUT'])
def update(app_id):
    # What should you check first?
```

A) Nothing, just update
B) Check if record exists, then update
C) Delete old record first
D) Create new record

**Answer: B**
Always check if the record exists before attempting to update it. Return 404 if not found.

---

## Question 11
How do you delete a record with JavaScript?

```javascript
async function deleteApplication(id) {
    if (!confirm('Are you sure?')) return;
    
    const response = await fetch(/* What? */);
}
```

A) `fetch('/api/applications')`
B) `fetch('/api/applications/' + id, { method: 'DELETE' })`
C) `fetch('/api/delete?id=' + id)`
D) `fetch('/api/applications', { body: id })`

**Answer: B**
Include ID in URL and use DELETE method.

---

## Question 12
What does PATCH method do?

A) Same as POST
B) Partial update (only specified fields)
C) Same as DELETE
D) Creates new records

**Answer: B**
PATCH is for partial updates—updating only some fields, not the entire record.

---

## Question 13
How do you implement a quick status change?

```javascript
function updateStatus(id, newStatus) {
    // What's the best approach?
}
```

A) Delete and recreate the record
B) Fetch with PATCH to update only status field
C) Update everything with PUT
D) Reload the page

**Answer: B**
Use PATCH method to update only the status field without fetching or sending other data.

---

## Question 14
What should you return when a record to delete is not found?

```python
@app.route('/api/applications/<int:app_id>', methods=['DELETE'])
def delete(app_id):
    app = find_application(app_id)
    
    if not app:
        # What should you return?
```

A) `return "Error"`
B) `return jsonify({'error': 'Application not found'}), 404`
C) `return None`
D) Delete anyway

**Answer: B**
Return JSON error with 404 status code (Not Found).

---

## Question 15
How do you remove an application from an array in Flask?

```python
applications = [{...}, {...}, {...}]

# Remove application with id = 5
```

A) `applications.remove(5)`
B) `applications = [app for app in applications if app['id'] != 5]`
C) `del applications[5]`
D) `applications.delete(5)`

**Answer: B**
Use list comprehension to create new list without the deleted item.

---

## Question 16
What's wrong with this DELETE function?

```javascript
async function deleteApplication(id) {
    await fetch(`/api/applications/${id}`, {
        method: 'DELETE'
    });
    
    loadApplications(); // Reload list
}
```

A) Nothing wrong
B) Missing user confirmation
C) Wrong HTTP method
D) Wrong URL format

**Answer: B**
Missing confirmation dialog—should ask user before deleting.

---

## Question 17
How do you populate an edit form with current data?

```javascript
const app = await fetch(`/api/applications/${id}`).then(r => r.json());

// Now what?
```

A) Do nothing
B) Set form input values to app properties
C) Delete the data
D) Create new application

**Answer: B**
Set each form input's value to the corresponding property from the fetched data.

---

## Question 18
What's the difference between PUT and PATCH?

A) No difference
B) PUT updates entire record, PATCH updates specific fields
C) PUT creates, PATCH deletes
D) PATCH is for images only

**Answer: B**
PUT replaces the entire record, PATCH updates only specified fields.

---

## Question 19
Should you validate data before UPDATE?

A) No, only validate on CREATE
B) Yes, always validate updated data
C) Validation is optional
D) Only validate in Flask

**Answer: B**
Always validate data on both CREATE and UPDATE operations, frontend and backend.

---

## Question 20
What should happen after deleting a record?

A) Nothing
B) Show confirmation, reload list to remove deleted item
C) Keep showing the deleted item
D) Reload entire website

**Answer: B**
Notify user of successful deletion and refresh the list to reflect the change.

---

## Practical Challenge

Build a complete UPDATE and DELETE system:

**Requirements:**
1. Display list of applications with Edit and Delete buttons
2. Clicking Edit opens modal with current data
3. User can modify fields and save changes (PUT request)
4. Clicking Delete shows confirmation dialog
5. Only delete if user confirms (DELETE request)
6. Show success/error messages
7. Reload list after UPDATE or DELETE
8. Implement quick status change (PATCH request)

**Flask endpoints to implement:**
```python
@app.route('/api/applications/<int:id>', methods=['GET'])     # Get current data
@app.route('/api/applications/<int:id>', methods=['PUT'])     # Update
@app.route('/api/applications/<int:id>', methods=['DELETE'])  # Delete
@app.route('/api/applications/<int:id>/status', methods=['PATCH'])  # Quick status
```

Can you build this complete UPDATE/DELETE system?

---

## Summary

Key Concepts:
- **UPDATE**: Use PUT for full updates, PATCH for partial
- **DELETE**: Always confirm before deleting
- **Include ID**: URL must include record ID (e.g., `/api/resource/5`)
- **Check Existence**: Verify record exists before UPDATE/DELETE
- **User Feedback**: Show success/error messages
- **Refresh Display**: Reload data after changes
- **Modals**: Use for edit forms to keep user on same page
- **Validation**: Validate updated data like you validate new data
- **Destructive Actions**: Always confirm DELETE operations

You now understand the complete CRUD cycle!
