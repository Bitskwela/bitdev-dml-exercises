#!/usr/bin/env node
"use strict";

/**
 * Gate against ethers v5 (and dead testnets) in the ch04 dApp lessons.
 *
 * The grader runs ethers v6 and rejects v5 APIs, so lesson prose, starters,
 * answers or answer keys that still teach v5 send a learner straight into a
 * failing grade. This scans every learner-facing file in the chapter and exits
 * non-zero on any hit.
 *
 * A deliberate mention — a "v5 → v6" migration note — is allowed by marking
 * the line itself: `<!-- v5-ok -->` in Markdown, `// v5-ok` in JavaScript (or
 * in a JS code block inside Markdown). JSON has no comments, so a hit in
 * `spec.json` cannot be waived.
 *
 *   node scripts/check-v5.js               # ch04, summary per file
 *   node scripts/check-v5.js --verbose     # also every offending line
 *   node scripts/check-v5.js <dir>         # another lesson tree
 */

const fs = require("node:fs");
const path = require("node:path");

const DEFAULT_ROOT = path.join(__dirname, "..", "contracts", "ch_04_dapps");

/** File names scanned, wherever they sit under the root. */
const SCANNED = new Set([
  "act_1.md",
  "mat_1.md",
  "act_1.js",
  "act_1.answer.js",
  "spec.json",
  "quiz.md",
  "Ch4_AnswersKeys.md",
  "README.md",
]);

/**
 * @typedef {object} Rule
 * @property {string} name - What the learner is told.
 * @property {RegExp} pattern
 */

/** @type {Rule[]} v5 APIs and the testnets that shut down, with the v6 fix. */
const RULES = [
  { name: "ethers.providers (v6: ethers.BrowserProvider / JsonRpcProvider)", pattern: /\bethers\.providers\b/ },
  { name: "ethers.utils (v6: top-level, e.g. ethers.parseUnits)", pattern: /\bethers\.utils\b/ },
  { name: "BigNumber (v6: native bigint)", pattern: /\bBigNumber\b/ },
  { name: ".toNumber() (v6: Number(x))", pattern: /\.toNumber\(\)/ },
  { name: "ethers.constants (v6: ethers.ZeroAddress, ethers.MaxUint256, ...)", pattern: /\bethers\.constants\b/ },
  { name: ".deployed() (v6: await contract.waitForDeployment())", pattern: /\.deployed\(\)/ },
  { name: "deployTransaction (v6: contract.deploymentTransaction())", pattern: /\bdeployTransaction\b/ },
  { name: "docs.ethers.org/v5 (link the v6 docs)", pattern: /docs\.ethers\.org\/v5/ },
  { name: "Goerli / Mumbai / Rinkeby / Ropsten (shut down; use Sepolia / Amoy)", pattern: /\b(goerli|mumbai|rinkeby|ropsten)\b/i },
];

/** @returns {boolean} Whether `line` carries the waiver marker valid for `file`. */
function isWaived(file, line) {
  if (file.endsWith(".md")) return line.includes("<!-- v5-ok -->") || line.includes("// v5-ok");
  if (file.endsWith(".js")) return line.includes("// v5-ok");
  return false;
}

/** @returns {string[]} Every scanned file under `root`, sorted. */
function scannedFiles(root) {
  const found = [];
  for (const entry of fs.readdirSync(root, { withFileTypes: true })) {
    const full = path.join(root, entry.name);
    if (entry.isDirectory()) found.push(...scannedFiles(full));
    else if (SCANNED.has(entry.name)) found.push(full);
  }
  return found.sort();
}

/**
 * @typedef {object} Hit
 * @property {number} line - 1-based.
 * @property {string} rule
 * @property {string} text
 */

/** @returns {Hit[]} Unwaived v5 hits in one file; one per rule per line. */
function scanFile(file) {
  const hits = [];
  fs.readFileSync(file, "utf8")
    .split(/\r?\n/)
    .forEach((text, i) => {
      if (isWaived(file, text)) return;
      for (const rule of RULES) {
        if (rule.pattern.test(text)) hits.push({ line: i + 1, rule: rule.name, text: text.trim() });
      }
    });
  return hits;
}

function main() {
  const args = process.argv.slice(2);
  const verbose = args.includes("--verbose");
  const root = path.resolve(args.find((a) => !a.startsWith("--")) || DEFAULT_ROOT);

  let total = 0;
  const byRule = new Map();
  for (const file of scannedFiles(root)) {
    const hits = scanFile(file);
    if (hits.length === 0) continue;
    total += hits.length;
    console.log(`${String(hits.length).padStart(4)}  ${path.relative(root, file).replace(/\\/g, "/")}`);
    for (const hit of hits) {
      byRule.set(hit.rule, (byRule.get(hit.rule) || 0) + 1);
      if (verbose) console.log(`        L${hit.line} ${hit.rule}: ${hit.text.slice(0, 120)}`);
    }
  }

  if (total === 0) {
    console.log("No ethers v5 APIs or dead testnets found.");
    return;
  }
  console.log("\nBy rule:");
  for (const [rule, count] of [...byRule].sort((a, b) => b[1] - a[1])) {
    console.log(`${String(count).padStart(4)}  ${rule}`);
  }
  console.log(`\n${total} v5 hits. Rewrite to ethers v6, or mark a deliberate migration note with <!-- v5-ok --> / // v5-ok.`);
  process.exitCode = 1;
}

main();
