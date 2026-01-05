# Le 11: Cleaning Up Branches – Professional Discipline

![Branch Cleanup](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-cleanup.png)

## Scene: Repository Chaos Reveals a Lesson

**Three months later. Barangay Blockchain v1.0 is about to ship.**

Maria gets a message: new London developer joins the team.

"I need context," the developer writes. "I'll read the Git history."

Maria decides to give them an overview of branches:

```bash
git branch -a
```

The output scrolls... and scrolls... and scrolls. Maria stops counting after 47 branches.

"Oh no," she mutters.

The London developer messages: "Which branches should I care about? Which are active? Which are old?"

Marco walks over. "This is embarrassing."

"Why?" Maria asks.

"Because look at these names: feature/voting-1, feature/voting-2, feature/voting-improvements, feature/voting-refactor. Some are merged. Some are duplicates. Some are from months ago."

"Why is that a problem?"

"Because," Marco says, "an unclear repository means unclear thinking. If we can't tell which branches are active, we're not thinking clearly about our work."

He pulls up the naming conventions they established three months ago. "We're supposed to delete branches after merging. We've been lazy about it."

"So... we clean up?"

"We clean up," Marco confirms. "Starting today. After every merge, delete the branch. Immediately. Make it a habit. A clean repository is a sign of a professional team."

**This lesson teaches that software development isn't just about code—it's about discipline and clear communication.**

**Time Allotment**: 25 minutes

**Topics Covered**:

- Deleting local branches (removing pointers after merging)
- Deleting remote branches (cleanup on GitHub)
- Understanding branch lifecycle (created, developed, merged, deleted)
- Keeping repository clean (a sign of team discipline)
- Communication value of clean repositories (new developers understand immediately)

---

## Deleting Branches

After merging, delete the branch:

```bash
# Safe delete (won't delete unmerged work)
git branch -d feature/voting-improvements

# Force delete (be careful!)
git branch -D feature/voting-improvements
```

The `-d` flag is safe. It refuses to delete if unmerged work exists. The `-D` flag forces deletion.

## After Merging

```bash
# Before cleanup
git branch
# Output:
#   bugfix/validator-crash (merged weeks ago)
#   feature/gdpr-compliance (merged yesterday)
#   feature/payment-retry (merged last week)
#   feature/voting-improvements (merged this morning)
#   main

# After cleanup
git branch -d bugfix/validator-crash
git branch -d feature/gdpr-compliance
git branch -d feature/payment-retry
git branch -d feature/voting-improvements

git branch
# Output:
#   main
```

Much clearer. Now you immediately know: the only branch is main. Everything else is in the history.

## Automatic Cleanup

Many teams set a policy: "Delete your branch as part of the merge."

When you merge on GitHub, there's a button: "Delete branch." Click it.

Locally, add to your workflow:

1. Merge branch
2. Delete branch immediately
3. Don't leave stale branches

## Why This Matters for Global Deployment

**Messy repository (47 branches):**

- New Singapore developer: "Which branches are active?"
- Takes 30 minutes to figure out
- Maybe merges from wrong branch by mistake

**Clean repository (just main):**

- New Singapore developer: "What should I work on?"
- "Create feature/[your-feature] from main"
- 30 seconds to understand

For distributed teams with frequent onboarding, clean repositories matter.

## Seeing Deleted Branches

Even after you delete a branch locally, the commits still exist:

```bash
# Delete feature/voting-improvements
git branch -d feature/voting-improvements

# Can you still see the commits?
git log --all --grep="voting"
# YES, commits still exist!

# Can you recover the branch?
git branch feature/voting-improvements abc123
# YES, you can recreate it from the commit hash
```

Deleting a branch is safe. You're not deleting commits, just the pointer.

## Key Takeaways

✓ Delete branches after merging
✓ Use `git branch -d` (safe) or `-D` (force)
✓ Commits still exist even after deletion
✓ Clean repository helps team coordination
✓ Establish cleanup as part of workflow

**Next Lesson:** With clean branches, let's talk about branch strategies—how to organize branching for different deployment models (Gitflow, GitHub Flow, trunk-based).
