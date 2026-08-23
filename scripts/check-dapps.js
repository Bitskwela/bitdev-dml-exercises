#!/usr/bin/env node
"use strict";

/**
 * Golden gate for `runtime: "react-jsx"` exercises.
 *
 * For each lesson: the instructor answer must PASS its own test and the starter
 * must FAIL it. A test that both satisfy proves nothing — it would ship an
 * exercise that grades every submission green — so that case is reported RED.
 *
 * Mirrors `check-cpp.sh` / `check-git.sh` / `check-rust.sh`, and runs the same
 * harness the server will: only the JSX transform differs (esbuild here, SWC in
 * `blockskwela-rs`).
 *
 *   node scripts/check-dapps.js                 # every react-jsx lesson
 *   node scripts/check-dapps.js <lesson-dir>    # one lesson
 */

const fs = require("node:fs");
const path = require("node:path");
const vm = require("node:vm");
const esbuild = require("esbuild");

const { createHarness } = require("../contracts/harness");

const CONTRACTS_DIR = path.join(__dirname, "..", "contracts");
const ANSWER_FILE = "act_1.answer.js";
const STARTER_FILE = "act_1.js";
// NOT "act_1.test.js": Django's sync_courses globs `act_1.test.*` into
// ModuleContent.test_file and the course API serializes that URL to the browser,
// which would hand students the hidden test. `act_1.t.js` dodges the glob, the
// same way the Solidity harness's `act_1.t.sol` does.
const TEST_FILE = "act_1.t.js";
const SPEC_FILE = "spec.json";

/**
 * Runtimes this gate grades.
 *
 * `react-jsx` mounts a component; `javascript` (ch05, ch06) has none and is
 * judged on its console output instead. Both run the same harness under the
 * same transform -- only what counts as "the submission" differs.
 */
const GRADED_RUNTIMES = new Set(["react-jsx", "javascript"]);

/**
 * Whether a string is a plain JavaScript identifier, safe to interpolate.
 *
 * `spec.json` is content, and content is not a place to accept arbitrary code,
 * so anything else is dropped rather than trusted.
 */
function isJsIdentifier(name) {
  return /^[A-Za-z_$][A-Za-z0-9_$]*$/.test(name);
}

/**
 * Copy a plain script's top-level names onto its exports.
 *
 * Mirrors `export_epilogue` in `blockskwela-rs`. A submission is evaluated in a
 * function scope, so `function foo() {}` at a script's top level is invisible to
 * the test that wants to call it. `typeof` keeps it safe: a name the student
 * never declared reads as "undefined" instead of throwing, so an unfinished task
 * fails its own test rather than taking the whole submission down.
 */
function exportEpilogue(exports_ = []) {
  return exports_
    .filter(isJsIdentifier)
    .map((name) => `module.exports.${name} = typeof ${name} === "undefined" ? undefined : ${name};`)
    .join("\n");
}

/** Transform JSX/ESM to CommonJS the sandbox can evaluate. */
function transform(source, filename) {
  return esbuild.transformSync(source, {
    loader: "jsx",
    format: "cjs",
    target: "es2020",
    sourcefile: filename,
  }).code;
}

/**
 * Evaluate one module inside the harness sandbox.
 *
 * The context holds only what the harness provides — no `fs`, no `net`, no
 * host `process`. That is the same boundary QuickJS will enforce structurally.
 */
function evaluate(source, filename, harness) {
  const module = { exports: {} };
  const context = vm.createContext({
    ...harness.globals,
    require: harness.requireModule,
    module,
    exports: module.exports,
  });
  new vm.Script(transform(source, filename), { filename }).runInContext(context, {
    timeout: 5000,
  });
  return module.exports;
}

/** Resolve the component a test should mount. */
function componentOf(exports_, filename) {
  const candidate = exports_.default || exports_;
  if (typeof candidate !== "function") {
    throw new Error(`${filename} has no default-exported component.`);
  }
  return candidate;
}

/**
 * Run a lesson's test file against one submission.
 *
 * @returns `{ passed, total, results, compileError? }` — the same shape the
 * server's ValidationReport carries, so the two stay in lockstep.
 */
