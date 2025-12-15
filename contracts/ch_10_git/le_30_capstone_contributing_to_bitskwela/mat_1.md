# Le 30: Capstone - Contributing to Bitskwela

![Capstone](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-capstone.png)

## Background Story

Maria looks at her journey. Two months ago, she didn't know what Git was. She thought version control meant saving files as `project_v1.docx`, `project_v2_final.docx`, `project_v2_final_FINAL.docx`.

Now she's:

- Managing branches like a pro
- Resolving merge conflicts without panic
- Contributing to open-source projects
- Helping onboard new developers
- Part of a global team spanning four time zones

This capstone project brings everything together. You'll contribute to the Bitskwela learning platform—the same platform you've been learning from.

"You've learned Git to work on the Barangay Blockchain," Marco says. "Now prove it by contributing to Bitskwela itself. Real repository. Real review. Real impact."

**Time Allotment**: 90-120 minutes

**Topics Covered**:

- Complete contribution workflow
- All Git skills combined
- Real-world open source experience
- Building your developer profile

---

## The Challenge

You will contribute to the Bitskwela repository. This is a real contribution to a real project.

**Your Mission:**

1. Fork the Bitskwela repository
2. Find an issue to work on
3. Make your contribution
4. Submit a pull request
5. Respond to feedback
6. Get your code merged

## Phase 1: Setup (15 minutes)

### Fork and Clone

```bash
# 1. Go to GitHub: github.com/bitskwela/dml-exercises
# 2. Click "Fork"
# 3. Clone YOUR fork

git clone https://github.com/YOUR_USERNAME/dml-exercises.git
cd dml-exercises

# 4. Add upstream
git remote add upstream https://github.com/bitskwela/dml-exercises.git

# 5. Verify setup
git remote -v
# origin    https://github.com/YOUR_USERNAME/dml-exercises.git
# upstream  https://github.com/bitskwela/dml-exercises.git
```

### Sync With Upstream

```bash
git fetch upstream
git checkout main
git merge upstream/main
git push origin main
```

## Phase 2: Find Your Contribution (15 minutes)

Check the repository for issues labeled:

- `good-first-issue`
- `documentation`
- `help-wanted`

**Contribution Ideas:**

| Type          | Examples                                      |
| ------------- | --------------------------------------------- |
| Documentation | Fix typos, improve explanations, add examples |
| Code          | Fix bugs, improve tests, add features         |
| Content       | Add exercises, improve lesson clarity         |
| Translation   | Add Filipino translations                     |

### Claim Your Issue

Comment on the issue:

```
I'd like to work on this issue. I'm a learner completing the Git capstone.
```

Or create your own issue if you find something to improve.

## Phase 3: Create Your Branch (5 minutes)

```bash
# Create feature branch with descriptive name
git checkout -b docs/fix-lesson-15-typos

# Or for code changes
git checkout -b fix/voting-module-validation

# Or for new content
git checkout -b feat/add-solidity-exercise-5
```

## Phase 4: Make Your Changes (30-45 minutes)

### Example: Documentation Fix

```bash
# Open the file
code contracts/ch_10_git/le_15_lesson_15/mat_1.md

# Make your changes...
# Fix typos, improve explanations, add examples

# Stage your changes
git status
git add contracts/ch_10_git/le_15_lesson_15/mat_1.md

# Commit with proper message
git commit -m "docs: fix typos in lesson 15

- Fixed 'recieve' -> 'receive'
- Clarified merge vs rebase explanation
- Added example for fetch --prune

Ref: #123"
```

### Example: Code Contribution

```bash
# Make your code changes
# ... edit files ...

# Run tests if applicable
npm test

# Stage and commit
git add .
git commit -m "fix: validate voter ID before submission

The voting module accepted malformed voter IDs.
Now validates format before processing.

- Added ID format validation
- Added error message for invalid IDs
- Added unit tests for validation

Fixes #456"
```

### Multiple Commits Are OK

```bash
git commit -m "feat: add initial exercise structure"
git commit -m "feat: add exercise instructions"
git commit -m "test: add solution verification tests"
git commit -m "docs: add exercise to index"
```

## Phase 5: Push to Your Fork (5 minutes)

```bash
# Push your branch to YOUR fork
git push origin docs/fix-lesson-15-typos
```

## Phase 6: Create Pull Request (10 minutes)

On GitHub:

1. Go to your fork
2. Click "Compare & pull request"
3. Ensure base is `bitskwela/dml-exercises:main`
4. Fill out the PR template

