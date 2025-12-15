# Le 25: Commit Message Best Practices

![Commit Messages](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-commit-messages.png)

## Background Story

It's 2 AM in Singapore. The production server is down. A voting transaction failed, and the system is locked.

The Singapore developer opens the git log to find when the problem was introduced:

```bash
git log --oneline -10
# a1b2c3d fix
# c4d5e6f update
# g7h8i9j stuff
# k1l2m3n changes
# o4p5q6r wip
# s7t8u9v more fixes
# w1x2y3z asdf
```

"What is 'stuff'? What did 'changes' change? What was 'fix' fixing?" The developer has no idea. He has to read every commit's diff to understand what happened. An hour later, he finds the bug—introduced in "asdf."

Next day, team meeting. Marco displays the log on the screen.

"This is why commit messages matter," he says. "When it's 2 AM and production is down, 'fix stuff' doesn't help anyone. We're implementing commit message standards today."

**Time Allotment**: 40 minutes

**Topics Covered**:

- Why commit messages matter
- The anatomy of a good commit message
- Conventional Commits format
- Writing messages for future developers
- Common mistakes and how to avoid them

---

## Why Commit Messages Matter

Commit messages serve multiple purposes:

1. **Debugging**: Understanding what changed and why
2. **Code Review**: Reviewers understand intent before reading code
3. **Documentation**: Permanent record of decisions
4. **Changelog Generation**: Automated release notes
5. **Blame/Bisect**: Finding when bugs were introduced

A good commit message saves hours of investigation.

## The Anatomy of a Good Commit Message

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Example:

```
feat(voting): add duplicate vote prevention

Add validation to prevent voters from casting multiple votes
in the same election. The system now checks the voter registry
before accepting a new vote.

Closes #42
```

## The Subject Line (First Line)

Rules for the subject line:

| Rule                    | Good                        | Bad                                                                               |
| ----------------------- | --------------------------- | --------------------------------------------------------------------------------- |
| 50 characters or less   | `feat: add vote validation` | `feat: add vote validation and also check for duplicates and update the registry` |
| Imperative mood         | `fix: prevent crash`        | `fix: prevents crash` or `fix: prevented crash`                                   |
| No period at end        | `feat: add login`           | `feat: add login.`                                                                |
| Capitalize first letter | `Fix: resolve bug`          | `fix: resolve bug`                                                                |

Think of it as completing: "If applied, this commit will..."

- "If applied, this commit will **add vote validation**" ✅
- "If applied, this commit will **added vote validation**" ❌

## Conventional Commits Format

The Barangay Blockchain team adopts Conventional Commits:

### Types

| Type       | When to Use                 | Example                                 |
| ---------- | --------------------------- | --------------------------------------- |
| `feat`     | New feature                 | `feat: add voter registration`          |
| `fix`      | Bug fix                     | `fix: resolve duplicate vote bug`       |
| `docs`     | Documentation               | `docs: update API guide`                |
| `style`    | Formatting, no code change  | `style: fix indentation`                |
| `refactor` | Code change, no feature/fix | `refactor: extract validation function` |
| `test`     | Adding tests                | `test: add voting unit tests`           |
| `chore`    | Maintenance                 | `chore: update dependencies`            |

### Scope (Optional)

Scope indicates the area of code affected:

```
feat(voting): add ballot validation
fix(auth): resolve login timeout
docs(api): update endpoint examples
```

## The Body (Optional but Valuable)

When the subject line isn't enough, add a body:

```
fix(voting): prevent race condition in vote counting

When multiple votes arrive simultaneously, the counter could
skip increments due to unsynchronized access. This change
adds mutex locks around the counting logic.

The issue was reported by Singapore deployment where high
traffic caused undercounting during peak hours.
```

Body should explain:

- **What** changed (already in subject)
- **Why** the change was made
- **How** it was implemented (if non-obvious)

## The Footer (Optional)

For references and metadata:

```
feat(voter): add age verification

Add validation to verify voter age meets minimum requirement.

Closes #42
Related to #38
BREAKING CHANGE: Voter registration now requires birthdate field
```

## Real-World Comparison

### Bad Commit History

```
a1b2c3d fix
c4d5e6f update
g7h8i9j stuff
k1l2m3n changes
o4p5q6r wip
```

Singapore developer at 2 AM: "I have no idea what any of this does."

### Good Commit History

```
a1b2c3d fix(voting): prevent duplicate votes in same election
c4d5e6f feat(voter): add registration validation
g7h8i9j refactor(auth): extract token validation logic
k1l2m3n docs(api): update voting endpoint documentation
o4p5q6r test(voting): add edge case tests for invalid ballots
```

Singapore developer at 2 AM: "The duplicate vote fix might be related to our issue. Let me check that commit."

## Why This Matters for Global Deployment

Global teams have:

- **Different time zones**: The person debugging may not be the person who wrote the code
- **Asynchronous communication**: Can't always ask "what did this change do?"
- **High turnover**: New team members need to understand history
- **Compliance requirements**: Audit trails need clarity

The Barangay Blockchain is a voting system. In six months, an auditor might ask: "Why was this voting logic changed in October?"

Good commit message: "feat(voting): add fraud detection per barangay council requirement #78"

Bad commit message: "update" (Auditor: "What update? Why? Who approved this?")

## Tools and Enforcement

### Git Commit Template

Create `.gitmessage`:

```
# <type>(<scope>): <subject>
# |<----  Using a Maximum Of 50 Characters  ---->|

# Explain why this change is being made
# |<----   Try To Limit Each Line to a Maximum Of 72 Characters   ---->|

# Provide links or keys to any relevant tickets, articles, or resources
# Example: Closes #42

# --- COMMIT END ---
# Type: feat, fix, docs, style, refactor, test, chore
# Scope: component or file affected
# Subject: imperative, no caps, no period
# Body: explain what and why (not how)
```

```bash
git config --global commit.template ~/.gitmessage
```

### Commitlint (Automation)

Many teams use commitlint to enforce standards:

```bash
# Rejects: "fix stuff"
# Accepts: "fix(voting): resolve duplicate ballot issue"
```

## Common Mistakes to Avoid

| Mistake    | Problem                                 | Solution                            |
| ---------- | --------------------------------------- | ----------------------------------- |
| "fix"      | What was fixed?                         | "fix(auth): resolve login timeout"  |
| "update"   | What was updated?                       | "feat(ui): update dashboard layout" |
| "wip"      | Work in progress shouldn't be committed | Finish the work, then commit        |
| "asdf"     | Meaningless                             | Take 30 seconds to write properly   |
| Past tense | "Fixed the bug"                         | Imperative: "Fix the bug"           |
| Too long   | Subject > 50 chars                      | Split into multiple commits         |

## Key Takeaways

✓ Commit messages are documentation for future developers
✓ Use Conventional Commits format: type(scope): subject
✓ Subject line: 50 chars, imperative mood, no period
✓ Body explains why, not just what
✓ Good messages save hours during debugging
✓ Global teams depend on clear commit history
✓ "fix" and "update" are never acceptable alone

**Next Lesson:** Gitignore—keeping your repository clean and secure.
