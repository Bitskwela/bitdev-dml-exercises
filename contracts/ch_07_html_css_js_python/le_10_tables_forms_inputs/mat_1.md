## Background Story

The barangay website project was progressing well. Tian and Rhea Joy had built beautiful pages with semantic HTML and polished CSS. But two critical features were missing: displaying structured data and collecting user input.

The barangay captain had requested two specific functionalities:

1. **Population Data Table**: A page showing the population breakdown by sitio (sub-village), households, and registered voters
2. **Online Application Form**: A form where residents could apply for barangay clearances online instead of coming to the office

Tian stared at the population data spreadsheet the barangay secretary had provided. Rows and columns of numbers—sitios, population counts, household numbers. How do you display tabular data in HTML?

They tried using `<div>` elements and CSS Grid, but it felt clunky and semantically wrong. There had to be a proper HTML element for tables... right?

Rhea Joy was tackling the application form. She'd created a beautiful design in Figma—text inputs for name and address, radio buttons for document type selection, a textarea for the request reason, a submit button. But translating that design into functional HTML was proving difficult.

How do you create a text input field? How do you make radio buttons where only one can be selected? How do you capture user submissions?

It was Saturday afternoon, and they were both at the internet cafe, each struggling with their respective challenges.

"This feels like we're missing fundamental knowledge," Tian said, frustrated. "We've learned headings, paragraphs, links, images... but nothing about displaying data tables or creating forms."

"Are these advanced topics?" Rhea Joy asked.

Tian pulled out their phone and called Kuya Miguel.

"Kuya, we need to display a population data table and create an application form, but we don't know the HTML for either. Are those advanced topics, or did we skip something?"

Miguel laughed. "Not advanced at all! Those are actually fundamental HTML topics—you definitely need to learn them. HTML has specific elements for tables (`<table>`, `<tr>`, `<td>`) and forms (`<form>`, `<input>`, `<textarea>`, `<select>`). Both are essential for real-world websites."

"Why didn't we learn them earlier?"

"We focused on structure, content, and basic styling first. But now that you have that foundation, it's time to learn data display and user input collection. Tables for structured data. Forms for collecting information from users. Combined with CSS for styling and eventually JavaScript for validation and submission handling, these elements become incredibly powerful."

Miguel continued, "Tables have been part of HTML since the beginning—though people used to misuse them for page layouts before CSS Flexbox and Grid existed. Forms are how the web became interactive. Every login page, every search box, every signup form—all built with HTML form elements."

"Can you teach us both today?" Tian asked.

"Absolutely. Let's start with tables—how to structure data in rows and columns, use headers, add borders and styling. Then we'll move to forms—text inputs, radio buttons, checkboxes, dropdowns, textareas, and how to handle form submission. By the end of today, you'll have your population table displaying beautifully and your application form ready to collect user data."

---

## Theory & Lecture Content

## HTML Tables

**Tables** = Display data in rows and columns

### Basic Table Structure

```html
<table>
    <tr>  <!-- Table Row -->
        <th>Header 1</th>  <!-- Table Header -->
        <th>Header 2</th>
    </tr>
    <tr>
        <td>Data 1</td>  <!-- Table Data -->
        <td>Data 2</td>
    </tr>
</table>
```

**Tags:**
- `<table>` = Wrapper for entire table
- `<tr>` = Table Row
- `<th>` = Table Header (bold, centered by default)
- `<td>` = Table Data (normal text)

### Filipino Example: Barangay Population

```html
<table border="1">
    <tr>
        <th>Sitio</th>
        <th>Population</th>
        <th>Households</th>
    </tr>
    <tr>
        <td>Sitio 1</td>
        <td>542</td>
        <td>98</td>
    </tr>
    <tr>
        <td>Sitio 2</td>
        <td>687</td>
        <td>125</td>
    </tr>
    <tr>
        <td>Sitio 3</td>
        <td>411</td>
        <td>76</td>
    </tr>
</table>
```

### Table Sections

```html
<table>
    <thead>  <!-- Table Head (header rows) -->
        <tr>
            <th>Name</th>
            <th>Position</th>
        </tr>
    </thead>
    
    <tbody>  <!-- Table Body (data rows) -->
        <tr>
            <td>Maria Santos</td>
            <td>Captain</td>
        </tr>
        <tr>
            <td>Juan Dela Cruz</td>
            <td>Kagawad</td>
        </tr>
    </tbody>
    
    <tfoot>  <!-- Table Footer (summary rows) -->
        <tr>
            <td>Total Officials:</td>
            <td>8</td>
        </tr>
    </tfoot>
</table>
```

### Table Attributes

