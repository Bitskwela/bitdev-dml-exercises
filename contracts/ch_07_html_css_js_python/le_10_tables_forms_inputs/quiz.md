# Tables, Forms, and Inputs Quiz

---

# Quiz 1

## Quiz: Tables and Forms

**Scenario:**

Tian creates a clearance application form:

```html
<form action="submit.php" method="POST">
    <label for="name">Name:</label>
    <input type="text" id="name" name="name" required>
    
    <label for="email">Email:</label>
    <input type="email" id="email" name="email">
    
    <p>Gender:</p>
    <input type="radio" id="male" name="gender" value="male">
    <label for="male">Male</label>
    <input type="radio" id="female" name="gender" value="female">
    <label for="female">Female</label>
    
    <button type="submit">Submit</button>
</form>

<table border="1">
    <tr>
        <th>Service</th>
        <th>Fee</th>
    </tr>
    <tr>
        <td>Clearance</td>
        <td>₱50</td>
    </tr>
</table>
```

**Question 1:** What's the difference between GET and POST methods?

- A) No difference
- B) GET shows data in URL (searches), POST hides data (secure)
- C) POST faster
- D) GET more secure

**Answer: B**

GET shows data in the URL (bookmarkable, for searches/filters). POST hides data in the request body (more secure for passwords/personal info).

**Question 2:** Why should labels have `for` attribute matching input `id`?

- A) Visual styling
- B) Accessibility (clicking label focuses input)
- C) Optional decoration
- D) No benefit

**Answer: B**

Linking labels with `for="id"` improves accessibility (screen readers) and UX (clicking label focuses the input, larger tap target).

---

# Quiz 2

**Question 3:** What's the difference between radio buttons and checkboxes?

- A) No difference
- B) Radio (choose one), Checkbox (choose multiple)
- C) Radio for text, Checkbox for numbers
- D) Both choose multiple

**Answer: B**

Radio buttons let you choose one option from a group (same `name`). Checkboxes let you choose multiple options independently.

**Question 4:** In a table, what's the difference between `<th>` and `<td>`?

- A) No difference
- B) `<th>` = header (bold, centered), `<td>` = data
- C) `<th>` for numbers only
- D) `<td>` bold by default

**Answer: B**

`<th>` (table header) is bold and centered by default, describes columns/rows. `<td>` (table data) contains the actual data cells.

**Question 5:** What attribute makes an input field mandatory?

- A) `mandatory`
- B) `required`
- C) `needed`
- D) `important`

**Answer: B**

The `required` attribute makes an input field mandatory. HTML5 validates this before form submission.  

---

## Detailed Explanations

Q1 **GET vs POST:**

**GET:**
- Data visible in URL: `search.php?query=clearance&city=batangas`
- Bookmarkable, shareable links
- Use for: Searches, filters, non-sensitive data
- Limit: ~2000 characters

**POST:**
- Data hidden in request body (not in URL)
- More secure (passwords, personal info)
- Use for: Forms with sensitive data, file uploads
- No size limit

Q2 **Label-Input association:**
```html
<label for="username">Username:</label>
<input type="text" id="username" name="username">
```

**Benefits:**
1. **Clickable area:** Clicking label focuses input
2. **Accessibility:** Screen readers announce label text
3. **Mobile UX:** Larger tap target

**Wrong approach:**
```html
<label>Username:</label>  <!-- Not linked -->
<input type="text" name="username">
```

Q3 **Radio vs Checkbox:**

**Radio buttons:**
- Choose **one** option
- Same `name` attribute groups them
```html
<input type="radio" name="gender" value="male"> Male
<input type="radio" name="gender" value="female"> Female
```

**Checkboxes:**
- Choose **multiple** options
- Independent selections
```html
<input type="checkbox" name="services" value="clearance"> Clearance
<input type="checkbox" name="services" value="cedula"> Cedula
```

Q4 **Table headers vs data:**

**`<th>` (Table Header):**
- Bold, centered by default
- Describes column/row
- Screen readers identify as headers

**`<td>` (Table Data):**
- Normal font weight
- Actual data cells

```html
<tr>
    <th>Name</th>  <!-- Bold header -->
    <th>Age</th>
</tr>
<tr>
    <td>Maria</td>  <!-- Normal data -->
    <td>35</td>
</tr>
```

Q5 **Form validation:**
```html
<!-- Required field -->
<input type="text" required>

<!-- With custom error message -->
<input type="text" required title="Name is required">

<!-- Combine with other validation -->
<input type="email" required minlength="5">
```

HTML5 validation happens **before** server submission (instant feedback).

---

**Key Concepts:**
- **Forms:** `action` (destination), `method` (GET/POST)
- **Inputs:** text, email, password, radio, checkbox, select, textarea
- **Labels:** Link with `for="id"` for accessibility
- **Tables:** `<th>` (headers), `<td>` (data), `<tr>` (rows)
- **Validation:** `required`, `minlength`, `pattern`

**Next:** Lesson 11 (Semantic HTML).