async function grade(lessonDir, submissionPath) {
  const spec = JSON.parse(fs.readFileSync(path.join(lessonDir, SPEC_FILE), "utf8"));
  const harness = createHarness(spec);

  let Component;
  try {
    const source = fs.readFileSync(submissionPath, "utf8");
    // The epilogue goes inside the submission, after the student code, so the
    // names it reads are the ones their script just defined.
    const withEpilogue = `${source}
${exportEpilogue(spec.exports)}`;
    const exports_ = evaluate(withEpilogue, path.basename(submissionPath), harness);
    // A plain-script lesson has nothing to mount: it is graded on what it
    // printed while loading, which the harness has already captured.
    Component = spec.runtime === "javascript" ? exports_ : componentOf(exports_, submissionPath);
  } catch (error) {
    return { passed: false, total: 0, results: [], compileError: error.message };
  }

  // The test file sees the component under test as `Submission`.
  harness.globals.Submission = Component;
  try {
    evaluate(fs.readFileSync(path.join(lessonDir, TEST_FILE), "utf8"), TEST_FILE, harness);
  } catch (error) {
    return { passed: false, total: 0, results: [], compileError: `test file: ${error.message}` };
  }

  const results = await harness.registry.run();
  return {
    passed: results.length > 0 && results.every((r) => r.status === "pass"),
    total: results.length,
    results,
  };
}

/** Every directory holding a `react-jsx` spec. */
function findLessons(root) {
  const found = [];
  for (const chapter of fs.readdirSync(root, { withFileTypes: true })) {
    if (!chapter.isDirectory()) continue;
    const chapterDir = path.join(root, chapter.name);
    for (const lesson of fs.readdirSync(chapterDir, { withFileTypes: true })) {
      if (!lesson.isDirectory()) continue;
      const dir = path.join(chapterDir, lesson.name);
      const specPath = path.join(dir, SPEC_FILE);
      if (!fs.existsSync(specPath)) continue;
      try {
        if (GRADED_RUNTIMES.has(JSON.parse(fs.readFileSync(specPath, "utf8")).runtime)) found.push(dir);
      } catch {
        // A malformed spec is reported by the gate itself, not skipped here.
        found.push(dir);
      }
    }
  }
  return found.sort();
}

/** Run the gate for one lesson and print its verdict. */
async function gateLesson(lessonDir) {
  const name = path.basename(lessonDir);
  for (const required of [SPEC_FILE, TEST_FILE, ANSWER_FILE, STARTER_FILE]) {
    if (!fs.existsSync(path.join(lessonDir, required))) {
      console.log(`RED   ${name} — missing ${required}`);
      return false;
    }
  }

  const answer = await grade(lessonDir, path.join(lessonDir, ANSWER_FILE));
  const starter = await grade(lessonDir, path.join(lessonDir, STARTER_FILE));

  if (answer.compileError) {
    console.log(`RED   ${name} — answer failed to load: ${answer.compileError}`);
    return false;
  }
  if (!answer.passed) {
    console.log(`RED   ${name} — the instructor answer does not pass its own test:`);
    for (const r of answer.results.filter((x) => x.status === "fail")) {
      console.log(`        ${r.name}\n          ${r.reason}`);
    }
    return false;
  }
  if (starter.passed) {
    console.log(`RED   ${name} — the starter also passes, so the test proves nothing`);
    return false;
  }

  const starterFailures = starter.compileError
    ? "starter does not compile"
    : `${starter.results.filter((r) => r.status === "fail").length}/${starter.total} fail`;
  console.log(`GREEN ${name} — answer ${answer.total}/${answer.total} pass, ${starterFailures}`);
  return true;
}

async function main() {
  const target = process.argv[2];
  const lessons = target ? [path.resolve(target)] : findLessons(CONTRACTS_DIR);

  if (lessons.length === 0) {
    console.log("No react-jsx lessons found.");
    return;
  }

  const verdicts = [];
  for (const lesson of lessons) verdicts.push(await gateLesson(lesson));

  const green = verdicts.filter(Boolean).length;
  console.log(`\n${green}/${verdicts.length} lessons GREEN`);
  if (green !== verdicts.length) process.exitCode = 1;
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
