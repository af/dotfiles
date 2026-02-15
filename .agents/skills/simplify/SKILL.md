---
name: simplify-since
argument-hint: [base-branch-or-ref]
description: Refactor local changes for simplicity
---

Refactor changes that have been made locally to make them simpler

1. Get the baseReference, which is the first argument to the skill.
If no base is given, use the default branch, via `basename $(git symbolic-ref --short refs/remotes/origin/HEAD)`

2. Get the full local changes with `git diff ${baseReference}`

3. Analyze the local changes and look for any places the code can be made simpler

4. Suggest refactorings to the user and ask if you should proceed with the changes

Guidelines:
* Do not suggest any trivial changes (formatting, etc)
