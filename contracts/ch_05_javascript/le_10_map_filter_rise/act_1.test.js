const { validateSolution } = require("../test-helper.js");
const path = require("path");
const codePath = path.join(__dirname, "act_1.answer.js");

describe("Lesson 10: Map Filter Rise", () => {
  const products = [
    { name: "Apple", price: 50, stock: 10 },
    { name: "Banana", price: 30, stock: 20 },
    { name: "Rice", price: 40, stock: 5 },
  ];

  test("getProductNames should return uppercase names", () => {
    validateSolution(codePath, (context) => {
      const { getProductNames } = context;
      expect(getProductNames(products)).toEqual(["APPLE", "BANANA", "RICE"]);
    });
  });

  test("filterLowStock should return products below stock threshold", () => {
    validateSolution(codePath, (context) => {
      const { filterLowStock } = context;
      expect(filterLowStock(products, 10)).toEqual([
        { name: "Rice", price: 40, stock: 5 },
      ]);
    });
  });

  test("calculateTotalValue should return the sum of all product values", () => {
    validateSolution(codePath, (context) => {
      const { calculateTotalValue } = context;
      // (50*10) + (30*20) + (40*5) = 500 + 600 + 200 = 1300
      expect(calculateTotalValue(products)).toBe(1300);
    });
  });
});
