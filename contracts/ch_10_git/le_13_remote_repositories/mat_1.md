# Le 13: Remote Repositories

![Remote Repositories](https://bitdev-dml-assets.s3.ap-southeast-1.amazonaws.com/ch_10/git-remote.png)

## Background Story

The Barangay Blockchain lives on Maria's laptop. "Now we need the team to collaborate," Marco says. "Let's move the code to GitHub."

Dev Sam in Cebu needs the code. "How do I get it?" London developer asks. "I need to work on the same project."

"We create a remote repository on GitHub," Marco explains. "A central place everyone can push to and pull from."

Maria pushes her code to GitHub. Dev Sam clones it (gets his own copy). London dev clones it. Now three developers, three regions, one shared codebase.

"This is where 'Beyond the Islands' really happens," Marco says. "Code from Barangay Hall in Manila is now accessible to developers worldwide."

**Time Allotment**: 35 minutes

**Topics Covered**:
- What remotes are
- Setting up GitHub
- Cloning repositories
- Adding remotes
- Pushing and pulling

---

## What is a Remote?

A remote is a pointer to a repository somewhere else (usually GitHub).

Your local repository:
- Lives on your computer
- Has your branches
- Only you can commit to it

A remote repository:
- Lives on GitHub/Gitlab/etc
- Has shared branches
- Everyone can push/pull from it

```bash
# See your remotes
git remote -v
# Output:
# origin    https://github.com/bitskwela/barangay-blockchain.git (fetch)
# origin    https://github.com/bitskwela/barangay-blockchain.git (push)
```

`origin` is the default remote name, pointing to the main repository.

## Setting Up a Remote

```bash
# Add a remote
git remote add origin https://github.com/bitskwela/barangay-blockchain.git

# Verify
git remote -v

# Push your branch to remote
git push origin main

# Now code is on GitHub!
```

## Cloning

Dev Sam in Cebu gets the code:

```bash
# Clone the repository (get full copy)
git clone https://github.com/bitskwela/barangay-blockchain.git

# He now has:
# - Full history
# - All branches
# - Remote connection to GitHub
cd barangay-blockchain

# He can see remotes
git remote -v
# origin → GitHub
```

## Multiple Remotes

Advanced teams have multiple remotes:

```bash
# Upstream (official project)
git remote add upstream https://github.com/official/barangay-blockchain.git

# Origin (your fork)
git remote add origin https://github.com/yourusername/barangay-blockchain.git
```

## Why This Matters for Global Deployment

Maria's laptop goes down. Code is lost if it's only local.
Code on GitHub: safe, accessible, recoverable.

Maria pushes to origin. Singapore dev pulls from origin. Both have same code.

Without remotes: one person's laptop = one source of truth (dangerous).
With remotes: GitHub = shared, backed-up source of truth (safe).

## Key Takeaways

✓ Remotes point to external repositories
✓ GitHub is the most common remote
✓ Clone to get a copy with remote connection
✓ Push sends your code to remote
✓ Pull gets latest code from remote

**Next Lesson:** Push and pull—how code moves between your computer and GitHub.
