const { validateSolution } = require("../test-helper.js");
const path = require("path");
const codePath = path.join(__dirname, "act_1.answer.js");

describe("Lesson 03: Loops of Liberation", () => {
  test("printNumbers should log numbers from start to end", () => {
    validateSolution(codePath, (context) => {
      const { printNumbers, console } = context;
      printNumbers(1, 3);
      expect(console.log).toHaveBeenCalledWith(1);
      expect(console.log).toHaveBeenCalledWith(2);
      expect(console.log).toHaveBeenCalledWith(3);
    });
  });

  test("sumArray should return the sum of all elements", () => {
    validateSolution(codePath, (context) => {
      const { sumArray } = context;
      expect(sumArray([1, 2, 3, 4, 5])).toBe(15);
      expect(sumArray([10, -5, 2])).toBe(7);
      expect(sumArray([])).toBe(0);
    });
  });

  test("multiplicationTable should return a 2D array of products", () => {
    validateSolution(codePath, (context) => {
      const { multiplicationTable } = context;
      const table = multiplicationTable(3);
      expect(table).toEqual([
        [1, 2, 3],
        [2, 4, 6],
        [3, 6, 9],
      ]);
    });
  });
});
