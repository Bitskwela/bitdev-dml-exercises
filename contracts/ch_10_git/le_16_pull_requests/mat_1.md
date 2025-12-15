# Le 16: Pull Requests

![Pull Requests](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-pull-request.png)

## Background Story

Wednesday afternoon. Maria finishes her `feature/voter-registration` branch. 47 commits, 2,000 lines of code, three weeks of work. She's proud of it.

"I'll just merge it to main," she says, reaching for the merge button.

"Wait!" Marco's voice comes through the team chat. "We don't merge directly anymore. Create a Pull Request."

Maria frowns. "But I know my code works. I tested it."

Marco explains: "It's not about whether YOU know it works. It's about whether the TEAM knows it works. A Pull Request lets Dev Sam review your code. London can check for security issues. I can verify it follows our patterns. And Neri can see what's changing before it goes to production."

Maria creates her first Pull Request. Within an hour, Dev Sam comments: "Line 234—this validation could be bypassed. See my suggestion." London adds: "Good work! But please add error handling for network failures." Marco approves with a note: "Clean code. Let's ship it after addressing the feedback."

Three days later, Maria's code merges—better than she wrote it, reviewed by three developers across three time zones, documented in the PR conversation for anyone who asks "why did we build it this way?"

Pull Requests aren't bureaucracy. They're how distributed teams maintain quality while moving fast.

**Time Allotment**: 45 minutes

**Topics Covered**:

- What Pull Requests are
- Creating a Pull Request
- The review process
- Addressing feedback
- Merging and closing PRs
- PR best practices for distributed teams

---

## What is a Pull Request?

A Pull Request (PR) is a formal request to merge one branch into another. It provides:

1. **Code Review**: Others can see your changes before they're merged
2. **Discussion**: Comment on specific lines, ask questions, suggest improvements
3. **Approval Workflow**: Require approvals before merging
4. **Documentation**: Record of why changes were made
5. **CI/CD Integration**: Run tests automatically before merging

```
feature/voter-registration  →  Pull Request  →  main
       (your work)              (review)        (production-ready)
```

## Creating a Pull Request

### Step 1: Push Your Branch

```bash
# Make sure your branch is on GitHub
git push origin feature/voter-registration
```

### Step 2: Open PR on GitHub

1. Go to your repository on GitHub
2. Click "Pull Requests" tab
3. Click "New Pull Request"
4. Select base branch (main) and compare branch (feature/voter-registration)
5. Click "Create Pull Request"

### Step 3: Write a Good PR Description

```markdown
## Description

Implements voter registration for the Barangay Blockchain.

## Changes

- Add VoterRegistry.sol contract
- Add registration validation
- Add duplicate voter detection
- Add registration events

## Testing

- [x] Unit tests pass
- [x] Manual testing on localhost
- [x] Tested with 1000 simulated voters

## Screenshots

[If applicable]

## Related Issues

Closes #42
```

## The Review Process

### Reviewer Actions

Reviewers can:

1. **Comment**: Ask questions, discuss approach
2. **Approve**: "This looks good to merge"
3. **Request Changes**: "Please fix these issues first"

### Line-by-Line Comments

```javascript
// Reviewer comments on specific line:
// "This validation can be bypassed if address is empty string.
//  Consider: require(bytes(voter.address).length > 0, 'Empty address');"

function registerVoter(address voter) public {
    require(voter != address(0), "Invalid voter");  // ← Comment here
    // ...
}
```

### PR Conversation Example

```
Maria (author): Ready for review!

Dev Sam: Line 45 - potential reentrancy issue.
         Use checks-effects-interactions pattern.

Maria: Good catch! Fixed in commit abc123.

Dev Sam: ✅ Approved

London: Security looks good. One suggestion:
        add rate limiting to prevent registration spam.

Maria: Added in commit def456.

London: ✅ Approved

Marco: LGTM! Merging now.
```

## Addressing Feedback

When reviewers request changes:

```bash
# Make the fixes on your branch
git checkout feature/voter-registration

# Edit files based on feedback
nano VoterRegistry.sol

# Commit the fixes
git add .
git commit -m "Address PR feedback: add reentrancy guard"

# Push to update the PR
git push origin feature/voter-registration
```

The PR automatically updates. Reviewers see your new commits.

## Merging the Pull Request

Once approved, you can merge. Three options:

### 1. Merge Commit (Preserves History)

```
Creates a merge commit. Full history visible.
Best for: Large features you want to track as a unit.
```

### 2. Squash and Merge (Clean History)

```
Combines all PR commits into one commit on main.
Best for: Features with many small "work in progress" commits.
```

### 3. Rebase and Merge (Linear History)

```
Replays commits on top of main without merge commit.
Best for: Teams that prefer linear git history.
```

## Why This Matters for Global Deployment

The Barangay Blockchain deploys to four regions. One bad merge can affect thousands of users.

**Without PRs**: Maria merges directly. Bug goes to production. Singapore notices at 2 AM their time. Emergency rollback. Neri is upset.

**With PRs**: Three developers review. Bug caught before merge. Maria fixes it. Clean deployment. Everyone sleeps well.

PRs also solve the timezone problem:

```
11 AM Manila: Maria opens PR
 6 PM Singapore: Singapore dev reviews, approves
 9 AM London: London dev reviews, approves
10 AM Manila: Maria merges after global review
```

No one waits. Reviews happen asynchronously. Merges are safe.

## PR Best Practices

### For Authors:

1. **Small PRs**: Under 400 lines is ideal. Easier to review.
2. **One Feature Per PR**: Don't mix unrelated changes.
3. **Good Description**: Explain what, why, and how.
4. **Self-Review First**: Check your own diff before requesting review.
5. **Respond Promptly**: Don't leave reviewers hanging.

### For Reviewers:

1. **Be Constructive**: "Consider X" not "This is wrong."
2. **Ask Questions**: "What happens if Y?" helps understanding.
3. **Acknowledge Good Work**: "Nice approach!" matters.
4. **Review Promptly**: Blocked PRs block developers.
5. **Be Specific**: Point to exact lines, suggest exact fixes.

## Key Takeaways

✓ Pull Requests are formal merge requests with review
✓ They provide code review, discussion, and approval workflow
✓ Write clear descriptions explaining what and why
✓ Address feedback with new commits that update the PR
✓ Use merge strategies appropriate for your team
✓ PRs enable asynchronous collaboration across time zones
✓ Small, focused PRs get reviewed faster

**Next Lesson:** What happens when your push is rejected? Learn to handle remote rejections gracefully.
