# GitHub Action: Create release and version branch

Creates a release and version branch when a specific commit message is provided 

## Inputs

### `github_token`
**Optional**

## Example usage
```yml
name: Creates new release and version branch
on:
  push:
    branch: "master"

jobs:
  WIP
```
