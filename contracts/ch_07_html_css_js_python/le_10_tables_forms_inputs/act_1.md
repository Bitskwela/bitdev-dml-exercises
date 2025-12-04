# Lesson 10 Activities: Tables, Forms, and Inputs

## Structured Data and User Interaction

Master HTML tables for displaying data and forms for collecting user input!

---

## Activity 1: Basic Table Structure

**Goal:** Create properly structured tables.

**Create:** `table-basic.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Basic Table</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid black; padding: 8px; text-align: left; }
        th { background-color: #4CAF50; color: white; }
    </style>
</head>
<body>
    <h1>Barangay Officials</h1>
    
    <table>
        <!-- Table header -->
        <thead>
            <tr>
                <th>Name</th>
                <th>Position</th>
                <th>Contact</th>
            </tr>
        </thead>
        
        <!-- Table body -->
        <tbody>
            <tr>
                <td>Juan Dela Cruz</td>
                <td>Barangay Captain</td>
                <td>0912-345-6789</td>
            </tr>
            <tr>
                <td>Maria Santos</td>
                <td>Kagawad - Health</td>
                <td>0923-456-7890</td>
            </tr>
            <tr>
                <td>Pedro Reyes</td>
                <td>Kagawad - Education</td>
                <td>0934-567-8901</td>
            </tr>
        </tbody>
        
        <!-- Table footer -->
        <tfoot>
            <tr>
                <td colspan="3"><strong>Total Officials: 3</strong></td>
            </tr>
        </tfoot>
    </table>
</body>
</html>
```

**Table structure:**
- `<table>` - Container
- `<thead>` - Header section
- `<tbody>` - Body section
- `<tfoot>` - Footer section
- `<tr>` - Table row
- `<th>` - Header cell
- `<td>` - Data cell

---

## Activity 2: Service Fee Table

**Goal:** Create a practical fee schedule table.

**Create:** `service-fees.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Service Fees</title>
    <style>
        table { border-collapse: collapse; width: 600px; margin: 20px auto; }
        th, td { border: 1px solid #ddd; padding: 12px; }
        th { background-color: #0066cc; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        tr:hover { background-color: #ddd; }
        .price { text-align: right; font-weight: bold; }
    </style>
</head>
<body>
    <h1>Barangay Service Fees</h1>
    
    <table>
        <caption>Official Fee Schedule (2025)</caption>
        <thead>
            <tr>
                <th>Service</th>
                <th>Requirements</th>
                <th>Processing Time</th>
                <th>Fee</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Barangay Clearance</td>
                <td>Valid ID, 2x2 photo</td>
                <td>Same day</td>
                <td class="price">₱50.00</td>
            </tr>
            <tr>
                <td>Barangay ID</td>
                <td>Valid ID, 1x1 photo</td>
                <td>3 days</td>
                <td class="price">₱30.00</td>
            </tr>
            <tr>
                <td>Business Permit (New)</td>
                <td>DTI/SEC, Business Plan</td>
                <td>5-7 days</td>
                <td class="price">₱500.00</td>
            </tr>
            <tr>
                <td>Business Permit (Renewal)</td>
                <td>Previous permit, Updated docs</td>
                <td>3 days</td>
                <td class="price">₱300.00</td>
            </tr>
            <tr>
                <td>Indigency Certificate</td>
                <td>Valid ID, Proof of residency</td>
                <td>Same day</td>
                <td class="price">Free</td>
            </tr>
            <tr>
                <td>Cedula</td>
                <td>Valid ID</td>
                <td>Same day</td>
                <td class="price">₱5.00 - ₱5,000.00</td>
            </tr>
        </tbody>
        <tfoot>
            <tr>
                <td colspan="4" style="text-align: center;">
                    <em>Fees subject to change without prior notice</em>
                </td>
            </tr>
        </tfoot>
    </table>
</body>
</html>
```

**Features:**
- Caption for context
- Striped rows (CSS)
- Hover effect
- Right-aligned prices
- Colspan for footer

---

## Activity 3: Table with Rowspan and Colspan

**Goal:** Master cell spanning.

