const fs = require("fs");
const vm = require("vm");

/**
 * Validates a student's JavaScript solution against expected results.
 * @param {string} codePath - Path to the file to test.
 * @param {Function} testFn - A function that receives the script context and performs assertions.
 */
function validateSolution(codePath, testFn) {
  let code = fs.readFileSync(codePath, "utf8");

  // Transform 'const/let/var x =' to 'global.x =' to make them accessible in context
  code = code.replace(/^(const|let|var)\s+(\w+)\s*=/gm, "global.$2 =");
  // Handle function declarations
  code = code.replace(/^function\s+(\w+)/gm, "global.$1 = function"); // Handle class declarations
  code = code.replace(/^class\s+(\w+)/gm, "global.$1 = class");
  const context = {
    global: {},
    console: {
      log: jest.fn(),
      error: jest.fn(),
      warn: jest.fn(),
    },
    alert: jest.fn(),
    confirm: jest.fn(),
    prompt: jest.fn(),
    // Mocking browser globals if needed
    document: {
      addEventListener: jest.fn(),
      getElementById: jest.fn(() => ({
        innerText: "",
        textContent: "",
        innerHTML: "",
        style: {},
        addEventListener: jest.fn(),
        removeEventListener: jest.fn(),
        appendChild: jest.fn(),
        value: "",
        checked: false,
        focus: jest.fn(),
        dataset: {},
      })),
      querySelector: jest.fn(() => ({
        innerText: "",
        textContent: "",
        innerHTML: "",
        style: {},
        addEventListener: jest.fn(),
        removeEventListener: jest.fn(),
        appendChild: jest.fn(),
        value: "",
        checked: false,
        focus: jest.fn(),
        dataset: {},
      })),
      createElement: jest.fn(() => ({
        innerText: "",
        textContent: "",
        innerHTML: "",
        style: {},
        addEventListener: jest.fn(),
        removeEventListener: jest.fn(),
        appendChild: jest.fn(),
        value: "",
        checked: false,
        focus: jest.fn(),
        dataset: {},
      })),
    },
    localStorage: {
      getItem: jest.fn(),
      setItem: jest.fn(),
      removeItem: jest.fn(),
      clear: jest.fn(),
    },
  };
  context.global = context; // allow self-reference
  context.window = context; // allow window reference
  vm.createContext(context);
  const script = new vm.Script(code);
  script.runInContext(context);
  testFn(context);
}

module.exports = { validateSolution };