```html
<!-- Colspan (merge columns) -->
<tr>
    <td colspan="2">Spans 2 columns</td>
</tr>

<!-- Rowspan (merge rows) -->
<tr>
    <td rowspan="2">Spans 2 rows</td>
    <td>Data</td>
</tr>
<tr>
    <td>Data</td>
</tr>
```

### Styled Table (with CSS)

```html
<style>
table {
    width: 100%;
    border-collapse: collapse;
}
th, td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}
th {
    background-color: #4CAF50;
    color: white;
}
tr:nth-child(even) {
    background-color: #f2f2f2;
}
</style>

<table>
    <tr>
        <th>Service</th>
        <th>Fee</th>
    </tr>
    <tr>
        <td>Barangay Clearance</td>
        <td>₱50</td>
    </tr>
    <tr>
        <td>Cedula</td>
        <td>₱5-100</td>
    </tr>
</table>
```

## HTML Forms

**Forms** = Collect user input and send to server

### Basic Form Structure

```html
<form action="submit.php" method="POST">
    <!-- Form inputs go here -->
    <button type="submit">Submit</button>
</form>
```

**Attributes:**
- `action` = URL where form data is sent
- `method` = How data is sent (GET or POST)
  - **GET:** Data in URL (visible, for searches)
  - **POST:** Data hidden (secure, for sensitive info)

### Input Fields

#### Text Input

```html
<label for="name">Name:</label>
<input type="text" id="name" name="name" placeholder="Enter your name" required>
```

**Attributes:**
- `type="text"` = Single-line text
- `id` = Links to label (accessibility)
- `name` = Field name sent to server
- `placeholder` = Hint text
- `required` = Must be filled

#### Email Input

```html
<label for="email">Email:</label>
<input type="email" id="email" name="email" required>
```

Automatically validates email format.

#### Password Input

```html
<label for="password">Password:</label>
<input type="password" id="password" name="password" required minlength="8">
```

Hides characters while typing.

#### Number Input

```html
<label for="age">Age:</label>
<input type="number" id="age" name="age" min="18" max="100" required>
```

#### Date Input

```html
<label for="birthdate">Birthdate:</label>
<input type="date" id="birthdate" name="birthdate" required>
```

#### Radio Buttons (choose one)

```html
<p>Gender:</p>
<input type="radio" id="male" name="gender" value="male">
<label for="male">Male</label><br>

<input type="radio" id="female" name="gender" value="female">
<label for="female">Female</label><br>

<input type="radio" id="other" name="gender" value="other">
<label for="other">Prefer not to say</label>
```

**Note:** Same `name` attribute groups radio buttons (only one selectable).

#### Checkboxes (choose multiple)

```html
<p>Services needed:</p>
<input type="checkbox" id="clearance" name="services" value="clearance">
<label for="clearance">Barangay Clearance</label><br>

<input type="checkbox" id="cedula" name="services" value="cedula">
<label for="cedula">Cedula</label><br>

<input type="checkbox" id="permit" name="services" value="permit">
<label for="permit">Business Permit</label>
```

#### Dropdown (Select)

```html
<label for="barangay">Barangay:</label>
<select id="barangay" name="barangay" required>
    <option value="">-- Choose Barangay --</option>
    <option value="stonino">Sto. Niño</option>
    <option value="sanjose">San Jose</option>
    <option value="poblacion">Poblacion</option>
</select>
```

#### Textarea (Multi-line)

```html
<label for="message">Message:</label>
<textarea id="message" name="message" rows="5" cols="40" placeholder="Enter your message"></textarea>
```

#### File Upload

```html
<label for="document">Upload ID:</label>
<input type="file" id="document" name="document" accept=".pdf,.jpg,.png">
```

### Submit and Reset Buttons

```html
<button type="submit">Submit Form</button>
<button type="reset">Clear Form</button>
```

Or:

```html
<input type="submit" value="Submit">
<input type="reset" value="Clear">
```