**Create:** `table-spanning.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Table Spanning</title>
    <style>
        table { border-collapse: collapse; width: 80%; margin: 20px auto; }
        th, td { border: 1px solid black; padding: 10px; text-align: center; }
        th { background-color: #4CAF50; color: white; }
    </style>
</head>
<body>
    <h1>Barangay Office Schedule</h1>
    
    <table>
        <thead>
            <tr>
                <th>Time</th>
                <th>Monday</th>
                <th>Tuesday</th>
                <th>Wednesday</th>
                <th>Thursday</th>
                <th>Friday</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>8:00 - 10:00 AM</td>
                <td colspan="5">General Services (All Windows Open)</td>
            </tr>
            <tr>
                <td>10:00 - 12:00 PM</td>
                <td rowspan="2">Clearance Processing</td>
                <td>ID Processing</td>
                <td rowspan="2">Clearance Processing</td>
                <td>ID Processing</td>
                <td>Permits</td>
            </tr>
            <tr>
                <td>1:00 - 3:00 PM</td>
                <td>Permits</td>
                <td>Permits</td>
                <td colspan="2">Priority Services</td>
            </tr>
            <tr>
                <td>3:00 - 5:00 PM</td>
                <td colspan="5">General Services (Walk-in Only)</td>
            </tr>
        </tbody>
    </table>
    
    <h2>Kagawad Availability</h2>
    <table>
        <thead>
            <tr>
                <th>Day</th>
                <th>Health</th>
                <th>Education</th>
                <th>Public Safety</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Monday</td>
                <td rowspan="3">M. Santos</td>
                <td>P. Reyes</td>
                <td rowspan="2">J. Garcia</td>
            </tr>
            <tr>
                <td>Tuesday</td>
                <td>P. Reyes</td>
            </tr>
            <tr>
                <td>Wednesday</td>
                <td colspan="2">All Kagawads Available</td>
            </tr>
        </tbody>
    </table>
</body>
</html>
```

**Attributes:**
- `colspan="3"` - Spans 3 columns
- `rowspan="2"` - Spans 2 rows

---

## Activity 4: Basic Form Structure

**Goal:** Create a simple contact form.

**Create:** `form-basic.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Contact Form</title>
</head>
<body>
    <h1>Contact Barangay Sto. Niño</h1>
    
    <form action="submit.php" method="POST">
        <!-- Text input -->
        <label for="name">Full Name:</label><br>
        <input type="text" id="name" name="name" required><br><br>
        
        <!-- Email input -->
        <label for="email">Email:</label><br>
        <input type="email" id="email" name="email" required><br><br>
        
        <!-- Textarea -->
        <label for="message">Message:</label><br>
        <textarea id="message" name="message" rows="5" cols="40" required></textarea><br><br>
        
        <!-- Submit button -->
        <button type="submit">Send Message</button>
        <button type="reset">Clear Form</button>
    </form>
</body>
</html>
```

**Form attributes:**
- `action` - Where to send data
- `method` - How to send (GET or POST)

**Important:** Every input needs a `<label>` for accessibility!

---

## Activity 5: Input Types

**Goal:** Explore all HTML5 input types.

**Create:** `input-types.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Input Types</title>
</head>
<body>
    <h1>HTML5 Input Types</h1>
    
    <form>
        <!-- Text -->
        <label for="text">Text:</label>
        <input type="text" id="text" name="text" placeholder="Enter text"><br><br>
        
        <!-- Password -->
        <label for="password">Password:</label>
        <input type="password" id="password" name="password"><br><br>
        
        <!-- Email -->
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" placeholder="juan@example.com"><br><br>
        
        <!-- Tel -->
        <label for="tel">Phone:</label>
        <input type="tel" id="tel" name="tel" pattern="09[0-9]{9}" placeholder="09123456789"><br><br>
        
        <!-- Number -->
        <label for="age">Age:</label>
        <input type="number" id="age" name="age" min="18" max="100"><br><br>
        
        <!-- Date -->
        <label for="birthdate">Birthdate:</label>
        <input type="date" id="birthdate" name="birthdate"><br><br>
        
        <!-- Time -->
        <label for="time">Appointment Time:</label>
        <input type="time" id="time" name="time"><br><br>
        
        <!-- Color -->
        <label for="color">Favorite Color:</label>
        <input type="color" id="color" name="color"><br><br>
        
        <!-- Range -->
        <label for="satisfaction">Satisfaction (1-10):</label>
        <input type="range" id="satisfaction" name="satisfaction" min="1" max="10"><br><br>
        
        <!-- File -->
        <label for="file">Upload File:</label>
        <input type="file" id="file" name="file"><br><br>
        
        <!-- URL -->
        <label for="website">Website:</label>
        <input type="url" id="website" name="website" placeholder="https://example.com"><br><br>
        
        <!-- Search -->
        <label for="search">Search:</label>
        <input type="search" id="search" name="search"><br><br>
        
        <button type="submit">Submit</button>
    </form>
</body>
</html>
```

