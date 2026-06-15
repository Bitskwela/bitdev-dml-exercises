# C++ Chapter — Answer Validation Contract

This chapter is validated by **compile + run + compare-output**, the same shape
as the Rust chapter's `scripts/check-rust.sh`. It is intentionally simple so it
can be wired into `blockskwela-rs` (or any grader) without bespoke per-lesson
code.

## Files per lesson

| File | Role | Required |
|------|------|----------|
| `act_1.cpp` | Student starter (has `// TODO` gaps, but must still compile) | yes |
| `act_1.answer.cpp` | Reference solution: a complete program with `main()` | yes |
| `act_1.input.txt` | stdin piped to the program (interactive lessons only) | only if the program reads `cin`/`getline` |
| `act_1.expected.txt` | Golden stdout the answer must produce — the oracle | yes |
| `act_1.output.txt` | Human-readable copy of the golden output (same content) | yes |
| `act_1.test.cpp` | Self-contained validator: embeds the expected output, reads a candidate's stdout from **its own stdin**, exits `0`=PASS / `1`=FAIL | yes |
| `mat_1.md` | Lesson material | yes |
| `act_1.md` | Activity brief | yes |
| `meta.md` | Front-matter (title, type, slug) | yes |

## How a submission is graded

```
g++ -std=c++17 -O2 student.cpp -o prog        # 1. compile (fail => compile error)
./prog < act_1.input.txt > out.txt            # 2. run (input.txt optional)
g++ -std=c++17 -O2 act_1.test.cpp -o validator
./validator < out.txt                         # 3. exit 0 = PASS, 1 = FAIL
```

The validator compares line-by-line, ignoring leading/trailing blank lines and
trailing whitespace, so cosmetic spacing never causes a false negative.

### Equivalent shell check (no separate validator binary)

`scripts/check-cpp.sh` does the same thing by diffing program stdout against
`act_1.expected.txt`. Run the whole chapter locally with:

```bash
bash scripts/check-cpp.sh                 # defaults to contracts/ch_08_cpp
```

## Wiring into blockskwela-rs (future)

`bslib/services/compilers/` currently has `solidity.rs` only. To support C++,
add a `cpp.rs` service that:

1. writes the submission to a temp dir,
2. shells out to `g++ -std=c++17 -O2` (or clang++) to compile — capture stderr
   as the "compile error" message shown to the student,
3. runs the binary with a per-lesson stdin fixture (the `act_1.input.txt`
   content, stored alongside the lesson or in the DB),
4. compares stdout to the stored golden output (the `act_1.expected.txt`
   content) using the same trim rules as `act_1.test.cpp`.

Register it in `CompilerLanguage` (e.g. `#[serde(rename = "cpp")] Cpp`) in
`bslib/routes/compiler.rs`, mirroring the existing `Sol` arm.

## Regenerating golden output

If an answer's output legitimately changes, recompute the goldens:

```bash
# from contracts/ch_08_cpp/<lesson>/
g++ -std=c++17 -O2 act_1.answer.cpp -o /tmp/a
/tmp/a < act_1.input.txt > act_1.expected.txt   # omit redirect input if none
```

Then re-embed it into `act_1.test.cpp` and copy to `act_1.output.txt`.
