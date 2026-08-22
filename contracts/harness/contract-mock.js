"use strict";

/**
 * The mocked `ethers.Contract`.
 *
 * Split from `chain-mock.js` to keep that module under the size cap and to put
 * the single most intricate piece — the Proxy that turns any ABI member into a
 * recording, fixture-driven call — behind one clear boundary.
 *
 * Every dependency is injected rather than closed over, so the class can be
 * built against a test double as easily as against the real recorder.
 */

const { fixtureValue } = require("./ethers-utils");

/**
 * Build the `Contract` class for one grading run.
 *
 * @param deps.recorder - Call recorder.
 * @param deps.fixtureFor - Resolve a contract fixture by address.
 * @param deps.txResponse - Build a transaction response for a write.
 * @param deps.contractInstances - Registry every instance appends itself to,
 *   so a test can fire events at contracts the component built internally.
 * @returns The `Contract` class.
 */
function createContractClass({ recorder, fixtureFor, txResponse, contractInstances }) {
  class Contract {
    constructor(address, abi, runner) {
      recorder.record("new ethers.Contract", [address]);
      const fixture = fixtureFor(address);
      const contractListeners = new Map();
      /** How many times each `sequences` method has been called. */
      const sequenceCursor = new Map();

      // Every ABI member resolves to a recording function. A Proxy is used so
      // the mock needs no per-exercise wiring — the fixture alone drives it.
      const instance = new Proxy(this, {
        get(_target, prop) {
          if (prop === "target" || prop === "address") return address;
          if (prop === "runner") return runner;
          if (prop === "on") {
            return (event, handler) => {
              recorder.record("contract.on", [String(event)]);
              const list = contractListeners.get(String(event)) || [];
              list.push(handler);
              contractListeners.set(String(event), list);
            };
          }
          if (prop === "off" || prop === "removeAllListeners") {
            return (event) => {
              recorder.record("contract.off", [String(event)]);
              contractListeners.delete(String(event));
            };
          }
          if (prop === "__emit") {
            return (event, ...args) => {
              for (const h of contractListeners.get(String(event)) || []) h(...args);
            };
          }
          if (prop === "getAddress") {
            return async () => {
              recorder.record("contract.getAddress", []);
              return address;
            };
          }
          if (typeof prop !== "string") return undefined;

          return async (...args) => {
            recorder.record(`contract.${prop}`, args);
            const revert = (fixture.reverts || {})[prop];
            if (revert) throw new Error(revert);

            // `sequences` serves a different value per call, for the indexed
            // reads a list lesson makes — `tasks(0)`, `tasks(1)`, … The last
            // entry repeats rather than running out, so an over-eager loop
            // fails on its assertion instead of on an undefined.
            const sequence = (fixture.sequences || {})[prop];
            if (Array.isArray(sequence) && sequence.length > 0) {
              const seen = sequenceCursor.get(prop) ?? 0;
              sequenceCursor.set(prop, seen + 1);
              return fixtureValue(sequence[Math.min(seen, sequence.length - 1)]);
            }

            if (Object.hasOwn(fixture.returns || {}, prop)) {
              return fixtureValue(fixture.returns[prop]);
            }
            // Unlisted members are treated as state-changing writes.
            return txResponse(prop, fixture);
          };
        },
      });

      contractInstances.push(instance);
      return instance;
    }
  }
  return Contract;
}

module.exports = { createContractClass };