**Each input type has built-in validation!**

---

## Activity 6: Radio, Checkbox, and Select

**Goal:** Master selection inputs.

**Create:** `selection-inputs.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <title>Selection Inputs</title>
</head>
<body>
    <h1>Service Request Form</h1>
    
    <form>
        <!-- Radio buttons (single choice) -->
        <fieldset>
            <legend>Select Service:</legend>
            <input type="radio" id="clearance" name="service" value="clearance" required>
            <label for="clearance">Barangay Clearance</label><br>
            
            <input type="radio" id="id" name="service" value="id">
            <label for="id">Barangay ID</label><br>
            
            <input type="radio" id="permit" name="service" value="permit">
            <label for="permit">Business Permit</label><br>
        </fieldset><br>
        
        <!-- Checkboxes (multiple choice) -->
        <fieldset>
            <legend>Additional Requirements:</legend>
            <input type="checkbox" id="rush" name="rush" value="yes">
            <label for="rush">Rush Processing (+₱50)</label><br>
            
            <input type="checkbox" id="pickup" name="pickup" value="yes">
            <label for="pickup">Pickup Service (+₱20)</label><br>
            
            <input type="checkbox" id="certified" name="certified" value="yes">
            <label for="certified">Certified True Copy (+₱30)</label><br>
        </fieldset><br>
        
        <!-- Dropdown (select) -->
        <label for="purpose">Purpose:</label>
        <select id="purpose" name="purpose" required>
            <option value="">-- Select Purpose --</option>
            <option value="employment">Employment</option>
            <option value="loan">Loan Application</option>
            <option value="school">School Requirements</option>
            <option value="travel">Travel/Passport</option>
            <option value="other">Other</option>
        </select><br><br>
        
        <!-- Multiple select -->
        <label for="docs">Required Documents (hold Ctrl to select multiple):</label><br>
        <select id="docs" name="docs" multiple size="5">
            <option value="id">Valid ID</option>
            <option value="photo">1x1 Photo</option>
            <option value="photo2x2">2x2 Photo</option>
            <option value="residency">Proof of Residency</option>
            <option value="income">Proof of Income</option>
        </select><br><br>
        
        <button type="submit">Submit Request</button>
    </form>
</body>
</html>
```

**Key differences:**
- **Radio:** Only one selection per group (same `name`)
- **Checkbox:** Multiple selections allowed
- **Select:** Dropdown list (single or multiple)

---

## Activity 7: Complete Barangay Clearance Application Form

**Goal:** Build a comprehensive form with validation.

**Create:** `clearance-application.html`

