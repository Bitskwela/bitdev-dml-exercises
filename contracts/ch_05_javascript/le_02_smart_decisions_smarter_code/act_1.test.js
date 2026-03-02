const path = require("path");
const { validateSolution } = require("../test-helper");

describe("le_02_smart_decisions_smarter_code", () => {
  const filePath = path.join(__dirname, "act_1.answer.js");

  test("checkBudgetStatus should return correct statuses", () => {
    validateSolution(filePath, (context) => {
      expect(context.checkBudgetStatus(5001)).toBe("Over budget");
      expect(context.checkBudgetStatus(5000)).toBe("At limit");
      expect(context.checkBudgetStatus(4999)).toBe("Under budget");
    });
  });

  test("isValidEntry should validate range 1-5000", () => {
    validateSolution(filePath, (context) => {
      expect(context.isValidEntry(1)).toBe(true);
      expect(context.isValidEntry(5000)).toBe(true);
      expect(context.isValidEntry(0)).toBe(false);
      expect(context.isValidEntry(5001)).toBe(false);
    });
  });

  test("classifyExpense should categorize costs correctly", () => {
    validateSolution(filePath, (context) => {
      expect(context.classifyExpense(3001, "event")).toBe("High event expense");
      expect(context.classifyExpense(3000, "event")).toBe(
        "Normal event expense",
      );
      expect(context.classifyExpense(100, "supplies")).toBe(
        "Operational expense",
      );
      expect(context.classifyExpense(100, "food")).toBe("Operational expense");
      expect(context.classifyExpense(100, "other")).toBe(
        "Uncategorized expense",
      );
    });
  });
});
