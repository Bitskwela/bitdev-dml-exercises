"use strict";

/**
 * Pure value helpers of the mocked ethers v6 surface, plus the v5 removal map.
 *
 * Split from `chain-mock.js` so the stateful mocks (providers, contracts, the
 * call recorder) stay separate from the arithmetic, which is a total function
 * of its inputs and needs no fixture.
 */

/** Removed in ethers v6, keyed to the v6 replacement the student should use. */
const V5_REMOVALS = {
  providers:
    "ethers.providers.X — use ethers.BrowserProvider / ethers.JsonRpcProvider",
  utils:
    "ethers.utils.X — the helpers moved to the top level, e.g. ethers.parseUnits",
  constants: "ethers.constants.X — use ethers.ZeroAddress and friends",
  BigNumber: "ethers.BigNumber — v6 uses the native bigint type",
};

/** Error thrown when student code reaches for a removed ethers v5 API. */
function v5Error(name) {
  return new Error(
    `This exercise runs ethers v6, where ${V5_REMOVALS[name]}. Update your code to the v6 API.`,
  );
}

/**
 * Coerce a fixture value to what an ethers v6 call would return.
 *
 * A numeric string ending in `n` models a `uint256`, which v6 surfaces as a
 * native bigint rather than v5's BigNumber object.
 */
function fixtureValue(raw) {
  // Recurse into arrays so a tuple return — `contract.tasks(i)` destructured as
  // `[id, content, done]` — can mix bigints and plain values.
  if (Array.isArray(raw)) return raw.map(fixtureValue);
  if (typeof raw === "string" && /^-?\d+n$/.test(raw)) return BigInt(raw.slice(0, -1));
  return raw;
}

/** ethers.formatUnits — bigint to a decimal string. */
function formatUnits(value, decimals = 18) {
  const scale = BigInt(10) ** BigInt(decimals);
  const amount = BigInt(value);
  const whole = amount / scale;
  const frac = (amount % scale)
    .toString()
    .padStart(Number(decimals), "0")
    .replace(/0+$/, "");
  return frac ? `${whole}.${frac}` : `${whole}.0`;
}

/** ethers.parseUnits — decimal string to bigint. */
function parseUnits(value, decimals = 18) {
  const [whole, frac = ""] = String(value).split(".");
  const padded = frac.padEnd(Number(decimals), "0").slice(0, Number(decimals));
  return BigInt(whole + padded);
}

/** ethers.isAddress. */
function isAddress(value) {
  return /^0x[0-9a-fA-F]{40}$/.test(String(value));
}

/**
 * A deterministic 32-byte hash stand-in.
 *
 * Grading asserts that a value *was* hashed and threaded through, never that it
 * equals a specific keccak digest — so a stable placeholder is enough, and
 * avoids pulling a crypto implementation into the sandbox.
 */
function pseudoHash(value) {
  return `0x${String(value).length.toString(16).padStart(64, "0")}`;
}

module.exports = {
  V5_REMOVALS,
  fixtureValue,
  formatUnits,
  isAddress,
  parseUnits,
  pseudoHash,
  v5Error,
};