```html
<!DOCTYPE html>
<html lang="en-PH">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Barangay Clearance Application</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 800px; margin: 20px auto; padding: 20px; }
        fieldset { margin-bottom: 20px; padding: 15px; border: 2px solid #4CAF50; }
        legend { font-weight: bold; color: #4CAF50; }
        label { display: inline-block; width: 200px; margin-bottom: 10px; }
        input, select, textarea { width: 300px; padding: 5px; margin-bottom: 10px; }
        input[type="radio"], input[type="checkbox"] { width: auto; }
        .required { color: red; }
        button { padding: 10px 20px; margin: 10px 5px; cursor: pointer; }
        button[type="submit"] { background-color: #4CAF50; color: white; border: none; }
        button[type="reset"] { background-color: #f44336; color: white; border: none; }
    </style>
</head>
<body>
    <h1>Barangay Clearance Application Form</h1>
    <p><span class="required">*</span> Required fields</p>
    
    <form action="process-application.php" method="POST" enctype="multipart/form-data">
        
        <!-- Personal Information -->
        <fieldset>
            <legend>Personal Information</legend>
            
            <label for="lastname">Last Name: <span class="required">*</span></label>
            <input type="text" id="lastname" name="lastname" required minlength="2"><br>
            
            <label for="firstname">First Name: <span class="required">*</span></label>
            <input type="text" id="firstname" name="firstname" required><br>
            
            <label for="middlename">Middle Name:</label>
            <input type="text" id="middlename" name="middlename"><br>
            
            <label for="suffix">Suffix:</label>
            <select id="suffix" name="suffix">
                <option value="">-- None --</option>
                <option value="Jr.">Jr.</option>
                <option value="Sr.">Sr.</option>
                <option value="II">II</option>
                <option value="III">III</option>
                <option value="IV">IV</option>
            </select><br>
            
            <label>Gender: <span class="required">*</span></label>
            <input type="radio" id="male" name="gender" value="male" required>
            <label for="male" style="width: auto;">Male</label>
            <input type="radio" id="female" name="gender" value="female">
            <label for="female" style="width: auto;">Female</label><br><br>
            
            <label for="birthdate">Birthdate: <span class="required">*</span></label>
            <input type="date" id="birthdate" name="birthdate" required max="2007-12-04"><br>
            
            <label for="age">Age: <span class="required">*</span></label>
            <input type="number" id="age" name="age" required min="18" max="120"><br>
            
            <label>Civil Status: <span class="required">*</span></label>
            <input type="radio" id="single" name="civil_status" value="single" required>
            <label for="single" style="width: auto;">Single</label>
            <input type="radio" id="married" name="civil_status" value="married">
            <label for="married" style="width: auto;">Married</label>
            <input type="radio" id="widowed" name="civil_status" value="widowed">
            <label for="widowed" style="width: auto;">Widowed</label><br>
        </fieldset>
        
        <!-- Contact Information -->
        <fieldset>
            <legend>Contact Information</legend>
            
            <label for="mobile">Mobile Number: <span class="required">*</span></label>
            <input type="tel" id="mobile" name="mobile" required pattern="09[0-9]{9}" placeholder="09123456789" title="Format: 09XXXXXXXXX"><br>
            
            <label for="email">Email Address:</label>
            <input type="email" id="email" name="email" placeholder="juan@example.com"><br>
            
            <label for="address">Complete Address: <span class="required">*</span></label>
            <textarea id="address" name="address" rows="3" required placeholder="House No., Street, Purok/Sitio"></textarea><br>
        </fieldset>
        
        <!-- Application Details -->
        <fieldset>
            <legend>Application Details</legend>
            
            <label for="purpose">Purpose: <span class="required">*</span></label>
            <select id="purpose" name="purpose" required>
                <option value="">-- Select Purpose --</option>
                <option value="employment">Employment</option>
                <option value="local_employment">Local Employment</option>
                <option value="overseas_employment">Overseas Employment</option>
                <option value="loan">Loan Application</option>
                <option value="bank">Bank Requirements</option>
                <option value="school">School Requirements</option>
                <option value="scholarship">Scholarship Application</option>
                <option value="travel">Travel/Passport</option>
                <option value="permit">Business Permit</option>
                <option value="other">Other (specify below)</option>
            </select><br>
            
            <label for="other_purpose">If Other, specify:</label>
            <input type="text" id="other_purpose" name="other_purpose"><br>
            
            <label>Processing Type:</label>
            <input type="radio" id="regular" name="processing" value="regular" checked>
            <label for="regular" style="width: auto;">Regular (Same day - ₱50)</label><br>
            <label></label>
            <input type="radio" id="rush" name="processing" value="rush">
            <label for="rush" style="width: auto;">Rush (2 hours - ₱100)</label><br>
        </fieldset>
        
        <!-- Document Upload -->
        <fieldset>
            <legend>Upload Requirements</legend>
            
            <label for="valid_id">Valid ID: <span class="required">*</span></label>
            <input type="file" id="valid_id" name="valid_id" required accept=".jpg,.jpeg,.png,.pdf"><br>
            
            <label for="photo">2x2 Photo:</label>
            <input type="file" id="photo" name="photo" accept=".jpg,.jpeg,.png"><br>
            
            <label for="proof_residency">Proof of Residency:</label>
            <input type="file" id="proof_residency" name="proof_residency" accept=".jpg,.jpeg,.png,.pdf"><br>
        </fieldset>
        
        <!-- Declaration -->
        <fieldset>
            <legend>Declaration</legend>
            
            <input type="checkbox" id="data_privacy" name="data_privacy" required style="width: auto;">
            <label for="data_privacy" style="width: auto;">
                I consent to the collection and processing of my personal data in accordance with the Data Privacy Act of 2012. <span class="required">*</span>
            </label><br><br>
            
            <input type="checkbox" id="truthfulness" name="truthfulness" required style="width: auto;">
            <label for="truthfulness" style="width: auto;">
                I certify that all information provided is true and correct. <span class="required">*</span>
            </label><br>
        </fieldset>
        
        <!-- Buttons -->
        <div style="text-align: center;">
            <button type="submit">Submit Application</button>
            <button type="reset">Clear Form</button>
        </div>
    </form>
    
    <hr>
    <footer>
        <p><small>For assistance, contact: (043) 123-4567 or email brgy.stonino@example.com</small></p>
    </footer>
</body>
</html>
```

