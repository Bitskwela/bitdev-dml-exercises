# Activity: The Sto. Niño Digital Bulletin Board

In this activity, you will transform a chaotic block of text into a high-performance Digital Bulletin Board for the Barangay. You will use headings for hierarchy, lists for data organization, and semantic tags for emphasis.

## Objective
Convert raw text into an organized, scannable, and semantically correct dashboard.

---

## Tasks

### Task 1: The Primary Brand
**Action:** Add a top-level heading (`h1`) for the name of the portal and a brief introductory paragraph (`p`) below it.
```html
<h1>Barangay Sto. Niño Public Portal</h1>
<p>Your official source for community updates, legal requirements, and public service schedules.</p>
```

### Task 2: Establishing Hierarchy
**Action:** Create a section for "Community Announcements" using an `h2` tag. Follow it with a paragraph explaining that these are updated weekly.
```html
<h2>Community Announcements</h2>
<p>Stay updated with our latest activities. Updated every Monday.</p>
```

### Task 3: The Chaos-Killer (Unordered Lists)
**Action:** List the upcoming events using an unordered list (`ul`). Include at least three items: "Coastal Clean-Up Drive", "Monthly Town Hall Meeting", and "Mobile Blood Donation".
```html
<ul>
  <li>Coastal Clean-Up Drive (Saturday, 8:00 AM)</li>
  <li>Monthly Town Hall Meeting (Sunday, 2:00 PM)</li>
  <li>Mobile Blood Donation (Wednesday, Hall A)</li>
</ul>
```

### Task 4: Procedural Logic (Ordered Lists)
**Action:** Create an `h3` heading called "Business Clearance Procedure" and use an ordered list (`ol`) to outline the sequence of steps: "Submit Form", "Verify Documents", "Pay Fees", "Claim Permit".
```html
<h3>Business Clearance Procedure</h3>
<ol>
  <li>Go to Window 1 and submit the application form.</li>
  <li>Wait for document verification at Window 3.</li>
  <li>Proceed to the cashier for fee payment.</li>
  <li>Return after 24 hours to claim your permit.</li>
</ol>
```

### Task 5: The "Dictionary" of Services (Description List)
**Action:** Use a Description List (`dl`) to show the Document Types and their corresponding processing times.
```html
<dl>
  <dt>Barangay Indigency</dt>
  <dd>Processed within 30 minutes.</dd>
  <dt>Cedula (Community Tax Certificate)</dt>
  <dd>Instant issuance upon payment.</dd>
  <dt>Work Permit</dt>
  <dd>Requires 1-2 business days for validation.</dd>
</dl>
```

### Task 6: Strategic Emphasis
**Action:** Within your paragraph or list items, use `<strong>` for warnings and `<mark>` for deadlines.
```html
<p><strong>Warning:</strong> All applications must be submitted by <mark>Friday, 5:00 PM</mark>.</p>
```

### Task 7: Architectural Finishing Touches
**Action:** Add a horizontal rule (`hr`) to separate the content from the footer. In the footer, use the `<small>` tag for the legal disclaimer.
```html
<hr>
<small>&copy; 2024 Barangay Sto. Niño. All rights reserved. Unauthorized duplication is prohibited.</small>
```

### Task 8: Professional Styling (Internal CSS)
**Action:** Add a `<style>` tag in the `<head>` or at the top of your document to style the headings and lists.
```html
<style>
  body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    line-height: 1.6;
    color: #333;
    max-width: 800px;
    margin: 40px auto;
    padding: 0 20px;
  }
  h1 { color: #2c3e50; border-bottom: 2px solid #3498db; }
  h2 { color: #2980b9; margin-top: 30px; }
  dt { font-weight: bold; color: #e67e22; margin-top: 10px; }
  mark { background-color: #f1c40f; padding: 2px 5px; border-radius: 3px; }
</style>
```
