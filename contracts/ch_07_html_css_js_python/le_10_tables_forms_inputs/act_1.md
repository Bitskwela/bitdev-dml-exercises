# Activity: The Sto. Niño Digital Census & Application System

In this activity, you will build the "Engine Room" of the Barangay portal. You will display structured community data using tables and create a robust application form for residents to request official documents.

## Objective
Master complex data display and interactive user input collection.

---

## Tasks

### Task 1: The Community Census (Tables)
**Action:** Create a table showing the population breakdown. Include a `<thead>` with "Sitio", "Voters", and "Population". Add at least 3 rows in the `<tbody>`.
```html
<table>
  <thead>
    <tr>
      <th>Sitio Name</th>
      <th>Registered Voters</th>
      <th>Total Population</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Purok One</td>
      <td>450</td>
      <td>1,200</td>
    </tr>
    <tr>
      <td>Riverside</td>
      <td>310</td>
      <td>850</td>
    </tr>
    <tr>
      <td>Hilltop</td>
      <td>120</td>
      <td>400</td>
    </tr>
  </tbody>
  <tfoot>
    <tr>
      <td>Total</td>
      <td>880</td>
      <td>2,450</td>
    </tr>
  </tfoot>
</table>
```

### Task 2: Structural Flexibility (Spanning)
**Action:** Add a row at the top of the table body that spans all 3 columns to announce a "System-wide Census Update".
```html
<tr>
  <td colspan="3" style="text-align: center; background-color: #f1c40f;"><strong>Notice:</strong> 2024 Census Update in Progress</td>
</tr>
```

### Task 3: The Application Portal (Form Basics)
**Action:** Create a `<form>` with a `<fieldset>` and `<legend>` called "Document Request Details".
```html
<form action="/submit-request" method="POST">
  <fieldset>
    <legend>Document Request Details</legend>
    <!-- Inputs go here -->
  </fieldset>
</form>
```

### Task 4: Digital Identity (Input Types)
**Action:** Inside your fieldset, add a `text` input for Full Name, an `email` input for notifications, and a `tel` input for a 11-digit phone number. Use `required` for all.
```html
<label for="fullname">Full Name:</label>
<input type="text" id="fullname" name="fullname" required>

<label for="email">Email Address:</label>
<input type="email" id="email" name="email" required>

<label for="phone">Phone Number:</label>
<input type="tel" id="phone" name="phone" pattern="[0-9]{11}" placeholder="09123456789" required>
```

### Task 5: Strategic Selection (Radio & Select)
**Action:** Add a radio button group for "Gender" and a dropdown menu (`select`) for the "Type of Document" (e.g., Clearance, Indigency, ID).
```html
<p>Gender:</p>
<input type="radio" id="male" name="gender" value="male">
<label for="male">Male</label>
<input type="radio" id="female" name="gender" value="female">
<label for="female">Female</label>

<label for="doc-type">Document Requested:</label>
<select id="doc-type" name="doc-type">
  <option value="clearance">Barangay Clearance</option>
  <option value="indigency">Certificate of Indigency</option>
  <option value="id">Barangay ID</option>
</select>
```

### Task 6: The Final Handshake (Validation & Submission)
**Action:** Add a checkbox for "Data Privacy Agreement" and a submit button.
```html
<input type="checkbox" id="privacy" name="privacy" required>
<label for="privacy">I agree to the Data Privacy terms.</label>

<button type="submit">Submit Request</button>
```

### Task 7: Elite Interface Design (Internal CSS)
**Action:** Add a `<style>` block to make the table look professional with zebra stripes and ensure the form inputs are easy to click on mobile.
```html
<style>
  table { width: 100%; border-collapse: collapse; margin-bottom: 30px; }
  th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
  th { background-color: #2c3e50; color: white; }
  tr:nth-child(even) { background-color: #f9f9f9; }
  
  form { background: #ecf0f1; padding: 20px; border-radius: 8px; }
  label { display: block; margin-top: 15px; font-weight: bold; }
  input[type="text"], input[type="email"], input[type="tel"], select {
    width: 100%; padding: 10px; margin-top: 5px; border: 1px solid #bdc3c7; border-radius: 4px;
    box-sizing: border-box; /* Crucial for width: 100% */
  }
  button { margin-top: 20px; padding: 10px 20px; background: #27ae60; color: white; border: none; cursor: pointer; }
</style>
```
