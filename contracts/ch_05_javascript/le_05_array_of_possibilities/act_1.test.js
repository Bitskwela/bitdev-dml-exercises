const { validateSolution } = require("../test-helper.js");
const path = require("path");
const codePath = path.join(__dirname, "act_1.answer.js");

describe("Lesson 05: Array of Possibilities", () => {
  test("findHighestScore should return the maximum value in an array", () => {
    validateSolution(codePath, (context) => {
      const { findHighestScore } = context;
      expect(findHighestScore([10, 20, 5, 30, 25])).toBe(30);
      expect(findHighestScore([-10, -5, -20])).toBe(-5);
    });
  });

  test("getEvenNumbers should return an array of even numbers", () => {
    validateSolution(codePath, (context) => {
      const { getEvenNumbers } = context;
      expect(getEvenNumbers([1, 2, 3, 4, 5, 6])).toEqual([2, 4, 6]);
      expect(getEvenNumbers([1, 3, 5])).toEqual([]);
      expect(getEvenNumbers([2, 4, 6])).toEqual([2, 4, 6]);
    });
  });

  test("calculateAverage should return the mean of an array of numbers", () => {
    validateSolution(codePath, (context) => {
      const { calculateAverage } = context;
      expect(calculateAverage([80, 90, 70])).toBe(80);
      expect(calculateAverage([100, 50])).toBe(75);
    });
  });
});
