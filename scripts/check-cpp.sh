#!/usr/bin/env bash
# Compile-and-run validation for every C++ activity in the course chapters.
# Runnable locally and in CI:  bash scripts/check-cpp.sh
#
# Per-lesson validation contract (see contracts/ch_08_cpp/TESTING.md):
#   act_1.answer.cpp   - full solution (a complete program with main())
#   act_1.cpp          - student starter (must still COMPILE with its TODOs)
#   act_1.input.txt    - OPTIONAL stdin fed to the program (interactive lessons)
#   act_1.expected.txt - golden stdout the answer must produce (the oracle)
#
# A lesson PASSES when:
#   1. act_1.answer.cpp compiles cleanly, AND
#   2. running it (with act_1.input.txt on stdin if present) yields stdout that
#      matches act_1.expected.txt exactly (after trailing-whitespace trim), AND
#   3. act_1.cpp (starter) also compiles.
set -uo pipefail

STD=c++17
workdir="$(mktemp -d)"
trap 'rm -rf "$workdir"' EXIT

ans_total=0; ans_ok=0
start_total=0; start_ok=0
failures=()

norm() { sed -e 's/[[:space:]]*$//' "$1"; }   # strip trailing whitespace per line

check_lesson() {                       # $1 = lesson dir
  local dir="$1" rel
  rel="$(basename "$dir")"
  local ans="$dir/act_1.answer.cpp"
  local starter="$dir/act_1.cpp"
  local expected="$dir/act_1.expected.txt"
  local input="$dir/act_1.input.txt"

  # 1) answer compiles
  ans_total=$((ans_total+1))
  if ! g++ -std="$STD" -O2 -Wall -o "$workdir/ans" "$ans" 2> "$workdir/cerr"; then
    echo "FAIL (compile) $rel/act_1.answer.cpp"; sed 's/^/    /' "$workdir/cerr"
    failures+=("$rel: answer compile"); 
  else
    # 2) run + diff against golden output (if an expected file exists)
    if [[ -f "$expected" ]]; then
      local runin="/dev/null"
      [[ -f "$input" ]] && runin="$(cd "$(dirname "$input")" && pwd)/$(basename "$input")"
      # Run in an isolated cwd so file-writing lessons don't litter the repo.
      ( cd "$workdir" && ./ans < "$runin" ) > "$workdir/out" 2>&1
      if diff <(norm "$workdir/out") <(norm "$expected") > "$workdir/diff" 2>&1; then
        ans_ok=$((ans_ok+1)); echo "ok             $rel"
      else
        echo "FAIL (output)  $rel"; sed 's/^/    /' "$workdir/diff" | head -30
        failures+=("$rel: output mismatch")
      fi
    else
      echo "WARN (no expected) $rel — answer compiles but no act_1.expected.txt"
      ans_ok=$((ans_ok+1))
    fi
  fi

  # 3) starter compiles
  if [[ -f "$starter" ]]; then
    start_total=$((start_total+1))
    if g++ -std="$STD" -O0 -o "$workdir/st" "$starter" 2> "$workdir/serr"; then
      start_ok=$((start_ok+1))
    else
      echo "FAIL (compile) $rel/act_1.cpp (starter)"; sed 's/^/    /' "$workdir/serr"
      failures+=("$rel: starter compile")
    fi
  fi
}

CHAPTER="${1:-contracts/ch_08_cpp}"
echo "== C++ lessons in $CHAPTER =="
while IFS= read -r d; do
  check_lesson "$d"
done < <(find "$CHAPTER" -maxdepth 1 -type d -name 'le_*' | sort)

echo
echo "answers:  ${ans_ok}/${ans_total} compiled & matched"
echo "starters: ${start_ok}/${start_total} compiled"
if (( ${#failures[@]} )); then
  echo; echo "FAILURES:"; printf '  - %s\n' "${failures[@]}"; exit 1
fi
echo "ALL GREEN"
