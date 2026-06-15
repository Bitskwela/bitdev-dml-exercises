const fs = require("fs");
const vm = require("vm");

/**
 * Builds a fresh mock DOM element. Each call returns an independent object so
 * that assertions in one test never leak into another.
 */
function makeElement() {
  return {
    innerText: "",
    textContent: "",
    innerHTML: "",
    style: {},
    classList: {
      add: jest.fn(),
      remove: jest.fn(),
      toggle: jest.fn(),
      contains: jest.fn(() => false),
    },
    setAttribute: jest.fn(),
    getAttribute: jest.fn(),
    addEventListener: jest.fn(),
    removeEventListener: jest.fn(),
    appendChild: jest.fn(),
    remove: jest.fn(),
    value: "",
    checked: false,
    focus: jest.fn(),
    dataset: {},
  };
}

/**
 * Validates a student's JavaScript solution against expected results.
 *
 * The solution file is executed inside an isolated VM context. Top-level
 * declarations are rewired onto the context's global object so the test
 * callback can reach them. Modern syntax (ES modules) and browser/runtime
 * APIs (DOM, localStorage, fetch, timers) are supported so lessons can be
 * written idiomatically without dumbing the answers down.
 *
 * @param {string} codePath - Path to the file to test.
 * @param {Function} testFn - Receives the script context and performs assertions.
 * @returns {*} Whatever testFn returns (so async assertions can be awaited).
 */
function validateSolution(codePath, testFn) {
  let code = fs.readFileSync(codePath, "utf8");

  // --- Normalize ES module syntax so it runs in a plain VM script ---
  // A single answer file is self-contained, so cross-file imports are no-ops.
  code = code.replace(/^\s*import\s+[^;]*?;?\s*$/gm, "");
  // `export default config;` -> expose it as `default` on the context.
  code = code.replace(/^export\s+default\s+([^;]+);?/gm, "global.default = $1;");
  // Strip the leading `export` keyword from `export function/const/class ...`.
  code = code.replace(/^export\s+/gm, "");

  // --- Rewire top-level declarations onto the context global ---
  // Transform 'const/let/var x =' to 'global.x =' to make them accessible.
  code = code.replace(/^(const|let|var)\s+(\w+)\s*=/gm, "global.$2 =");
  // Handle function declarations.
  code = code.replace(/^function\s+(\w+)/gm, "global.$1 = function");
  // Handle class declarations.
  code = code.replace(/^class\s+(\w+)/gm, "global.$1 = class");

  const context = {
    global: {},
    console: {
      log: jest.fn(),
      error: jest.fn(),
      warn: jest.fn(),
      info: jest.fn(),
    },
    alert: jest.fn(),
    confirm: jest.fn(),
    prompt: jest.fn(),
    setTimeout: (...args) => global.setTimeout(...args),
    clearTimeout: (...args) => global.clearTimeout(...args),
    setInterval: (...args) => global.setInterval(...args),
    clearInterval: (...args) => global.clearInterval(...args),
    fetch: (...args) => global.fetch(...args),
    document: {
      addEventListener: jest.fn(),
      getElementById: jest.fn(() => makeElement()),
      querySelector: jest.fn(() => makeElement()),
      querySelectorAll: jest.fn(() => []),
      createElement: jest.fn(() => makeElement()),
    },
    localStorage: global.localStorage || {
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
  return testFn(context);
}

module.exports = { validateSolution };
