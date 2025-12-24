# Le 11: Cleaning Up Branches

![Branch Cleanup](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-cleanup.png)

## Background Story

Three months later. The Barangay Blockchain has shipped 20 features. Maria runs `git branch` and scrolls... and scrolls... and scrolls.

"We have 47 branches," Maria says in horror. "feature/voting-1 through feature/voting-20, all deleted branches we forgot to clean, bugfix branches from months ago..."

"This is why we clean up," Marco says. "After we merge, we delete the branch. No need to keep it around."

New developer from London joins the call: "I'm confused. Which branches are active? Which are old?"

Marco realizes: "This is a message. If we can't tell which branches are active, we're not cleaning up fast enough. Let's establish a cleanup routine."

By establishing simple cleanup habits, the team keeps their repository clear. New developers understand immediately what's being worked on.

**Time Allotment**: 25 minutes

**Topics Covered**:
- Deleting local branches
- Deleting remote branches
- Understanding branch lifecycle
- Keeping repository clean
- Communication value of clean repositories

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