**Features implemented:**
✅ Proper form structure with fieldsets  
✅ Required field indicators  
✅ All input types (text, email, tel, number, date, select, radio, checkbox, file, textarea)  
✅ Input validation (pattern, min, max, required)  
✅ Placeholder text and titles  
✅ Data privacy consent  
✅ File upload with accept filter  
✅ Professional styling  
✅ Submit and reset buttons

---

<details>
<summary><strong>📝 Answer Key</strong></summary>

## Activity 1: Table Structure

**Complete table anatomy:**
```html
<table>
    <caption>Table Title</caption>  <!-- Optional: table description -->
    
    <thead>  <!-- Header section -->
        <tr>  <!-- Table row -->
            <th>Header 1</th>  <!-- Header cell -->
            <th>Header 2</th>
        </tr>
    </thead>
    
    <tbody>  <!-- Body section -->
        <tr>
            <td>Data 1</td>  <!-- Data cell -->
            <td>Data 2</td>
        </tr>
    </tbody>
    
    <tfoot>  <!-- Footer section -->
        <tr>
            <td colspan="2">Footer content</td>
        </tr>
    </tfoot>
</table>
```

**Best practices:**
- Always use `<thead>`, `<tbody>`, `<tfoot>` for structure
- Use `<th>` for headers (bold by default, semantic)
- Use `<caption>` for table description
- Add CSS borders (default has no borders)

## Activity 2: Table Styling

**Essential CSS for tables:**
```css
/* Collapse borders */
table {
    border-collapse: collapse;
    width: 100%;
}

/* Cell styling */
th, td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}

/* Header styling */
th {
    background-color: #4CAF50;
    color: white;
}

/* Zebra striping */
tr:nth-child(even) {
    background-color: #f2f2f2;
}

/* Hover effect */
tr:hover {
    background-color: #ddd;
}
```

## Activity 3: Colspan and Rowspan

**Colspan (horizontal spanning):**
```html
<tr>
    <td colspan="3">Spans 3 columns</td>
</tr>
```

**Rowspan (vertical spanning):**
```html
<tr>
    <td rowspan="2">Spans 2 rows</td>
    <td>Normal cell</td>
</tr>
<tr>
    <!-- First cell is rowspan from above -->
    <td>Normal cell</td>
</tr>
```

**Combined:**
```html
<table>
    <tr>
        <td colspan="2" rowspan="2">Spans 2 cols and 2 rows</td>
        <td>Normal</td>
    </tr>
    <tr>
        <td>Normal</td>
    </tr>
    <tr>
        <td>Normal</td>
        <td>Normal</td>
        <td>Normal</td>
    </tr>
</table>
```

## Activity 4: Form Basics

**Complete form syntax:**
```html
<form action="submit.php" method="POST" enctype="multipart/form-data">
    <!-- Form fields here -->
</form>
```

**Form attributes:**
- `action` - URL where form data is sent
- `method` - HTTP method (GET or POST)
  - **GET:** Data in URL (visible, bookmarkable)
  - **POST:** Data in request body (hidden, secure)
- `enctype` - Encoding type (required for file uploads)
  - `application/x-www-form-urlencoded` (default)
  - `multipart/form-data` (for files)
  - `text/plain` (plain text)

**Label association:**
```html
<!-- Method 1: for attribute -->
<label for="name">Name:</label>
<input type="text" id="name" name="name">

<!-- Method 2: wrap input -->
<label>
    Name:
    <input type="text" name="name">
</label>
```

## Activity 5: Input Types

**Complete input type reference:**

```html
<!-- Text inputs -->
<input type="text">       <!-- Plain text -->
<input type="password">   <!-- Hidden text -->
<input type="email">      <!-- Email validation -->
<input type="tel">        <!-- Phone number -->
<input type="url">        <!-- URL validation -->
<input type="search">     <!-- Search box -->

<!-- Numbers -->
<input type="number" min="0" max="100" step="5">
<input type="range" min="0" max="100">

<!-- Dates and times -->
<input type="date">       <!-- Date picker -->
<input type="time">       <!-- Time picker -->
<input type="datetime-local">  <!-- Date + time -->
<input type="month">      <!-- Month picker -->
<input type="week">       <!-- Week picker -->

<!-- Others -->
<input type="color">      <!-- Color picker -->
<input type="file" accept=".jpg,.pdf" multiple>  <!-- File upload -->
<input type="hidden" value="secret">  <!-- Hidden field -->
<input type="checkbox">   <!-- Checkbox -->
<input type="radio">      <!-- Radio button -->

<!-- Buttons -->
<input type="submit" value="Submit">
<input type="reset" value="Reset">
<input type="button" value="Click Me">
<!-- Better: use <button> instead -->
<button type="submit">Submit</button>
<button type="reset">Reset</button>
<button type="button">Click Me</button>
```

