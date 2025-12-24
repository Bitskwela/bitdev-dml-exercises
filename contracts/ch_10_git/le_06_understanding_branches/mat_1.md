# Le 06: Understanding Branches

![Branch Visualization](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-branches.png)

## Background Story

The Barangay Blockchain team has grown. Maria is still refactoring the permission system, but now Marco wants to work on the voting results display simultaneously. "If we both work on main branch, our changes will conflict," Marco says. "We need to work on separate branches."

Dev Sam from Cebu joins the video call: "I want to add payment integration without blocking you two. How do we all work at once?"

Neri, the barangay official, needs weekly voting reports ready by Monday. The team realizes that without parallel development, they'd have to wait: Maria finishes, then Marco starts, then Sam starts. Sequential work means months to deliver.

"Branches are the answer," Marco explains. "Think of them as parallel universes for code. Each of us works in our own universe without affecting others. When we're ready, we merge."

What Maria, Marco, and Dev Sam learn today will let them work simultaneously across three regions, each on different features, all pushing to production when ready.

**Time Allotment**: 30 minutes

**Topics Covered**:

- What branches are (pointers to commits)
- HEAD and branch pointers
- How branches isolate work
- Why branches matter for global teams
- Creating and listing branches

---

## What is a Branch?

A branch is a pointer—a reference to a specific commit. That's it. Not a folder copy, not a separate file system, just a pointer.

When you initialize a Git repository, Git creates a default branch called `main` (previously called `master`). The `main` branch points to a commit.

```bash
main → [commit: abc123]
```

When you create a new branch, Git creates another pointer:

```bash
main → [commit: abc123]
feature/voting → [commit: abc123]
```

Both branches point to the same commit initially. But as you add commits on `feature/voting`, that branch pointer moves forward:

```bash
main → [commit: abc123]
feature/voting → [commit: def456] → [commit: ghi789]
```

Meanwhile, `main` stays at abc123 unless someone updates it. This is parallel development.

## HEAD: You Are Here

`HEAD` is a special pointer that says "you are currently on this branch." It points to your current branch, which points to a commit.

```bash
HEAD → main → [commit: abc123]
```

When you switch branches:

```bash
HEAD → feature/voting → [commit: ghi789]
```

This is why your working directory changes when you switch branches. Git is updating your files to match the commit that `feature/voting` points to.

## Branch Isolation

Here's the power: changes on one branch don't affect another.

Maria works on `feature/voting`:

```bash
# She's on feature/voting branch
voting.js is modified
message.js is modified
# She commits
```

Marco switches to `feature/payment` and pulls up `voting.js`. To him, it's unchanged. His branch hasn't seen Maria's commits. They're isolated.

When they merge, Git combines the work. If they modified different files—no problem. If they modified the same files in the same places—merge conflict (lesson 9).

## Why This Matters for Global Deployment

**Without branches (sequential):**

```
London developer sits idle
↓ (waiting for Manila to finish)
Manila developer works
↓ (when Maria finishes, commits)
Cebu Dev Sam can finally start
↓ (when Sam finishes)
London can finally code
```

With 4-hour time zones between regions, sequential work means someone is always waiting.

**With branches (parallel):**

```
London:  feature/voting     ────→ ──→ (working)
Manila:  feature/payment    ────→ ──→ (working)
Cebu:    feature/dashboard  ────→ ──→ (working)
main:                        (unchanged, ready to deploy)
```

All three regions work simultaneously. When ready, they merge to main. London doesn't wait for Manila. Manila doesn't block Cebu. This is how global teams move fast.

## Creating Your First Branch

You'll learn the commands in lesson 7. For now, understand that creating a branch is simple:

```bash
git branch feature/voting
```

This creates a new pointer called `feature/voting` pointing to your current commit. It doesn't create a folder, doesn't copy files, doesn't take much space. It's just a pointer.

## Branch Naming Conventions

Professional teams follow patterns:

- **feature/X** - New features (feature/voting, feature/payment)
- **bugfix/X** - Bug fixes (bugfix/validator, bugfix/security)
- **hotfix/X** - Emergency production fixes (hotfix/critical-bug)
- **release/X** - Release preparation (release/1.0.0)
- **docs/X** - Documentation (docs/api-guide)

This naming helps everyone understand what each branch does. When Neri, the non-technical stakeholder, hears "feature/voting-results," she understands immediately. Naming matters.

## Listing Branches

You can see all branches:

```bash
git branch          # List local branches
git branch -a       # List all branches (including remote)
git branch -v       # List with details
```

## Why This Matters for Global Deployment

Barangay Blockchain needs to deploy simultaneously to Manila, Cebu, Singapore, and London. With branches:

- **Manila team** works on `feature/voting-protection` without affecting Singapore
- **Singapore team** works on `feature/multi-region-sync` without affecting Cebu
- **London team** works on `feature/gdpr-compliance` without affecting Manila
- **All code** merges to `main` only when tested and ready
- **All regions** deploy the same `main` branch with confidence

Branches solve the coordination nightmare of distributed teams.

---

## Key Takeaways

✓ Branches are pointers to commits, not folder copies
✓ HEAD shows which branch you're currently on
✓ Work on one branch doesn't affect another
✓ Naming conventions clarify branch purpose
✓ Branches enable parallel development for distributed teams
✓ Global teams deploy faster with parallel development

**Next Lesson:** Let's create and switch between branches. Maria will start her feature, Marco will start his, and they'll work in parallel.

```bash
# Example Git commands
```

### Summary

This lesson covers Understanding Branches in detail.

---

**Ready for the activity? Let's get started!**
