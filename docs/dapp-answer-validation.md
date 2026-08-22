# dApp Answer Validation — Authoring Guide (`runtime: "react-jsx"`)

How to make a Chapter 4 dApp exercise gradable. The Solidity guide is
[`answer-validation.md`](./answer-validation.md); this is its JavaScript sibling and
follows the same contract — hidden test, machine-readable spec, golden gate before publish.

> Frontend flow: [`blockskwela-fe/docs/answer-validation.md`](../../docs/answer-validation.md)
> Plan and rationale: `blockskwela-fe/openspec/changes/add-dapp-answer-validation/`

---

## Why these exercises need a different harness

Chapter 4 contains **no Solidity**. Every exercise is a React component talking to an
already-deployed contract through a supplied ABI, so `forge test` has nothing to grade. The
student's artefact is a component, and the thing worth asserting is what it *renders* and
which *chain calls* it makes.

The old `act_1.test.js` files could not do that: they `readFileSync`'d the **instructor's**
answer and string-matched it, so they passed unconditionally and never saw a student's work.
They are replaced, not extended.

## Per-exercise files

| File | Role |
|---|---|
| `act_1.js` | **NEW** — the starter, extracted from `act_1.md` |
| `act_1.answer.js` | Instructor solution — **ethers v6** |
| `act_1.t.js` | **REWRITTEN** — behavioural, hidden, runs against the student's source |
| `spec.json` | **NEW** — runtime, props, env, modules, chain fixture |
| `mat_1.md`, `meta.md`, images | Unchanged |

## Why the test is called `act_1.t.js`, never `act_1.test.js`

**This name is load-bearing. Do not "fix" it.**

Django's `sync_courses` command crawls every lesson directory and, for an activity, globs:

| glob | lands in | reaches the browser? |
|---|---|---|
| `act_1.sol` | `ModuleContent.skeleton_file` | **yes** — serialized by the course API |
| `act_1.answer.*` | `ModuleContent.answers_file` | no — not in the serializer's `fields` |
| `act_1.test.*` | `ModuleContent.test_file` | **yes** — serialized by the course API |
| `act_1.output.*` | `ModuleContent.output_file` | no |

A file named `act_1.test.js` therefore gets uploaded to S3 and its URL handed to the
student's browser — which would publish the hidden grading test and make the exercise
trivially gameable. `act_1.t.js` matches none of those globs, exactly as the Solidity
harness's `act_1.t.sol` matches none of them.

`spec.json` is also ignored by the sync: it only considers files whose base name starts
with `act_`, `mat_`, `sol_` or `ans_`, and `spec` does not. Both the spec and the test
reach the grader through the R2 bundle, never through Django.

> The starter has the mirror-image problem: `skeleton_file` is hardcoded to `act_1.sol`, so
> a `.js` starter is **not** picked up and cannot be served this way. That is why the
> starter is delivered through the bundle instead — no Django change needed.

## `spec.json`

```jsonc
{
  "permaname": "le-02-read-smart-contract-data", // MUST equal meta.md's permaname
  "runtime": "react-jsx",                        // absent ⇒ "solidity"
  "source_file": "NFTReader.jsx",
  "entry": "default",
  "ethers": "6",
  "props": { "proposals": ["A", "B"] },          // props the component is mounted with
  "env": { "REACT_APP_CONTRACT_ADDRESS": "0xAA…" }, // what process.env.* resolves to
  "modules": {                                   // what a relative import returns
    "../abi/SimpleNFT.json": ["function name() view returns (string)"]
  },
  "chain": {
    "accounts": ["0x1234…7890"],
    "chainId": "0xaa36a7",
    "contracts": {
      "0xAA…": {
        "returns": { "name": "Sining Chain", "totalMinted": "3n" },
        "reverts": { "mint": "not owner" }
      }
    }
  }
}
```

**Fixture conventions**

- A numeric string ending in `n` (`"3n"`) becomes a **bigint**, which is what a `uint256`
  read returns in ethers v6.
- A member listed in `returns` is a read. Anything **not** listed is treated as a write and
  returns a transaction with a `wait()`.
