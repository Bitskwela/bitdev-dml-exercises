# Le 29: Forking and Open Source Contribution

![Open Source Contribution](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-opensource.png)

## Scene: Beyond the Barangay

**Two months later. Barangay Blockchain v1.0 has shipped successfully.**

Maria checks her email during morning coffee.

"Dear Barangay Blockchain Team: We're impressed with your voting module implementation. We'd like to invite you to contribute it to the OpenGov Governance Framework, used by 150+ municipalities across Southeast Asia."

Her hands shake.

She runs to find Marco, Dev Sam, and Alexis (who's visiting from Mexico City). "They want us. Our code. In an open-source project with hundreds of developers."

Marco reads the email. "This is the moment. You've gone from 'local team shipping software' to 'contributors to a global project.'"

"But it's different, right?" Maria asks nervously. "We can't just merge. They own the repository."

"Exactly," Marco confirms. "You fork. You contribute. Their maintainers review. You iterate. Then they decide whether to include your work. This is open-source development."

"People from Thailand, Indonesia, Vietnam will review my code?"

"Yes. And you'll learn from their feedback. You'll read code from developers in seven countries. You'll grow beyond what we can teach you locally."

Alexis leans forward. "And your voting module—it's not just for your barangay anymore. It could help villages that have been struggling to conduct fair elections. Your code becomes infrastructure."

Maria looks at her laptop. The same keyboard where she created her first Git commits. The same screen where she learned branches, merges, pull requests. The same place where she solved merge conflicts at 2 AM and celebrated deployment victories.

Now her code is leaving that laptop. Traveling to a global project. Being reviewed by strangers. Potentially improving thousands of lives.

"Let's do it," she says.

**This lesson teaches that Git isn't just a tool for teams. It's a tool for the world. This is open-source contribution.**

**Time Allotment**: 50 minutes

**Topics Covered**:

- What is forking?
- The open source contribution workflow
- Managing upstream vs origin
- Keeping your fork updated
- Creating quality pull requests
- Responding to maintainer feedback

---

## What is Forking?

When you fork a repository, you create your own copy on GitHub.

```
Official Repository (You can't push here)
github.com/opengov-framework/governance-tools

        ↓ Fork (Create your copy)

Your Fork (You can push here)
github.com/mariadev/governance-tools
```

A fork is:

- Your complete copy of the project
- Independent from the original
- Under your control (you can push, create branches)
- Linked to the original (for pull requests)

## Step 1: Fork the Repository

On GitHub:

1. Go to the official repository
2. Click "Fork" button (top right)
3. Choose your account
4. GitHub creates your copy

Now you have `github.com/yourname/governance-tools`.

## Step 2: Clone Your Fork

```bash
# Clone YOUR fork (not the official repo)
git clone https://github.com/mariadev/governance-tools.git
cd governance-tools

# Check your remotes
git remote -v
# origin    https://github.com/mariadev/governance-tools.git (fetch)
# origin    https://github.com/mariadev/governance-tools.git (push)
```

## Step 3: Add Upstream Remote

You need to track the official repository to get updates:

```bash
# Add the official repo as "upstream"
git remote add upstream https://github.com/opengov-framework/governance-tools.git

# Verify remotes
git remote -v
# origin    https://github.com/mariadev/governance-tools.git (fetch)
# origin    https://github.com/mariadev/governance-tools.git (push)
# upstream  https://github.com/opengov-framework/governance-tools.git (fetch)
# upstream  https://github.com/opengov-framework/governance-tools.git (push)
```

Now you have:

- `origin`: Your fork (you push here)
- `upstream`: Official repo (you pull updates from here)

## Step 4: Create a Feature Branch

Never work directly on main. Create a branch for your contribution:

```bash
# Ensure you're on main and up to date
git checkout main
git pull upstream main

# Create feature branch
git checkout -b feature/barangay-voting-module

# Now make your changes...
```

## Step 5: Make Your Changes

```bash
# Add the Barangay voting module
cp -r ~/barangay-blockchain/voting-module ./modules/

# Stage and commit
git add modules/voting-module/
git commit -m "feat: add Filipino barangay voting module

This module implements secure voting for Philippine barangay
elections with features:
- Voter registration validation
- Vote encryption
- Result verification

Tested in San Juan barangay elections (2024)
Ref: barangay-blockchain/barangay-blockchain#45"
```

## Step 6: Push to Your Fork

```bash
# Push to YOUR fork (origin), not upstream
git push origin feature/barangay-voting-module
```

## Step 7: Create Pull Request

On GitHub:

1. Go to your fork
2. Click "Compare & pull request"
3. Base: `opengov-framework/governance-tools:main`
4. Compare: `mariadev/governance-tools:feature/barangay-voting-module`
5. Write a clear description
6. Submit

### Writing a Good PR Description

```markdown
## Summary

Adds a voting module based on the Barangay Blockchain project
used in Philippine local elections.

## Features

- Voter registration with ID validation
- Secret ballot implementation
- Transparent vote counting
- Multi-language support (Filipino, English)

## Testing

- Unit tests: `npm test modules/voting-module`
- Used in 5 barangay elections
- Processed 10,000+ votes

## Screenshots

[Images of the voting interface]

## Related Issues

Closes #234 (Need SEA voting module)
```

## Keeping Your Fork Updated

The official repository gets updates. Keep your fork current:

```bash
# Fetch updates from official repo
git fetch upstream

# Update your main branch
git checkout main
git merge upstream/main

# Push to your fork
git push origin main
```

### Before Starting New Work

Always sync first:

```bash
git checkout main
git pull upstream main
git push origin main
git checkout -b feature/new-contribution
```

## Responding to Feedback

Maintainers will review your PR. They might request changes:

```markdown
Maintainer: "Could you add documentation for the voter
registration function?"
```

Make the changes:

```bash
# On your feature branch
git checkout feature/barangay-voting-module

# Make requested changes
# ... edit files ...

# Commit the changes
git commit -m "docs: add voter registration documentation"

# Push to your fork
git push origin feature/barangay-voting-module
```

The pull request updates automatically. No need to create a new one.

## Best Practices for Contributors

### Before You Start

- Read CONTRIBUTING.md
- Check existing issues and PRs
- Ask before big changes
- Follow the project's code style

### Your Commits

- Small, focused commits
- Clear commit messages
- One logical change per commit

### Your PR

- Clear title and description
- Reference related issues
- Include tests if applicable
- Be patient with reviews

### Communication

- Be respectful and professional
- Accept feedback gracefully
- Ask questions if unclear
- Thank maintainers for their time

## Common Contribution Workflow

```bash
# 1. Sync your fork
git checkout main
git pull upstream main
git push origin main

# 2. Create feature branch
git checkout -b feature/my-contribution

# 3. Make changes, commit
git add .
git commit -m "feat: add new feature"

# 4. Push to your fork
git push origin feature/my-contribution

# 5. Create PR on GitHub

# 6. Address feedback (if any)
git commit -m "refactor: address review feedback"
git push origin feature/my-contribution

# 7. PR gets merged by maintainer

# 8. Clean up
git checkout main
git pull upstream main
git branch -d feature/my-contribution
```

## Why This Matters for Global Deployment

Contributing to open source:

- **Visibility**: Your work reaches developers worldwide
- **Growth**: Learn from experienced maintainers
- **Impact**: Your code helps projects beyond your team
- **Career**: Open source contributions are valued by employers

The Barangay Blockchain started in Manila. Now it could help communities in Jakarta, Bangkok, Ho Chi Minh City—anywhere that needs transparent local governance.

"This is what 'Beyond the Islands' really means," Marco tells Maria. "Our code travels further than we ever could."

## Key Takeaways

✓ Fork creates your copy of someone else's repository
✓ `origin` = your fork (push here)
✓ `upstream` = official repo (pull updates from here)
✓ Always work on branches, never directly on main
✓ Keep your fork synced with upstream
✓ Write clear PR descriptions
✓ Be patient and professional with maintainers
✓ Your local project can have global impact

**Next Lesson:** Capstone project—putting it all together!
