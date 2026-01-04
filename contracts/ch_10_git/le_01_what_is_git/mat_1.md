# What is Git?

![1.0 - COVER](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_10_git/le_01_what_is_git/1.0%20-%20COVER.png)

## Scene

Marco starts his day in Manila, checking emails from his distributed team. Maria, in Cebu, just sent him a voting system update. But when he opens the file, something's wrong—his changes are gone.

Hours of work on the tie-breaking logic, overwritten.

"We have a problem," Marco tells the team on their video call. "We can't keep editing the same files without losing work. We need a system to track changes, see who did what, and merge work safely."

That's when Neri, who mentored the team through their first blockchain project, suggests: "You need Git—the same tool that powers every major open-source project in the world."

To help the team start, let's dive into the fundamentals of Git: What it is, why it matters, and how it prevents chaos like what just happened to Marco.

## What is Git?

![1.1 - GIT CONCEPTS](https://blockskwela.s3.ap-southeast-1.amazonaws.com/courses/contracts/ch_10_git/le_01_what_is_git/1.1.png)

### Version Control: The Ledger for Code

> Git is a **distributed version control system (DVCS)**. Think of it as a detailed ledger where every change to your code is recorded: who made it, when they made it, and why.

Just like a barangay treasurer keeps a record of every transaction—with signatures and dates—Git keeps a permanent record of every code change.

#### The Problem Without Version Control

Imagine the marketplace without a ledger:

- Marco saves `voting-system.py` at 2:00 PM
- Maria saves `voting-system.py` at 2:05 PM—overwriting Marco's changes
- A third developer downloads the file at 2:30 PM—but which version?
- Nobody knows the history
- A bug is discovered—but nobody knows who introduced it
- Recovery is impossible

#### The Solution With Git

With Git:

- Every change is recorded with who made it and why ("Added tiebreaker logic")
- Developers work in isolated branches—no overwrites
- Changes are merged safely, not just replaced
- History is preserved forever
- If something breaks, you revert to a known good state instantly

### Git's Distributed Power

> Git isn't stored on a single server. Each developer has a complete copy of the entire history. This is distributed version control—no single point of failure.

Unlike older systems (CVS, SVN) where a central server could crash and lose everything:

| Feature           | CVS  | SVN    | Git       |
| ----------------- | ---- | ------ | --------- |
| Distributed       | ❌   | ❌     | ✅        |
| Offline work      | ❌   | ❌     | ✅        |
| Fast branching    | ❌   | ❌     | ✅        |
| Collaboration     | Poor | Better | Excellent |
| Industry standard | ❌   | ❌     | ✅        |

Git gives the Manila Digital Collective the ability to work offline, merge changes safely, and maintain a complete history locally. Every developer is a backup.

### A Brief History: Why Git Exists

In 2005, Linus Torvalds (creator of Linux) needed a version control system that could handle thousands of developers contributing to the Linux kernel. No existing system was fast or flexible enough. So he created Git in just two weeks.

Git became the industry standard because it solved real problems that teams face every day: coordination across locations, parallel development, and safe merging.

## Core Git Concepts

### The Three Spaces

Git organizes code into three locations:

1. **Working Directory**: Your actual files on your laptop—where you edit code
2. **Staging Area**: Files you've marked to be committed—your next snapshot
3. **Repository (.git folder)**: The permanent record of all commits—the ledger

### Key Git Terms

- **Repository (Repo)**: A project folder containing your code and all Git history
- **Commit**: A snapshot of your code at a specific moment (with a message explaining why)
- **Branch**: A parallel timeline of development—like parallel work streams
- **Merge**: Combining changes from different branches safely
- **Remote**: A copy of your repository on a server (like GitHub)
- **Clone**: Downloading a complete copy of a repository

## Why Git Matters for Your Team

As Marco and the Manila Digital Collective scale from 3 developers to 30 across multiple cities:

- **Coordination**: Work simultaneously without stepping on each other
- **Transparency**: Every decision is recorded—no mystery about who changed what
- **Safety**: Never lose code again; always revert to a previous state
- **Professionalism**: Git is standard in every tech company and open-source project
- **Global Impact**: Contribute to projects worldwide using the same Git workflow

---

**Ready to understand the next step? Let's configure Git and set up your identity!**
