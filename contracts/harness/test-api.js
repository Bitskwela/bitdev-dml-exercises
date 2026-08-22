"use strict";

/**
 * Test registry and assertions for dApp grading.
 *
 * Host-independent by design: the same `describe`/`it`/`expect` run under Node
 * (authoring, CI golden gate) and under QuickJS (the server grader), so a test
 * that passes locally grades identically in production. `expect` is
 * chai-flavoured to match the assertions the rest of this repo already uses.
 */

/** Assertion failure, distinguished from a crash in the student's own code. */
class AssertionError extends Error {
  constructor(message) {
    super(message);
    this.name = "AssertionError";
    this.isAssertion = true;
  }
}

/** Render a value compactly for a failure message. */
function show(value) {
  if (typeof value === "string") return JSON.stringify(value);
  if (typeof value === "bigint") return `${value}n`;
  if (Array.isArray(value)) return `[${value.map(show).join(", ")}]`;
  if (value && typeof value === "object") return JSON.stringify(value);
  return String(value);
}

/** Truncate long haystacks so a failure message stays readable. */
function clip(text, limit = 400) {
  const s = String(text);
  return s.length > limit ? `${s.slice(0, limit)}…` : s;
}

/**
 * Chai-flavoured assertions.
 *
 * @param actual - The value under test.
 * @param label - Optional context prefixed to any failure message.
 */
function expect(actual, label) {
  const prefix = label ? `${label}: ` : "";
  const api = {
    get to() {
      return api;
    },
    get be() {
      return api;
    },
    get been() {
      return api;
    },
    get and() {
      return api;
    },
    equal(expected, message) {
      if (!Object.is(actual, expected)) {
        throw new AssertionError(
          message || `${prefix}expected ${show(expected)} but got ${show(actual)}`,
        );
      }
      return api;
    },
    eql(expected, message) {
      if (JSON.stringify(actual) !== JSON.stringify(expected)) {
        throw new AssertionError(
          message || `${prefix}expected ${show(expected)} but got ${show(actual)}`,
        );
      }
      return api;
    },
    contain(needle, message) {
      const ok = Array.isArray(actual)
        ? actual.some((item) => Object.is(item, needle))
        : String(actual).includes(String(needle));
      if (!ok) {
        throw new AssertionError(
          message || `${prefix}expected ${show(needle)} to appear in ${clip(show(actual))}`,
        );
      }
      return api;
    },
    match(pattern, message) {
      if (!pattern.test(String(actual))) {
        throw new AssertionError(
          message || `${prefix}expected ${clip(show(actual))} to match ${pattern}`,
        );
      }
      return api;
    },
    true(message) {
      return api.equal(true, message);
    },
    false(message) {
      return api.equal(false, message);
    },
    ok(message) {
      if (!actual) {
        throw new AssertionError(message || `${prefix}expected a truthy value, got ${show(actual)}`);
      }
      return api;
    },
  };

  api.not = {
    equal(expected, message) {
      if (Object.is(actual, expected)) {
        throw new AssertionError(message || `${prefix}expected not to equal ${show(expected)}`);
      }
      return api;
    },
    contain(needle, message) {
      const present = Array.isArray(actual)
        ? actual.some((item) => Object.is(item, needle))
        : String(actual).includes(String(needle));
      if (present) {
        throw new AssertionError(
          message || `${prefix}expected ${show(needle)} not to appear in ${clip(show(actual))}`,
        );
      }
      return api;
    },
    match(pattern, message) {
      if (pattern.test(String(actual))) {
        throw new AssertionError(
          message || `${prefix}expected ${clip(show(actual))} not to match ${pattern}`,
        );
      }
      return api;
    },
    ok(message) {
      if (actual) {
        throw new AssertionError(
          message || `${prefix}expected a falsy value, got ${show(actual)}`,
        );
      }
      return api;
    },
  };
  api.to.not = api.not;

  return api;
}

/**
 * Collect `describe`/`it` declarations, then run them in order.
 *
 * Declaration and execution are separate phases so the runner can report a
 * total before anything executes, and so one thrown test cannot prevent the
 * rest from running.
 */
function createRegistry() {
  const cases = [];
  let suite = "";

  function describe(name, fn) {
    const previous = suite;
    suite = previous ? `${previous} > ${name}` : name;
    fn();
    suite = previous;
  }

  function it(name, fn) {
    cases.push({ name: suite ? `${suite} > ${name}` : name, fn });
  }

  /**
   * Run every registered case.
   *
   * @param onSettled - Optional hook run after each case, for teardown.
   * @returns One result per case: `{ name, status, reason? }`.
   */
  async function run(onSettled) {
    const results = [];
    for (const testCase of cases) {
      try {
        await testCase.fn();
        results.push({ name: testCase.name, status: "pass" });
      } catch (error) {
        results.push({
          name: testCase.name,
          status: "fail",
          reason: error && error.message ? error.message : String(error),
        });
      }
      if (typeof onSettled === "function") onSettled();
    }
    return results;
  }

  return { cases, describe, it, run };
}

module.exports = { AssertionError, createRegistry, expect };
