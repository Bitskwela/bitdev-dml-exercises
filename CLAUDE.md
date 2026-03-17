# Bitskwela x Bitdev DML Exercises

## Project Overview

Educational curriculum repository with **305 lessons across 12 chapters** covering blockchain, web development, systems programming, and data science. All lessons use Filipino-themed storytelling (barangays, palengke, jeepney, sari-sari stores) with characters like Neri, Odessa, and Det.

**This is a content/curriculum repo, not a production application.** The primary output is lesson materials, exercises, and tests — not deployable software.

## Tech Stack

- **Hardhat 2.23.0** — Smart contract framework (Solidity 0.8.27)
- **OpenZeppelin 5.3.0** — Smart contract libraries
- **Chai** — Assertion library (Solidity tests via Hardhat)
- **Jest 30.2.0** — JavaScript lesson tests
- **Languages:** Solidity, JavaScript, C++, Python, Move

## Repository Structure

```
contracts/           # All lesson content (NOT just Solidity)
  ch_01_basic_solidity/        # 30 lessons
  ch_02_solidity_side_quests/  # 7 lessons
  ch_03_mini_projects/         # 5 lessons
  ch_04_dapps/                 # 20 lessons
  ch_05_javascript/            # 20 lessons
  ch_06_javascript_mini_projects/ # 5 lessons
  ch_07_html_css_js_python/    # 47 lessons
  ch_08_cpp/                   # 31 lessons
  ch_09_python/                # 30 lessons
  ch_10_git/                   # 30 lessons
  ch_11_deploying_on_vercel/   # 30 lessons
  ch_12_move_language/         # 50 lessons
quizzes/answers/     # Quiz answer keys (1 per chapter)
artifacts/           # Hardhat compiled output (gitignored)
cache/               # Hardhat cache (gitignored)
ignition/modules/    # Hardhat Ignition deployment (Lock.js example)
test/                # Empty — tests live inside each lesson folder
```

## Lesson File Conventions

Every lesson lives in `contracts/ch_NN_topic/le_NN_name/` with these files:

| File | Purpose |
|------|---------|
| `meta.md` | YAML frontmatter: title, description, date, tags, type, permaname, slug |
| `mat_1.md` | Educational material / reading content |
| `act_1.{sol,js,cpp,move}` | Student starter code |
| `act_1.answer.{sol,js,cpp,move}` | Instructor solution |
| `act_1.test.{js,cpp}` | Test file for validation |
| `details.md` | Optional detailed explanation |
| `quiz.md` | Optional self-assessment |
| `1.0 - COVER.png` | Optional lesson cover image |

## Naming Conventions

- **Chapters:** `ch_NN_snake_case` (e.g., `ch_01_basic_solidity`)
- **Lessons:** `le_NN_snake_case` (e.g., `le_01_waking_up_to_chaos`)
- **Activity files:** `act_N.{ext}`, answers: `act_N.answer.{ext}`, tests: `act_N.test.{ext}`
- **Materials:** `mat_N.md`
- **Metadata:** `meta.md` with YAML frontmatter

### Language-specific style

- **Solidity:** PascalCase contracts, camelCase functions, UPPER_SNAKE_CASE constants
- **JavaScript:** ES6+, const/let, arrow functions
- **C++:** snake_case functions, PascalCase classes
- **Move:** PascalCase modules, camelCase functions

## Test Patterns

Tests are **decentralized** — each lesson has its own test file, not a central test suite.

### Solidity tests (Hardhat + Chai)
```javascript
const { expect } = require("chai");
describe("ContractName", function () {
  it("should do X", async function () {
    const C = await ethers.getContractFactory("ContractName");
    const c = await C.deploy();
    expect(await c.someValue()).to.equal(expected);
  });
});
```

### JavaScript tests (Jest)
```javascript
const { validateSolution } = require("../test-helper");
describe("lesson_name", () => {
  test("should do X", () => { /* ... */ });
});
```

### C++ tests
Standalone files with `main()`, string-based output validation, exit code pass/fail.

## Running Tests

```bash
npm test              # Hardhat Solidity tests
npx hardhat test      # Same, explicit
npx jest              # JavaScript lesson tests
```

## Commands to Know

```bash
npx hardhat compile   # Compile all Solidity contracts
npx hardhat test      # Run Solidity tests
npx hardhat clean     # Clear artifacts/cache
```

## Important Notes

- The `contracts/` folder contains ALL chapters, not just Solidity — don't assume `.sol` only
- Quiz answer filenames have a typo: `ch_NN_quiz-anwers.md` (missing 's') — keep consistent
- `.github/` is gitignored; only contains `copilot-instructions.md`
- `exercises/` folder is gitignored
- No CI/CD, linting, or formatting configs exist
- `meta.md` frontmatter fields: `title`, `description`, `date`, `tags`, `type` (ActivityExercise | NormalExercise), `permaname` (immutable), `slug` (can change)