### PR Template

```markdown
## Summary

[What does this PR do?]

## Type of Change

- [ ] Documentation
- [ ] Bug fix
- [ ] New feature
- [ ] Content improvement

## Details

[Explain your changes in detail]

## Testing

[How did you test your changes?]

## Checklist

- [ ] I have read the CONTRIBUTING guidelines
- [ ] My code follows the project style
- [ ] I have tested my changes
- [ ] I have updated documentation if needed

## Related Issues

Closes #[issue number]

## Screenshots (if applicable)

[Add screenshots here]
```

## Phase 7: Respond to Review (15-30 minutes)

Maintainers will review your PR. Common feedback:

**"Please squash your commits"**

```bash
git rebase -i HEAD~3
# Mark commits as 'squash'
git push --force-with-lease origin docs/fix-lesson-15-typos
```

**"Please rebase on latest main"**

```bash
git fetch upstream
git rebase upstream/main
# Resolve conflicts if any
git push --force-with-lease origin docs/fix-lesson-15-typos
```

**"Please add a test"**

```bash
# Add the test
git add test/new-test.js
git commit -m "test: add verification test"
git push origin docs/fix-lesson-15-typos
```

## Phase 8: Celebrate the Merge!

When your PR is merged:

```bash
# Clean up your local repository
git checkout main
git pull upstream main
git branch -d docs/fix-lesson-15-typos
git push origin --delete docs/fix-lesson-15-typos
```

🎉 You are now an open-source contributor!

## Skills Checklist

This capstone tests every skill from the course:

| Lesson | Skill                 | Applied In          |
| ------ | --------------------- | ------------------- |
| 1-3    | Basic Git, commits    | Making changes      |
| 4-6    | Branching, merging    | Feature branch      |
| 7-9    | Conflicts, log        | Resolving issues    |
| 10-12  | Workflow, strategies  | Branch naming       |
| 13-14  | Remote, push/pull     | Fork workflow       |
| 15-17  | Fetch, PR, rejections | Creating PR         |
| 18     | Collaboration         | Team workflow       |
| 19-21  | Rebase, cherry-pick   | Cleaning history    |
| 22-23  | Stash, reflog         | Emergency recovery  |
| 24     | Workflow strategies   | Contribution flow   |
| 25     | Commit messages       | Quality commits     |
| 26     | .gitignore            | Proper exclusions   |
| 27     | Tags                  | Version awareness   |
| 28     | Hooks                 | Quality enforcement |
| 29     | Forking               | OSS contribution    |

## Evaluation Criteria

Your contribution will be evaluated on:

| Criteria        | Points | Description                |
| --------------- | ------ | -------------------------- |
| Branch naming   | 10     | Follows convention         |
| Commit messages | 20     | Clear, conventional format |
| Code quality    | 20     | Clean, tested, documented  |
| PR description  | 15     | Complete, clear            |
| Review response | 15     | Professional, prompt       |
| Actual merge    | 20     | Contribution accepted      |

## Beyond the Capstone

This is just the beginning. With these skills you can:

- Contribute to any open-source project
- Collaborate on professional teams
- Manage complex codebases
- Mentor other developers

Your Bitskwela contribution is proof you can work on real projects with real teams.

## Maria's Journey Complete

Maria submits her capstone PR. A documentation fix—small but meaningful.

Three days later, her code is merged. Her GitHub profile now shows:

```
Contributed to bitskwela/dml-exercises
```

Dev Sam in Cebu uses her improved documentation to understand a concept faster.

A new learner in Vietnam finds her explanation helpful.

"You started learning Git to work on Barangay Blockchain," Marco says. "Now your code helps developers across Asia."

Maria smiles. She remembers the chaos of `project_final_FINAL.docx`. She remembers the terror of her first merge conflict. She remembers the confusion of remote repositories.

Now she's an open-source contributor. A global developer. Beyond the islands.

**Your turn.**

## Key Takeaways

✓ Git mastery comes from real-world practice
✓ Contributing to open source builds your profile
✓ The workflow: fork → branch → commit → push → PR → review → merge
✓ Quality matters: good commits, clear PRs, professional communication
✓ Every contribution helps someone, somewhere
✓ You are now equipped to work on any project, anywhere

**Congratulations on completing the Git course! 🎉**

You've gone from "what is version control?" to contributing to real open-source projects. The Barangay Blockchain team is proud of you.

Now go build something amazing.
