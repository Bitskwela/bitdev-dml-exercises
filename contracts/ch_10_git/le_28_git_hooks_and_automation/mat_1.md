# Le 28: Git Hooks and Automation

![Git Hooks](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-hooks.png)

## Scene: Automated Quality Control

**Thursday code review. The team is reviewing Maria's new feature.**

Pull request: voter analytics module. 12 commits.

**Comment 1 from Dev Sam**: "Maria, line 234 has a typo: `voterCount` instead of `voterCound`. ESLint would have caught this."

**Comment 2 from London**: "Your commit message says 'add analytics' but it also includes changes to the payment module. Your commit message doesn't match your code."

**Comment 3 from Marco**: "I see you have `console.log('DEBUG')` in the code. This should never reach production. A linter would have warned you."

Twelve commits. Eight comments. All of them things that could have been caught by a computer, not a human.

Marco closes the PR and calls a meeting.

"We're wasting time reviewing things machines should catch," he says bluntly. "ESLint catches typos. Prettier formats code. Commit-msg hooks validate commit messages. Tests fail before you push. The computer enforces our standards so we can focus on actual design and logic."

He introduces git hooks—scripts that run automatically at critical moments.

"Before your commit is saved, the pre-commit hook runs. It checks for linting errors, missing tests, console.log statements. If anything fails, your commit is blocked. The computer says: 'Fix this before I let you commit.'"

"Then commit-msg runs. Validates your message. Follows our format."

"Finally, pre-push runs tests. If any test fails, your push is blocked. You can't push broken code."

Maria looks at the PR review comments again. With proper hooks, that PR would have:
1. Had the typo caught before commit
2. Had the console.log blocked before commit
3. Had the commit message validated before push
4. Had tests run before push

"One PR," she realizes. "Could have been perfect on first submission."

"Exactly," Marco says. "The computer does its job. We do ours. Humans review strategy. Machines enforce standards."

**This lesson teaches automation. Prevention is always better than detection.**

**Time Allotment**: 45 minutes

**Topics Covered**:

- What are Git hooks?
- Client-side vs server-side hooks
- Common hooks: pre-commit, commit-msg, pre-push
- Setting up hooks with Husky
- Enforcing code quality automatically

---

## What Are Git Hooks?

Git hooks are scripts that run automatically at specific points in the Git workflow.

```
You run:              Git hook runs:
─────────────────────────────────────────
git commit       →    pre-commit (before commit)
                 →    commit-msg (validate message)
git push         →    pre-push (before push)
git merge        →    post-merge (after merge)
```

If a hook script exits with a non-zero status, the action is blocked.

## Where Hooks Live

```bash
# Hooks are in .git/hooks/
ls .git/hooks/

# Sample hooks (not active by default)
# pre-commit.sample
# commit-msg.sample
# pre-push.sample
```

To activate: remove `.sample` and make executable:

```bash
mv .git/hooks/pre-commit.sample .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

## Client-Side Hooks

### pre-commit

Runs before the commit is created. Perfect for:

- Running linters
- Formatting code
- Checking for secrets
- Running quick tests

```bash
#!/bin/sh
# .git/hooks/pre-commit

# Run ESLint
npm run lint
if [ $? -ne 0 ]; then
  echo "❌ Linting failed. Fix errors before committing."
  exit 1
fi

echo "✅ Linting passed!"
exit 0
```

### commit-msg

Validates commit message format.

```bash
#!/bin/sh
# .git/hooks/commit-msg

commit_msg_file=$1
commit_msg=$(cat "$commit_msg_file")

# Check for conventional commit format
if ! echo "$commit_msg" | grep -qE "^(feat|fix|docs|style|refactor|test|chore)(\(.+\))?: .+"; then
  echo "❌ Commit message must follow Conventional Commits format:"
  echo "   feat: add new feature"
  echo "   fix: resolve bug"
  echo "   docs: update documentation"
  exit 1
fi

echo "✅ Commit message format valid!"
exit 0
```

### pre-push

Runs before pushing. Good for:

- Running full test suite
- Building the project
- Checking branch naming

```bash
#!/bin/sh
# .git/hooks/pre-push

# Run tests before pushing
npm test
if [ $? -ne 0 ]; then
  echo "❌ Tests failed. Fix tests before pushing."
  exit 1
fi

echo "✅ All tests passed!"
exit 0
```

## The Problem with .git/hooks

Hooks in `.git/hooks/` are:

- **Not tracked by Git** (the .git folder is excluded)
- **Not shared** with the team
- **Easy to forget** to set up

Solution: Use a tool like **Husky** to manage hooks in the repository.

## Setting Up Husky

Husky stores hooks in the repository so they're shared with the team.

### Installation

```bash
# Install Husky
npm install husky --save-dev

# Initialize Husky
npx husky init

