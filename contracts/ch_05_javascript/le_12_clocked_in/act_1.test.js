const { validateSolution } = require("../test-helper.js");
const path = require("path");
const codePath = path.join(__dirname, "act_1.answer.js");

describe("Lesson 12: Clocked In", () => {
  test("getTomorrowDate should return tomorrow's date in YYYY-MM-DD format", () => {
    validateSolution(codePath, (context) => {
      const { getTomorrowDate } = context;
      const today = new Date();
      const tomorrow = new Date(today);
      tomorrow.setDate(today.getDate() + 1);
      const yyyy = tomorrow.getFullYear();
      const mm = String(tomorrow.getMonth() + 1).padStart(2, "0");
      const dd = String(tomorrow.getDate()).padStart(2, "0");
      const expected = `${yyyy}-${mm}-${dd}`;
      expect(getTomorrowDate()).toBe(expected);
    });
  });

  test("getHoursDifference should calculate hours between two date strings", () => {
    validateSolution(codePath, (context) => {
      const { getHoursDifference } = context;
      const diff = getHoursDifference(
        "2024-03-02T10:00:00",
        "2024-03-02T15:00:00",
      );
      expect(diff).toBe(5);
    });
  });

  test('formatDatePH should format date as "02 Mar 2026"', () => {
    validateSolution(codePath, (context) => {
      const { formatDatePH } = context;
      const date = new Date("2026-03-02");
      const formatted = formatDatePH(date);
      // Result of date.toLocaleString('en-PH', { month: 'short' }) for 2nd Mar
      expect(formatted).toMatch(/02 (Mar|Mar.) 2026/);
    });
  });
});
