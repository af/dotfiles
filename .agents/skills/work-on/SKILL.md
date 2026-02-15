---
name: work-on
description: Take a github url and start work on it
---

You will be given a url to a GitHub issue. If you don't receive one, ask for it.

1. Use the `gh` command line program to read the description and fetch any linked/related issues for context.

2. Explicitly ask the user: "Is there any context you would like to add before starting?"

3. If there is still any ambiguity about the task, ask clarifying questions up front.

4. Check out a new branch for the task, using the format `123-short-descriptive-name` where 123 is the issue number

5. Start work on the code changes for the task in the current directory. Don't commit any changes unless asked to do so.

5. When complete, print a summary of the work done, and any remaining loose ends or ambiguities encountered
