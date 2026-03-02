const { validateSolution } = require("../../ch_05_javascript/test-helper.js");
const path = require("path");

describe("Le 04: Online Jeep Fare Calculator", () => {
  const codePath = path.join(__dirname, "act_1.answer.js");

  test("getBaseFare should return correct fare per route", () => {
    validateSolution(codePath, (context) => {
      const { getBaseFare } = context.global;
      expect(getBaseFare("cubao-pasig")).toBe(10);
      expect(getBaseFare("trinoma-qch")).toBe(12);
      expect(getBaseFare("edsa-ortigas")).toBe(11);
      expect(getBaseFare("invalid")).toBe(0);
    });
  });

  test("calculateFare logic for discounts and luggage", () => {
    validateSolution(codePath, (context) => {
      const { calculateFare } = context.global;

      // Base: Cubao-Pasig (10)
      expect(calculateFare("cubao-pasig", "none", false)).toBe("10.00");
      expect(calculateFare("cubao-pasig", "student", false)).toBe("8.00");
      expect(calculateFare("cubao-pasig", "senior", false)).toBe("7.00");

      // With luggage (+5)
      expect(calculateFare("cubao-pasig", "none", true)).toBe("15.00");
      expect(calculateFare("cubao-pasig", "student", true)).toBe("13.00");
    });
  });

  test("calcBtn should trigger result update", () => {
    validateSolution(codePath, (context) => {
      const { document } = context;

      const routeSelect = { value: "trinoma-qch" };
      const discountSelect = { value: "senior" };
      const luggageCheckbox = { checked: true };
      const resultDiv = { textContent: "" };
      let clickHandler;
      const calcBtn = {
        addEventListener: jest.fn((event, handler) => {
          if (event === "click") clickHandler = handler;
        }),
        click: () => clickHandler && clickHandler(),
      };

      document.querySelector.mockImplementation((selector) => {
        if (selector === "#route-select") return routeSelect;
        if (selector === "#discount-select") return discountSelect;
        if (selector === "#luggage-addon") return luggageCheckbox;
        if (selector === "#calc-btn") return calcBtn;
        if (selector === "#fare-result") return resultDiv;
        return { addEventListener: jest.fn() };
      });

      const { setupFareCalculator } = context.global;
      setupFareCalculator();

      const expectedFare = 12 - 3 + 5; // 14.00
      calcBtn.click();

      expect(resultDiv.textContent).toContain(
        `Fare: ₱${expectedFare.toFixed(2)}`,
      );
    });
  });
});
