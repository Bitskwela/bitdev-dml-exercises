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
 * Microtask turns one case may take before it is declared hung. Generous: a
 * full re-render settle is at most a few thousand, and a case does a handful.
 */
const CASE_TICK_BUDGET = 100000;

/**
 * Run one case, failing it if it never settles.
 *
 * Without this a promise the submission awaits that never resolves leaves the
 * whole run pending forever: Node then exits *successfully* with nothing
 * printed, and QuickJS never produces a report. Counting microtask turns rather
 * than wall-clock time keeps it deterministic and host-independent.
 */
async function withinBudget(fn) {
  let finished = false;
  const work = Promise.resolve()
    .then(fn)
    .finally(() => {
      finished = true;
    });
  async function watchdog() {
    for (let i = 0; i < CASE_TICK_BUDGET && !finished; i += 1) await Promise.resolve();
    // Finished means `work` holds the verdict. Its settlement reaches the race a
    // tick after `finished` flips, so resolving here would let a failing case
    // win the race as a pass — defer to it instead.
    if (finished) return work;
    throw new Error(
      "This test never finished: something your code awaited never settled (a promise that never resolves, or an await on a value that is not really a promise).",
    );
  }
  return Promise.race([work, watchdog()]);
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
  /** Errors nothing in the submission caught, awaiting the case they belong to. */
  const uncaught = [];

  /**
   * Record an error the submission raised but never handled — typically an
   * un-awaited async call in a `useEffect` that rejected. In a browser that is
   * a console error the learner would see; here it would otherwise vanish (or,
   * under Node, kill the grader). It is attached to the case that was running.
   *
   * The harness reports what it can catch itself (async effects, timer
   * callbacks); a host may also forward its own unhandled-rejection signal.
   */
  function reportUncaught(error) {
    uncaught.push(error && error.message ? error.message : String(error));
  }

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
   * An uncaught error raised during a case fails that case, with the error in
   * the reason, so the learner is told what actually broke rather than only
   * that some later assertion did not hold.
   *
   * @param onSettled - Optional hook run after each case, for teardown. It may
   *   return a promise, which is awaited — a host uses that to let its own
   *   unhandled-rejection signal fire before the case is reported.
   * @returns One result per case: `{ name, status, reason? }`.
   */
  async function run(onSettled) {
    const results = [];
    for (const testCase of cases) {
      let reason;
      try {
        await withinBudget(testCase.fn);
      } catch (error) {
        reason = error && error.message ? error.message : String(error);
      }
      if (typeof onSettled === "function") await onSettled();
      const raised = uncaught.splice(0, uncaught.length);
      if (raised.length > 0) {
        const note = `Your code raised an error nothing caught (an un-awaited promise, e.g. in a useEffect): ${raised.join("; ")}`;
        reason = reason ? `${reason} — and: ${note}` : note;
      }
      results.push(
        reason === undefined
          ? { name: testCase.name, status: "pass" }
          : { name: testCase.name, status: "fail", reason },
      );
    }
    return results;
  }

  return { cases, describe, it, reportUncaught, run };
}

module.exports = { AssertionError, createRegistry, expect };
