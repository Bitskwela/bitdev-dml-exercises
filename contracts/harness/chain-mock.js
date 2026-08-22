"use strict";

/**
 * Deterministic chain mocks for grading dApp exercises.
 *
 * Grading must be free, offline and repeatable, so no exercise ever touches a
 * real RPC. `spec.json` declares the fixture — accounts, chain id, per-contract
 * return values and reverts — and these mocks serve it while recording every
 * call, which is what a lesson's tests actually assert on.
 *
 * The surface is **ethers v6**, matching the 6.13.4 the content repo installs.
 * The v5 entry points are present only as throwing stubs: a v5 answer must fail
 * loudly with the v6 replacement named, never be quietly accepted.
 */

const {
  V5_REMOVALS,
  fixtureValue,
  formatUnits,
  isAddress,
  parseUnits,
  pseudoHash,
  v5Error,
} = require("./ethers-utils");

/** Record of one recorded interaction, e.g. `contract.name` or `provider.getSigner`. */
function makeRecorder() {
  const entries = [];
  return {
    entries,
    record(target, args) {
      entries.push({ target, args });
    },
    /** Names of every call whose target matches, in order. */
    of(target) {
      return entries.filter((e) => e.target === target).map((e) => e.args);
    },
    /** Every recorded target name, in call order. */
    targets() {
      return entries.map((e) => e.target);
    },
  };
}

/**
 * Build the mocked `ethers` module and `window.ethereum` for one grading run.
 *
 * @param spec - The exercise spec; `spec.chain` supplies the fixture.
 * @returns `{ ethers, ethereum, recorder }`.
 */
