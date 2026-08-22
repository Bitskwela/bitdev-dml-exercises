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
const { drainMicrotasks, mount } = require("./render");

/** The host's real Date, kept before the sandbox shadows it. */
const OriginalDate = Date;

/** Fixed clock for grading: 2026-01-01T00:00:00Z. Determinism over realism. */
const FIXED_NOW = 1767225600000;

/** Seeded stand-in for Math.random, for the same reason. */
const FIXED_RANDOM = 0.42;

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

/** A recording stand-in for a callback prop, e.g. `onVoted`. */
function createSpy(implementation) {
  const calls = [];
  const fn = (...args) => {
    calls.push(args);
    return typeof implementation === "function" ? implementation(...args) : undefined;
  };
  fn.calls = calls;
  fn.called = () => calls.length > 0;
  return fn;
}

/** A Date whose `now()` never moves, so a nonce-stamping lesson is gradable. */
function createFrozenDate() {
  return Object.assign(
    function FixedDate(...args) {
      return args.length ? new OriginalDate(...args) : new OriginalDate(FIXED_NOW);
    },
    { now: () => FIXED_NOW, parse: OriginalDate.parse, UTC: OriginalDate.UTC },
  );
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
    console: { log() {}, info() {}, warn() {}, error() {} },
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
    setInterval: () => 0,
    clearInterval() {},
    Date: createFrozenDate(),
    Math: Object.create(Math, {
      random: { value: () => FIXED_RANDOM, enumerable: true },
    }),
    describe: registry.describe,
    it: registry.it,
    expect,
    spy: createSpy,
    /**
     * Mount the component under test.
     *
     * @param Component - Usually the `Submission` global.
     * @param options.props - Overrides merged over the spec's `props`.
     * @param options.wallet - `"present"` (default) or `"absent"` to exercise
     *   the no-MetaMask branch.
     */
    render: (Component, options = {}) => {
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
