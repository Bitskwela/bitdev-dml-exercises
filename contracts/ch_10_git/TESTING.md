# Git Chapter — Answer Validation Contract

Git activities are validated by **replay + assert state**: run the canonical
solution in a throwaway repository, then assert the resulting repo state. This
is the Git analogue of the C++ chapter's compile-run-diff and is easy to wire
into `blockskwela-rs`.

## Files per lesson

| File | Role | Required |
|------|------|----------|
| `act_1.md` | Hands-on lab brief (objectives + guided steps + how it's graded) | yes |
| `act_1.answer.sh` | Canonical **runnable** solution. Runs in an empty working dir and performs the lesson's full git workflow. Remote lessons create a local **bare repo** as `origin`. | yes |
| `act_1.expect.sh` | Grader. Runs **after** the solution in the same dir; asserts repo state (branches, commit count, files, tags, stashes, remotes...). Exit `0` = PASS. | yes |
| `act_1.answer.md` | Human-readable answer: the solution script + step explanation | yes |
| `mat_1.md` | Lesson material (+ Common Pitfalls) | yes |
| `meta.md` | Front-matter | yes |

## How a submission is graded

```
# in a fresh temp dir, under an isolated HOME with a fixed identity:
bash act_1.answer.sh      # (the student's commands, or the reference solution)
bash act_1.expect.sh      # exit 0 = PASS, non-zero = FAIL
```

`scripts/check-git.sh` does exactly this for the whole chapter:

```bash
bash scripts/check-git.sh                 # defaults to contracts/ch_10_git
```

## Determinism (critical)

The harness pins everything that would otherwise make Git non-reproducible, so
results never depend on the runner's machine or git version:

- isolated `HOME` with a fixed `user.name`/`user.email`
- fixed `GIT_AUTHOR_DATE` / `GIT_COMMITTER_DATE`
- `init.defaultBranch=main`, pager disabled, `pull.rebase=false`
- `protocol.file.allow=always` so **local bare repos** can act as remotes

Assertions therefore check **structural facts** (branch exists, commit count,
file presence/content, tag type, merge-commit parent count, stash empty,
`origin/main` in sync) — **never** commit hashes, which are non-deterministic.

## Remote lessons without GitHub

Lessons covering push/pull/fetch/PRs/forks create a local `--bare` repository as
`origin` (and a second bare repo as a "fork" for the forking lesson). The full
workflow runs offline and deterministically — no network, no GitHub account.

## Wiring into blockskwela-rs (future)

A `git.rs` grader service would:

1. create a temp dir + isolated `HOME` with the deterministic config above,
2. write the student's submitted commands to `act_1.answer.sh` (or accept the
   repo state they built),
3. run it, then run the lesson's stored `act_1.expect.sh`,
4. return the exit code (0 = pass) and captured stderr/stdout as feedback.

Because grading is "run a shell script, check exit code," it does not need a
language-specific compiler the way Solidity/C++ do — just a sandboxed shell with
`git` available.
