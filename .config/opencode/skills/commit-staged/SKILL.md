---
name: commit-staged
description: Use when the user asks to commit staged file changes, or says "commit staged", "commit my changes", or similar. Runs `git diff --cached` and generates a conventional commit message, then commits.
---

# Commit Staged

When the user asks to commit their staged changes:

1. Run `git status` and `git diff --cached` to see what's staged.
2. Check `git log --oneline -10` to infer the repo's commit style.
3. Generate a conventional commit message (type(scope): description).
4. Commit with `git commit -m "..."`.
5. Report the commit hash and summary.