# This creates:
# - .husky/ directory (tracked by Git)
# - .husky/pre-commit (sample hook)
```

### Creating Hooks with Husky

```bash
# Create pre-commit hook
echo "npm run lint" > .husky/pre-commit

# Create commit-msg hook
echo 'npx commitlint --edit "$1"' > .husky/commit-msg

# Create pre-push hook
echo "npm test" > .husky/pre-push
```

### Husky + lint-staged

For faster pre-commit, only lint changed files:

```bash
npm install lint-staged --save-dev
```

`package.json`:

```json
{
  "lint-staged": {
    "*.js": ["eslint --fix", "prettier --write"],
    "*.sol": ["solhint"],
    "*.md": ["prettier --write"]
  }
}
```

`.husky/pre-commit`:

```bash
#!/usr/bin/env sh
npx lint-staged
```

Now linting only runs on staged files—fast even in large projects.

## Enforcing Commit Messages

Use **commitlint** to enforce Conventional Commits:

```bash
# Install
npm install @commitlint/config-conventional @commitlint/cli --save-dev

# Create config
echo "module.exports = {extends: ['@commitlint/config-conventional']}" > commitlint.config.js
```

`.husky/commit-msg`:

```bash
#!/usr/bin/env sh
npx commitlint --edit "$1"
```

Now any commit not following the format is rejected:

```bash
git commit -m "fixed stuff"
# ❌ subject may not be empty
# ❌ type may not be empty

git commit -m "fix: resolve timezone display issue"
# ✅ Commit successful
```

## Barangay Blockchain Hook Setup

### Full Setup

```bash
# 1. Install dependencies
npm install husky lint-staged @commitlint/config-conventional @commitlint/cli --save-dev

# 2. Initialize Husky
npx husky init

# 3. Set up pre-commit (lint staged files)
echo "npx lint-staged" > .husky/pre-commit

# 4. Set up commit-msg (validate format)
echo 'npx commitlint --edit "$1"' > .husky/commit-msg

# 5. Set up pre-push (run tests)
echo "npm test" > .husky/pre-push
```

### package.json Configuration

```json
{
  "scripts": {
    "lint": "eslint . && solhint contracts/**/*.sol",
    "test": "hardhat test",
    "prepare": "husky"
  },
  "lint-staged": {
    "*.js": ["eslint --fix"],
    "*.sol": ["solhint"],
    "*.json": ["prettier --write"]
  }
}
```

## What Gets Caught Automatically

| Issue                  | Hook       | When Caught   |
| ---------------------- | ---------- | ------------- |
| Linting errors         | pre-commit | Before commit |
| Formatting issues      | pre-commit | Before commit |
| Bad commit message     | commit-msg | During commit |
| Failing tests          | pre-push   | Before push   |
| Console.log statements | pre-commit | Before commit |
| Committed secrets      | pre-commit | Before commit |

## Checking for Secrets (Security Hook)

```bash
# .husky/pre-commit with secret detection
#!/usr/bin/env sh

# Check for potential secrets
if git diff --cached | grep -iE "(password|secret|api_key|private_key).*=.*['\"][^'\"]+['\"]"; then
  echo "❌ Potential secret detected! Remove before committing."
  exit 1
fi

npx lint-staged
```

## Bypassing Hooks (Emergency Use Only)

Sometimes you need to bypass hooks:

```bash
# Skip pre-commit and commit-msg hooks
git commit --no-verify -m "emergency: production hotfix"

# Skip pre-push hook
git push --no-verify
```

**Use sparingly.** If you're bypassing hooks regularly, fix the underlying issue.

## Server-Side Hooks

These run on the Git server (GitHub, GitLab):

| Hook         | When                   | Purpose                   |
| ------------ | ---------------------- | ------------------------- |
| pre-receive  | Before accepting push  | Reject non-compliant code |
| update       | Per-branch during push | Branch-specific rules     |
| post-receive | After push accepted    | Trigger deployments       |

Most teams use CI/CD instead of server-side hooks, but the concept is similar.

## Why This Matters for Global Deployment

The Barangay Blockchain team is distributed:

- Maria in Manila
- Dev Sam in Cebu
- London developers
- Singapore contractors

Without hooks:

- Different linting on different machines
- Inconsistent commit messages
- Broken code reaching the repository
- Time wasted on preventable issues

With hooks:

- Same standards enforced everywhere
- Consistent commit history
- Broken code caught locally
- Code review focuses on logic, not style

"Hooks are automated team standards," Marco explains. "No matter who commits or where, the rules are enforced."

## Key Takeaways

✓ Git hooks run scripts at key workflow points
✓ pre-commit: lint and format before committing
✓ commit-msg: enforce message format
✓ pre-push: run tests before pushing
✓ Use Husky to share hooks with the team
✓ Use lint-staged to lint only changed files
✓ Hooks prevent bad code from reaching the repository
✓ `--no-verify` bypasses hooks (use sparingly)

**Next Lesson:** Forking and contributing to open source—collaborating beyond your team.
