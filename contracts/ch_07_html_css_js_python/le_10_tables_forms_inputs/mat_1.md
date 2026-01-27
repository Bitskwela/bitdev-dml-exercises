## Background Story

![Cover Image](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_7/C7+10.0+-+COVER.png)

Tian and Rhea Joy had built a beautiful, navigating website, but the Barangay Captain had a new challenge.

"It looks great, but where is the data?" the Captain asked. "I need residents to see the population breakdown by Sitio. And more importantly—I need them to stop lining up at the hall just to ask for a form. They should be able to submit their requests right here."

Tian looked at the spreadsheet of Sitios and households. "I can just type this out in paragraphs?"

"No," Miguel intervened. "That’s a Junior mistake. Para-text is for stories. **Tabular Data** belongs in a **Table**. And **User Intent** belongs in a **Form**."

Rhea Joy looked at the Figma design for the application form. "There are so many boxes! Text, dates, dropdowns... how do we make the browser understand what each one is for?"

"An Elite Developer doesn't just 'put boxes' on a screen," Miguel explained. "They define the **Data Type**. If you need an email, use an email type. If you need a choice, use a radio. This helps the browser validate the data *before* it even reaches the server."

"So, we’re making the site interactive?" Tian asked.

"Exactly," Miguel said. "We’re moving from a 'Broadcast' site to a 'Communication' platform. Let’s build the engine room."

---

## Theory & Lecture Content

## Structured Data & Human Input

### 1. The Data Grid: HTML Tables (`<table>`)
Tables are for **Tabular Data** (numbers, schedules, lists of people). 

- **The Anatomy:**
  - `<thead>`: The header section.
  - `<tbody>`: The meat of the data.
  - `<tfoot>`: Sums or summary info.
  - `<tr>`: A Row.
  - `<th>`: A Header cell (bold and centered).
  - `<td>`: A Data cell.

- **Merging Cells:**
  - `colspan="2"`: Merge columns horizontally.
  - `rowspan="2"`: Merge rows vertically.

### 2. The Interaction Engine: HTML Forms (`<form>`)
A form is a container for inputs that will be sent to a server.
- `action`: The destination (where the data goes).
- `method`: Usually `POST` for sensitive data (submitting forms) or `GET` for searches.

### 3. Precision Inputs: The `<input>` Tag
The `type` attribute determines how the user interacts with the field.

| Type | Use Case | Benefits |
| :--- | :--- | :--- |
| `text` | Names, addresses | Standard input. |
| `email` | Email addresses | Auto-validates the '@' symbol. |
| `password` | Secret keys | Masks symbols with dots. |
| `date` | Birthdays | Opens a calendar picker. |
| `number` | Ages, counts | Only allows numeric characters. |
| `radio` | Gender, Yes/No | Force selection of exactly **one** option. |
| `checkbox` | Interests, Agreement | Allows **multiple** selections. |

### 4. Selection & Multi-line
- **`<select>` & `<option>`:** The dropdown menu. Best for saved space.
- **`<textarea>`:** For long messages or complaints.

### 5. Semantic Labeling (`<label>`)
**Elite Rule:** Never use an input without a `<label>`.
The `for` attribute in the label must match the `id` of the input. This is critical for accessibility (screen readers) and UX (clicking the text selects the box).

```html
<label for="user-name">Full Name:</label>
<input type="text" id="user-name" name="fullname">
```

### 6. Validation (The Guardian)
Use attributes to force the user to provide correct data:
- `required`: Field cannot be empty.
- `min`/`max`: For numbers and dates.
- `pattern`: Use Regex for custom formats (like phone numbers).

---

## Clean Code: Form Architecture

**Junior Mistake:**
```html
<p>Enter Email: <input type="text"></p>
```
*Why this is bad:* No label association, wrong input type, no validation.

**Elite Precision:**
```html
<fieldset>
  <legend>Contact Information</legend>
  <label for="email">Official Email:</label>
  <input type="email" id="email" name="email" required placeholder="name@example.com">
</fieldset>
```
*Why this is good:* Uses a `<fieldset>` for grouping, correct type, and accessibility links.

---

## Summary for the Aspiring Engineer

1. **Tables are for facts.** Don't use them for layout; use them for structured research.
2. **Forms are for actions.** Every input should have a specific `type` and a `name`.
3. **Accessibility is a requirement.** Always link labels to inputs via `id`.
4. **Validation saves time.** Let the browser catch errors before they hit the database.

**Next Lesson:** Closing the loop with Semantic HTML.

---

## Closing Story

Tian finished the "Sitio Census Table." It looked sharp, with alternating row colors. Next was the "Clearance Request Form." 

"I tried typing a letter in the 'Age' box and it wouldn't let me!" Rhea Joy laughed.

"That's the power of the `number` type," Miguel said. "You've just prevented a data entry error without a single line of JavaScript. That’s elite efficiency."

The Barangay Sto. Niño portal was no longer just a page—it was a functioning application.
