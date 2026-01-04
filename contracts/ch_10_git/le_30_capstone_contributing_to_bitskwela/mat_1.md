# Le 30: Capstone – Contributing to Bitskwela

![Capstone](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-capstone.png)

## Scene: Full Circle

**Friday afternoon. The Barangay Hall server room. Six months after Neri's vision began.**

Maria looks at her hands. She's holding a laptop—same one from Day 1, when Git meant nothing to her.

Six months ago:

- She saved files as `barangay-blockchain-v1.sol`, `barangay-blockchain-v1-final.sol`, `barangay-blockchain-v1-FINAL-FINAL.sol`
- Version control was manual. Merging meant emailing Word documents.
- She didn't know what a pull request was.
- Her code lived on her laptop. If it crashed, the work was gone.

Today:

- She manages 50+ branches across 5 repositories
- She resolves merge conflicts in seconds, not hours
- She's reviewed 47 pull requests from Sam, Alexis, and volunteers
- She's the senior developer mentoring the new intern
- Her code is deployed to 7 barangays, backed up infinitely, history tracked perfectly

But something remarkable happened beyond all this.

Three weeks ago, Alexis found a bug in the Bitskwela learning platform itself. A typo in the Git tutorial (Le 15). She created a pull request. Bitskwela accepted it. Her name is now in the contributors list of an open-source learning platform used across Southeast Asia.

Last week, Sam noticed the database module in Bitskwela had a performance issue. He forked the repository, fixed it, submitted a PR. The Bitskwela team merged it. Now 50,000 learners use Sam's code every day.

"This is what we learned Git for," Marco says, standing beside Maria. "Not just to manage our own code. But to contribute to projects bigger than ourselves. To collaborate globally. To be part of something."

Neri enters, carrying a certificate.

"Barangay Blockchain Version 2.0 just went live in all 7 barangays," Neri says. "Payment processing is working. Voting is secure. The system handles 10,000 transactions per day."

She hands the certificate to Maria.

"You didn't just build this. You led the team that built it. Using Git. Using open source. Using global collaboration."

Neri smiles.

"Now it's your turn to teach others."

---

## The Final Challenge: Closing the Loop

This capstone brings everything together in one final way.

You've used Git to build Barangay Blockchain. You've experienced branching, merging, conflict resolution, remote collaboration, and team coordination.

Now you'll use those same skills to contribute to **Bitskwela itself**—the platform that taught you.

"You've learned Git by solving our problem," Marco says to the team. "Now we'll help other learners by solving theirs."

**What You'll Do:**

1. Fork the Bitskwela repository (public, open source)
2. Find an issue or improvement to work on
3. Create a branch and make your contribution
4. Submit a pull request with a clear description
5. Respond to code review feedback
6. Get merged into the official project

**Why This Matters:**

- It's _real_. Not a practice exercise. Real code in a real project.
- It's _open source_. You contribute to something public, global, shared.
- It's _mentorship_. You help other learners understand concepts better.
- It's _your portfolio_. Your contribution is permanent, credited, visible to other developers.
- It's _the cycle_. You learned from Bitskwela. Now you help others learn.

**Time Allotment**: 120-180 minutes (2-3 hours)  
This is not a quick exercise. Contributions take time. That's intentional.

**Topics Covered**:

- Complete contribution workflow to open source
- Forking vs cloning (the open source pattern)
- Pulling from upstream while maintaining your fork
- Clear pull request descriptions
- Responding to code review
- The ethics of open source contributions
- Building your developer reputation

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
