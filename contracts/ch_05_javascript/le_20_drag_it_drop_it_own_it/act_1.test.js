const { validateSolution } = require("../test-helper.js");
const path = require("path");
const codePath = path.join(__dirname, "act_1.answer.js");

describe("Lesson 20: Drag It Drop It Own It", () => {
  test("allowDrop should prevent default event behavior", () => {
    validateSolution(codePath, (context) => {
      const { allowDrop } = context;
      const event = { preventDefault: jest.fn() };
      allowDrop(event);
      expect(event.preventDefault).toHaveBeenCalled();
    });
  });

  test("drag should set dataTransfer and add dragging class", () => {
    validateSolution(codePath, (context) => {
      const { drag } = context;
      const dataTransfer = { setData: jest.fn() };
      const classList = { add: jest.fn() };
      const event = { dataTransfer, target: { id: "task-1", classList } };

      drag(event);
      expect(dataTransfer.setData).toHaveBeenCalledWith("text/plain", "task-1");
      expect(classList.add).toHaveBeenCalledWith("dragging");
    });
  });

  test("drop should move element to closest column", () => {
    validateSolution(codePath, (context) => {
      const { drop, document } = context;
      const dataTransfer = { getData: jest.fn().mockReturnValue("task-1") };
      const mockCard = { id: "task-1", classList: { remove: jest.fn() } };
      const mockColumn = { appendChild: jest.fn() };
      const event = {
        preventDefault: jest.fn(),
        dataTransfer,
        target: { closest: jest.fn().mockReturnValue(mockColumn) },
      };

      document.getElementById.mockReturnValue(mockCard);
      drop(event);

      expect(mockColumn.appendChild).toHaveBeenCalledWith(mockCard);
      expect(mockCard.classList.remove).toHaveBeenCalledWith("dragging");
    });
  });

  test("createTaskCard should return a draggable div with correct text and id", () => {
    validateSolution(codePath, (context) => {
      const { createTaskCard, document } = context;
      const card = createTaskCard("task-1", "Do coding");

      expect(card.draggable).toBe(true);
      expect(card.id).toBe("task-1");
      expect(card.textContent).toBe("Do coding");
    });
  });
});
