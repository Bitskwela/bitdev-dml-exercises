#!/usr/bin/env node
// Lift a chapter's existing oracles into `cases[]` spec.json bundles for the
// `process` runtime.
//
// Task 10 in `openspec/changes/add-multi-runtime-validation` is mechanical by
// design: ch08 already ships `act_1.expected.txt` for all 31 lessons and
// `act_1.input.txt` for the 5 that read stdin, so the bundle is a transcription
// of files that already exist rather than 31 authoring jobs. This script is that
// transcription, plus the audit that proves the transcription is safe.
//
// DRY RUN BY DEFAULT. It prints what it would write and exits; `--write` is
// required to touch the tree. Nothing here should be published before the
// `process` runtime exists in blockskwela-rs (Task 8) — a bundle declaring a
// runtime the server does not implement fails closed, which is correct, but it
// is still a bundle that cannot grade.
//
// NORMALISATION IS NOT APPLIED HERE. The oracle is stored byte for byte and
// normalised at compare time, on both sides, exactly as `scripts/check-cpp.sh`
// does. That script is the ground truth and its `norm()` is precisely:
//
//     sed -e 's/[[:space:]]*$//'      # strip trailing whitespace, per line
//
// It does NOT drop leading or trailing blank lines. (design.md's prose says it
// does; the script is what actually produced every oracle in the tree, so the
// script wins.) Measured on ch08: 1 of 31 oracles opens with a blank line and 1
// of 31 has no trailing newline, so anything that "tidies" the oracle breaks
// those two lessons.
//
// Usage:
//   node scripts/make-process-cases.mjs contracts/ch_08_cpp --toolchain cpp17 --ext cpp
//   node scripts/make-process-cases.mjs contracts/ch_08_cpp --toolchain cpp17 --ext cpp --write

import { readFileSync, writeFileSync, existsSync, readdirSync, statSync } from "node:fs";
import { join, basename } from "node:path";

const args = process.argv.slice(2);
const chapterDir = args.find((a) => !a.startsWith("--"));
const flag = (name, fallback = null) => {
  const i = args.indexOf(`--${name}`);
  return i === -1 ? fallback : args[i + 1];
};
const WRITE = args.includes("--write");
const TOOLCHAIN = flag("toolchain", "cpp17");
const EXT = flag("ext", "cpp");

if (!chapterDir || !existsSync(chapterDir)) {
  console.error("usage: make-process-cases.mjs <chapter-dir> [--toolchain cpp17] [--ext cpp] [--write]");
  process.exit(2);
}

/** Lesson dir name -> permaname, matching the ch05/ch06 convention exactly. */
const permanameFor = (dir) => basename(dir).replace(/_/g, "-");

/** `check-cpp.sh`'s norm(): strip trailing whitespace per line. Nothing else. */
const norm = (text) =>
  text
    .split("\n")
    .map((line) => line.replace(/[ \t]+$/, ""))
    .join("\n");

const lessons = readdirSync(chapterDir)
  .map((name) => join(chapterDir, name))
  .filter((p) => statSync(p).isDirectory())
  .sort();

const specs = [];
const skipped = [];
const audit = { leadingBlank: [], noTrailingNewline: [], trailingWs: [], withStdin: [], crlf: [] };

for (const dir of lessons) {
  const expectedPath = join(dir, "act_1.expected.txt");
  const inputPath = join(dir, `act_1.input.txt`);
  const starterPath = join(dir, `act_1.${EXT}`);
  const answerPath = join(dir, `act_1.answer.${EXT}`);

  const missing = [
    ["expected", expectedPath],
    ["starter", starterPath],
    ["answer", answerPath],
  ]
    .filter(([, p]) => !existsSync(p))
    .map(([label]) => label);

  if (missing.length) {
    skipped.push({ lesson: basename(dir), missing });
    continue;
  }

  const expected = readFileSync(expectedPath, "utf8");
  const stdin = existsSync(inputPath) ? readFileSync(inputPath, "utf8") : "";

  // Audit the edge cases that a careless implementation silently breaks.
  if (/^[ \t]*\n/.test(expected)) audit.leadingBlank.push(basename(dir));
  if (!expected.endsWith("\n")) audit.noTrailingNewline.push(basename(dir));
  if (norm(expected) !== expected) audit.trailingWs.push(basename(dir));
  if (expected.includes("\r")) audit.crlf.push(basename(dir));
  if (stdin) audit.withStdin.push(basename(dir));

  specs.push({
    dir,
    spec: {
      permaname: permanameFor(dir),
      runtime: "process",
      toolchain: TOOLCHAIN,
      source_file: `act_1.${EXT}`,
      cases: [
        {
          // One run per lesson, matching check-cpp.sh: compile the submission,
          // feed it the lesson's stdin if any, compare its output to the oracle.
          name: "produces the expected output",
          stdin,
          expect_stdout: expected,
        },
      ],
    },
  });
}

// ------------------------------------------------------------------ report ---

console.log(`chapter        : ${chapterDir}`);
console.log(`toolchain      : ${TOOLCHAIN}  (source act_1.${EXT})`);
console.log(`lessons found  : ${lessons.length}`);
console.log(`bundles ready  : ${specs.length}`);
console.log(`skipped        : ${skipped.length}`);
for (const s of skipped) console.log(`   - ${s.lesson}: missing ${s.missing.join(", ")}`);

console.log(`\n-- oracle audit --`);
console.log(`   with stdin            : ${audit.withStdin.length}  [${audit.withStdin.join(", ")}]`);
console.log(`   leading blank line    : ${audit.leadingBlank.length}  [${audit.leadingBlank.join(", ")}]`);
console.log(`   no trailing newline   : ${audit.noTrailingNewline.length}  [${audit.noTrailingNewline.join(", ")}]`);
console.log(`   trailing whitespace   : ${audit.trailingWs.length}  [${audit.trailingWs.join(", ")}]`);
console.log(`   CR in oracle (CRLF)   : ${audit.crlf.length}  [${audit.crlf.join(", ")}]`);

if (audit.crlf.length) {
  console.log(
    `\n   WARNING: a CR in an oracle survives check-cpp.sh's norm() (which strips\n` +
      `   only spaces and tabs) but will not survive a checkout on another platform.\n` +
      `   Normalise line endings in the content repo before publishing these.`,
  );
}

const existing = specs.filter(({ dir }) => existsSync(join(dir, "spec.json")));
if (existing.length) {
  console.log(`\n   ${existing.length} lesson(s) already have a spec.json; those are never overwritten.`);
}

if (!WRITE) {
  console.log(`\n-- dry run; nothing written. Sample bundle --`);
  if (specs[0]) {
    const sample = structuredClone(specs[0].spec);
    // Keep the sample readable: oracles run to dozens of lines.
    const shown = sample.cases[0].expect_stdout;
    sample.cases[0].expect_stdout =
      shown.length > 160 ? `${shown.slice(0, 160)}… (${shown.length} chars)` : shown;
    console.log(JSON.stringify(sample, null, 2));
  }
  console.log(`\nRe-run with --write to create ${specs.length - existing.length} spec.json file(s).`);
  process.exit(0);
}

let written = 0;
for (const { dir, spec } of specs) {
  const out = join(dir, "spec.json");
  if (existsSync(out)) continue; // never clobber an authored bundle
  writeFileSync(out, `${JSON.stringify(spec, null, 2)}\n`, "utf8");
  written += 1;
}
console.log(`\nwrote ${written} spec.json file(s).`);
