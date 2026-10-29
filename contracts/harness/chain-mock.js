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
  abiValue,
  fixtureValue,
  formatUnits,
  getAddress,
  isAddress,
  parseUnits,
  pseudoHash,
  toResult,
  v5Error,
} = require("./ethers-utils");
const { createContractClass } = require("./contract-mock");

/** Record of one recorded interaction, e.g. `contract.name` or `provider.getSigner`. */
function makeRecorder() {
  const entries = [];
  return {
    entries,
    record(target, args) {
      entries.push({ target, args });
    },
    /** Forget everything recorded so far. */
    clear() {
      entries.length = 0;
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
 * A decoded receipt log, as v6 gives a log it could match to the ABI.
 *
 * A class so `log instanceof ethers.EventLog` — the v6 way to tell a decoded
 * log from a raw one — works on what the mock returns.
 */
class EventLog {
  constructor(fields) {
    Object.assign(this, fields);
  }
}

/**
 * Build the mocked `ethers` module and `window.ethereum` for one grading run.
 *
 * @param spec - The exercise spec; `spec.chain` supplies the fixture.
 * @returns `{ ethers, ethereum, recorder, emitContract, reset }`.
 */
function createChain(spec) {
  const chain = (spec && spec.chain) || {};
  const accounts = chain.accounts || [];
  const chainId = chain.chainId || "0xaa36a7";
  const contracts = chain.contracts || {};
  const recorder = makeRecorder();
  let listeners = new Map();
  /** Every Contract the component constructed, so tests can fire its events. */
  const contractInstances = [];
  /**
   * Whether this site holds the wallet's permission. A fresh visitor's wallet
   * reveals no accounts until `eth_requestAccounts` is approved, which is what
   * MetaMask does; `chain.connected: true` models an already-authorised site.
   */
  let connected = chain.connected === true;

  /** Answer one JSON-RPC method from the fixture. Shared by wallet and providers. */
  function rpc(method) {
    if (method === "eth_requestAccounts") {
      connected = true;
      return accounts;
    }
    if (method === "eth_accounts") return connected ? accounts : [];
    if (method === "eth_chainId") return chainId;
    if (method === "wallet_switchEthereumChain") return null;
    if (method === "personal_sign") return chain.signature || "0xsig";
    return null;
  }

  /** EIP-1193 provider, as MetaMask injects it. */
  const ethereum = {
    isMetaMask: true,
    async request({ method, params }) {
      recorder.record("window.ethereum.request", [method, params]);
      return rpc(method);
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

  /**
   * A signed transaction response, as a v6 write returns.
   *
   * The receipt carries `logs`, not v5's `events`. Each entry is an `EventLog`
   * with `fragment.name`, `eventName` and an `args` Result readable both by
   * name and by position, so a lesson that reads its own event has something
   * real to parse. What is emitted per method comes from the fixture's `emits`.
   */
  function txResponse(name, fixture) {
    const emitted = (fixture.emits || {})[name];
    const hash = chain.txHash || "0xtx";
    const logs = emitted
      ? [
          new EventLog({
            fragment: { name: emitted.name, type: "event" },
            eventName: emitted.name,
            args: toResult(
              Object.values(emitted.args || {}).map(abiValue),
              Object.keys(emitted.args || {}),
            ),
            topics: [pseudoHash(emitted.name)],
            data: "0x",
            transactionHash: hash,
          }),
        ]
      : [];

    return {
      hash,
      async wait() {
        recorder.record(`tx.wait`, [name]);
        return { status: 1, hash, logs };
      },
    };
  }

  const { Contract, buildContract } = createContractClass({
    recorder,
    fixtureFor,
    txResponse,
    contractInstances,
  });

  const signer = {
    /** Sync in v6, and the same value `getAddress()` resolves to. */
    get address() {
      return accounts[0];
    },
    async getAddress() {
      recorder.record("signer.getAddress", []);
      return accounts[0];
    },
    async signMessage(message) {
      recorder.record("signer.signMessage", [message]);
      return chain.signature || "0xsig";
    },
  };

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
    /** Raw JSON-RPC, answered from the same fixture as the wallet. */
    async send(method, params) {
      recorder.record("provider.send", [method, params]);
      return rpc(method);
    }
  }

  class BrowserProvider extends BaseProvider {
    constructor(source) {
      super();
      recorder.record("new ethers.BrowserProvider", [Boolean(source)]);
      this.source = source && typeof source.request === "function" ? source : ethereum;
    }
    /** v6 forwards raw RPC to the injected wallet, so it is recorded there too. */
    async send(method, params) {
      recorder.record("provider.send", [method, params]);
      return this.source.request({ method, params });
    }
    /**
     * As v6 does: when the site holds no permission yet, ask the wallet for it
     * (`eth_requestAccounts`, the MetaMask prompt) before handing out a signer.
     */
    async getSigner() {
      recorder.record("provider.getSigner", []);
      if (!connected) await this.source.request({ method: "eth_requestAccounts", params: [] });
      return signer;
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
      this.abi = abi;
      this.runner = runner;
    }
    async deploy(...args) {
      recorder.record("factory.deploy", args);
      const address = chain.deployedAddress || "0xdeployed";
      const hash = chain.txHash || "0xtx";
      const deployTx = {
        hash,
        async wait() {
          return { status: 1, hash, contractAddress: address, logs: [] };
        },
      };
      return buildContract(address, this.abi, this.runner, { deployTx });
    }
  }

  const ethers = {
    BrowserProvider,
    JsonRpcProvider,
    Contract,
    ContractFactory,
    EventLog,
    ZeroAddress: "0x0000000000000000000000000000000000000000",
    getAddress,
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
    getBytes: (value) => {
      recorder.record("ethers.getBytes", [value]);
      const hex = String(value).replace(/^0x/, "");
      return Uint8Array.from(hex.match(/../g) || [], (b) => parseInt(b, 16));
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

  /**
   * What the submission did at module scope, before any test rendered it.
   *
   * A provider or contract built at the top of the file is constructed once,
   * when the module loads — as in a browser. Resetting to *nothing* would hide
   * it from every test ("never built a JsonRpcProvider", "never subscribed"),
   * so each reset returns to this snapshot instead.
   */
  let moduleScope = null;

  /**
   * Return the chain to its pre-render state.
   *
   * One harness serves every `it` in a lesson's test file, so without this the
   * call log accumulates and a later test sees calls made by an earlier one —
   * which silently turns "did the component call X?" into "did any test call
   * X?". Called at the start of each `render`.
   */
  function reset() {
    if (moduleScope === null) {
      moduleScope = {
        entries: recorder.entries.slice(),
        instances: contractInstances.slice(),
        listeners: new Map([...listeners].map(([k, v]) => [k, v.slice()])),
        connected,
      };
      for (const instance of moduleScope.instances) instance.__mark();
    }
    recorder.clear();
    recorder.entries.push(...moduleScope.entries);
    listeners = new Map([...moduleScope.listeners].map(([k, v]) => [k, v.slice()]));
    connected = moduleScope.connected;
    // Instances built during a render are dropped, with their listeners and
    // `sequences` cursors; module-scope ones are rewound to how they loaded.
    contractInstances.length = 0;
    for (const instance of moduleScope.instances) {
      instance.__restore();
      contractInstances.push(instance);
    }
  }

  return { ethers, ethereum, recorder, emitContract, reset };
}

module.exports = { createChain, V5_REMOVALS };