- `reverts` makes a call throw, for testing error paths.
- Grading is offline and deterministic: `Date.now()` is frozen, `Math.random()` is seeded,
  and timers resolve immediately. Never write a test that depends on wall-clock time.

## Writing the test

The component under test is the global `Submission`. Mount it with `render`.

```js
describe("Lesson 02: Read Smart Contract Data", () => {
  it("Task 1: reads name, symbol and totalMinted on mount", async () => {
    const ui = await render(Submission);
    expect(ui.callTargets()).to.contain("contract.name", "…actionable message…");
  });
});
```

### Harness API

| Call | Purpose |
|---|---|
| `render(Submission, { props, wallet })` | Mount. `wallet: "absent"` removes `window.ethereum`. |
| `ui.text()` | All rendered text, whitespace-collapsed. |
| `ui.click(label)` | Click the control whose text contains `label`, then re-render. |
| `ui.type(value)` | Fire the first input's `onChange`. |
| `ui.emit(event, …)` | Fire a wallet event (`accountsChanged`). |
| `ui.emitContract(event, …)` | Fire a contract event; returns how many listeners got it (`0` proves the student never subscribed). |
| `ui.calls(target)` | Arguments of every call to `target`, e.g. `contract.vote`. |
| `ui.callTargets()` / `ui.called(t)` | Every call target in order / whether one happened. |
| `ui.all(tag)` / `ui.find(tag, label)` | Query rendered host nodes. |
| `ui.unmount()` | Run effect cleanups — how you test `useEffect` teardown. |
| `spy(fn?)` | Recording stand-in for a callback prop; `.calls`, `.called()`. |

### Rules

- **Assert behaviour, never source text.** `expect(code).to.contain("useState")` is banned:
  it accepts a wrong answer containing the right word and rejects a correct one spelled
  differently. Assert on `ui.text()` or the call log.
- **Every failure message must say what to do.** The student sees only this string.
  "Expected contract.name() to be called on mount" beats "assertion failed".
- **The golden rule:** the test must PASS against `act_1.answer.js` and FAIL against
  `act_1.js`. The gate enforces it.

## ethers v6, not v5

The mock implements **ethers 6.13.4** — the version this repo already installs via
`@nomicfoundation/hardhat-toolbox`. The v5 entry points exist only as throwing stubs, so a
v5 answer fails with the replacement named rather than being quietly accepted:

| v5 | v6 |
|---|---|
| `new ethers.providers.Web3Provider(w)` | `new ethers.BrowserProvider(w)` |
| `new ethers.providers.JsonRpcProvider(u)` | `new ethers.JsonRpcProvider(u)` |
| `provider.getSigner()` | `await provider.getSigner()` — **now async** |
| `ethers.utils.parseUnits(…)` | `ethers.parseUnits(…)` |
| `bn.toNumber()` | `Number(bn)` |
| `contract.deployed()` | `contract.waitForDeployment()` |
| `contract.address` | `await contract.getAddress()` |
| `ethers.utils.splitSignature(s)` | `ethers.Signature.from(s)` |

`getSigner()` becoming async is the one that changes control flow — read each call site
rather than running a find-and-replace.

## Verify

```bash
node scripts/check-dapps.js                                    # every react-jsx lesson
node scripts/check-dapps.js contracts/ch_04_dapps/le_01_…      # one lesson
```

`GREEN` means the answer passes and the starter fails. CI runs the same command on every PR
touching an exercise ([`dapps.yml`](../.github/workflows/dapps.yml)) and blocks a RED gate.

## Coverage

| Lessons | Status |
|---|---|
| ch04 le_01 – le_05 | Gradable, golden gate GREEN (31 tests) |
| ch04 le_06 – le_20 | Not yet — starter, spec, v6 migration and test still to author |
| ch05, ch06 | Planned; plain JavaScript rather than JSX, same harness |

An exercise with no published bundle is **not** gated — students self-mark it, exactly as
before. Adding a validator is always additive and never retroactively locks anyone out.
