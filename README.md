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
      uses: elstudio/actions-settings@v2-beta
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```
