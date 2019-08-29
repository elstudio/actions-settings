# actions-settings
GitHub Action to run [Probot settings](https://github.com/probot/settings) to set repository defaults.

This action simply runs probot-settings, which can be used to set up labels, branch protection rules -- pretty much anything on the repository settings tab. Settings are read from a yaml file in the repository.


## Example Use

Example `probot-settings.yml` file:

```
name: Enforce repository settings

on: [push]

jobs:
  probot-settings:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v1
    - name: Run probot-settings
      uses: elstudio/actions-settings@v2
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### A fancer example

Let's say you run `probot-settings` just one time. (Which is useful if you're setting up labels when a repository is first created.)

```yaml
name: Enforce repository settings just once

on: [push]

jobs:
  probot-settings:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v1
    - name: Run probot-settings
      uses: elstudio/actions-settings@v2
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}


    - name: Remove workflow file from master branch
      run: rm ./.github/workflows/probot-settings.yml
      if: endsWith(github.ref, '/master') && ! endsWith(github.repository, '-template')

    - name: Commit changes
      uses: elstudio/actions-js-build/commit@v2
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

