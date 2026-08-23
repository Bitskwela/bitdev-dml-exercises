"use strict";

/**
 * The dApp grading harness: render a student's component against a mocked
 * chain and expose a queryable result.
 *
 * Host-independent ES2020 — Node runs it for authoring and the CI golden gate,
 * QuickJS runs it inside `blockskwela-rs`. The host supplies only the JSX
 * transform (esbuild / SWC) and a module loader; everything a test can observe
 * is defined here, so a lesson grades identically in both.
 *
 * This module assembles the sandbox. Rendering lives in `render.js`, the chain
 * mocks in `chain-mock.js`, and the assertions in `test-api.js`.
 */

const react = require("./react-shim");
const { createChain } = require("./chain-mock");
const { createRegistry, expect } = require("./test-api");
const { createDom } = require("./dom-mock");
const { drainMicrotasks, mount } = require("./render");
const {
  FIXED_RANDOM,
  createConsoleCapture,
  createFetch,
  createFrozenDate,
  createSpy,
  createTimers,
} = require("./sandbox");

/** Build the `react` module a student's `import ... from "react"` resolves to. */
function buildReactModule() {
  const reactModule = {
    createElement: react.createElement,
    Fragment: react.Fragment,
    useState: react.useState,
    useEffect: react.useEffect,
    useMemo: react.useMemo,
    useCallback: react.useCallback,
    useRef: react.useRef,
  };
  reactModule.default = reactModule;
  return reactModule;
}

/**
 * Wrap a spec-declared module value so both default and named imports work.
 *
 * An ABI is usually a JSON array, which has no named exports — hence the
 * array check before spreading.
 */
function asModule(value) {
  const named =
    typeof value === "object" && value !== null && !Array.isArray(value) ? value : {};
  return { default: value, ...named };
}

/**
 * Build the globals a student's module and its test are evaluated against.
 *
 * The returned object is the *entire* environment: there is no filesystem, no
 * network and no process here, because none of it is ever bound.
 *
 * @param spec - The exercise spec (`runtime`, `props`, `env`, `modules`, `chain`).
 * @returns `{ chain, globals, registry, requireModule }`.
 */
function createHarness(spec) {
  const chain = createChain(spec);
  const registry = createRegistry();
  const consoleCapture = createConsoleCapture();
  const dom = createDom(spec);
  const timers = createTimers();
  const reactModule = buildReactModule();
  /** Whether MetaMask is installed for the render in progress. */
  let walletPresent = true;

  // Modules a student file may import. Anything else is an explicit failure,
  // so an exercise cannot accidentally depend on the host's package tree.
  const modules = {
    react: reactModule,
    ethers: { ethers: chain.ethers, ...chain.ethers },
    ...Object.fromEntries(
      Object.entries((spec && spec.modules) || {}).map(([name, value]) => [
        name,
        asModule(value),
      ]),
    ),
  };

  /** Resolve an import to a harness-provided module. */
  function requireModule(name) {
    if (Object.hasOwn(modules, name)) return modules[name];
    throw new Error(
      `Cannot import ${JSON.stringify(name)} in this exercise. Available: ${Object.keys(modules).join(", ")}`,
    );
  }

  const recordAlert = (message) => chain.recorder.record("alert", [String(message)]);

  // `window.ethereum` is a getter so a test can render the no-wallet branch:
  // MetaMask's absence is the *absence* of the property, which is exactly what
  // `if (!window.ethereum)` checks for.
  const windowStub = Object.defineProperty(
    { location: { reload() {} }, alert: recordAlert },
    "ethereum",
    { enumerable: true, get: () => (walletPresent ? chain.ethereum : undefined) },
  );

  const globals = {
    React: reactModule,
    console: consoleCapture.console,
    alert: recordAlert,
    window: windowStub,
    // Exercises read `process.env.REACT_APP_*`; serve the spec's values rather
    // than the host's real environment.
    process: { env: { ...((spec && spec.env) || {}) } },
    setTimeout: (fn) => {
      // Timers resolve immediately: grading is deterministic and never waits.
      Promise.resolve().then(fn);
      return 0;
    },
    clearTimeout() {},
    // Intervals are registered but never fire on their own — a test drives them
    // with `tick()`. Grading must be deterministic and must not wait on a real
    // clock, and a repeating callback that fired by itself would do both.
    // `setTimeout` is deliberately left resolving immediately: ch04 depends on
    // that for settling renders.
    setInterval: (fn, ms) => timers.set(fn, ms),
    clearInterval: (id) => timers.clear(id),
    fetch: createFetch(spec, chain.recorder),
    // Deterministic object URLs: a lesson that previews an uploaded file needs
    // `URL.createObjectURL`, and a real blob: URL would differ on every run.
    URL: {
      createObjectURL(file) {
        chain.recorder.record("URL.createObjectURL", [file && file.name]);
        return `blob:mock/${(file && file.name) || "unnamed"}`;
      },
      revokeObjectURL(url) {
        chain.recorder.record("URL.revokeObjectURL", [url]);
      },
    },
    Date: createFrozenDate(),
    Math: Object.create(Math, {
      random: { value: () => FIXED_RANDOM, enumerable: true },
    }),
    describe: registry.describe,
    it: registry.it,
    expect,
    spy: createSpy,
    /**
     * Everything the submission printed, oldest first.
     *
     * This is how a plain-script exercise (`runtime: "javascript"`, ch05/ch06)
     * is graded: those lessons have no component to mount and no export to
     * inspect — their observable behaviour *is* their console output. Asserting
     * on it keeps such a test behavioural rather than a source-substring match.
     *
     * The submission runs once, before any `it`, so the output is the same for
     * every test in the file and is deliberately **not** cleared by `render`.
     *
     * @param level - Optional filter: `"log"`, `"info"`, `"warn"` or `"error"`.
     * @returns The formatted lines.
     */
    logs: (level) => consoleCapture.lines(level),
    /** The page a plain-script lesson manipulates. See `dom-mock.js`. */
    document: dom.document,
    localStorage: dom.localStorage,
    /** The element a selector refers to, for asserting on what changed. */
    el: dom.el,
    /** Dispatch an event at a selector; false when a handler prevented it. */
    fire: dom.fire,
    /** Advance every registered interval by `times` rounds. */
    tick: (times) => timers.tick(times),
    /** How many intervals are still running. */
    activeTimers: () => timers.active(),
    /**
     * Mount the component under test.
     *
     * @param Component - Usually the `Submission` global.
     * @param options.props - Overrides merged over the spec's `props`.
     * @param options.wallet - `"present"` (default) or `"absent"` to exercise
     *   the no-MetaMask branch.
     */
    render: (Component, options = {}) => {
      // Each test starts from a clean chain: one harness serves every `it` in
      // the file, so a stale call log would leak between them.
      chain.reset();
      walletPresent = options.wallet !== "absent";
      return mount(Component, {
        props: { ...((spec && spec.props) || {}), ...(options.props || {}) },
        chain,
      });
    },
  };
  globals.globalThis = globals;
  windowStub.window = windowStub;

  return { chain, globals, registry, requireModule };
}

module.exports = { createHarness, drainMicrotasks, mount };
