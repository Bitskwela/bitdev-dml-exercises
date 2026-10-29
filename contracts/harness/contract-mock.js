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
 *
 * Each special member below mirrors ethers 6.13.4, checked against the real
 * library rather than from memory: `then` is undefined (a v6 contract is not a
 * thenable), `connect()` is synchronous, `on`/`off` resolve to the contract,
 * and `deploymentTransaction()` is null unless a factory deployed it.
 */

const { abiOutputs, abiValue, shapeReturn } = require("./ethers-utils");

/**
 * Build the `Contract` class for one grading run.
 *
 * @param deps.recorder - Call recorder.
 * @param deps.fixtureFor - Resolve a contract fixture by address.
 * @param deps.txResponse - Build a transaction response for a write.
 * @param deps.contractInstances - Registry every instance appends itself to,
 *   so a test can fire events at contracts the component built internally.
 * @returns `{ Contract, buildContract }` — `buildContract` makes an instance
 *   without recording a `new ethers.Contract`, for `connect()` and factories.
 */
function createContractClass({ recorder, fixtureFor, txResponse, contractInstances }) {
  class Contract {
    constructor(address, abi, runner) {
      recorder.record("new ethers.Contract", [address]);
      return buildContract(address, abi, runner);
    }
  }

  /**
   * One mocked contract instance.
   *
   * @param options.deployTx - What `deploymentTransaction()` returns.
   * @param options.sequenceCursor - Shared with the contract this was
   *   `connect`ed from: both read the same chain, so `tasks(0)`, `tasks(1)`, …
   *   continue rather than restart.
   */
  function buildContract(address, abi, runner, options = {}) {
    const fixture = fixtureFor(address);
    /** How many times each `sequences` method has been called. */
    const sequenceCursor = options.sequenceCursor || new Map();
    let listeners = new Map();
    /** Listeners as they stood when the harness marked module scope. */
    let marked = new Map();

    const copyListeners = (from) => new Map([...from].map(([k, v]) => [k, v.slice()]));

    function subscribe(event, handler) {
      const list = listeners.get(String(event)) || [];
      list.push(handler);
      listeners.set(String(event), list);
    }

    /** `record` is false for a `once` listener removing itself — not a cleanup. */
    function unsubscribe(event, handler, record = true) {
      if (record) recorder.record("contract.off", [String(event)]);
      if (typeof handler !== "function") listeners.delete(String(event));
      else listeners.set(String(event), (listeners.get(String(event)) || []).filter((h) => h !== handler && h.__original !== handler));
    }

    /** `contract.interface`: only what a lesson reads a receipt with. */
    const contractInterface = {
      /** A decodable log → its description; anything else → null, as in v6. */
      parseLog(log) {
        if (!log || !log.fragment || !log.args || typeof log.eventName !== "string") return null;
        return { name: log.eventName, fragment: log.fragment, args: log.args, signature: log.fragment.name, topic: (log.topics || [])[0] };
      },
    };

    /** A read or write of ABI member `prop`. */
    function member(prop) {
      return async (...args) => {
        recorder.record(`contract.${prop}`, args);
        const revert = (fixture.reverts || {})[prop];
        if (revert) throw new Error(revert);
        const outputs = abiOutputs(abi, prop);

        // `sequences` serves a different value per call, for the indexed
        // reads a list lesson makes — `tasks(0)`, `tasks(1)`, … The last
        // entry repeats rather than running out, so an over-eager loop
        // fails on its assertion instead of on an undefined.
        const sequence = (fixture.sequences || {})[prop];
        if (Array.isArray(sequence) && sequence.length > 0) {
          const seen = sequenceCursor.get(prop) ?? 0;
          sequenceCursor.set(prop, seen + 1);
          return shapeReturn(abiValue(sequence[Math.min(seen, sequence.length - 1)]), outputs);
        }

        if (Object.hasOwn(fixture.returns || {}, prop)) {
          return shapeReturn(abiValue(fixture.returns[prop]), outputs);
        }
        // Unlisted members are treated as state-changing writes.
        return txResponse(prop, fixture);
      };
    }

    // A Proxy so the mock needs no per-exercise wiring — the fixture alone
    // drives it. The target carries the prototype so `instanceof` holds.
    const instance = new Proxy(Object.create(Contract.prototype), {
      get(_target, prop) {
        if (typeof prop !== "string") return undefined;
        switch (prop) {
          // v6 lists `then` in passProperties: awaiting a contract, or
          // returning one from an async function, must yield the contract.
          case "then":
            return undefined;
          case "target":
            return address;
          // v5 members. Real v6 has no such ABI-less properties, so they read
          // as undefined there; `deployed()` fails naming its replacement
          // rather than being mistaken for a contract write.
          case "address":
          case "deployTransaction":
            return undefined;
          case "deployed":
            return () => {
              throw new Error(
                "contract.deployed() is ethers v5. In v6 use await contract.waitForDeployment(), and contract.target (or await contract.getAddress()) instead of contract.address.",
              );
            };
          case "runner":
            return runner;
          case "interface":
            return contractInterface;
          case "connect":
            return (nextRunner) => {
              recorder.record("contract.connect", []);
              return buildContract(address, abi, nextRunner, { sequenceCursor });
            };
          case "deploymentTransaction":
            return () => options.deployTx || null;
          case "waitForDeployment":
            return async () => {
              recorder.record("contract.waitForDeployment", []);
              if (options.deployTx) await options.deployTx.wait();
              return instance;
            };
          case "getAddress":
            return async () => {
              recorder.record("contract.getAddress", []);
              return address;
            };
          case "on":
          case "once":
            return async (event, handler) => {
              recorder.record(`contract.${prop}`, [String(event)]);
              if (prop === "on") subscribe(event, handler);
              else {
                const wrapped = (...args) => {
                  unsubscribe(event, wrapped, false);
                  return handler(...args);
                };
                wrapped.__original = handler;
                subscribe(event, wrapped);
              }
              return instance;
            };
          case "off":
            return async (event, handler) => {
              unsubscribe(event, handler);
              return instance;
            };
          case "removeAllListeners":
            // No argument means every event, as in v6. Each is recorded as an
            // `off` so a cleanup check sees what was actually removed.
            return async (event) => {
              recorder.record("contract.removeAllListeners", event === undefined ? [] : [String(event)]);
              const events = event === undefined ? [...listeners.keys()] : [event];
              for (const name of events) unsubscribe(name);
              return instance;
            };
          case "__emit":
            return (event, ...args) => {
              for (const h of (listeners.get(String(event)) || []).slice()) h(...args);
            };
          case "__mark":
            return () => {
              marked = copyListeners(listeners);
            };
          case "__restore":
            return () => {
              listeners = copyListeners(marked);
              sequenceCursor.clear();
            };
          default:
            return member(prop);
        }
      },
    });

    contractInstances.push(instance);
    return instance;
  }

  return { Contract, buildContract };
}

module.exports = { createContractClass };