function createChain(spec) {
  const chain = (spec && spec.chain) || {};
  const accounts = chain.accounts || [];
  const chainId = chain.chainId || "0xaa36a7";
  const contracts = chain.contracts || {};
  const recorder = makeRecorder();
  const listeners = new Map();
  /** Every Contract the component constructed, so tests can fire its events. */
  const contractInstances = [];

  /** EIP-1193 provider, as MetaMask injects it. */
  const ethereum = {
    isMetaMask: true,
    async request({ method, params }) {
      recorder.record("window.ethereum.request", [method, params]);
      if (method === "eth_requestAccounts" || method === "eth_accounts") return accounts;
      if (method === "eth_chainId") return chainId;
      if (method === "wallet_switchEthereumChain") return null;
      if (method === "personal_sign") return chain.signature || "0xsig";
      return null;
    },
    on(event, handler) {
      recorder.record("window.ethereum.on", [event]);
      const list = listeners.get(event) || [];
      list.push(handler);
      listeners.set(event, list);
    },
    removeListener(event, handler) {
      recorder.record("window.ethereum.removeListener", [event]);
      const list = (listeners.get(event) || []).filter((h) => h !== handler);
      listeners.set(event, list);
    },
    /** Test-only: fire a wallet event at whatever the component registered. */
    __emit(event, ...args) {
      for (const handler of listeners.get(event) || []) handler(...args);
    },
  };

  /** Look a contract's fixture up by address, tolerating an unknown address. */
  function fixtureFor(address) {
    if (Object.hasOwn(contracts, address)) return contracts[address];
    if (Object.hasOwn(contracts, "*")) return contracts["*"];
    return { returns: {}, reverts: {} };
  }

  /** A signed transaction response, as a v6 write returns. */
  function txResponse(name) {
    return {
      hash: chain.txHash || "0xtx",
      async wait() {
        recorder.record(`tx.wait`, [name]);
        return { status: 1, hash: chain.txHash || "0xtx" };
      },
    };
  }

  class Contract {
    constructor(address, abi, runner) {
      recorder.record("new ethers.Contract", [address]);
      const fixture = fixtureFor(address);
      const contractListeners = new Map();

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
            if (Object.hasOwn(fixture.returns || {}, prop)) {
              return fixtureValue(fixture.returns[prop]);
            }
            // Unlisted members are treated as state-changing writes.
            return txResponse(prop);
          };
        },
      });

      contractInstances.push(instance);
      return instance;
    }
  }

  /** Shared by BrowserProvider and JsonRpcProvider. */
  class BaseProvider {
    async getSigner() {
      recorder.record("provider.getSigner", []);
      return signer;
    }
    async getNetwork() {
      recorder.record("provider.getNetwork", []);
      return { chainId: BigInt(parseInt(chainId, 16)), name: chain.networkName || "sepolia" };
    }
    async getBalance(address) {
      recorder.record("provider.getBalance", [address]);
      return fixtureValue(chain.balance || "0n");
    }
    async getFeeData() {
      recorder.record("provider.getFeeData", []);
      return { gasPrice: fixtureValue(chain.gasPrice || "0n") };
    }
  }

  const signer = {
    async getAddress() {
      recorder.record("signer.getAddress", []);
      return accounts[0];
    },
    async signMessage(message) {
      recorder.record("signer.signMessage", [message]);
      return chain.signature || "0xsig";
    },
  };

  class BrowserProvider extends BaseProvider {
    constructor(source) {
      super();
      recorder.record("new ethers.BrowserProvider", [Boolean(source)]);
    }
  }

  class JsonRpcProvider extends BaseProvider {
    constructor(url) {
      super();
      recorder.record("new ethers.JsonRpcProvider", [url]);
    }
  }

  class ContractFactory {
    constructor(abi, bytecode, runner) {
      recorder.record("new ethers.ContractFactory", [Boolean(abi), Boolean(bytecode), Boolean(runner)]);
    }
    async deploy(...args) {
      recorder.record("factory.deploy", args);
      const address = chain.deployedAddress || "0xdeployed";
      return {
        target: address,
        async getAddress() {
          return address;
        },
        async waitForDeployment() {
          recorder.record("contract.waitForDeployment", []);
          return this;
        },
      };
    }
  }

  const ethers = {
    BrowserProvider,
    JsonRpcProvider,
    Contract,
    ContractFactory,
    ZeroAddress: "0x0000000000000000000000000000000000000000",
    isAddress,
    formatUnits,
    parseUnits,
    formatEther: (value) => formatUnits(value, 18),
    parseEther: (value) => parseUnits(value, 18),
    verifyMessage: (message, signature) => {
      recorder.record("ethers.verifyMessage", [message, signature]);
      return chain.recoveredAddress || accounts[0];
    },
    id: (value) => {
      recorder.record("ethers.id", [value]);
      return pseudoHash(value);
    },
    hashMessage: (value) => {
      recorder.record("ethers.hashMessage", [value]);
      return pseudoHash(value);
    },
    Signature: {
      from: (signature) => {
        recorder.record("ethers.Signature.from", [signature]);
        return { v: 27, r: `0x${"1".repeat(64)}`, s: `0x${"2".repeat(64)}`, serialized: signature };
      },
    },
  };

  // v5 entry points exist only to fail with a message that names the fix.
  for (const name of Object.keys(V5_REMOVALS)) {
    Object.defineProperty(ethers, name, {
      get() {
        throw v5Error(name);
      },
    });
  }

  /**
   * Fire a contract event at every listener the component registered.
   *
   * The component builds its own `Contract` internally, so a test cannot hold a
   * reference to it; broadcasting to each instance created during the render is
   * how a lesson's `contract.on(...)` wiring gets exercised.
   *
   * @returns How many instances received the event — `0` means the component
   * never subscribed, which is itself the assertion a listener lesson makes.
   */
  function emitContract(event, ...args) {
    let delivered = 0;
    for (const instance of contractInstances) {
      instance.__emit(event, ...args);
      delivered += 1;
    }
    return delivered;
  }

  return { ethers, ethereum, recorder, emitContract };
}

module.exports = { createChain, V5_REMOVALS };
