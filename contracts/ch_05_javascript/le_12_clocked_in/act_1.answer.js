// Task 1: Get Tomorrow's Date
function getTomorrowDate() {
  // DATE OBJECT: JavaScript's built-in way to work with dates and times
  // new Date() creates a Date object with current date/time
  const today = new Date();

  // Create a copy of today's date (not a reference!)
  // new Date(today) = creates new Date object from existing one
  const tomorrow = new Date(today);

  // setDate() changes the day of the month
  // getDate() returns current day (1-31)
  // Adding 1 gives us tomorrow (JavaScript handles month/year rollovers)
  tomorrow.setDate(today.getDate() + 1);

  // FORMAT AS YYYY-MM-DD
  const year = tomorrow.getFullYear(); // e.g., 2024

  // getMonth() returns 0-11 (January=0!), so add 1
  // String() converts number to string
  // padStart(2, "0") ensures 2 digits: "1" → "01", "12" → "12"
  const month = String(tomorrow.getMonth() + 1).padStart(2, "0");

  const day = String(tomorrow.getDate()).padStart(2, "0");

  // Template literal to combine into ISO format
  return `${year}-${month}-${day}`;

  // ALTERNATIVE: Use toISOString()
  // return tomorrow.toISOString().split('T')[0];
}

// Task 2: Calculate Hours Between Dates
function getHoursDifference(startDate, endDate) {
  const start = new Date(startDate);
  const end = new Date(endDate);

  const diffMs = end.getTime() - start.getTime();
  const diffHours = diffMs / (1000 * 60 * 60);

  return diffHours;
}

// Task 3: Format Date as String
function formatDatePH(date) {
  const day = String(date.getDate()).padStart(2, "0");
  const month = date.toLocaleString("en-PH", { month: "short" });
  const year = date.getFullYear();

  return `${day} ${month} ${year}`;
}
