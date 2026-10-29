#!/usr/bin/env node
"use strict";

/**
 * Regression guard for the dApp grading harness: the alternative-solution corpus.
 *
 * `check-dapps.js` proves one answer passes and one starter fails per lesson.
 * That cannot catch a harness that rejects a *different* correct ethers v6
 * solution (a false negative a learner hits as "my right code is graded wrong"),
 * or one that accepts a wrong solution. This grades every file under
 * `scripts/dapp-alts/<lesson_dir>/` against that lesson's real test and compares
 * the verdict with `scripts/dapp-alts/manifest.json`:
 *
 *   expect "pass"                    must pass every case        (else RED)
 *   expect "fail"                    must fail at least one case (else RED)
 *   expect "pass" + known_failing    still fails for a reason outside the harness
 *                                    (the test or the lesson prose); tracked as
 *                                    KNOWN, and RED once it starts passing so the
 *                                    stale marker gets removed.
 *   expect "fail" + known_passing    a wrong solution a too-weak *test* accepts
 *                                    (a false positive to fix in the test, not
 *                                    the harness); KNOWN, RED once it fails.
 *
 * The corpus lives in `scripts/`, not `contracts/`: Django's course sync globs
 * lesson folders, and these files must never reach a learner.
 *
 *   node scripts/check-dapp-alts.js                  # whole corpus
 *   node scripts/check-dapp-alts.js <lesson_dir>     # one lesson's alts
 *   node scripts/check-dapp-alts.js --verbose        # print failing reasons
 */

const fs = require("node:fs");
const path = require("node:path");

const { findLessons, grade, CONTRACTS_DIR } = require("./check-dapps");

const ALTS_DIR = path.join(__dirname, "dapp-alts");
const MANIFEST = path.join(ALTS_DIR, "manifest.json");

/**
 * @typedef {object} AltEntry
 * @property {string} lesson - Lesson directory name, e.g. `le_08_send_tokens_via_ui`.
 * @property {string} file - File name inside `dapp-alts/<lesson>/`.
 * @property {"pass" | "fail"} expect - Whether a correct grader passes it.
 * @property {string} reason - One line: why it is correct, or what is wrong with it.
 * @property {string} [known_failing] - Why a correct alt still fails (not a harness bug).
 * @property {string} [known_passing] - Why a wrong alt still passes (a weak test).
 */

/**
 * @typedef {object} Verdict
 * @property {AltEntry} entry
 * @property {"OK" | "KNOWN" | "RED"} status
 * @property {string} actual - `pass`, `fail N/M`, or `load error`.
 * @property {string[]} failures - Failing case names and reasons.
 */

/** @returns {AltEntry[]} The manifest, validated. Throws on a malformed entry. */
function readManifest() {
  const parsed = JSON.parse(fs.readFileSync(MANIFEST, "utf8"));
  const alts = Array.isArray(parsed.alts) ? parsed.alts : [];
  for (const entry of alts) {
    const where = `${entry.lesson}/${entry.file}`;
    if (entry.expect !== "pass" && entry.expect !== "fail") {
      throw new Error(`manifest: ${where} has expect ${JSON.stringify(entry.expect)}`);
    }
    if (typeof entry.reason !== "string" || entry.reason.trim() === "") {
      throw new Error(`manifest: ${where} needs a one-line reason`);
    }
    if (entry.known_failing !== undefined && entry.expect !== "pass") {
      throw new Error(`manifest: ${where} — known_failing only applies to expect "pass"`);
    }
    if (entry.known_passing !== undefined && entry.expect !== "fail") {
      throw new Error(`manifest: ${where} — known_passing only applies to expect "fail"`);
    }
  }
  return alts;
}

/**
 * Files on disk with no manifest entry, and entries with no file. Either is a
 * corpus that silently stopped guarding something.
 *
 * @param {AltEntry[]} alts
 * @returns {string[]} Problems, one per line.
 */
