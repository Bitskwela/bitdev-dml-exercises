# Chapter 10 Quiz: Git Version Control Fundamentals to Advanced

```json
[
  {
    "id": 1,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A design pattern for software development" },
      { "id": "b", "text": "A distributed version control system" },
      { "id": "c", "text": "A project management tool" },
      { "id": "d", "text": "A continuous integration platform" }
    ],
    "question": "What is Git?"
  },
  {
    "id": 2,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A folder that contains all project files" },
      { "id": "b", "text": "A database of user credentials" },
      {
        "id": "c",
        "text": "A hidden folder containing version control metadata"
      },
      { "id": "d", "text": "A configuration file for Git settings" }
    ],
    "question": "What is the .git directory?"
  },
  {
    "id": 3,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "The staging area (index) is where changes are prepared before committing."
  },
  {
    "id": 4,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      {
        "id": "a",
        "text": "A snapshot of the project at a specific point in time with recorded changes"
      },
      { "id": "b", "text": "A reference to the current branch" },
      { "id": "c", "text": "A backup copy of the repository" },
      { "id": "d", "text": "A temporary save point that will be deleted" }
    ],
    "question": "What is a commit?"
  },
  {
    "id": 5,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A parallel line of development" },
      { "id": "b", "text": "A copy of the repository" },
      { "id": "c", "text": "A saved version of a file" },
      { "id": "d", "text": "A tag marking a release" }
    ],
    "question": "What is a branch in Git?"
  },
  {
    "id": 6,
    "type": "TF",
    "answer": false,
    "points": 1,
    "question": "Once a commit is pushed to a remote repository, it can never be changed."
  },
  {
    "id": 7,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      {
        "id": "a",
        "text": "Pulling changes from another branch into your current branch"
      },
      { "id": "b", "text": "Creating a new commit that combines two branches" },
      { "id": "c", "text": "Integrating changes from one branch into another" },
      { "id": "d", "text": "Deleting a branch after it's no longer needed" }
    ],
    "question": "What is merging?"
  },
  {
    "id": 8,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A conflict where two files have the same name" },
      {
        "id": "b",
        "text": "A conflict where changes in two branches affect the same lines"
      },
      { "id": "c", "text": "A merge that cannot be completed" },
      { "id": "d", "text": "An error during push to remote repository" }
    ],
    "question": "What is a merge conflict?"
  },
  {
    "id": 9,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Temporarily saving changes without committing" },
      { "id": "b", "text": "Creating a backup of the current branch" },
      { "id": "c", "text": "Removing files from the staging area" },
      { "id": "d", "text": "Deleting branches that are no longer needed" }
    ],
    "question": "What is stashing in Git?"
  },
  {
    "id": 10,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A server where code is stored" },
      { "id": "b", "text": "A local copy of a repository" },
      { "id": "c", "text": "A remote version of your repository" },
      { "id": "d", "text": "A branch that only exists locally" }
    ],
    "question": "What is a remote repository?"
  },
  {
    "id": 11,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "Pull is equivalent to running fetch followed by merge."
  },
  {
    "id": 12,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Downloading changes from remote without merging" },
      { "id": "b", "text": "Uploading all commits to remote" },
      { "id": "c", "text": "Deleting remote branches" },
      { "id": "d", "text": "Creating a new remote connection" }
    ],
    "question": "What does fetch do?"
  },
  {
    "id": 13,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Use git reset to undo the modification" },
      {
        "id": "b",
        "text": "The changes cannot be undone once they're written to disk"
      },
      {
        "id": "c",
        "text": "Use git checkout or git restore to discard changes"
      },
      { "id": "d", "text": "Manually delete and recreate the file" }
    ],
    "question": "SITUATION: You modified a file locally but haven't staged it. How do you discard the changes?"
  },
  {
    "id": 14,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Delete the branch and create a new one" },
      {
        "id": "b",
        "text": "Use git reset --hard to permanently erase the bad commit"
      },
      {
        "id": "c",
        "text": "Use git revert to create a new commit that undoes the changes"
      },
      { "id": "d", "text": "Push the broken code to main and fix it later" }
    ],
    "question": "SITUATION: You committed changes that broke your application. What's the safest way to undo them?"
  },
  {
    "id": 15,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      {
        "id": "a",
        "text": "It rewrites commit history by moving commits to a new base"
      },
      { "id": "b", "text": "It creates a merge commit combining two branches" },
      { "id": "c", "text": "It deletes old commits from history" },
      { "id": "d", "text": "It synchronizes remote with local repository" }
    ],
    "question": "What is rebasing?"
  },
  {
    "id": 16,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A merge that involves only one branch" },
      { "id": "b", "text": "A merge that creates a new commit" },
      {
        "id": "c",
        "text": "A merge where the base branch pointer is moved forward"
      },
      { "id": "d", "text": "A merge that cannot resolve conflicts" }
    ],
    "question": "What is a fast-forward merge?"
  },
  {
    "id": 17,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A file that lists commands to run before commits" },
      {
        "id": "b",
        "text": "A file that lists files to ignore from version control"
      },
      { "id": "c", "text": "A configuration file for Git settings" },
      { "id": "d", "text": "A file that stores commit history" }
    ],
    "question": "What is .gitignore used for?"
  },
  {
    "id": 18,
    "type": "TF",
    "answer": true,
    "points": 1,
    "question": "Git hooks allow you to run scripts automatically at certain points in Git workflow."
  },
  {
    "id": 19,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A reference to a specific commit" },
      { "id": "b", "text": "A marker for a feature branch" },
      { "id": "c", "text": "A copy of a repository" },
      { "id": "d", "text": "A merge conflict resolution" }
    ],
    "question": "What is a tag?"
  },
  {
    "id": 20,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A request to revert a pull request" },
      { "id": "b", "text": "A way to push code directly to main" },
      { "id": "c", "text": "A proposal to merge code changes for review" },
      { "id": "d", "text": "A way to fetch updates from remote" }
    ],
    "question": "What is a pull request?"
  },
  {
    "id": 21,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      {
        "id": "a",
        "text": "Git does not allow commit messages to be edited after committing"
      },
      {
        "id": "b",
        "text": "Use git commit --amend to modify the message before pushing"
      },
      {
        "id": "c",
        "text": "You must reset and recommit with the correct message"
      },
      { "id": "d", "text": "Create a new commit with the corrected message" }
    ],
    "question": "SITUATION: You committed with a typo in your message. How do you fix it?"
  },
  {
    "id": 22,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      {
        "id": "a",
        "text": "Fetch the latest remote changes and merge them into your local branch"
      },
      {
        "id": "b",
        "text": "Force push your local changes to overwrite the remote"
      },
      { "id": "c", "text": "Delete your local branch and create a new one" },
      {
        "id": "d",
        "text": "Your changes will be rejected by Git and cannot be pushed"
      }
    ],
    "question": "SITUATION: Your local branch is behind the remote repository. What do you do?"
  },
  {
    "id": 23,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      {
        "id": "a",
        "text": "A branch pattern like main/feature or dev/feature"
      },
      { "id": "b", "text": "A way to organize commits in a repository" },
      { "id": "c", "text": "A structured approach to branching and merging" },
      { "id": "d", "text": "A type of remote repository" }
    ],
    "question": "What is a branching strategy?"
  },
  {
    "id": 24,
    "type": "MCQ",
    "answer": "b",
    "points": 1,
    "choices": [
      { "id": "a", "text": "Picking a single feature from one branch" },
      {
        "id": "b",
        "text": "Applying a specific commit from one branch to another"
      },
      { "id": "c", "text": "Creating a new branch from an old commit" },
      { "id": "d", "text": "Removing a commit from history" }
    ],
    "question": "What is cherry-picking?"
  },
  {
    "id": 25,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      {
        "id": "a",
        "text": "Use git filter-branch or BFG to remove it from history before others pull"
      },
      {
        "id": "b",
        "text": "The data is now exposed and cannot be removed from the repository"
      },
      { "id": "c", "text": "Delete the branch to hide the password" },
      { "id": "d", "text": "Push a new commit on top to override it" }
    ],
    "question": "SITUATION: You accidentally committed a password to a public repository. What's the best action?"
  },
  {
    "id": 26,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A way to view current branch name" },
      { "id": "b", "text": "A log of all Git commands you've run" },
      { "id": "c", "text": "A log that tracks changes to HEAD reference" },
      { "id": "d", "text": "A reference to the remote repository" }
    ],
    "question": "What is reflog?"
  },
  {
    "id": 27,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      {
        "id": "a",
        "text": "Creating a copy of a repository in your own account to work independently"
      },
      { "id": "b", "text": "A branch that is temporarily saved for later use" },
      {
        "id": "c",
        "text": "A way to directly commit to someone else's repository"
      },
      { "id": "d", "text": "Downloading a repository without using Git" }
    ],
    "question": "What is forking?"
  },
  {
    "id": 28,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      {
        "id": "a",
        "text": "Fork the repository, create a feature branch, and submit a pull request"
      },
      { "id": "b", "text": "Clone it and push directly to the main branch" },
      { "id": "c", "text": "Request write access from the repository owner" },
      {
        "id": "d",
        "text": "Create an issue and wait for the maintainer to implement it"
      }
    ],
    "question": "SITUATION: You want to contribute to an open source project. What's the typical workflow?"
  },
  {
    "id": 29,
    "type": "MCQ",
    "answer": "c",
    "points": 1,
    "choices": [
      { "id": "a", "text": "A temporary branch that is automatically deleted" },
      { "id": "b", "text": "A read-only branch in a repository" },
      { "id": "c", "text": "A branch that is protected from direct pushes" },
      { "id": "d", "text": "The first branch created in a repository" }
    ],
    "question": "What is a protected branch?"
  },
  {
    "id": 30,
    "type": "MCQ",
    "answer": "a",
    "points": 1,
    "choices": [
      {
        "id": "a",
        "text": "Use git revert to create a commit that undoes the broken changes"
      },
      { "id": "b", "text": "Force push an older version to main" },
      {
        "id": "c",
        "text": "Use git reset --hard to remove the commit from history"
      },
      { "id": "d", "text": "Delete the main branch and recreate it" }
    ],
    "question": "SITUATION: A broken feature was merged to main. How do you safely undo it?"
  },
  {
    "id": 31,
    "type": "FIB",
    "answer": "git init",
    "points": 1,
    "question": "You have a new project folder on your computer. What command do you run to turn it into a Git repository?"
  },
  {
    "id": 32,
    "type": "FIB",
    "answer": "git add",
    "points": 1,
    "question": "You've modified several files and want to prepare them for a commit. What command do you use to stage these files?"
  },
  {
    "id": 33,
    "type": "FIB",
    "answer": "git commit -m",
    "points": 1,
    "question": "Your staged changes are ready to save permanently in your repository. What command do you run to create a commit with a message?"
  },
  {
    "id": 34,
    "type": "FIB",
    "answer": "git branch",
    "points": 1,
    "question": "You want to see all the branches in your repository and create a new one for a feature. What command do you use?"
  },
  {
    "id": 35,
    "type": "FIB",
    "answer": "git checkout -b",
    "points": 1,
    "question": "You need to create a new feature branch and immediately start working on it. What command creates and switches to this new branch?"
  },
  {
    "id": 36,
    "type": "FIB",
    "answer": "git merge",
    "points": 1,
    "question": "Your feature branch is complete and tested. Now you want to combine the changes from your feature branch back into the main branch. What command do you use?"
  },
  {
    "id": 37,
    "type": "FIB",
    "answer": "git push",
    "points": 1,
    "question": "You've committed your work locally and want to send your commits to the remote server so your team can see them. What command do you use?"
  },
  {
    "id": 38,
    "type": "FIB",
    "answer": "git pull",
    "points": 1,
    "question": "Your teammate just pushed new changes to the remote. Your local code is outdated and you need to get their changes. What single command fetches and merges their work?"
  },
  {
    "id": 39,
    "type": "FIB",
    "answer": "git log",
    "points": 1,
    "question": "You need to review all the commits your team has made over the last week to understand the project's progress. What command shows the commit history?"
  },
  {
    "id": 40,
    "type": "FIB",
    "answer": "git stash",
    "points": 1,
    "question": "You're working on a feature branch with uncommitted changes, but you need to switch to another branch for an urgent fix. You don't want to commit unfinished work. What command temporarily saves your changes?"
  }
]
```
