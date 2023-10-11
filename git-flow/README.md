# Git-flow

> The Git-flow script automates repository and project creation and configuration on GitHub.
>
> The resulting repository has three protected branches: 'dev,' 'bugfix,' and 'main.' As a result, you need to commit to a different branch and create a pull request before merging code, whether it's a new feature or a code fix.

# Requirements

- PowerShell
- Git
- GitHub CLI
- A GitHub account
- An authenticated user on GitHub in the local environment

# Steps

1. Create a remote repository on GitHub.
2. Clone it to a destination folder.
3. Create 'dev,' 'bugfix,' and 'main' branches, and push them to the remote repository.
4. Protect the newly created branches to prevent direct pushes to them.

# Variables

- `owner`: Refers to the user or organization.
- `repo`: Refers to the repository.
- `destinationFolder`: Refers to the directory in which the repository will be cloned.
- `visibility`: Refers to the visibility of the remote repository (public, internal, or private).