function corpusDrift(alts) {
  const listed = new Set(alts.map((a) => `${a.lesson}/${a.file}`));
  const problems = [];
  for (const lesson of fs.readdirSync(ALTS_DIR, { withFileTypes: true })) {
    if (!lesson.isDirectory()) continue;
    for (const file of fs.readdirSync(path.join(ALTS_DIR, lesson.name))) {
      if (!listed.has(`${lesson.name}/${file}`)) problems.push(`not in manifest: ${lesson.name}/${file}`);
    }
  }
  for (const key of listed) {
    if (!fs.existsSync(path.join(ALTS_DIR, key))) problems.push(`manifest names a missing file: ${key}`);
  }
  return problems;
}

/**
 * Grade one alt and judge it against its expectation.
 *
 * @param {AltEntry} entry
 * @param {Map<string, string>} lessonDirs - Lesson name to its absolute path.
 * @returns {Promise<Verdict>}
 */
async function judge(entry, lessonDirs) {
  const lessonDir = lessonDirs.get(entry.lesson);
  if (!lessonDir) {
    return { entry, status: "RED", actual: "no such lesson", failures: [] };
  }
  const report = await grade(lessonDir, path.join(ALTS_DIR, entry.lesson, entry.file));
  const failing = report.results.filter((r) => r.status === "fail");
  const failures = report.compileError
    ? [`load: ${report.compileError}`]
    : failing.map((r) => `${r.name} — ${r.reason}`);
  const actual = report.compileError
    ? "load error"
    : report.passed
      ? "pass"
      : `fail ${failing.length}/${report.total}`;

  return { entry, status: statusOf(entry, report.passed), actual, failures };
}

/**
 * The verdict for one alt. A known marker flips which outcome is tracked, and a
 * marker that no longer describes reality is itself RED so it gets removed.
 *
 * @param {AltEntry} entry
 * @param {boolean} passed - Whether every case passed.
 * @returns {"OK" | "KNOWN" | "RED"}
 */
function statusOf(entry, passed) {
  const asExpected = entry.expect === "pass" ? passed : !passed;
  const known = entry.expect === "pass" ? entry.known_failing : entry.known_passing;
  if (known) return asExpected ? "RED" : "KNOWN";
  return asExpected ? "OK" : "RED";
}

async function main() {
  const args = process.argv.slice(2);
  const verbose = args.includes("--verbose");
  const only = args.find((a) => !a.startsWith("--"));

  const alts = readManifest();
  const lessonDirs = new Map(findLessons(CONTRACTS_DIR).map((dir) => [path.basename(dir), dir]));
  const selected = only ? alts.filter((a) => a.lesson === path.basename(only)) : alts;
  const drift = only ? [] : corpusDrift(alts);

  const verdicts = [];
  for (const entry of selected) verdicts.push(await judge(entry, lessonDirs));

  for (const v of verdicts) {
    const known = v.entry.known_failing || v.entry.known_passing;
    const note =
      v.status === "RED" && known
        ? ` (${v.entry.known_failing ? "known_failing" : "known_passing"} is stale — remove the marker)`
        : v.status === "KNOWN"
          ? ` (known: ${known})`
          : "";
    console.log(
      `${v.status.padEnd(5)} ${v.entry.lesson}/${v.entry.file} — expect ${v.entry.expect}, got ${v.actual}${note}`,
    );
    if (v.failures.length && (verbose || (v.status === "RED" && v.entry.expect === "pass"))) {
      for (const failure of v.failures) console.log(`        ${failure}`);
    }
  }
  for (const problem of drift) console.log(`RED   ${problem}`);

  const count = (s) => verdicts.filter((v) => v.status === s).length;
  const red = count("RED") + drift.length;
  console.log(
    `\n${count("OK")} OK, ${count("KNOWN")} KNOWN (blocked outside the harness: test or prose), ${red} RED — ${verdicts.length} alts`,
  );
  if (red > 0) process.exitCode = 1;
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
