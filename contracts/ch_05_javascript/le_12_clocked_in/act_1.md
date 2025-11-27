# Date and Time Activity

## Initial Code

```js
// Task 1: Get Tomorrow's Date
function getTomorrowDate() {
  // Add your code here
}

// Task 2: Calculate Hours Between Dates
function getHoursDifference(startDate, endDate) {
  // Add your code here
}

// Task 3: Format Date as String
function formatDatePH(date) {
  // Add your code here
}
```

**Time Allotment: 20 minutes**

## Tasks for Learners

Topics Covered: `Date` Object, `getFullYear()`, `getMonth()`, `getDate()`, `setDate()`, `getTime()`, Date Formatting

---

### Task 1: Get Tomorrow's Date

Create a function that returns tomorrow's date as a string in `YYYY-MM-DD` format. Use the `Date` object methods to add one day to today's date.

```js
function getTomorrowDate() {
  const today = new Date();
  const tomorrow = new Date(today);
  tomorrow.setDate(today.getDate() + 1);

  const year = tomorrow.getFullYear();
  const month = String(tomorrow.getMonth() + 1).padStart(2, "0");
  const day = String(tomorrow.getDate()).padStart(2, "0");

  return `${year}-${month}-${day}`;
}
```

---

### Task 2: Calculate Hours Between Dates

Create a function that takes two date strings (ISO format) and returns the number of hours between them as a decimal number.

```js
function getHoursDifference(startDate, endDate) {
  const start = new Date(startDate);
  const end = new Date(endDate);

  const diffMs = end.getTime() - start.getTime();
  const diffHours = diffMs / (1000 * 60 * 60);

  return diffHours;
}
```

---

### Task 3: Format Date as String

Create a function that takes a `Date` object and returns a formatted string in the format "DD Mon YYYY" (e.g., "15 Jul 2023"). Use `padStart` for the day and `toLocaleString` for the month.

```js
function formatDatePH(date) {
  const day = String(date.getDate()).padStart(2, "0");
  const month = date.toLocaleString("en-PH", { month: "short" });
  const year = date.getFullYear();

  return `${day} ${month} ${year}`;
}
```

---

## Breakdown of the Activity

**Variables Defined:**

- `today`: A `Date` object representing the current date and time. Created using `new Date()`.

- `tomorrow`: A new `Date` object created from `today`. Modified using `setDate()` to add one day.

- `year`: The four-digit year extracted using `getFullYear()`.

- `month`: The month number (0-11) extracted using `getMonth()`. Add 1 to get the human-readable month (1-12).

- `day`: The day of the month (1-31) extracted using `getDate()`.

- `start` / `end`: `Date` objects created from ISO date strings for calculating time differences.

- `diffMs`: The difference between two dates in milliseconds, calculated by subtracting timestamps.

- `diffHours`: The difference converted to hours by dividing milliseconds by (1000 _ 60 _ 60).

**Key Concepts:**

- Creating Date Objects:
  `new Date()` creates a date for the current moment. `new Date(dateString)` parses an ISO date string. `new Date(existingDate)` creates a copy.

- Date Getter Methods:

  - `getFullYear()`: Returns the 4-digit year
  - `getMonth()`: Returns month (0-11, where 0 = January)
  - `getDate()`: Returns day of month (1-31)
  - `getTime()`: Returns timestamp in milliseconds

- Date Setter Methods:

  - `setDate(day)`: Sets the day of month
  - `setMonth(month)`: Sets the month (0-11)
  - Setters modify the original Date object

- Time Calculations:
  Subtract two timestamps (`getTime()`) to get difference in milliseconds. Convert to hours: `ms / (1000 * 60 * 60)`.

- `padStart(length, char)`:
  String method that pads the start with characters until it reaches the specified length. Useful for ensuring "01" instead of "1".

- `toLocaleString(locale, options)`:
  Formats dates according to locale. Use `{ month: "short" }` to get abbreviated month names like "Jul".

**Key Functions:**

- `getTomorrowDate()`:
  Demonstrates creating dates, modifying with `setDate()`, and formatting with string methods and `padStart()`.

- `getHoursDifference(startDate, endDate)`:
  Shows parsing date strings into Date objects and calculating time differences using timestamps.

- `formatDatePH(date)`:
  Combines multiple Date methods with `toLocaleString()` to create a human-readable Philippine date format.
