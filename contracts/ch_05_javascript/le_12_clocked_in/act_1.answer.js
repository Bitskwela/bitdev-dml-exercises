// Task 1: Get Tomorrow's Date
function getTomorrowDate() {
  const today = new Date();
  const tomorrow = new Date(today);
  tomorrow.setDate(today.getDate() + 1);

  const year = tomorrow.getFullYear();
  const month = String(tomorrow.getMonth() + 1).padStart(2, "0");
  const day = String(tomorrow.getDate()).padStart(2, "0");

  return `${year}-${month}-${day}`;
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
