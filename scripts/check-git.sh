#!/usr/bin/env bash
# Replay-and-assert validation for every Git activity in the course chapters.
# Runnable locally and in CI:  bash scripts/check-git.sh
#
# Per-lesson validation contract (see contracts/ch_10_git/TESTING.md):
#   act_1.answer.sh  - canonical runnable solution. Runs in an empty working
#                      dir and performs the lesson's git workflow end to end.
#                      (Remote lessons create a local bare repo as 'origin'.)
#   act_1.expect.sh  - grader. Runs AFTER the solution in the same dir and
#                      asserts repo state (branches, commit count, files,
#                      tags, stashes...). Exits 0 = PASS, non-zero = FAIL.
#
# Determinism: each lesson runs under an isolated HOME with a fixed identity,
# fixed commit dates, main as the default branch, and pager disabled — so
# results never depend on the runner's global git config or git version.
set -uo pipefail

total=0; ok=0
failures=()

run_lesson() {                      # $1 = lesson dir
  local dir="$1" rel
  rel="$(basename "$dir")"
  [[ -f "$dir/act_1.answer.sh" ]] || return 0      # only lessons with a runnable solution
  total=$((total+1))

  local sandbox; sandbox="$(mktemp -d)"
  local home="$sandbox/home"; local work="$sandbox/work"
  mkdir -p "$home" "$work"

  # --- deterministic environment ---
  export HOME="$home"
  export GIT_CONFIG_NOSYSTEM=1
  export GIT_AUTHOR_NAME="Maria Santos"  GIT_AUTHOR_EMAIL="maria@barangaymarket.ph"
  export GIT_COMMITTER_NAME="Maria Santos" GIT_COMMITTER_EMAIL="maria@barangaymarket.ph"
  export GIT_AUTHOR_DATE="2026-01-03T09:00:00 +0800"
  export GIT_COMMITTER_DATE="2026-01-03T09:00:00 +0800"
  git config --global init.defaultBranch main
  git config --global user.name "Maria Santos"
  git config --global user.email "maria@barangaymarket.ph"
  git config --global advice.detachedHead false
  git config --global core.pager cat
  git config --global pull.rebase false
  git config --global protocol.file.allow always   # allow local bare-repo remotes

  cp "$dir/act_1.answer.sh" "$work/act_1.answer.sh"
  [[ -f "$dir/act_1.expect.sh" ]] && cp "$dir/act_1.expect.sh" "$work/act_1.expect.sh"

  local rc=0
  ( cd "$work" && bash act_1.answer.sh ) > "$sandbox/out" 2>&1 || rc=$?
  if (( rc != 0 )); then
    echo "FAIL (solution) $rel"; sed 's/^/    /' "$sandbox/out" | tail -15
    failures+=("$rel: solution exited $rc"); rm -rf "$sandbox"; return 0
  fi

  if [[ -f "$work/act_1.expect.sh" ]]; then
    if ( cd "$work" && bash act_1.expect.sh ) > "$sandbox/eout" 2>&1; then
      ok=$((ok+1)); echo "ok             $rel"
    else
      echo "FAIL (assert)   $rel"; sed 's/^/    /' "$sandbox/eout" | tail -20
      failures+=("$rel: assertion failed")
    fi
  else
    echo "WARN (no expect) $rel — solution ran but no act_1.expect.sh"
    ok=$((ok+1))
  fi
  rm -rf "$sandbox"
}

CHAPTER="${1:-contracts/ch_10_git}"
echo "== Git lessons in $CHAPTER =="
while IFS= read -r d; do
  run_lesson "$d"
done < <(find "$CHAPTER" -maxdepth 1 -type d -name 'le_*' | sort)

echo
echo "lessons: ${ok}/${total} solutions ran & assertions passed"
if (( ${#failures[@]} )); then
  echo; echo "FAILURES:"; printf '  - %s\n' "${failures[@]}"; exit 1
fi
echo "ALL GREEN"
