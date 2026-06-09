#!/usr/bin/env bash
# Compile-check every Rust activity file in the course chapters.
# Runnable locally and used by CI (.github/workflows/rust.yml):
#   bash scripts/check-rust.sh
#
# Each lesson ships standalone single-file Rust programs (no Cargo project):
#   act_1.rs         - student starter (TODOs via todo!(), still compiles)
#   act_1.answer.rs  - full solution
# rustc derives the crate name from the filename, and "act_1.answer" is an
# invalid crate name (the dot), so we always pass an explicit --crate-name.
set -uo pipefail

EDITION=2021
workdir="$(mktemp -d)"
trap 'rm -rf "$workdir"' EXIT

answers_total=0; answers_ok=0
starters_total=0; starters_ok=0
failures=()

crate_name() { echo "$1" | sed -e 's/[^a-zA-Z0-9]/_/g'; }

check_file() {                       # $1 = path
  local file="$1"
  local rel="${file#./}"
  local crate; crate="$(crate_name "$rel")"

  if ! rustc --edition "$EDITION" --crate-name "$crate" "$file" -o "$workdir/$crate" 2> "$workdir/err"; then
    echo "FAIL (compile) $rel"; sed 's/^/    /' "$workdir/err"; failures+=("$rel"); return 1
  fi

  # Files carrying unit tests (e.g. Testing, Mini Project) also run them.
  if grep -q '#\[test\]' "$file"; then
    if ! rustc --edition "$EDITION" --test --crate-name "${crate}_t" "$file" -o "$workdir/${crate}_t" 2> "$workdir/err" \
       || ! "$workdir/${crate}_t" --quiet > "$workdir/testout" 2>&1; then
      echo "FAIL (test)    $rel"
      cat "$workdir/err" "$workdir/testout" 2>/dev/null | sed 's/^/    /'
      failures+=("$rel"); return 1
    fi
  fi

  echo "ok             $rel"; return 0
}

echo "== Rust answer files =="
while IFS= read -r f; do
  answers_total=$((answers_total+1))
  check_file "$f" && answers_ok=$((answers_ok+1))
done < <(find contracts -name 'act_1.answer.rs' | sort)

echo
echo "== Rust starter files =="
while IFS= read -r f; do
  starters_total=$((starters_total+1))
  check_file "$f" && starters_ok=$((starters_ok+1))
done < <(find contracts -name 'act_1.rs' | sort)

echo
echo "answers:  ${answers_ok}/${answers_total} compiled"
echo "starters: ${starters_ok}/${starters_total} compiled"

if [ "${#failures[@]}" -ne 0 ]; then
  echo "FAILED: ${failures[*]}"
  exit 1
fi
echo "All Rust files compile (edition ${EDITION}); all unit tests pass."
