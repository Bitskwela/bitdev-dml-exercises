"use strict";

/**
 * The deterministic pieces of the grading sandbox.
 *
 * Everything here exists to remove a source of variation: a console that
 * records instead of printing, intervals that only advance when a test says so,
 * a clock that never moves, and an offline `fetch`. Grading has to reach the
 * same verdict on every run and on both hosts, so nothing in this file may
 * consult the real world.
 *
 * Split out of `index.js` to keep each file under the repo's size limit:
 * `index.js` assembles the harness, this supplies the environment it assembles.
 */

/** The host's real Date, kept before the sandbox shadows it. */
const OriginalDate = Date;

/** Fixed clock for grading: 2026-01-01T00:00:00Z. Determinism over realism. */
const FIXED_NOW = 1767225600000;

/** Seeded stand-in for Math.random, for the same reason. */
const FIXED_RANDOM = 0.42;

/**
 * Render one console argument the way a student sees it in a browser console.
 *
 * Deliberately total: grading must never fail because a submission logged
 * something awkward. A circular object or a hostile `toString` degrades to a
 * placeholder rather than throwing out of the student's own `console.log`.
 */
function formatLogArg(value) {
  if (typeof value === "string") return value;
  if (typeof value === "bigint") return `${value}n`;
  if (value === undefined) return "undefined";
  if (value === null) return "null";
  if (typeof value === "function") return `[Function: ${value.name || "anonymous"}]`;
  try {
    const json = JSON.stringify(value);
    return json === undefined ? String(value) : json;
  } catch {
    return "[unserializable]";
  }
}

/**
 * A console that records instead of printing.
 *
 * The harness previously discarded output entirely, which is fine for a React
 * exercise judged on its rendered tree but leaves a plain-script exercise with
 * nothing observable at all. Recording is capped so a runaway loop cannot grow
 * the buffer without bound before the instruction budget stops it.
 */
function createConsoleCapture(limit = 1000) {
  const entries = [];
  const record = (level) => (...args) => {
    if (entries.length >= limit) return;
    entries.push({ level, text: args.map(formatLogArg).join(" ") });
  };
  return {
    console: {
      log: record("log"),
      info: record("info"),
      warn: record("warn"),
      error: record("error"),
    },
    lines: (level) =>
      entries
        .filter((entry) => !level || entry.level === level)
        .map((entry) => entry.text),
  };
}

/**
 * A registry of repeating callbacks that only advance when a test says so.
 *
 * A lesson about `setInterval` cannot be graded against a real clock: the test
 * would have to sleep, and the result would depend on timing. Here the
 * callbacks are held and `tick()` runs them, so "three seconds passed" is an
 * assertion rather than a wait.
 */
function createTimers() {
  const pending = new Map();
  let nextId = 1;

  return {
    set(fn, delay) {
      if (typeof fn !== "function") return 0;
      const id = nextId++;
      pending.set(id, { fn, delay });
      return id;
    },
    clear(id) {
      pending.delete(id);
    },
    /**
     * Run every live interval callback `times` times.
     *
     * Re-checks liveness inside the loop, so a callback that clears its own
     * interval — how a countdown stops — is not called again afterwards.
     */
    tick(times = 1) {
      for (let round = 0; round < times; round += 1) {
        for (const [id, timer] of [...pending.entries()]) {
          if (pending.has(id)) timer.fn();
        }
      }
    },
    /** How many intervals are still running, for assertions about `stop()`. */
    active() {
      return pending.size;
    },
  };
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

/**
 * Build the offline `fetch` a lesson's HTTP reads resolve against.
 *
 * Exercises that read NFT metadata do a real `fetch` of an IPFS gateway URL.
 * Grading is offline, so `spec.http` declares the responses. A URL the spec
 * does not name rejects with a message naming it, rather than hanging or
 * silently returning undefined.
 *
 * @param spec - The exercise spec; `spec.http` maps URL to a JSON body.
 * @param recorder - The chain recorder, so tests can assert what was fetched.
 */
function createFetch(spec, recorder) {
  const routes = (spec && spec.http) || {};
  return async function fetchStub(url) {
    const key = String(url);
    recorder.record("fetch", [key]);
    if (!Object.hasOwn(routes, key)) {
      throw new Error(
        `No offline response declared for ${JSON.stringify(key)}. Add it to spec.http.`,
      );
    }
    const body = routes[key];
    return {
      ok: true,
      status: 200,
      async json() {
        return body;
      },
      async text() {
        return JSON.stringify(body);
      },
    };
  };
}

/** Month names, so date formatting does not depend on the host's ICU data. */
const MONTHS_SHORT = "Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec".split(" ");
const MONTHS_LONG = [
  "January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December",
];

/**
 * Give one date instance deterministic locale formatting.
 *
 * Node ships full ICU and QuickJS does not, so `toLocaleString("en-PH", {
 * month: "short" })` yields `"Mar"` under the golden gate and nothing useful
 * under the server. A lesson that formats a date would then be GREEN in CI and
 * RED for students. Overriding it here is what keeps the two hosts honest.
 *
 * Only the `month` option these lessons use is interpreted; anything else falls
 * back to a stable ISO string rather than guessing at a locale.
 */
function withFixedLocale(date) {
  const localize = function localize(_locale, options) {
    if (options && options.month === "short") return MONTHS_SHORT[this.getMonth()];
    if (options && options.month === "long") return MONTHS_LONG[this.getMonth()];
    return this.toISOString();
  };
  date.toLocaleString = localize;
  date.toLocaleDateString = localize;
  return date;
}

/** A Date whose `now()` never moves, so a nonce-stamping lesson is gradable. */
function createFrozenDate() {
  return Object.assign(
    function FixedDate(...args) {
      return withFixedLocale(
        args.length ? new OriginalDate(...args) : new OriginalDate(FIXED_NOW),
      );
    },
    { now: () => FIXED_NOW, parse: OriginalDate.parse, UTC: OriginalDate.UTC },
  );
}


module.exports = {
  FIXED_NOW,
  FIXED_RANDOM,
  createConsoleCapture,
  createFetch,
  createFrozenDate,
  createSpy,
  createTimers,
  formatLogArg,
};