**Input validation attributes:**
```html
<input 
    type="text"
    required              <!-- Must be filled -->
    minlength="3"        <!-- Minimum length -->
    maxlength="50"       <!-- Maximum length -->
    pattern="[A-Za-z]+"  <!-- Regex pattern -->
    placeholder="Hint"   <!-- Hint text -->
    title="Tooltip"      <!-- Error message -->
>

<input 
    type="number"
    min="0"              <!-- Minimum value -->
    max="100"            <!-- Maximum value -->
    step="5"             <!-- Increment -->
>

<input 
    type="file"
    accept=".jpg,.png"   <!-- File types -->
    multiple             <!-- Multiple files -->
>
```

## Activity 6: Selection Inputs

**Radio buttons (single choice):**
```html
<input type="radio" id="opt1" name="group" value="1" required>
<label for="opt1">Option 1</label>

<input type="radio" id="opt2" name="group" value="2">
<label for="opt2">Option 2</label>

<!-- Same 'name' = only one selectable -->
```

**Checkboxes (multiple choice):**
```html
<input type="checkbox" id="cb1" name="feature1" value="yes">
<label for="cb1">Feature 1</label>

<input type="checkbox" id="cb2" name="feature2" value="yes">
<label for="cb2">Feature 2</label>

<!-- Different 'name' = independent selections -->
```

**Select dropdown:**
```html
<!-- Single selection -->
<select name="choice" required>
    <option value="">-- Select --</option>
    <option value="1">Option 1</option>
    <option value="2" selected>Option 2 (default)</option>
    <option value="3">Option 3</option>
</select>

<!-- Multiple selection -->
<select name="choices" multiple size="5">
    <option value="1">Option 1</option>
    <option value="2">Option 2</option>
    <option value="3">Option 3</option>
</select>

<!-- Grouped options -->
<select name="location">
    <optgroup label="Luzon">
        <option value="manila">Manila</option>
        <option value="batangas">Batangas</option>
    </optgroup>
    <optgroup label="Visayas">
        <option value="cebu">Cebu</option>
        <option value="iloilo">Iloilo</option>
    </optgroup>
</select>
```

**Textarea:**
```html
<textarea 
    name="message" 
    rows="5" 
    cols="40"
    placeholder="Enter message"
    required
    minlength="10"
    maxlength="500"
></textarea>
```

## Activity 7: Form Validation

**Built-in HTML5 validation:**
```html
<!-- Required field -->
<input type="text" required>

<!-- Email format -->
<input type="email" required>

<!-- Pattern matching -->
<input type="tel" pattern="09[0-9]{9}" title="Format: 09XXXXXXXXX">

<!-- Number range -->
<input type="number" min="18" max="65">

<!-- String length -->
<input type="text" minlength="8" maxlength="20">

<!-- Date range -->
<input type="date" min="2020-01-01" max="2025-12-31">
```

**Philippine phone number pattern:**
```html
<input 
    type="tel" 
    pattern="09[0-9]{9}"
    placeholder="09123456789"
    title="Philippine mobile number (09XXXXXXXXX)"
    required
>
```

**Fieldset for grouping:**
```html
<fieldset>
    <legend>Personal Information</legend>
    <!-- Related fields here -->
</fieldset>
```

**File upload:**
```html
<!-- Single file -->
<input type="file" accept=".jpg,.jpeg,.png" required>

<!-- Multiple files -->
<input type="file" accept=".pdf,.doc,.docx" multiple>

<!-- Accept types -->
accept=".jpg,.png"         <!-- Specific extensions -->
accept="image/*"           <!-- All images -->
accept="image/jpeg,image/png"  <!-- MIME types -->
accept="application/pdf"   <!-- PDF only -->
```

**Form encryption for file uploads:**
```html
<form action="upload.php" method="POST" enctype="multipart/form-data">
    <input type="file" name="document">
    <button type="submit">Upload</button>
</form>
```

</details>

---

**Outstanding!** You've mastered tables for data display and forms for user input. You can now create interactive, data-driven web pages!

**Next:** Semantic HTML for better structure and accessibility!
