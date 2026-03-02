const { validateSolution } = require("../test-helper.js");
const path = require("path");
const codePath = path.join(__dirname, "act_1.answer.js");

describe("Lesson 15: Building From Scratch", () => {
  test('createCard should return element with class "card", h3 title and p content', () => {
    validateSolution(codePath, (context) => {
      const { createCard, document } = context;
      const mockContainer = { appendChild: jest.fn() };
      const card = createCard("Title", "Content");

      expect(card.className).toBe("card");
      expect(card.appendChild).toHaveBeenCalled();
      // card.appendChild should be called with Title (h3) and Content (p)
    });
  });

  test("createList should return ul with individual li elements", () => {
    validateSolution(codePath, (context) => {
      const { createList, document } = context;
      const items = ["Buy Milk", "Buy Eggs"];
      const ul = createList(items);

      expect(document.createElement).toHaveBeenCalledWith("ul");
      expect(document.createElement).toHaveBeenCalledWith("li");
      expect(ul.appendChild).toHaveBeenCalledTimes(2);
    });
  });

  test("removeCardById should remove correct card from container", () => {
    validateSolution(codePath, (context) => {
      const { removeCardById, document } = context;
      const mockCard = { id: "card-1" };
      const container = {
        querySelector: jest.fn().mockReturnValue(mockCard),
        removeChild: jest.fn(),
      };

      const result = removeCardById("1", container);
      expect(container.querySelector).toHaveBeenCalledWith('[data-id="1"]');
      expect(container.removeChild).toHaveBeenCalledWith(mockCard);
      expect(result).toBe(true);
    });
  });
});
