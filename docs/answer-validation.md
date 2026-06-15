# Solidity Answer Validation — Authoring Guide (content repo)

This repo is the **source of truth** for the hidden test suites that grade student
Solidity submissions. Each Web3 exercise (currently chapter 1) ships a Foundry
test that the `blockskwela-rs` server runs against the student's contract on an
ephemeral EVM, returning a per-test pass/fail report to the frontend.

This guide is for **content authors**: how to add or change a test, verify it, and
publish it. You do not need to touch the Rust server or the frontend.

> Server internals: [`blockskwela-rs/docs/answer-validation.md`](../../blockskwela-rs/docs/answer-validation.md)
> Frontend flow: [`blockskwela-fe/docs/answer-validation.md`](../../docs/answer-validation.md)

---

## Per-exercise files

A gradable exercise directory (e.g. `contracts/ch_01_basic_solidity/le_01_waking_up_to_chaos/`)
contains, in addition to the existing narrative/skeleton/answer assets:

| File | Role |
|---|---|
| `act_1.sol` | Starter the student edits (already existed) |
| `act_1.answer.sol` | Instructor reference answer — **source of truth** for names/signatures (already existed) |
| `spec.json` | **NEW** — machine-readable grading spec |
| `act_1.t.sol` | **NEW** — the hidden Foundry test suite |
| `MathLibrary.sol`, … | Optional fixed helper sources the student imports (see `extra_sources`) |

The `act_1.t.sol` is **hidden** from students — it lives here and in R2, never in
the frontend. Students only see the pass/fail report.

### `spec.json`

```jsonc
{
  "permaname": "waking-up-to-chaos",   // MUST equal meta.md's permaname (and slug)
  "contract": "PalengkePay",           // the contract name declared in act_1.answer.sol
  "source_file": "PalengkePay.sol",    // filename the student's source is written to under src/
  "solc": "0.8.26",
  "via_ir": true,
  "optimizer": true,
  "allowed_imports": [],               // import remappings (see below)
  "extra_sources": [],                 // fixed helper files (see below)
  "concepts": ["state-variables"],     // metadata (free-form, not graded)
  "difficulty": "beginner",
  "est_minutes": 15,
  "prerequisites": []
}
```

The grader pins the compiler from `spec.json` (`solc`, `via_ir`, `optimizer`).
Keep `permaname` identical to `meta.md`'s `permaname` — the frontend sends
`course_body.slug` (which equals the permaname) to look up the bundle.

### `act_1.t.sol` conventions

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Test} from "forge-std/Test.sol";
import {PalengkePay} from "../src/PalengkePay.sol";   // <-- ../src/, NOT act_1.answer.sol

contract PalengkePayTest is Test {
    PalengkePay internal p;
    function setUp() public { p = new PalengkePay(); }

    function test_recordPayment_storesPayer() public {
        p.recordPayment("Tindera Maria", 500, "Juan Dela Cruz");
        assertEq(p.payerName(), "Juan Dela Cruz", "payerName not stored");
    }
}
```

Rules:
- Import the contract from **`../src/<source_file>`** — the grader assembles the
  student's submission at `src/<source_file>`, the test at `test/Exercise.t.sol`.
- Port the behavior from the original `act_1.test.js`, then **expand**: initial
  state, accumulation, revert conditions, events, access control.
- Cheatcodes: `vm.deal` (fund before sending ETH), `vm.prank`/`vm.startPrank`
  (control `msg.sender`), `vm.expectRevert(bytes("msg"))` (requires),
  `vm.expectRevert(Type.Error.selector)` (custom errors), `vm.warp`/`vm.roll`
  (time), `vm.expectEmit` (events).
- **The golden rule:** the test must PASS against `act_1.answer.sol` and FAIL
  against the starter `act_1.sol`. Assert real behavior, not just that functions
  exist.

### `allowed_imports` (OpenZeppelin, etc.)

Each entry is a remapping `PREFIX=RELPATH`, where `RELPATH` resolves under the
grader's shared lib dir. For OpenZeppelin:

```json
"allowed_imports": ["@openzeppelin/contracts/=@openzeppelin/contracts/"]
```

The server image vendors OpenZeppelin (currently v5.3.0) at that path. To use a
new OZ path, no change is needed beyond the remapping; to bump the OZ version,
update the `blockskwela-rs` Dockerfile.

### `extra_sources` (fixed helper files)

When the student's contract imports a **provided** file (e.g. `import "./MathLibrary.sol";`),
list it so the grader writes it next to the student source under `src/`:

```json
"extra_sources": ["MathLibrary.sol"]
```

Put the file itself in the exercise directory; the publish step uploads it with
the bundle.

---

## Verify and publish

The tooling lives in `blockskwela-rs` (run from a checkout of that repo, with
`.env` for R2 and `GRADER_LIB_DIR` pointing at a dir containing `forge-std/`
[and `@openzeppelin/contracts/` for OZ exercises]).

```bash
LESSON=../bitdev-dml-exercises/contracts/ch_01_basic_solidity/le_01_waking_up_to_chaos

# 1. Verify ONLY (answer passes, starter fails). Exit 0 = GREEN.
GRADER_LIB_DIR=~/.grader-lib cargo run --example golden_gate -- "$LESSON"

# 2. Publish to R2. This RE-RUNS the golden gate first and refuses to publish if RED.
cargo run --example publish_bundle -- "$LESSON"
```

A content/test change needs **no server or frontend redeploy** — the running
server reads the fresh bundle from R2 on the next grade.

---

## CI (automatic)

[`.github/workflows/validate-and-publish.yml`](../.github/workflows/validate-and-publish.yml):

- **Pull request** → golden gate on changed lessons (**blocking** — a RED gate
  fails the check).
- **Push to `main`** → golden gate **then** publish changed lessons to R2.
- **Manual run** (`workflow_dispatch`, `all: true`) → verify/publish every lesson.

Required repo secrets: `GRADER_REPO_TOKEN` (read access to `blockskwela-rs`),
`R2_ACCOUNT_ID`, `R2_BUCKET_NAME`, `R2_ACCESS_KEY_ID`, `R2_SECRET_ACCESS_KEY`.

So in normal operation, content authors just open a PR; merging it re-publishes
the affected bundles automatically — no `cargo` by hand.

---

## Coverage

Chapter 1 (`ch_01_basic_solidity`) — all 30 exercises are gradable and pass the
golden gate. Chapters 2–4 use the same harness and are planned follow-ons.