## Complete Form Example: Barangay Clearance Application

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Barangay Clearance Application</title>
</head>
<body>
    <h1>Barangay Clearance Application Form</h1>
    
    <form action="submit.php" method="POST">
        <!-- Personal Information -->
        <fieldset>
            <legend>Personal Information</legend>
            
            <label for="fullname">Full Name:</label><br>
            <input type="text" id="fullname" name="fullname" required><br><br>
            
            <label for="birthdate">Birthdate:</label><br>
            <input type="date" id="birthdate" name="birthdate" required><br><br>
            
            <label for="age">Age:</label><br>
            <input type="number" id="age" name="age" min="0" max="120" required><br><br>
            
            <p>Gender:</p>
            <input type="radio" id="male" name="gender" value="male" required>
            <label for="male">Male</label>
            <input type="radio" id="female" name="gender" value="female">
            <label for="female">Female</label><br><br>
            
            <label for="address">Address:</label><br>
            <textarea id="address" name="address" rows="3" required></textarea><br><br>
        </fieldset>
        
        <!-- Contact Information -->
        <fieldset>
            <legend>Contact Information</legend>
            
            <label for="phone">Phone Number:</label><br>
            <input type="tel" id="phone" name="phone" placeholder="0917-123-4567" required><br><br>
            
            <label for="email">Email:</label><br>
            <input type="email" id="email" name="email"><br><br>
        </fieldset>
        
        <!-- Purpose -->
        <fieldset>
            <legend>Purpose of Clearance</legend>
            
            <label for="purpose">Select Purpose:</label><br>
            <select id="purpose" name="purpose" required>
                <option value="">-- Choose Purpose --</option>
                <option value="employment">Employment</option>
                <option value="school">School Enrollment</option>
                <option value="loan">Loan Application</option>
                <option value="other">Other</option>
            </select><br><br>
            
            <label for="details">Additional Details:</label><br>
            <textarea id="details" name="details" rows="4"></textarea><br><br>
        </fieldset>
        
        <!-- Document Upload -->
        <fieldset>
            <legend>Required Documents</legend>
            
            <label for="validid">Upload Valid ID:</label><br>
            <input type="file" id="validid" name="validid" accept=".jpg,.png,.pdf" required><br><br>
            
            <input type="checkbox" id="terms" name="terms" required>
            <label for="terms">I agree to the terms and conditions</label><br><br>
        </fieldset>
        
        <!-- Submit -->
        <button type="submit">Submit Application</button>
        <button type="reset">Clear Form</button>
    </form>
</body>
</html>
```

## Form Validation Attributes

```html
<!-- Required field -->
<input type="text" required>

<!-- Minimum/Maximum length -->
<input type="text" minlength="5" maxlength="20">

<!-- Number range -->
<input type="number" min="18" max="65">

<!-- Pattern (regex) -->
<input type="text" pattern="[0-9]{4}" title="Enter 4-digit code">

<!-- Email validation (automatic) -->
<input type="email">

<!-- URL validation (automatic) -->
<input type="url">
```

## Fieldset and Legend

**Fieldset** = Groups related form fields  
**Legend** = Title for fieldset

```html
<fieldset>
    <legend>Personal Information</legend>
    <!-- Form fields here -->
</fieldset>
```

## Form Accessibility

```html
<!-- Always use labels -->
<label for="username">Username:</label>
<input type="text" id="username" name="username">

<!-- Placeholder is NOT a substitute for label -->
<!-- WRONG: -->
<input type="text" placeholder="Username">  <!-- No label! -->

<!-- CORRECT: -->
<label for="username">Username:</label>
<input type="text" id="username" placeholder="Enter username">
```

## Common Mistakes

### ❌ Missing `name` attribute
```html
<input type="text" id="fullname">  <!-- No name, won't submit -->
```
✅ **Correct:**
```html
<input type="text" id="fullname" name="fullname">
```

### ❌ Labels not linked to inputs
```html
<label>Name:</label>
<input type="text" id="name">  <!-- Label doesn't link -->
```
✅ **Correct:**
```html
<label for="name">Name:</label>
<input type="text" id="name" name="name">
```

### ❌ Using tables for layout
```html
<!-- WRONG: Tables for page layout -->
<table><tr><td>Header</td></tr></table>
```
✅ **Correct:** Use tables only for tabular data, not layout.

## Summary

**Tables:**
- `<table>`, `<tr>` (row), `<th>` (header), `<td>` (data)
- Sections: `<thead>`, `<tbody>`, `<tfoot>`
- Merge: `colspan`, `rowspan`

**Forms:**
- `<form action method>`
- Inputs: text, email, password, number, date, radio, checkbox, select, textarea, file
- Attributes: `required`, `placeholder`, `min`, `max`, `minlength`, `maxlength`
- Always use `<label>` for accessibility
- `<fieldset>` + `<legend>` for grouping

**Next lesson:** Semantic HTML

---

## Closing Story

Tian built a contact form: name, email, message, submit button. It didn't send data anywhere yet (that's backend stuff for later), but it was there. Clickable. Usable.

"Forms are the bridge between frontend and backend," Kuya Miguel explained. "Right now, it's just HTML. But soon, you'll connect it to a server, store submissions in a database, send email confirmations. That's when it becomes powerful."

Tian typed into the form fields, clicked submit. Nothing happened. But that was okay. The structure was ready. The foundation was set. When the time came to add backend logic, this form would be waiting.

_Next up: Semantic HTMLmeaningful structure!_ 