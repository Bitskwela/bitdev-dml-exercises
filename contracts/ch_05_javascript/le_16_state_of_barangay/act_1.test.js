const { validateSolution } = require("../test-helper.js");
const path = require("path");
const codePath = path.join(__dirname, "act_1.answer.js");

describe("Lesson 16: State of Barangay", () => {
  beforeAll(() => {
    global.localStorage = {
      getItem: jest.fn(),
      setItem: jest.fn(),
      clear: jest.fn(),
    };
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  test("getState and setState should manipulate singleton state object", () => {
    validateSolution(codePath, (context) => {
      const { getState, setState } = context;
      setState("userName", "Juan");
      expect(getState("userName")).toBe("Juan");
    });
  });

  test("saveState and loadState should persist and restore data from localStorage", () => {
    validateSolution(codePath, (context) => {
      const { saveState, loadState, setState, getState } = context;
      setState("draft", "hello world");
      saveState();

      expect(global.localStorage.setItem).toHaveBeenCalledWith(
        "appState",
        expect.any(String),
      );
      const savedData = JSON.parse(
        global.localStorage.setItem.mock.calls[0][1],
      );
      expect(savedData.draft).toBe("hello world");

      global.localStorage.getItem.mockReturnValue(
        JSON.stringify({ draft: "restored" }),
      );
      loadState();
      expect(getState("draft")).toBe("restored");
    });
  });

  test("showScreen should update state and set display: block to matching section", () => {
    validateSolution(codePath, (context) => {
      const { showScreen, document } = context;
      const mockSectionHome = { id: "home", style: { display: "none" } };
      const mockSectionAbout = { id: "about", style: { display: "none" } };

      document.querySelectorAll.mockReturnValue([
        mockSectionHome,
        mockSectionAbout,
      ]);
      showScreen("home");

      expect(mockSectionHome.style.display).toBe("block");
      expect(mockSectionAbout.style.display).toBe("none");
    });
  });
});
